# Structural changesets — source awaiting manual Build/runtime verification

Null-reference increment (source awaiting Build/test): set-link changesets now
accept an original LinksTo=nil only when NativeValue is numeric zero. Nonzero
unresolved references remain rejected before mutation. Rollback uses native
LinksTo=nil and verifies numeric zero plus nil resolution, then still requires
complete raw/tree/plugin snapshot equality. No reference IDs are guessed from
display strings. Run `python api-client/verify_null_link_changesets.py` after
Build/load. It creates its own FLST, adds a null LNAM, sets Firebolt, rolls back
to null, checks replay and removes the temporary record. No save is performed.
This increment has not yet been compiled or runtime-tested.

Null-reference runtime gate passed on 2026-11-06, PID 39364: a temporary FLST
with a null LNAM was changed to Firebolt, replayed with the same key, rolled
back to numeric zero/nil with complete normalized snapshot verification, and
removed. Repeated rollback returned the same result. No saves were performed.
The existing non-null link and add-element changeset suites also passed in
this process. Nonzero unresolved references remain intentionally unsupported.

## Reference changeset increment — awaiting another Build/test

POST /api/element-changesets now also accepts op set-link with the same
file/formID/path/source shape as batch set-link. The original reference must
resolve to a loaded main record; null and unresolved originals are rejected
before mutation in this increment. Existing-master validation is unchanged.
The original target plugin/ID is retained, the changed element's actual sorted
location and subtree are captured, and rollback uses native LinksTo followed
by UpdateRefs. Full normalized raw/tree/plugin equality is required for success.
Original target availability is rechecked before rollback. No automatic master
addition, null restoration, multi-operation transaction or save is included.

After Build/load, run `python api-client/verify_link_changesets.py` against the
usual unsaved test plugin. It changes the first Actor Effect to Firebolt and
checks diff, replay, rollback after list sorting and complete visible content
restoration; server verification includes normalized raw bytes and metadata.
This new mode has not been compiled or runtime-tested yet.

Reference runtime gate passed on 2026-11-06, PID 40516: changing the first Actor
Effect in race 05005734 to Skyrim.esm Firebolt produced full diff and successful
same-key replay. Native rollback after list sorting returned rolled_back with
complete normalized raw/tree/plugin verification; client visible content
returned to its pre-test state. Repeated rollback returned the same result.
No save occurred. Null/unresolved originals remain unsupported. Separate
reference-mode conflict/error-path coverage is still pending; the shared guard
is covered by the add-element suite.

Latest runtime gate passed on 2026-11-06, PID 6344: race 05005734 accepted the
full snapshot; add-element diff, replay, inspection, conflict rejection and
native rollback passed. Server reported rolled_back only after complete raw,
node-tree and plugin-metadata equality. Client tree comparison excludes only
the derived Record Header/Data Size field, which native serialization refreshes
lazily; this does not weaken the server fingerprint verification. An initial
client assertion stopped after conflict refusal because of that header refresh;
its added null entry was cleaned up, the client comparison was corrected, and
the complete suite passed on rerun. FULL is Breton UBE and Actor Effects has
its original three entries. No plugin was saved. Broader structural operations
and failure paths remain outside this passed case.

First increment adds `POST /api/element-changesets` for a single add-element
operation. Existing batch operations retain their current semantics and do not
automatically acquire undo. Record creation/deletion, remove/clear-element and
set-link remain outside this changeset increment.

```json
{"op":"add-element","file":"Test.esp","formID":"05005734",
 "path":"Actor Effects","template":"Actor Effect"}
```

Native template and root signature addition use the existing ExecuteElementOp.
Use Idempotency-Key and normal top-level preconditions. `dryRun` is explicitly
rejected: a structural preview requires a sandbox that does not exist yet.
Non-localized editable records only. No plugin saving is exposed.

