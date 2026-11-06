#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verify the xEdit API after the "remove all save capability" change, plus a
general smoke test of the running server.

What it proves (always run):
  1. GET  /api/status               - API reachable, plugins loaded, which pid
  2. GET  /api                      - index has no save endpoint, batch op list
                                      has no "save", and carries "savePolicy"
  3. static                         - api-client has no "save" subcommand
  4. POST /api/plugins/{f}/save     - 404 not_found (endpoint really is gone)
  5. POST /api/batch  op="save"     - HTTP 200 but ok=false + explanatory error
  6. POST .../merge-effects         - 404 not_found (no scenario-specific endpoint left)
  7. read smoke                     - plugins / records / tree / find still work
  8. write smoke (in memory)        - values round-trip: set then restore, so the
                                      net change is zero and nothing gets saved

Opt-in extras:
  --write-test   exercise a real field edit (set + verify + restore original).
                 Read-only masters cannot be edited, so with only Skyrim.esm loaded the
                 check is skipped - add --scratch-write to create a throwaway plugin and
                 do the round-trip there instead.
  --patch-test   create a throwaway plugin with autoSave=true to prove the flag is
                 ignored and no file appears on disk, and prove that re-using an
                 existing plugin name is refused with 409 instead of popping a modal
                 dialog in the GUI. WARNING: this adds an in-memory plugin to the
                 xEdit session; do NOT press Save in the GUI afterwards, or that junk
                 plugin will be written to disk.

Zero third-party dependencies (urllib only).

Usage:
  python verify_api.py                                   # default port 7000
  python verify_api.py --port 7000 --token mysecret
  python verify_api.py --write-test
  python verify_api.py --patch-test --data-dir "F:\\Skyrim SCSIM\\Game\\Data"

