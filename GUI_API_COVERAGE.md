# GUI editing parity: working inventory and implementation backlog

Scope: every plugin-data edit supported by this fork's GUI, in memory. Saving
remains GUI-only. UI layout/navigation and external asset generation are separate
from plugin edits, not silently counted as supported. Specialized modes and
game-dependent operations must be audited before claiming complete coverage.

This is an initial source inventory, not a completed parity certification.
Evidence below names handlers in `xEdit/xeMainForm.pas` and interfaces in
`Core/wbInterface.pas`. Existing uncommitted development is preserved.

Legend: **partial** means a usable primitive exists but not complete GUI parity;
**missing** means no dedicated/exhaustive API support was found; **pending** means
new source awaiting manual Delphi Build and runtime testing. Existing support
does not imply changeset/undo support. Runtime evidence currently covers SSE
only, including scalar edits on SCSI-UBERace-Patch.esp.

| ID | GUI capability / source evidence | API status | Next acceptance test |
|---|---|---|---|
| D01 | Exact field read; GetEditValue | pending: GET .../element | Compare FULL, numeric, enum and reference EditValues with GUI |
| D02 | Editing choices; IwbElement.EditInfo | pending: element?options=1 | Enumerations/flags; truncation; costly reference lists |
| D03 | Add templates; GetAssignTemplates, mniViewAddClick | pending: element?templates=1 | Enumerate legal container additions without mutating |
| D04 | Edit/remove/clear eligibility | pending: element metadata | Editable, protected and optional elements |
| D05 | Full type schema, union rules, reference target restrictions | missing | Agent discovers rules for unfamiliar record signatures |
| E01 | Scalar edit; vstViewNewText | partial: values, batch set, tracked scalar changesets | Normalization, callbacks, partial failure; basic tests passed |
| E02 | Reference field edit; SetLinksTo | partial: legacy set/copy only | Resolve target, validate type, add masters, verify link |
| E03 | Flag edits; GUI field editor | partial: legacy values | Individual bits and record flags without clobbering other bits |
| E04 | Optional field addition; mniViewAddClick | partial: batch copy only creates some missing targets | Add absent optional field without source record |
| E05 | Optional field removal; mniViewRemoveClick | partial: numeric remove-item only | Named optional element, required-field rejection |
| E06 | Clear/reset; mniViewClearClick | missing | Preserve GUI's distinction between clear and remove |
| E07 | List addition; mniViewAddClick | partial: add-item | Empty list, native template, count callback, returned item identity |
| E08 | List removal; mniViewRemoveClick | partial: remove-item | Valid/invalid index, required count, references updated |
| E09 | List ordering; mniViewMoveUp/DownClick | missing | Reorder only when GUI permits; reject sorted containers |
| E10 | Native sorting; mniViewSortClick | missing | Match GUI sort results and preserve linked fields |
| E11 | Drag/drop assignment; vstViewDragDrop | partial: batch copy/copy-elements | Arbitrary nested source/target paths and CanAssign checks |
| E12 | Bulk field copy; mniViewCopyToSelectedRecordsClick | partial: batch orchestration | Per-record result, dependencies and partial failure |
| R01 | New empty record; mniNavAddClick | missing | Create by signature, defaults, allocate FormID, return identity |
| R02 | Copy as override; mniNavCopyIntoClick | partial: patch | Existing destination, children and dependencies |
| R03 | Copy as new; mniNavCopyIntoClick | partial: create-record | Return structured new ID, EDID collision policy, linked records |
| R04 | Remove record/override; mniNavRemoveClick | partial: original-record/reference guard and winning/non-winning override removal tested | Child handling pending; see API_RECORD_REMOVAL.md |
| R05 | Record flags; IwbMainRecord setters | partial: legacy values | Deleted/persistent/compressed etc. only where GUI allows |
| R06 | FormID change; mniNavChangeFormIDClick | missing | Collision checks and reference updates |
| R07 | Reference replacement; mniNavChangeReferencingRecordsClick | missing | Select scope, inspect before/after incoming links |
| R08 | Batch reference replacement | missing | Native batch behavior and bounded failure reporting |
| F01 | New plugin; AddNewFileName | partial: patch callback | Empty/nonempty plugin; name collision and header metadata |
| F02 | Plugin header editing | partial: legacy paths | Author/description/flags; validate game-specific restrictions |
| F03 | Add masters; mniNavAddMastersClick | partial: addmasters, batch masters | Missing dependency and circular dependency errors |
| F04 | Sort/clean masters; respective GUI handlers | partial: batch masters | Remapping preserves record references; report actual masters |
| V01 | Error checking; mniNavCheckForErrorsClick | missing | Structured checks for record/plugin, no modal interruption |
| V02 | Build references; mniNavBuildRefClick | missing | Observable task completion and incoming/outgoing links |
| V03 | Reachability; mniNavBuildReachableClick | missing | Read analysis versus mutation distinguished |
| A01 | Remove ITM; mniNavRemoveIdenticalToMasterClick | missing | Native criteria, preview candidates and actual changes |
| A02 | Injected-record cleanup; mniNavCleanupInjectedClick | missing | Identify candidates and match native cleanup behavior |
| A03 | Delta patch; mniNavCreateDeltaPatchClick | missing | Audit inputs and specialized output semantics |
| A04 | VWD operations; mniNavSetVWDAutoClick | missing | Determine game constraints and native bulk behavior |
| A05 | Spreadsheet edits; vstSpreadSheetNewText/drag handlers | audit needed | Ensure field primitives cover mutations rather than adding UI endpoints |
| A06 | Script-driven edits and remaining menu actions | audit needed | Inventory script-only mutations and classify special workflows |
| S01 | Preconditions and idempotency | partial: request-level checks and session replay | Same policy for every unified operation; document capacity |
| S02 | Diff and undo | partial: one-record scalar changesets | Structural snapshots; creation/removal; callback side effects |
| S03 | Saving | intentionally GUI-only | No API route or generic interaction may invoke save |

