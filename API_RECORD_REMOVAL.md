# Native record removal

`POST /api/batch` accepts:

```json
{"strict":true,"ops":[{"op":"remove-record","file":"Test.esp",
 "formID":"FE002800","mode":"new-record","expectedEditorID":"APIProbeSpell",
 "dryRun":true}]}
```

Set dryRun false or omit it to execute. This physically removes the record in
memory; it does not set the Deleted flag. No save endpoint is added.

Mode new-record supports original records only: native IsMaster, no overrides,
no child group, no incoming references, native editable/removable. It is not
restricted to records created by this API. File ownership and exact EditorID
are checked; mode must be explicit. Parent/child cascades and reference
replacement are not implemented. References reflect the
currently loaded session; unloaded plugins are not inspected.

The main-thread GUI callback clears matching history entries, clears the active
comparison, removes the navigation node where required, calls native Remove,
and refreshes navigation/view. The API checks that the ID is absent afterward.
Preview performs the same eligibility checks without invoking the callback.
Use an Idempotency-Key for retry; same-key replay returns the original success,
whereas a fresh request for an already removed ID fails.

Results include state preview/not_applied/possibly_partial/applied, original ID,
EditorID, reversible:false. A callback/native exception can leave partial data
or GUI changes. There is no structural rollback. Removal does not promise to
restore allocation counters, plugin modified flags, or empty groups from earlier
creation. Scalar changesets targeting a removed record cannot restore it.

After manual Build and MO launch/load, run against an unsaved test plugin:

```powershell
python api-client/verify_record_removal.py --file SCSI-UBERace-Patch.esp
```

This creates/removes only its own new SPEL and FLST and checks preview, EDID
mismatch, incoming-reference refusal, detach, 404, replay and absent-record
rejection. Override and child-group guards, and GUI behavior with an actively
selected record need additional runtime coverage. Do not claim GUI parity from
these cases alone.

## Runtime verification — 2026-11-05

Rebuilt SSEEdit PID 3708 loaded SCSI-UBERace-Patch.esp via the API. Reference
cache cleanup was answered yes; status reached ready. The integration script
passed all assertions: create SPEL, preview without removal, reject incorrect
EditorID, create FLST and link it to SPEL, reject deletion with incoming
references (state not_applied and complete spell tree unchanged), remove the
reference array, remove FLST, remove SPEL, verify both return 404. Identical-key
removal replay returned original success; a fresh removal of the absent SPEL
was rejected without mutation.

Both temporary records were removed from memory. No plugin was saved. Allocation
counters/modified flags/empty groups were not restored. Existing race 05005734
passed the scalar changeset suite (including verified rollback), and query
space/literal-plus encoding regression passed afterward. The active GUI
selection case and post-allocation creation failure reporting remain untested.

## Override mode

```json
{"strict":true,"ops":[{"op":"remove-record","file":"TestPatch.esp",
 "formID":"00012FD0","mode":"override","expectedEditorID":"Firebolt",
 "expectedMasterFile":"Skyrim.esm","expectedWinningFile":"TestPatch.esp",
 "dryRun":true}]}
```

Requires an actual override with no child group and native edit/remove permission.
expectedMasterFile and expectedWinningFile are mandatory and checked against the
loaded chain before mutation. Both winning and non-winning overrides are eligible.
Removing a non-winning override can leave the winning file unchanged. Removing
the winning override exposes the preceding definition. The Deleted flag is not
set, other overrides and the original are preserved, and masters are not cleaned.

Incoming references are allowed in this mode because the original FormID survives.
Their effective behavior can change when a different definition becomes winning;
the API does not promise equivalent game behavior. References to child records
are outside this increment, which rejects child groups. Results add mode,
masterFile and winningFile; winningFile describes the pre-state in preview and
the observed post-state on success. On failure it is diagnostic only.

The same GUI cleanup callback is used. Postchecks verify the destination no
longer contains the record and the original is still available. There is no
structural undo; use an unsaved test session.

After manual Build/load:

```powershell
python api-client/verify_override_removal.py
```

The script copies Skyrim.esm Firebolt into a uniquely named in-memory patch,
checks preview and mode/chain mismatch rejection, removes only that override,
then checks the original tree and global override chain equal their pre-test
responses. It also checks same-key replay. The empty temporary plugin remains
in memory, unsaved. Non-winning removal and active GUI selection still require
separate coverage.

### Override runtime verification — 2026-11-05

Rebuilt SSEEdit PID 30624 loaded the test plugin and reached ready. The script
passed override copy, preview, wrong mode/master/winning rejection, native
removal, destination 404, original tree/global chain restoration and same-key
replay. Temporary patch: APIProbeOverride_e0a02bb5a01d.esp.

An additional two-patch chain test copied Firebolt into
APIProbeChain_7023020def.esp and APIProbeChain_50b17322a6.esp. Removing the first
(non-winning) override preserved the second as winner; removing the second
returned winningFile Skyrim.esm. Both destination lookups returned 404, and the
complete original tree and global chain equaled their pre-test responses.

The original-record deletion suite (including incoming-reference refusal and
detach) and status/log regression passed afterward. No saves were performed.
Three empty temporary plugins remain in memory. Active GUI selection and
child-group rejection still lack runtime coverage; no cascade/structural undo
is implemented.
