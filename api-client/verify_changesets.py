"""Opt-in integration check against a rebuilt xEdit; edits memory, then rolls back.

Use an editable disposable, non-localized plugin and a scalar text field.
No save or launch operations are performed. Standard library only.
"""
import argparse
import json
import urllib.error
import urllib.request
import uuid


def call(base, path, body=None, key=None, token=None):
    data = None if body is None else json.dumps(body, ensure_ascii=False).encode("utf-8")
    request = urllib.request.Request(base + path, data=data)
    request.add_header("Content-Type", "application/json")
    if key:
        request.add_header("Idempotency-Key", key)
    if token:
        request.add_header("Authorization", "Bearer " + token)
    try:
        response = urllib.request.urlopen(request, timeout=120)
    except urllib.error.HTTPError as exc:
        response = exc
    with response:
        return response.code, json.load(response)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", default="http://127.0.0.1:7000")
    parser.add_argument("--token")
    parser.add_argument("--file", required=True)
    parser.add_argument("--record", required=True)
    parser.add_argument("--path", default="FULL - Name")
    parser.add_argument("--before", required=True, help="Exact current EditValue")
    parser.add_argument("--after", required=True, help="Valid different EditValue")
    args = parser.parse_args()
    if args.before == args.after:
        parser.error("before and after must differ")
    key = "verify-" + uuid.uuid4().hex
    payload = dict(file=args.file, formID=args.record,
                   values={args.path: args.after}, expected={args.path: args.before})
    def request(path, body=None, request_key=None):
        return call(args.base, path, body, request_key, args.token)

    status, preview = request("/api/changesets", dict(payload, dryRun=True))
    assert status == 200 and preview["ok"] and preview["state"] == "preview", preview
    assert preview["changes"][0]["before"] == args.before, preview
    bad = dict(payload, expected={args.path: args.before + uuid.uuid4().hex})
    status, result = request("/api/changesets", bad)
    assert status == 409 and result["error"]["code"] == "precondition_failed", result
    status, result = request("/api/changesets", payload, key)
    change_id = result.get("changeSetID")
    if status != 200 or not change_id:
        raise AssertionError(result)
    rollback_path = "/api/changesets/" + change_id + "/rollback"
    try:
        assert result["ok"] and result["state"] == "applied", result
        status, replay = request("/api/changesets", payload, key)
        assert status == 200 and replay == result, replay
        status, conflict = request("/api/changesets", dict(payload, dryRun=True), key)
        assert status == 409 and conflict["error"]["code"] == "idempotency_conflict", conflict
        status, stored = request("/api/changesets/" + change_id)
        assert status == 200 and stored == result, stored
        assert result["changes"][0]["after"] == args.after, result
    finally:
        status, rolled = request(rollback_path, {})
        if status != 200 or not rolled.get("ok") or rolled.get("state") != "rolled_back":
            raise RuntimeError("Rollback needs attention; changeset=" + change_id + ": " + repr(rolled))
    status, repeated = request(rollback_path, {})
    assert status == 200 and repeated["state"] == "rolled_back", repeated
    # Replaying the original request after rollback must not apply it again.
    status, replay = request("/api/changesets", payload, key)
    assert status == 200 and replay == result, replay
    status, preview = request("/api/changesets", dict(payload, dryRun=True))
    assert status == 200 and preview["ok"], preview
    print("PASS: preview, preconditions, diff, replay, key conflict, inspection, verified rollback")


if __name__ == "__main__":
    main()
