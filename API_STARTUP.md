# API startup selection

## Unified status and logs (requires a new Build)

`GET /api/status` now exposes `phase`: `initializing`,
`waiting_for_selection`, `waiting_for_interaction`, `loading`, `ready`, or
`failed`. Failure takes priority over waits; interaction takes priority over
selection; ready requires loader completion without errors. Existing flags are
retained. `busy` is true only for `loading`.

`phaseSince` is the UTC ISO-8601 transition timestamp; `phaseDurationMs` uses a
monotonic clock. Loader transitions are observed by the main-thread API timer,
so these are observation timestamps, not exact background-thread event times.
`lastLoadError` contains a reported startup exception/fatal message, or a generic
failure message directing the client to logs. A startup-list exception now sets
the loader error instead of leaving status permanently loading. Data handlers
remain gated after a loading failure, even if the loader completion flag is set.

`GET /api/logs?after=0` returns recent GUI/loader messages with `sequence`, UTC
`time`, and `message`. Use `nextCursor` as the next `after` value. Up to 200 entries
are retained, each message capped at 2000 characters; `truncated:true` means the
requested cursor predates retained history. Cursors belong to one process: reset
to zero when status PID changes. Logs can include local paths and plugin names;
they require the same token as other protected endpoints. `logCursor` in status
is the current sequence. The unauthenticated status endpoint also exposes
`lastLoadError`, consistent with the existing status exemption.

There is no automatic failure timeout: legitimate loading may take a long time.
An unintegrated modal or fatal path that does not report an error can still block
progress. API status requests may themselves be delayed by long main-thread work.

After manually rebuilding and launching through MO, run the read-only check:

```powershell
python api-client/verify_status.py
```

Also check phase transitions across selection, cache interaction, successful
loading and a real loading failure. Runtime checks have not been run for this
increment; the current running EXE still uses the previous status schema.

Use the existing `-SSE -api:7000` arguments when launching SSEEdit through MO.
No additional switch is needed. In normal plugin edit/view mode, API mode skips
the startup developer message and What's New modal, starts the HTTP server at
the selection stage, and waits for a selection. Normal non-API startup keeps its
existing dialogs. Cleaning and other specialized tool modes are not changed to
API-controlled selection.

1. `GET /api/status`: wait for `waitingForSelection: true`.
2. `GET /api/modules`: obtain available valid plugins from the MO-visible data
   environment. Each entry has `fileName` and `active` (current session module
   flag, initially derived from the active list; not a promise that it is loaded).
3. `POST /api/load` with `{"plugins":["MyMod.esp","OtherMod.esp"]}`.
   Names are exact plugin filenames, case insensitive. Dependencies are included
   by xEdit's native activation/load simulation. Unknown names, missing masters,
   circular dependencies, and load-slot errors reject selection; the agent may
   correct and submit again. Supply a fresh Idempotency-Key per new selection.
4. A 200 response means selection was accepted, not that loading succeeded.
   Poll `/api/status` until `pluginsLoaded` is true and `loaderError` is false.
   `loaderError: true` means loading failed. Existing data endpoints reject
   requests before loading completes.

`busy` reports background plugin loading: false while waiting for selection or interaction,
true after selection is accepted and loading is unfinished, and false after
loading completes or fails. It does not count the status query itself. API
requests execute serially on the main thread, so status cannot observe another
API handler midway through execution; a long handler can delay status replies.

The selection affects this xEdit process only. It does not change MO's plugin
activation list. Selection is one-shot: `/api/load` returns 409 outside the
waiting stage. Re-open SSEEdit to choose a different set. GET /api/modules remains
read-only. Token authentication applies to both new endpoints; only status is
unauthenticated as before. No save capability is added.

This source change requires a manual Delphi Build and testing through MO.
Validate startup status, module enumeration, invalid/empty selection, dependencies,
successful loading, duplicate load rejection, and closing while waiting. Other
loader warnings/errors can still require GUI attention; this is not a guarantee
of completely unattended startup under every game configuration.

## Structured interactions

Reference-cache cleanup is now connected to `GET /api/interactions`, accessible
before plugin loading completes. It returns `interactions: []` when none has been
created; otherwise it returns the latest interaction with `id`, `type`, `state`,
`blocking`, `message`, `choice`, and `choices` describing the effects of yes/no.
Only one pending interaction is supported. IDs are process-local GUIDs; a newer
interaction replaces the previous history entry. Unknown/expired IDs return 404.

`POST /api/interactions/{id}/respond` with `{"choice":"no"}` keeps the old cache;
`{"choice":"yes"}` authorizes the existing GUI cleanup path to delete it. No
automatic default/timeout response is submitted. The modal remains visible and
the user can answer it manually. Both paths update the same interaction state.
Closing the dialog without Yes is treated as No.

Status exposes `waitingForInteraction`; `busy` is false during this wait. Same
choice retries return success without invoking cleanup again. Opposite-choice
retries return 409 `interaction_resolved`. Existing token authentication and
optional Idempotency-Key support apply. A resolved response confirms the choice
was delivered; cleanup then runs through the original GUI flow, whose individual
file deletion failures are handled as before. It is not a deletion-success report.

Only reference-cache confirmation is wired in this increment. This is not a
generic handler for arbitrary Windows/third-party dialogs, and no save dialog is
exposed. API startup selection and skip behavior remain unchanged.

After manual Build, validate with an actual stale-cache prompt: status reports
waitingForInteraction, GET returns the visible message, invalid choices are
rejected without closing the dialog, No closes it and allows loading, repeated
No succeeds, and subsequent Yes conflicts. In another session test manual GUI
No and inspect the resolved state. Test Yes only when deleting those old cache
files is intended. These runtime checks have not yet been performed.