The response includes changeSetID, state, error, reversible, diffComplete,
recordOrMetadataChanged and changes. diffComplete is false if the after-snapshot
could not be captured; the response must not be treated as a complete diff then.
recordOrMetadataChanged includes differences in the full fingerprint, so raw or
metadata changes can be flagged even when positional node differences are empty. Each
change has a numeric record-relative path and before/after objects (or null):
name, editValue, childCount. Comparison covers every node, including count fields
and other visible side effects, rather than only the requested parent value.
Paths identify positions: sorting can produce multiple changed positions. This
is not a semantic list-move diff and does not assign persistent element IDs.
Raw bytes and plugin metadata are checked separately, not exposed in the diff.

Inspect via GET /api/changesets/{id}; rollback via POST to its /rollback suffix.
The server identifies the actual added element before serialization and records
its numeric position plus a complete subtree fingerprint. It offers rollback
only after observing exactly one new removable
child and the parent count increasing by one. Otherwise the operation can have
mutated data but returns partial/error and no available rollback.

Rollback first checks the entire raw record, all node values/structure and plugin
metadata still match the captured after-state. A mismatch returns 409 before
editing. Native Remove and UpdateRefs then run; rolled_back is reported only if
the complete snapshot equals the before-state. Native errors or incomplete
restoration yield rollback_failed, never success. There is no automatic rollback
on application errors. Manual/GUI edits that happen to reproduce the snapshot
are not a version history. Serialization rebuilds native objects, so rollback
re-resolves the saved position only after the complete record fingerprint
matches, and also verifies the complete added subtree. If normalization moves
or changes that subtree, rollback is not offered. Use one uninterrupted test
session; GUI delete/recreate and complex native normalization need runtime tests.

Limits: shared 128 changeset session capacity; 256 KiB requests; depth128,
16384 nodes, 2 MiB node JSON and 4 MiB total fingerprint per snapshot. Snapshots
are not persisted. Structural rollback does not restore GUI selection, modified
flags, unloaded plugins, file allocation counters or external string tables.
The initial scope adds elements to an existing record and allocates no FormIDs.

After manual Build, MO launch and test plugin loading:

```powershell
python api-client/verify_element_changesets.py
```

The script adds an Actor Effect to the test race, checks diff/inspection/replay,
changes FULL to verify conflict refusal without further edits, restores FULL,
rolls back and compares the full visible tree. The server additionally verifies
raw bytes and plugin metadata. This new functionality is not yet compiled or
runtime-tested by the agent. Optional subrecord additions, normalization side
effects, snapshot-limit errors and partial failure paths need separate coverage.

## First runtime attempt — 2026-11-05, PID 39724

This build did NOT pass the integration gate. The race contains 10321 nodes
(maximum observed visible depth8), exceeding the original 8192-node cap. The
request was rejected before mutation. Source limits were increased as above;
that change requires another manual Build.

On a disposable SPEL FE002800, adding an Effect produced complete positional
diffs, including child count and header size, but the retained-child eligibility
check returned partial/reversible:false. Adding FULL at root also returned
partial. No structural rollback success is claimed. Native serialization can
normalize headers/rebuild containers, and capture ordering was inconsistent.
Source now serializes raw data before node traversal, captures old child
identities after the pre-snapshot, checks addition eligibility before the
post-snapshot, and verifies retained identity again afterward. More precise
count diagnostics are included. These source corrections are not yet tested.

The test script now accepts --parent and --template for smaller test records.
The disposable SPEL (including both added elements) was removed using the
already verified record-removal API. The original race was not edited. No save
occurred. Rebuild is required before retesting conflict checks/native rollback.

## Second runtime attempt — PID 31896

The enlarged snapshot accepted race 05005734, and full positional diff included
SPCT 3->4, Actor Effects 3->4, sorted entries and header size 70432->70442.
Eligibility passed before serialization, but the post-snapshot identity check
rejected rollback: native serialization rebuilt the added element object.
This confirms the retained-interface approach is unsuitable. No successful
structural rollback is claimed. The added null Actor Effect was removed via the
existing element API; the list returned to the original three spell references.
No save occurred.

Source now records the verified new element's actual numeric location and full
subtree fingerprint before serialization, validates that location/content after
serialization, releases the stale interface, and re-resolves only after the
whole after-snapshot matches on rollback. The complete restored raw/tree/plugin
snapshot is still required for success. This correction needs another manual
Build and runtime test; the current process cannot exercise it.
