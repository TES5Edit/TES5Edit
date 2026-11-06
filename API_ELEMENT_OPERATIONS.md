# Native element operations: incremental runtime coverage

Four new `/api/batch` operations share an internal ExecuteElementOp dispatcher.
They reuse xEdit's GUI primitives, check the editable record and mode, optionally
compare the field's exact EditValue using `expected`, and call UpdateRefs after
success. Existing batch operations have not yet been migrated to this dispatcher.

Every operation requires `file`, load-order `formID`, `path`, and `op`. Use
Idempotency-Key for retry protection and top-level preconditions for multiple
request-start checks. `strict:true` stops after the first failure; it does NOT
roll back earlier operations or the failed operation's potential side effects.

## add-element

`path` selects an existing parent (empty path selects record root). Query the
parent with `/element?path=...&templates=1`, then pass an exact `template` name.
No template is guessed. Missing/ambiguous templates or native CanAssign rejection
fail before Assign. Creation uses Assign(wbAssignAdd, template, False) and
SetToDefaultIfAsCreatedEmpty, matching the GUI add primitive. Optional fields and
list entries use the same operation. Record-root removal is not supported.

```json
{"strict":true,"ops":[{"op":"add-element","file":"Test.esp",
 "formID":"05005734","path":"Actor Effects","template":"Actor Effect"}]}
```

The result returns the new element's actual edit value, displayPath, and numeric
relative `path` when found among the parent's children. Numeric paths describe
the post-operation order, not stable IDs: reacquire after sorting/other edits.
`applied` does not guarantee that a singleton template produced a brand-new child;
the native assignment semantics determine the outcome. Inspect results/counts.

## remove-element / clear-element

Runtime test found that record-root append templates do not enumerate missing
optional subrecords. The compiled and tested fix adds support for
`signature:"FULL"` instead of template in add-element, with `path:""`, to create an absent
top-level subrecord via native Add(signature). Existing subrecords and non-root
signature creation are rejected. Native definitions decide whether creation is
legal. Signature discovery remains incomplete. The legacy batch copy path also
now uses the source's native signature when recreating a missing subrecord;
the resolver falls back to native signature paths such as FULL.

Runtime evidence: list template creation, exact replay,
scalar reference setting to Firebolt, sorted-list removal, and complete visible
tree restoration passed. FULL removal and signature recreation now also pass,
as does copying from UBE_AllRace.esp to recreate a missing FULL using display-name
paths. Native signature reads/writes and duplicate creation rejection passed.
Both recreation paths restored the complete visible tree. Test record 05005734
ends with its original FULL value, Breton UBE. No plugin was saved. Other signatures,
games, successful Clear operations and missing-master rejection remain untested.

Operate on an existing named or numeric path. Native IsRemovable/IsClearable
must allow the operation. They call Remove/Clear, not arbitrary raw data writes.
The record root is explicitly rejected. Clear and remove remain distinct; a
required scalar can reject both. After list removal, reacquire numeric paths.

## set-link

Targets an editable scalar reference field, not a reference-containing structure.
Supply `source: {"file":"Skyrim.esm","formID":"000640B6"}`. The named plugin
and source record must already be loaded, and the owning source plugin must be
the destination or an existing master. Add masters separately first. This
increment deliberately does not auto-add implicit dependencies. References to
records newly cloned in earlier requests can use their actual load-order FormID.

Assignment uses native LinksTo and verifies the read-back load-order FormID. A
native refusal, normalization to a different target, or UpdateRefs exception is
reported as a failure. Full reference target-type schemas are still pending;
do not treat CanContainFormIDs as a complete list of legal signatures.

## Results and failure semantics

Each new op's batch result includes `result`:

```json
{"state":"applied","before":"...","after":"...",
 "path":"Actor Effects\\3","displayPath":"...","reversible":false}
```

`not_applied` means validation failed before invoking a mutator.
`possibly_partial` means a native mutation/default/callback/ref-update was
attempted and did not finish normally. Inspect the record; no automatic rollback
is attempted. `before/after` are selected element edit values, NOT a structural
diff or a complete side-effect report. Existing scalar changeset undo is not
extended to these operations. No save functionality is added.

## Manual Build / runtime gate

After Build and MO launch use the designated disposable/test plugin. Check
template discovery and addition; optional named-field removal/recreation;
list counts and references; valid link readback and rejected missing masters;
clear versus remove eligibility; expected-value mismatch; invalid template and
protected paths; idempotent retry; errors after an attempted mutation. Compare
with the GUI's behavior and inspect data afterward. Keep the session unsaved.
Do not claim parity or stable undo from compilation alone.
