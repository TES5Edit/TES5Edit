# API change safety (first increment)

These changes require rebuilding xEdit in Delphi. They have not been compiled
or exercised against xEdit yet. They do not add any save functionality.

## Session idempotency for every POST

Supply `Idempotency-Key: <unique key, at most 128 characters>`. An identical
method, raw URL (including query), and exact body returns the original HTTP
status and body without repeating the mutation. Different requests with the
same key return 409 `idempotency_conflict`. Errors are cached too. Authentication
still runs before replay. A retry after rollback also returns the original
response: it does not reapply the edit.

The cache lasts for this API server instance only. It keeps at most 128 keys;
it never evicts a key and rejects new keys at capacity with 503 before execution.
Restarting xEdit loses keys and history. Requests without keys retain their
existing behavior. This is not durable exactly-once execution across restarts.

## Optional preconditions on existing POST endpoints

Add this top-level array to a request, including `/api/batch`:

```json
{"preconditions":[{"file":"MyMod.esp","formID":"01000800",
  "path":"FULL - Name","equals":"Old name"}],"ops":[]}
```

Every condition is checked on the main thread before the handler runs. A
mismatch returns 409 `precondition_failed` with no operations executed. The
comparison uses exact `EditValue` strings. These are request-start conditions,
not per-operation conditions within batch. All entries require string fields.

## Tracked scalar edits

`POST /api/changesets`:

```json
{"file":"MyMod.esp","formID":"01000800",
 "expected":{"FULL - Name":"Old name"},
 "values":{"FULL - Name":"New name"},"dryRun":true}
```

`expected` must contain exactly the same paths as `values` (1..256 entries).
Values must be strings. Every path and expected value is validated before any
edit. Path aliases resolving to the same element are rejected. With `dryRun`
true, the response describes the requested changes without editing; it does
not execute setters and cannot predict normalization or callbacks. Omit dryRun
to apply; use an idempotency key when applying.

Responses include `changeSetID`, `state`, and `changes` entries containing
`file`, `formID`, `path`, `before`, `after`. Applied responses contain actual
EditValues after normalization. The diff covers the requested fields, not every
possible callback side effect. `GET /api/changesets/{id}` inspects the history.
Preview does not allocate a history ID. Up to 128 applied changesets are retained.

Scope: a single editable record in a non-localized plugin; scalar fields without
FormID references. Containers, references, localization string tables, creating
records/plugins, and master changes require structural snapshots and are not
supported by this endpoint. Existing write endpoints retain their existing
semantics and do not automatically create tracked diffs or undo history.

## Guarded, verified rollback

`POST /api/changesets/{id}/rollback` with `{}` restores requested fields in reverse
order. Before making any rollback edit it compares plugin metadata, record raw
bytes, and a recursively captured edit-value tree to the post-edit snapshot.
Later GUI/API edits cause 409 `rollback_conflict`, leaving them intact. The
complete snapshot must match the original before reporting `rolled_back`.
Already rolled-back requests are safe to repeat.

This first increment is not a general transaction/undo engine. Setter errors can
leave a `partial` changeset, which can be inspected and rolled back if its
snapshot is available. Rollback errors or failed whole-record verification leave
`rollback_failed`, never a false success. This state requires manual inspection;
automatic retry is refused. Callback side effects that cannot be reversed by
restoring fields remain a limitation. Dirty flags are not reset, and nothing is
saved. Snapshots are limited to 1 MiB and depth 128; keep initial use to simple
text/number fields in disposable plugins until IDE/runtime validation passes.

## Validation

Build LiteDebug / Win64 manually in Delphi, then launch through MO as usual.
Run the existing `api-client/verify_api.py` for compatibility and save policy.
For an explicitly chosen disposable editable record, run:

```powershell
python api-client/verify_changesets.py --file MyMod.esp --record 01000800 --path "FULL - Name" --before "Old name" --after "New name"
```

The integration check edits memory and rolls back in a finally block. It checks
preview, expected-value rejection, diff, response replay, conflicting key reuse,
history lookup, rollback verification, repeated rollback, and replay after undo.
Do not concurrently edit the test record; a conflict intentionally prevents undo.
Also manually check rollback conflict after a separate GUI edit, setter failure,
and callback-heavy field behavior before relying on this feature for real patches.
