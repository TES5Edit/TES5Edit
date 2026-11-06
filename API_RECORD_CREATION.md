# Empty native record creation

`POST /api/batch` now accepts `create-empty-record`, distinct from the existing
`create-record` clone operation:

```json
{"strict":true,"ops":[{"op":"create-empty-record","file":"Test.esp",
 "signature":"SPEL","editorID":"APIProbeSpell"}]}
```

The destination must already be loaded. Signature must have a definition in this
game. Native file Add creates/finds the top-level group; native group Add with
silent=true allocates the FormID without a GUI prompt. Default initialization
and UpdateRefs use xEdit's own behavior. These defaults do not imply a completed,
valid spell/item: inspect and initialize required data afterward.

Results include `result.state`, `result.formID` (load-order hex) and
`result.reversible:false`. Use the returned ID for later field/reference calls.
There are no temporary symbols linking same-batch operations yet. This op rejects
source, values and supplied formID rather than silently ignoring them. Optional
editorID collisions are checked within the destination even with EDID indexes
disabled; this may scan a large plugin. Cross-plugin duplicate IDs are not checked.

States: not_applied for early validation failure; possibly_partial if native
creation/default/EDID/ref updates were attempted and failed. A group or record
can remain after such a failure; when allocation returned a record its FormID is
included. There is no automatic removal or structural undo. An attempted FormID
allocation can also advance the file header counter. Use an Idempotency-Key for
retries; HTTP 200 is not equivalent to all batch operations succeeding.

Current scope is ordinary top-level groups only. Header/player, world/cell,
dialog INFO, landscape/pathgrid/navmesh and placed-reference creation are rejected
pending specialized parent handling. Other game-specific types can still be
rejected by the native group implementation. No assertion of all-signature or
cross-game parity is made. Persisting the plugin remains GUI-only.

Runtime gate after Build/MO launch: create a uniquely named SPEL in an unsaved
test plugin, inspect its tree/new ID; repeat same-key request and verify no second
record; reject duplicate EDID and invalid/child signatures before allocation;
initialize fields and attach it to a race list through set-link; inspect counts
and references. Test partial failure reporting. Keep the session unsaved because
record-removal/transactional undo are not implemented in this increment.

Previous pending coverage: successful clear-element on a native clearable field,
and missing-master set-link rejection still need a running API session. Port 7000
was unavailable when this source increment was prepared, so no live tests ran.

## Runtime verification — 2026-11-05

Rebuilt SSEEdit PID 36712 loaded SCSI-UBERace-Patch.esp through /api/load.
The reference-cache interaction was answered yes through the API. Status reached
ready. Created SPEL FE002800 (APIProbeSpell_0cf6dd47) with native defaults;
the identical Idempotency-Key request returned the identical response. Repeating
without the key rejected the duplicate EditorID with state not_applied.
ZZZZ, REFR and TES4 were rejected with state not_applied and no returned ID.

Added FULL, initialized six fields (name, cost, charge time, cast type, delivery,
effect magnitude), and linked Effects/0/EFID to Skyrim.esm MGEF 00012F03.
Readback confirmed each value. Added an Actor Effect to race 05005734 and linked
it to FE002800. Native sorting moved the entry; reacquired its actual index and
removed it. The complete depth-20 race tree equaled the pre-test tree afterward.
The new spell remains in memory; no plugin save was performed. No assertion of
in-game validity or complete spell authoring follows from these checks.

Scalar changeset regression passed preview, precondition rejection, diff,
idempotent replay, conflicting key rejection, inspection and verified rollback.
Read-only status/log checks also passed. Successful clear-element,
missing-master rejection and post-allocation failure reporting remain untested.
Localized Skyrim text appeared as replacement characters in API responses;
encoding needs separate investigation.

Follow-up runtime checks in the same session:

- A set-link from FE002800 to Dragonborn.esm 0301E2A6 was rejected for a
  missing master (not_applied); the entire spell tree was unchanged.
- Chinese FULL text survived an exact write/read round trip and was restored.
  This narrows the existing localized-text issue; it does not prove the loaded
  STRINGS resources or language/codepage configuration are correct. The HTTP
  request/response code uses UTF-8; native localization chooses decoding by
  resource language and optional .cpoverride. No global encoding was changed.
- Created temporary FLST FE002801 and NAVI FE002802. In NAVI, added NVMI and
  one nested Edge Links item using legacy add-item. The native field became
  clearable; clear-element succeeded and readback confirmed childCount=0.
  This is one array case, not general NAVI authoring validation. All three
  temporary records FE002800–FE002802 remain unsaved in memory.
- Post-allocation creation failure reporting is still unverified.

Found a query parser defect: `path=Navmesh+Infos` returned 404 while
`path=Navmesh%20Infos` returned 200 for the same existing element. The source
now replaces '+' with space only in query values, before percent decoding;
%2B and URL path plus characters retain their literal meaning. This fix awaits
manual Build and runtime verification. After restarting/loading, run:

```powershell
python api-client/verify_query_encoding.py --file SCSI-UBERace-Patch.esp --record 05005734 --path "Actor Effects"
```

The regression is read-only and checks equivalent space encodings and distinct
literal-plus handling.

Rebuild verification on 2026-11-05 (PID 35464): the query regression passed for
both `Actor Effects` and nested `DATA - DATA\Base Carry Weight` in race
05005734. In each case '+' and %20 returned identical successful metadata and
%2B remained distinct. Status/log verification passed in ready phase. Tests
performed no record edits or saves; old cache cleanup was confirmed via API.