## Implementation order

Current source increment (awaiting manual Build): `API_ELEMENT_OPERATIONS.md`
adds shared native add-element/remove-element/clear-element/set-link dispatch
for E02/E04/E05/E06/E07. These rows remain partial until runtime acceptance;
structural diff/undo and legacy-op migration are still outstanding.

Next source increment: `API_RECORD_CREATION.md`, create-empty-record for ordinary
top-level records (R01 partial). Runtime acceptance, child-parent placement,
record removal and structural undo remain pending.

1. **Inventory + read foundation (in progress).** Finish source/menu audit,
   validate D01-D04. Do not describe EditInfo as a complete schema. Return the
   caller's usable path separately from displayPath; numeric array paths avoid
   duplicate display-name ambiguity.
2. **Unified element operations.** Build an internal operation dispatcher using
   existing CanAssign/Assign/GetAssignTemplates/Remove/SetToDefault and native
   reference setters. Legacy routes should delegate to it incrementally.
   Start E02/E04/E05/E07/E08; report structured new item/record identities.
3. **Record construction + dependency handling.** R01-R04 and F01-F04. First
   end-to-end fixture: create spell/effect records and add a reference to a race's
   Actor Effects. Next: copy armor, change keywords/enchantment and validate.
4. **Result/validation contract.** Every operation reports attempted/applied/
   failed, affected records/elements, implicit dependencies, warnings and actual
   diff. Never label a legacy batch atomic. Per-op expectations and temporary
   symbols for newly created records need an explicit contract.
5. **Structural recovery.** Prototype native detached snapshots before selecting
   an undo design; test identities, reference indexes, child records, file header
   and master mapping. A field-value inverse is not a structural snapshot.
   Expose reversible/irreversible status explicitly while coverage grows.
6. **Advanced parity.** R05-R08, V01-V03, A01-A06 plus all remaining audited menu
   edits, per supported game. Reuse native implementation rather than duplicate
   cleaning/reference algorithms in HTTP handlers.
7. **Agent contract + regression.** OpenAPI, examples, supported capabilities and
   version, fixture-based regression, GUI-vs-API comparisons. Update this matrix
   after every Build/test rather than claiming broad success from a few fields.

## Completion gates

Each row needs: source mapping, operation contract, legal/illegal-target checks,
runtime test evidence, callback/dependency verification, structured failure
behavior and declared recovery level. Overall parity requires no unaudited GUI
plugin-edit mutation paths; unsupported games/features remain explicitly listed.
Passing SSE fixtures alone does not establish cross-game parity.

Tests use disposable in-memory plugins or user-designated test plugins. Manual
Delphi Build and MO launch remain the validation boundary; no IDE automation.