Exit code: 0 = every executed check passed, 1 = at least one FAIL.
"""
import argparse
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

BASE = "http://127.0.0.1"
CLIENT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "xedit_api_client.py")

PASS, FAIL, SKIP, INFO = "PASS", "FAIL", "SKIP", "INFO"
results = []          # (status, name, detail)


def record(status, name, detail=""):
    results.append((status, name, detail))
    line = f"[{status}] {name}"
    if detail:
        line += f"\n         {detail}"
    print(line, flush=True)
    return status == PASS


def call(port, path, token=None, method="GET", body=None, timeout=120):
    """Return (status_code, parsed_json_or_None, raw_text)."""
    data = body.encode("utf-8") if body is not None else None
    req = urllib.request.Request(f"{BASE}:{port}{path}", data=data, method=method)
    if body is not None:
        req.add_header("Content-Type", "application/json")
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            raw = resp.read().decode("utf-8", "replace")
            code = resp.status
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", "replace")
        code = e.code
    except Exception as e:                       # connection refused, timeout, ...
        return None, None, str(e)
    try:
        return code, json.loads(raw), raw
    except Exception:
        return code, None, raw


def walk_leaves(node, out):
    """Collect leaf nodes ({name, path, value}) of an element-tree JSON node.

    Tolerates the API envelope: {"ok":true,...,"tree":{...}} is unwrapped first.
    """
    if not isinstance(node, dict):
        return
    if isinstance(node.get("tree"), dict):
        walk_leaves(node["tree"], out)
        return
    kids = node.get("children")
    if isinstance(kids, list) and kids:
        for k in kids:
            walk_leaves(k, out)
    elif "value" in node:
        out.append(node)


# --------------------------------------------------------------------------- #
# checks
# --------------------------------------------------------------------------- #

def check_status(port, token):
    code, data, raw = call(port, "/api/status", token)
    if code != 200 or not isinstance(data, dict):
        record(FAIL, "GET /api/status", f"unreachable: HTTP {code} {raw[:200]}")
        return None
    if not data.get("ok"):
        record(FAIL, "GET /api/status", f"ok=false: {raw[:200]}")
        return None
    loaded = bool(data.get("pluginsLoaded"))
    record(PASS if loaded else FAIL, "GET /api/status",
           f"pid={data.get('pid')} gameMode={data.get('gameMode')} "
           f"pluginsLoaded={loaded} apiVersion={data.get('apiVersion')}")
    if loaded:
        record(PASS if data.get("busy") is False else FAIL,
               "status excludes its own request from busy",
               f"pluginsLoaded=True busy={data.get('busy')}")
    if not loaded:
        record(FAIL, "plugins loaded", "load plugins in the xEdit GUI, then re-run")
    return data


def check_index(port, token):
    code, data, raw = call(port, "/api", token)
    if code != 200 or not isinstance(data, dict):
        record(FAIL, "GET /api index", f"HTTP {code} {raw[:200]}")
        return
    eps = data.get("endpoints") or []
    saves = [e for e in eps if "/save" in e]
    record(PASS if not saves else FAIL, "index: no save endpoint listed",
           f"endpoints={len(eps)}" + (f" | still listed: {saves}" if saves else ""))

    batch = [e for e in eps if "/api/batch" in e]
    batch_has_save = any(re.search(r"ops:[^)]*\bsave\b", e) for e in batch)
    record(PASS if not batch_has_save else FAIL, "index: batch op list has no 'save'",
           batch[0] if batch else "no /api/batch entry found")

    policy = data.get("savePolicy")
    ok = isinstance(policy, str) and "GUI" in policy
    record(PASS if ok else FAIL, "index: savePolicy present",
           policy if policy else "missing 'savePolicy' field")

    scen = [e for e in eps if "merge-effects" in e]
    record(PASS if not scen else FAIL, "index: no scenario-specific endpoint listed",
           f"endpoints={len(eps)}" + (f" | still listed: {scen}" if scen else ""))


def check_client_source():
    try:
        with open(CLIENT, "r", encoding="utf-8") as fh:
            src = fh.read()
    except OSError as e:
        record(SKIP, "api-client has no save subcommand", f"cannot read {CLIENT}: {e}")
        return
    has_parser = bool(re.search(r'add_parser\(\s*["\']save["\']', src))
    has_dispatch = bool(re.search(r'args\.cmd\s*==\s*["\']save["\']', src))
    record(PASS if not (has_parser or has_dispatch) else FAIL,
           "api-client has no save subcommand",
           f"checked {os.path.basename(CLIENT)}")


def check_save_endpoint(port, token, plugin):
    """POST /api/plugins/{file}/save must no longer exist."""
    if not plugin:
        record(SKIP, "POST .../save is gone", "no loaded plugin to address")
        return
    path = "/api/plugins/" + urllib.parse.quote(plugin) + "/save"
    code, data, raw = call(port, path, token, method="POST", body="{}")
    if code == 200:
        record(FAIL, "POST .../save is gone",
               "endpoint still answered 200 - the running exe is an OLD build; "
               "rebuild and copy the new exe, then restart xEdit")
        return
    err = (data or {}).get("error") or {}
    code_s, msg = err.get("code", ""), err.get("message", "")
    if code == 404 and code_s == "not_found" and "Unknown endpoint" in msg:
        record(PASS, "POST .../save is gone", f"HTTP 404 {code_s}")
    elif code == 404:
        record(SKIP, "POST .../save is gone", f"404 but '{msg}' (plugin not loaded?)")
    else:
        record(FAIL, "POST .../save is gone", f"HTTP {code} {raw[:200]}")


def check_batch_save_op(port, token):
    """The batch 'save' op must be rejected with an explanation."""
    body = json.dumps({"strict": False, "ops": [{"op": "save"}]})
    code, data, raw = call(port, "/api/batch", token, method="POST", body=body)
    if code != 200 or not isinstance(data, dict):
        record(FAIL, "batch op 'save' rejected", f"HTTP {code} {raw[:200]}")
        return
    res = (data.get("results") or [{}])[0]
    err = str(res.get("error", ""))
    ok = (data.get("ok") is False and res.get("ok") is False
          and "not available" in err.lower() and "save" in err.lower())
    record(PASS if ok else FAIL, "batch op 'save' rejected",
           err or f"unexpected result: {json.dumps(res)[:200]}")


def check_scenario_endpoints_gone(port, token, plugin):
    """Scenario-specific endpoints must be gone: only generic primitives remain."""
    if not plugin:
        record(SKIP, "POST .../merge-effects is gone", "no loaded plugin to address")
        return
    path = ("/api/plugins/" + urllib.parse.quote(plugin)
            + "/records/00000000/merge-effects")
    code, data, raw = call(port, path, token, method="POST", body="{}")
    err = (data or {}).get("error") or {}
    msg = err.get("message", "")
    if code == 404 and err.get("code") == "not_found" and "Unknown endpoint" in msg:
        record(PASS, "POST .../merge-effects is gone", f"HTTP 404 {err.get('code')}")
    elif code == 404:
        record(FAIL, ".../merge-effects is gone",
               f"still routed (answered 404 '{msg}' for a bogus record instead of "
               f"'Unknown endpoint') - rebuild the exe")
    elif code == 200:
        record(FAIL, ".../merge-effects is gone",
               "the scenario-specific endpoint still exists - rebuild the exe")
    else:
        record(FAIL, ".../merge-effects is gone", f"HTTP {code} {raw[:160]}")


def check_read_smoke(port, token, plugins):
    """plugins -> plugin -> records -> tree -> find."""
    if not plugins:
        record(SKIP, "read smoke", "no plugins loaded")
        return None
    names = [p.get("fileName", "") for p in plugins]
    record(PASS, "GET /api/plugins", f"{len(names)} loaded: {', '.join(names[:6])}"
           + (" ..." if len(names) > 6 else ""))

    first = names[0]
    code, data, raw = call(port, "/api/plugins/" + urllib.parse.quote(first), token)
    # This endpoint used to return a bare plugin object without "ok"; the current
    # source adds it. Only HTTP 200 + fileName is required to pass, and a missing
    # "ok" is reported as an informational hint that the exe is behind the source.
    ok = (code == 200 and isinstance(data, dict)
          and data.get("fileName", "").lower() == first.lower())
    record(PASS if ok else FAIL, "GET /api/plugins/{file}",
           f"file={first} HTTP {code} keys={list(data)[:4] if isinstance(data, dict) else '?'}")
    if isinstance(data, dict) and "ok" not in data:
        record(INFO, "GET /api/plugins/{file} envelope",
               "no 'ok' field - this exe predates the consistency fix")

    # pick a plugin that actually has RACE records, for a cheap bounded query
    target, recs = None, []
    for name in names[:8]:
        q = urllib.parse.urlencode({"signature": "RACE", "limit": 5, "names": 1})
        code, data, _ = call(port, "/api/plugins/" + urllib.parse.quote(name) + "/records?" + q, token)
        if code == 200 and isinstance(data, dict) and data.get("ok") and data.get("records"):
            target, recs = name, data["records"]
            break
    if not recs:
        record(SKIP, "GET records?signature=RACE", "no RACE records in the first plugins")
        return None
    record(PASS, "GET records?signature=RACE",
           f"file={target} returned={len(recs)} first={recs[0].get('loadOrderFormID')}")

    rec = recs[0]
    fid = rec.get("loadOrderFormID", "")
    code, tree, raw = call(port, "/api/plugins/" + urllib.parse.quote(target)
                           + f"/records/{fid}/tree?depth=3", token)
    ok = code == 200 and isinstance(tree, dict)
    record(PASS if ok else FAIL, "GET .../tree", f"{target}/{fid} HTTP {code}")

    edid = next((r.get("editorID") for r in recs if r.get("editorID")), None)
    if edid:
        q = urllib.parse.urlencode({"editorID": edid, "signature": "RACE", "exact": 1, "limit": 5})
        code, data, raw = call(port, "/api/find?" + q, token)
        found = code == 200 and isinstance(data, dict) and data.get("count", 0) >= 1
        record(PASS if found else FAIL, "GET /api/find",
               f"editorID={edid} count={data.get('count') if isinstance(data, dict) else '?'} "
               f"edidIndexEnabled={data.get('edidIndexEnabled') if isinstance(data, dict) else '?'}")
    else:
        record(SKIP, "GET /api/find", "no editorID on the sampled records")
    return (target, rec)


def check_write_roundtrip(port, token, target, rec):
    """Edit a FULL - Name leaf, verify, then restore the original value."""
    if not target or not rec:
        record(SKIP, "write round-trip", "no sampled record")
        return
    fid = rec.get("loadOrderFormID", "")
    base = "/api/plugins/" + urllib.parse.quote(target) + f"/records/{fid}"
    code, data, raw = call(port, base + "/tree?depth=3", token)
    if code != 200 or not isinstance(data, dict):
        record(FAIL, "write round-trip: tree", f"HTTP {code} {raw[:200]}")
        return
    leaves = []
    walk_leaves(data, leaves)
    leaf = next((l for l in leaves if str(l.get("path", "")).endswith("FULL - Name")), None) \
        or next((l for l in leaves if str(l.get("name", "")).startswith("FULL")), None)
    if leaf is None:
        record(SKIP, "write round-trip", f"no FULL - Name leaf in {target}/{fid} depth 3")
        return
    path, original = leaf["path"], leaf.get("value", "")
    probe = original + " [api-verify]"

    code, data, raw = call(port, base + "/values", token, method="POST",
                           body=json.dumps({"values": {path: probe}}))
    if code == 403 and ((data or {}).get("error") or {}).get("code") == "read_only":
        record(SKIP, "write round-trip",
               f"{target}/{fid} is read-only (masters cannot be edited) - load a non-master "
               f"plugin or use --scratch-write")
        return
    if not (code == 200 and isinstance(data, dict) and data.get("ok")):
        record(FAIL, "write round-trip: set", f"HTTP {code} {raw[:200]}")
        return
    record(PASS, "write round-trip: set", f"{target}/{fid} '{path}' -> probe value")

    def current():
        c, t, _ = call(port, base + "/tree?depth=3", token)
        if c != 200 or not isinstance(t, dict):
            return None
        ls = []
        walk_leaves(t, ls)
        m = next((l for l in ls if l.get("path") == path), None)
        return None if m is None else m.get("value", "")

    got = current()
    record(PASS if got == probe else FAIL, "write round-trip: change visible",
           f"read back {got!r}")

    code, data, raw = call(port, base + "/values", token, method="POST",
                           body=json.dumps({"values": {path: original}}))
    ok_restore = code == 200 and isinstance(data, dict) and data.get("ok")
    got2 = current() if ok_restore else None
    record(PASS if (ok_restore and got2 == original) else FAIL, "write round-trip: restored",
           f"original={original!r} read back {got2!r} - net change is zero, nothing saved")


def check_scratch_write(port, token, target, rec):
    """No editable plugin loaded: create a throwaway one and edit inside it."""
    if not target or not rec:
        record(SKIP, "scratch write round-trip", "no source record to copy")
        return
    name = f"zz_api_write_probe_{int(time.time()) % 100000}.esp"
    body = json.dumps({"fileName": name, "isLight": False,
                       "records": [{"formID": rec.get("loadOrderFormID"), "file": target}]})
    code, data, raw = call(port, "/api/patch", token, method="POST", body=body)
    if not (code == 200 and isinstance(data, dict) and data.get("ok")):
        record(FAIL, "scratch write round-trip: create plugin", f"HTTP {code} {raw[:200]}")
        return
    q = urllib.parse.urlencode({"signature": rec.get("signature", "RACE"),
                                "limit": 5, "names": 1})
    code, data, _ = call(port, "/api/plugins/" + urllib.parse.quote(name) + "/records?" + q, token)
    recs = (data or {}).get("records") or []
    if not recs:
        record(FAIL, "scratch write round-trip", f"{name} lists no records")
        return
    record(PASS, "scratch write round-trip: scratch plugin",
           f"{name} with an override of {target}/{rec.get('loadOrderFormID')}")
    check_write_roundtrip(port, token, name, recs[0])
    record(INFO, "cleanup", f"do NOT press Save in xEdit - the in-memory scratch plugin "
                            f"'{name}' disappears when you exit without saving")


def check_patch_autosave(port, token, data_dir, existing_name):
    """autoSave must be gone, and an existing name must be refused without a modal dialog."""
    # Regression first: /api/patch used to fall through to frmMain.AddNewFileName,
    # which pops a modal "file exists already" dialog and blocks the whole API.
    if existing_name:
        body = json.dumps({"fileName": existing_name, "isLight": False, "records": []})
        t0 = time.time()
        code, data, raw = call(port, "/api/patch", token, method="POST", body=body, timeout=20)
        dt = time.time() - t0
        err = (data or {}).get("error") or {}
        ok = code == 409 and err.get("code") == "file_exists"
        detail = f"file={existing_name} HTTP {code} code={err.get('code')} in {dt:.1f}s"
        if code is None:
            detail += (" - TIMEOUT: the build still reaches the GUI, which is showing a modal "
                       "dialog; click OK in xEdit to unblock the API")
        record(PASS if ok else FAIL, "/api/patch refuses an existing name (no modal dialog)", detail)
    else:
        record(SKIP, "/api/patch refuses an existing name", "no loaded plugin name available")

    if not data_dir or not os.path.isdir(data_dir):
        record(SKIP, "/api/patch autoSave ignored", "pass --data-dir to check the Data folder")
        return
    probe = f"zz_api_policy_probe_{int(time.time()) % 100000}.esp"
    if any(f.lower() == probe.lower() for f in os.listdir(data_dir)):
        record(SKIP, "/api/patch autoSave ignored", f"{probe} already exists on disk")
        return
    body = json.dumps({"fileName": probe, "isLight": False, "autoSave": True, "records": []})
    code, data, raw = call(port, "/api/patch", token, method="POST", body=body)
    if not (code == 200 and isinstance(data, dict) and data.get("ok")):
        record(FAIL, "/api/patch autoSave ignored",
               f"HTTP {code} {raw[:200]} (if it hung, a modal dialog may be waiting in the GUI)")
        return
    on_disk = any(f.lower() == probe.lower() for f in os.listdir(data_dir))
    record(PASS if not on_disk else FAIL, "/api/patch autoSave ignored",
           f"in-memory plugin {data.get('fileName')} created; file on disk: {on_disk}")
    record(INFO, "cleanup", f"do NOT press Save in xEdit - the in-memory probe "
                            f"'{data.get('fileName')}' disappears when you exit without saving")


# --------------------------------------------------------------------------- #

def main():
    ap = argparse.ArgumentParser(description="Verify the xEdit API save policy + smoke test")
    ap.add_argument("--port", type=int, default=7000)
    ap.add_argument("--token", default="")
    ap.add_argument("--write-test", action="store_true",
                    help="edit a field and restore it (in memory only)")
    ap.add_argument("--scratch-write", action="store_true",
                    help="with --write-test: when only masters are loaded (nothing editable), "
                         "create a throwaway plugin holding one override and edit inside it "
                         "(do NOT save in the GUI afterwards)")
    ap.add_argument("--patch-test", action="store_true",
                    help="create a throwaway in-memory plugin to prove autoSave is ignored "
                         "(do NOT save in the GUI afterwards)")
    ap.add_argument("--data-dir", default="",
                    help="game Data folder, used by --patch-test to assert nothing was written")
    args = ap.parse_args()

    print(f"xEdit API policy/regression check - http://127.0.0.1:{args.port}"
          f"{' (token auth)' if args.token else ''}\n")

    st = check_status(args.port, args.token)
    check_index(args.port, args.token)
    check_client_source()

    plugins = []
    if st and st.get("pluginsLoaded"):
        code, data, _ = call(args.port, "/api/plugins", args.token)
        if code == 200 and isinstance(data, dict) and data.get("ok"):
            plugins = data.get("plugins") or []
        else:
            record(FAIL, "GET /api/plugins", f"HTTP {code}")

    check_save_endpoint(args.port, args.token, plugins[0].get("fileName") if plugins else None)
    check_batch_save_op(args.port, args.token)
    check_scenario_endpoints_gone(args.port, args.token,
                                  plugins[0].get("fileName") if plugins else None)

    sample = check_read_smoke(args.port, args.token, plugins)
    if args.write_test:
        if args.scratch_write:
            check_scratch_write(args.port, args.token, *(sample or (None, None)))
        else:
            check_write_roundtrip(args.port, args.token, *(sample or (None, None)))
    else:
        record(SKIP, "write round-trip", "pass --write-test to exercise an edit (in memory)")
    if args.patch_test:
        check_patch_autosave(args.port, args.token, args.data_dir,
                             plugins[0].get("fileName") if plugins else None)
    else:
        record(SKIP, "/api/patch autoSave ignored", "pass --patch-test --data-dir <Data>")

    n_pass = sum(1 for s, _, _ in results if s == PASS)
    n_fail = sum(1 for s, _, _ in results if s == FAIL)
    n_skip = sum(1 for s, _, _ in results if s == SKIP)
    print(f"\n=== {n_pass} passed, {n_fail} failed, {n_skip} skipped ===")
    if n_fail:
        print("FAILED checks mean the running exe does not match the source tree yet - "
              "rebuild in the Delphi IDE (LiteDebug/Win64) and copy the new exe.")
    return 1 if n_fail else 0


if __name__ == "__main__":
    sys.exit(main())
