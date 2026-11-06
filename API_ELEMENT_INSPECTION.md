# Precise element inspection: first schema-discovery increment

Compiled and runtime-tested on SSE with SCSI-UBERace-Patch.esp. Record root,
Actor Effects and DATA report 39/3/31 children in the tested race. Scalar FULL
also implements the native container interface but has zero children.

`GET /api/plugins/{file}/records/{formID}/element?path=<URL-encoded path>`

Returns name, caller path, displayPath, numeric xEdit elementType, display value,
exact editValue, editable/removable/clearable, canContainFormIDs, isContainer and
childCount where applicable. An empty path selects the record root. Missing
records/paths return 404; only GET is supported. Existing auth and loaded-state
gates apply. This endpoint does not edit or create history.

`isContainer` means the object exposes a native xEdit container interface. Some
scalar subrecords return true with childCount=0. Neither this flag nor zero
children implies support for arbitrary additions; inspect native templates and
operation eligibility instead. An empty list can also have zero children.

Optional `options=1` requests xEdit's native EditInfo, returned as editOptions.
These strings are editor options, not a full type/validation schema; an empty
list does not mean arbitrary text is valid. Optional `templates=1` requests native
GetAssignTemplates(wbAssignAdd), returned as addTemplates names. Template names
are advisory for this current container state, not persistent IDs or a new edit
operation. Both arrays are capped at 256 with explicit truncation flags; native
enumeration itself may still be expensive. Avoid requesting them unnecessarily.

Use editValue, not display value, when constructing exact expected conditions.
Use numeric list indexes for repeated names. The returned metadata describes
xEdit eligibility; it does not imply the scalar changeset endpoint supports that
element or that an operation has an undo implementation.

After manual Build test FULL, floating-point normalization, enum choices,
FormID reference display vs edit value, protected master fields, optional fields,
empty/nonempty lists and native templates, missing paths and POST rejection.
Compare with GUI editor options. Then rerun existing read/save-policy tests.
