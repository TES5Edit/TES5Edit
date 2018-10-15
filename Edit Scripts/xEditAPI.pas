(*
  xEdit API declarations to be used for editing scripts using Delphi.
  With this file you can now edit xEdit scripts using Delphi.
  This gives you full IDE benefits like checking for warnings and errors before
  executing your script, as well as intellisense and code insights.

  For example purposes in this documentation, we assume a user created xEdit script named GreatScript.pas.
  However, you can name your script almost anything. There are some limitations though,
  because the name of the script must match the unit declaration of the script, and
  unit names have limitations. For more info on naming restrictions, see:
    http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Fundamental_Syntactic_Elements_(Delphi)#Identifiers

  Instructions to get started editing xEdit scripts with Delphi:
  1. Download the free Delphi Starter edition from https://www.embarcadero.com/products/delphi/starter
  2. Create new console application project named GreatScriptApp
  3. Add this file xEditAPI.pas and GreatScript.pas to the project (menu Project -> Add to project)
  4. At the top of the script, modify or add the unit clause. The name of the unit must
     match exactly the filename of your script without the .pas extension.
  5. Then add the interface, implementation, and uses clauses to your script below.
     Afterwards, the top of your script file should look like this:

      unit GreatScript;

      interface
      implementation
      uses xEditAPI, Classes, SysUtils, StrUtils, Windows;

  6. You can add additional Delphi units to the 'uses' line if needed, for example IniFiles if script works with them.
  7. Check that project can be compiled Ctrl+F9 and the same script can be applied in xEdit without errors.
  8. While editing your script, before running it in xEdit, press Ctrl+F9 in Delphi to compile and ensure that the code is valid.
  9. You can also modify the GreatScriptApp file and have it run your xEdit script from Delphi. Put this code in the begin/end of that file:

      program GreatScriptApp;

      {$APPTYPE CONSOLE}

      {$R *.res}

      uses
        Windows,
        Winapi.ShellApi,
        System.SysUtils,
        xEditAPI in 'C:\Games\FO4Edit 3.2\Edit Scripts\xEditAPI.pas';
        GreatScript in 'C:\Games\FO4Edit 3.2\Edit Scripts\GreatScript.pas',

      begin
        try
          ShellExecute(0, Nil, 'C:\Games\FO4Edit 3.2\FO4Edit.exe', '-script:"GreatScript.pas" -nobuildrefs', 'C:\Games\FO4Edit 3.2', SW_SHOWNORMAL);
        except
          on E: Exception do
            Writeln(E.ClassName, ': ', E.Message);
        end;
      end.
*)
unit xEditAPI;

interface

uses SysUtils, Classes, UITypes, Vcl.Graphics;

// ********************************************************************
// xEdit Global Constants
// ********************************************************************

const
  LowInteger = Low(Integer);
  HighInteger = High(Integer);

// ********************************************************************
// xEdit Types
// ********************************************************************

type
  /// <summary>Base type for all data types except IwbResource and IwbResourceContainer.
  /// This and all of the subtypes are referred to as "elements" in the documentation.
  /// Used for working with data from *.esm and *.esp files.</summary>
  IwbElement = IInterface;
  /// <summary>Base type for all containers.</summary>
  IwbContainerBase = IInterface;
  /// <summary>Base type for an element that holds collections of other elements.</summary>
  IwbContainer = IInterface;
  /// <summary>A container that is sortable.</summary>
  IwbSortableContainer = IInterface;
  /// <summary>An element that holds data and a collection of other elements.</summary>
  IwbDataContainer = IInterface;
  /// <summary>The file header of an ESM or ESP plugin file.</summary>
  IwbFileHeader = IInterface;
  /// <summary>The base type for all records. This and all of the subtypes are referred to as "records" in the documentation.</summary>
  IwbRecord = IInterface;
  /// <summary>A plugin file's top-level groups. Each group holds a different type of record.</summary>
  IwbGroupRecord = IInterface;
  /// <summary>A any of a plugin file's records.</summary>
  IwbMainRecord = IInterface;
  /// <summary>All other records in a plugin's file that are not main or top-level group records.</summary>
  IwbSubRecord = IInterface;
  /// <summary>A mod's file. See FileByIndex().</summary>
  IwbFile = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  IwbContainerElementRef = IInterface;
  /// <summary>FIXME - DOCUMENT ME! Used for working with data from *.bsa and *.ba2 files.</summary>
  IwbResource = IInterface;
  /// <summary>Base type for BA2, BSA, and folder resourcess</summary>
  IwbResourceContainer = IInterface;
  /// <summary>Data representation of a BA2 file</summary>
  IwbBA2File = IInterface;
  /// <summary>Data representation of a BSA file</summary>
  IwbBSAFile = IInterface;
  /// <summary>Data representation of a folder</summary>
  IwbFolder = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbDefType = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbElementState = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbElementType = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbGridCell = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbVector = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TwbFastStringList = IInterface;
  /// <summary>FIXME - DOCUMENT ME!</summary>
  TGameResourceType = IInterface;

// ********************************************************************
// Global Variables
// ********************************************************************

/// <summary>Provides the file path to the game's data folder as a String</summary>
function DataPath: String;
/// <summary>Provides the file path to Tes5edit's installation folder as a String</summary>
function ProgramPath:	String;
/// <summary>Provides the file path to Tes5Edit's 'Edit Scripts' folder as a String.</summary>
/// <remarks>NOTE If launching TES5Edit via a .tes5pas file, ScriptsPath will change to the directory where the .te5pas file is located. (therefore if your script has any .pas file it is grabbing functions from, they also need to be in the that same directory.)</remarks>
function ScriptsPath:	String;
/// <summary>Provides the argument passed to the -scriptargs:"<args>" command line option as a String.</summary>
/// <remarks>NOTE: If one needs to pass comma separated or other formatted data they should pass it as a single string and then parse the string returned from ScriptArgs in a script's Initialize function.</remarks>
function ScriptArgs:	String;
/// <summary>Provides the number of loaded files in your current TES5Edit session</summary>
/// <remarks>NOTE: "Skyrim.Hardcoded.keep.this..." (aka. Skyrim.exe) is considered a file and is reflected in this variable.</remarks>
function FileCount:	Integer;
/// <summary>xEdit app name. Examples: 'TES5','TES4','FNV','FO3','FO4'</summary>
function wbAppName: String;
/// <summary>xEdit game name</summary>
function wbGameName: String;
/// <summary>xEdit version number.</summary>
function wbVersionNumber:	Integer;

// ********************************************************************
// Global Functions
// ********************************************************************

/// <summary>Pushes a line to TES5Edit's Information tab.</summary>
procedure AddMessage(asMessage: string);
/// <summary>An extension to Delphi's native <see cref="System|Assigned"/> function: returns true if aeElement is not Nil, and returns false otherwise.</summary>
function Assigned(aeElement: IwbElement): boolean; overload;
/// <summary>Delphi's native <see cref="System|Assigned"/> function: redefined here because Delphi doesn't support overloads of function from different modules.</summary>
function Assigned(aObject: TObject): Boolean; overload;
/// <summary>If you have stored an <c>IInterface</c> inside of a TList or TStringList, you must call this function when retrieving the object from the list, i.e. <c>ObjectToElement(myList.Items[0])</c>.</summary>
function ObjectToElement(akObject: TObject): IInterface;
/// <summary>Find a file by index. See also: <see cref="xEditAPI|FileCount"/>.</summary>
function FileByIndex(aiFile: integer): IwbFile;
/// <summary>Find a file by load order.</summary>
function FileByLoadOrder(aiLoadOrder: integer): IwbFile;
/// <summary>Returns the full path to the filename asFilename.</summary>
function FullPathToFilename(asFilename: string): string;
/// <summary>As of xEdit 3.1.2, calling this function will corrupt saved plugins until xEdit is restarted.</summary>
procedure EnableSkyrimSaveFormat();
/// <summary>Unverified: Modifies akList by adding entries based on the contents of the global wbRecordDefs.</summary>
procedure GetRecordDefNames(akList: TStrings);
/// <summary>Scroll to an element in the xEdit window</summary>
procedure JumpTo(aeElement: IwbElement; unknown: boolean);
/// <summary>Modifies akListOut, adding every entry in akListIn that contains the substring asFilter.</summary>
procedure wbFilterStrings(akListIn: TStrings; akListOut: TStrings; asFilter: String);
/// <summary>Modifies akList, removing any duplicate entries that it contains.</summary>
procedure wbRemoveDuplicateStrings(akList: TStringList);

// ********************************************************************
// IwbElement Functions
// ********************************************************************

/// <summary>Identical to Name except that it handles IwbFiles differently. Name will prepend a load order index (i.e. [02] PluginName.esp), while BaseName will not.</summary>
function BaseName(aeElement: IwbElement): string;
/// <summary>Builds reference information for the element and all of its descendants. Note that this function will run even if reference information has already been built.</summary>
procedure BuildRef(aeElement: IwbElement);
/// <summary>Guaranteed to return True if the element can contain form IDs, but not guaranteed to return False if it can't. This accesses an internal property, CanContainFormIDs, which the internal implementation of BuildRef uses to skip processing certain descendant elements.</summary>
function CanContainFormIDs(aeElement: IwbElement): boolean;
/// <summary>Returns true if the element is part of an array and can be moved further down using MoveDown.</summary>
function CanMoveDown(aeElement: IwbElement): boolean;
/// <summary>Returns true if the element is part of an array and can be moved further up using MoveUp.</summary>
function CanMoveUp(aeElement: IwbElement): boolean;
/// <summary>Returns the error message produced when the "Check for Errors" functionality is run on aeElement; or else an empty string if no error is found.</summary>
function Check(aeElement: IwbElement): string;
/// <summary>Manipulates the internal flags of an element, e.g. ClearElementState(eElement, esModified);. See also: GetElementState, SetElementState.</summary>
procedure ClearElementState(aeElement: IwbElement; aiState: TwbElementState);
/// <summary>Returns the main record that contains the element.</summary>
function ContainingMainRecord(aeElement: IwbElement): IwbMainRecord;
/// <summary>Returns the def-type of the element.</summary>
function DefType(aeElement: IwbElement): TwbDefType;
/// <summary>Returns the display name of the element, if it has one; otherwise, this behaves identically to Name. See also: BaseName, ShortName.</summary>
function DisplayName(aeElement: IwbElement): string;
/// <summary>Copy the contents of one element into a container element, or create and append an element to a container. aeContainer Destination element. aiIndex Where to place the new element, if the destination is an array. Specify HighInteger to append. Specify LowInteger or a negative value to add to non-arrays. aeSource Element to copy from. Use Nil to create a blank element of the appropriate type. abOnlySK Sorted Key Only; : Only apply to elements participating in container sorting, for internal xEdit usage. Use False. Sample: there is a script to copy VMAD subrecords "Skyrim - Copy VMAD subrecord.pas"</summary>
function ElementAssign(aeContainer: IwbContainer; aiIndex: integer; aeSource: IwbElement; abOnlySK: boolean): IwbElement;
/// <summary>Returns the type of the element. This is one of the following values: etFile, etMainRecord, etGroupRecord, etSubRecord, etSubRecordStruct, etSubRecordArray, etSubRecordUnion, etArray, etStruct, etValue, etFlag, etStringListTerminator,etUnion, etStructChapter.</summary>
function ElementType(aeElement: IwbElement): TwbElementType;
/// <summary>If aeElement is a set of named enum values, this function returns the names of any values that have been set, separated with spaces.</summary>
function EnumValues(aeElement: IwbElement): string;
/// <summary>Compares two elements by their ElementID. This is sometimes necessary, as different IInterface variables pointing to the same element don't always compare properly when using the = operator.</summary>
function Equals(aeElement1: IwbElement; aeElement2: IwbElement): boolean;
/// <summary>If aeElement is a set of flags, this function returns the names of all set flags, separated with spaces.</summary>
function FlagValues(aeElement: IwbElement): string;
/// <summary>Returns the full path to the element, going all the way down to its containing file. See also: Path, PathName.</summary>
function FullPath(aeElement: IwbElement): string;
/// <summary>Returns the element's container.</summary>
function GetContainer(aeElement: IwbElement): IwbContainer;
/// <summary>Returns a string representation of the element's value. See also: SetEditValue, GetElementEditValues, SetElementEditValues.</summary>
function GetEditValue(aeElement: IwbElement): string;
/// <summary>Checks the internal flags of an element. See also: ClearElementState, SetElementState.</summary>
function GetElementState(aeElement: IwbElement; aiState: TwbElementState): TwbElementState;
/// <summary>Returns the file that contains the element.</summary>
function GetFile(aeElement: IwbElement): IwbFile;
/// <summary>Returns the element's value. See also: SetNativeValue, GetElementNativeValues, SetElementNativeValues.</summary>
function GetNativeValue(aeElement: IwbElement): Variant;
/// <summary>Returns true if the record can be edited. In some cases, xEdit will block edits to files like Skyrim.esm.</summary>
function IsEditable(aeElement: IwbElement): boolean;
/// <summary>Returns true if the element is an injected record.</summary>
function IsInjected(aeElement: IwbElement): boolean;
/// <summary>Obtains the referenced element. Not to be confused with ReferencedBy Elements. Call this function on any container element (etSubRecord) to get the iwbMainRecord of that form. (Ex: Calling LinksTo() on any 'LNAM - FormID' subRecord found in a FormID List will return the IwbMainRecord of that record).</summary>
function LinksTo(aeElement: IwbElement): IwbElement;
/// <summary>Marks the element and all of its descendants as modified. This forces xEdit to serialize them.</summary>
procedure MarkModifiedRecursive(aeElement: IwbElement);
/// <summary>If the element is part of an array, this function moves it down by one slot. See also: CanMoveDown.</summary>
procedure MoveDown(aeElement: IwbElement);
/// <summary>If the element is part of an array, this function moves it up by one slot. See also: CanMoveUp.</summary>
procedure MoveUp(aeElement: IwbElement);
/// <summary>Returns the name of the element, if it has one. If aeElement is an IwbFile or certain kinds of IwbMainRecords, Name will return a "pretty" name, while BaseName or ShortName will return a more basic string. See also: DisplayName.</summary>
function Name(aeElement: IwbElement): string;
/// <summary>Returns the path component of aeElement -- that is, one single piece of the path that FullPath would return. You could use this when manually constructing a path to supply to ElementByPath. See also (and don't confuse with): FullPath, PathName.</summary>
function Path(aeElement: IwbElement): string;
/// <summary>Similar to FullPath except that names in the path are prefixed with brackets, to uniquely identify each element's unique position among its siblings (see IndexOf). Example: \[02] neromancer.esp\[7] Worldspace\[1] World Children\[1] Children of 00000D74\[0] Persistent\[2] [REFR:00100452]</summary>
function PathName(aeElement: IwbElement): string;
/// <summary>Removes the element from its file.</summary>
procedure Remove(aeElement: IwbElement);
/// <summary>Checks which master files aeElement depends on, and adds their filenames to akListOut. First boolean is Recursive to go over children elements if it is a container, second is Initial which is false by default.</summary>
procedure ReportRequiredMasters(aeElement: IwbElement; akListOut: TStrings; akUnknown1: boolean; akUnknown2: boolean);
/// <summary>Sets the element's value to one that matches the string representation passed in. See also: GetEditValue, GetElementEditValues, SetElementEditValues.</summary>
function SetEditValue(aeElement: IwbElement; asValue: string): string;
/// <summary>Manipulates the internal flags of an element. Returns the value prior to modification. See also: ClearElementState, GetElementState.</summary>
function SetElementState(aeElement: IwbElement; aiState: TwbElementState): TwbElementState;
/// <summary>Sets the element's value. See also: GetNativeValue, GetElementNativeValues, SetElementNativeValues.</summary>
function SetNativeValue(aeElement: IwbElement; avValue: variant): string;
/// <summary>Resets the element's data and adds missing fields if any</summary>
procedure SetToDefault(aeElement: IwbElement);
/// <summary>Generally the same as Name unless aeElement is a reference, cell, or similar record. Name will return detailed information for those records, while ShortName will return the signature and form ID in the format [XXXX:01234567].</summary>
function ShortName(aeElement: IwbElement): string;
/// <summary>Returns a string unique to the element entered. This can be used for sorting elements or for comparing them; for example, you could compare the SortKey for two elements in records which override each other to see if they are different from each other.</summary>
function SortKey(aeElement: IwbElement): string;
/// <summary>Copies an IwbMainRecord, IwbGroupRecord, or IwbContainer to the specified file. The abAsNew boolean controls whether or not you're copying the record as an override record. Returns the copied element.</summary>
function wbCopyElementToFile(aeElement: IwbElement; aeFile: IwbFile; abAsNew: boolean; abDeepCopy: boolean): IwbElement;
/// <summary>Details unknown. Returns the copied element.</summary>
function wbCopyElementToFileWithPrefix(aeElement: IwbElement; aeFile: IwbFile; abAsNew: boolean; abDeepCopy: boolean; akUnknown1: IInterface; akUnknown2: IInterface; akUnknown3: IInterface): IwbElement;
/// <summary>Copies an element to a record, e.g. the "Conditions" element on a COBJ record or a faction from an NPC_ record. Returns the copied element.</summary>
function wbCopyElementToRecord(aeElement: IwbElement; aeRecord: IwbMainRecord; abAsNew: boolean; abDeepCopy: boolean): IwbElement;

// ********************************************************************
// IwbContainer Functions
// ********************************************************************

/// <summary>Creates a child element with the name-or-signature asNameOrSignature in aeContainer if no such child already exists; otherwise, marks the existing child as modified. Returns the created or existing element.</summary>
function Add(aeContainer: IwbContainer; asNameOrSignature: string; abSilent: boolean): IwbElement;
/// <summary>Adds aeElement as a child of aeContainer. Throws an error if aeElement already has a container.</summary>
procedure AddElement(aeContainer: IwbContainer; aeElement: IwbElement);
/// <summary>Returns the number of "fake" elements xEdit adds before the "Record Header". For references it shows "Cell" for example. This getter accesses an internal function used internally for imposing some order on the sub-elements; it checks whether this element "counts," and if so, how many times. Seems to return 1 or 2 for (main?) records, and 0 for record fields (sub-records).</summary>
function AdditionalElementCount(aeContainer: IwbContainer): integer;
/// <summary>Returns the internal container flags for aeContainer (e.g. whether it's initialized, or whether it has had references built) as a bitmask. Refer to "Worldspace browser.pas" for a usage example.</summary>
function ContainerStates(aeContainer: IwbContainer): byte;
/// <summary>Returns the aiIndex-th child element in aeContainer. See also: ElementCount.</summary>
function ElementByIndex(aeContainer: IwbContainer; aiIndex: integer): IwbElement;
/// <summary>Searches aeContainer for the child element with name asName, and returns the found element or Nil. See also: ElementExists.</summary>
function ElementByName(aeContainer: IwbContainer; asName: string): IwbElement;
/// <summary>Searches aeContainer for the descendant element specified by path asPath, and returns the found element or Nil.</summary>
function ElementByPath(aeContainer: IwbContainer; asPath: string): IwbElement;
/// <summary>Searches aeContainer for the child element with signature asSignature, and returns the found element or Nil.</summary>
function ElementBySignature(aeContainer: IwbContainer; asSignature: string): IwbElement;
/// <summary>Returns the number of child elements in aeContainer. See also: ElementByIndex.</summary>
function ElementCount(aeContainer: IwbContainer): integer;
/// <summary>Returns true if aeContainer as a child element whose name is asName. See also: ElementByName.</summary>
function ElementExists(aeContainer: IwbContainer; asName: string): boolean;
/// <summary>Finds the element within aeContainer specified by asPath, and returns a string representation of its value.</summary>
function GetElementEditValues(aeContainer: IwbContainer; asPath: string): string;
/// <summary>Finds the element within aeContainer specified by asPath, and returns its value.</summary>
function GetElementNativeValues(aeContainer: IwbContainer; asPath: string): Variant;
/// <summary>Returns the index of aeChild in aeContainer, or -1 if aeChild is not a child element of aeContainer.</summary>
function IndexOf(aeContainer: IwbContainer; aeChild: IwbElement): integer;
/// <summary>Inserts aeElement as a child of aeContainer at the specified position.</summary>
function InsertElement(aeContainer: IwbContainer; aiPosition: integer; aeElement: IwbElement): integer;
/// <summary>Checks whether xEdit always keeps aeContainer sorted. If so, this function will return True, and calling CanMoveUp and CanMoveDown on child elements will always return False.</summary>
function IsSorted(aeContainer: IwbSortableContainer): boolean;
/// <summary>Returns the last child element in aeContainer, or Nil if there are no child elements.</summary>
function LastElement(aeContainer: IwbContainer): IwbElement;
/// <summary>Removes the aiIndex-th child from aeContainer, and returns it.</summary>
function RemoveByIndex(aeContainer: IwbContainer; aiIndex: integer; abMarkModified: boolean): IwbElement;
/// <summary>Removes avChild from aeContainer and returns the removed element. The avChild argument can be: the index of an element to remove from an array container; the name or signature of an element to remove; or an IwbElement to remove.</summary>
function RemoveElement(aeContainer: IwbContainer; avChild: Variant): IwbElement;
/// <summary>Reverses the order of the child elements in aeContainer.</summary>
procedure ReverseElements(aeContainer: IwbContainer);
/// <summary>Finds the element within aeContainer specified by asPath, and sets its value based on the string representation asValue.</summary>
/// <param name="aeContainer">Container of elements</param>
/// <param name="asPath">Path to element to change</param>
/// <param name="asValue">Text value to set</param>
procedure SetElementEditValues(aeContainer: IwbContainer; asPath: string; asValue: string);
/// <summary>Finds the element within aeContainer specified by asPath, and sets its value using thte native asValue.</summary>
/// <param name="aeContainer">Container of elements</param>
/// <param name="asPath">Path to element to change</param>
/// <param name="avValue">Variant value to set</param>
procedure SetElementNativeValues(aeContainer: IwbContainer; asPath: string; avValue: Variant);

// ********************************************************************
// IwbFile Functions
// ********************************************************************

/// <summary>Adds the specified file as a master for aeFile, if it isn't already a master.</summary>
procedure AddMasterIfMissing(aeFile: IwbFile; asMasterFilename: string);
/// <summary>Creates a new, empty plugin in the game's plugin folder (Data) and adds it to the end of the plugins list.</summary>
/// <param name="asFileName">Name of the plugin.</param>
/// <returns>The reference to the newly created plugin as a IwbFile</returns>
function AddNewFileName(asFileName: string): IwbFile;
/// <summary>Appears to find unnecessary files in aeFile's master list and remove them, updating all form indices accordingly. Don't confuse this within "cleaning master files" as in "removing ITMs and UDRs from official DLCs." This function is used in "Skyrim - Book Covers Patch.pas".</summary>
procedure CleanMasters(aeFile: IwbFile);
/// <summary>Converts aiFormID from a form ID relative to aeFile's master list (like that returned by FixedFormID) to a load-order-relative form ID (like that returned by FormID). See also: LoadOrderFormIDtoFileFormID.</summary>
function FileFormIDtoLoadOrderFormID(aeFile: IwbFile; aiFormID: cardinal): cardinal;
/// <summary>Writes the contents of aeFile to akOutStream. Used in "SaveAs.pas" to allow a user to save a loaded file under a new name; that script creates a TFileStream object and uses this function to write to it.</summary>
procedure FileWriteToStream(aeFile: IwbFile; akOutStream: TStream);
/// <summary>Returns aeFile's filename.</summary>
function GetFileName(aeFile: IwbFile): string;
/// <summary>Returns True if aeFile is flagged as an ESM. See also: SetIsESM.</summary>
function GetIsESM(aeFile: IwbFile): boolean;
/// <summary>Returns aeFile's index in the load order, or -1 if called on something that is not an IwbFile.</summary>
function GetLoadOrder(aeFile: IwbFile): integer;
/// <summary>Returns a new form ID, the same way that Add(..., ..., True) does.</summary>
function GetNewFormID(aeFile: IwbFile): cardinal;
/// <summary>If aeFile has a top-level group with the specified signature, that group is returned.</summary>
function GroupBySignature(aeFile: IwbFile; asSignature: string): IwbGroupRecord;
/// <summary>Returns True if aeFile contains a top-level group with the specified signature.</summary>
function HasGroup(aeFile: IwbFile; asSignature: string): boolean;
/// <summary>Returns True if aeFile has a file with the name asMasterFilename as a master.</summary>
function HasMaster(aeFile: IwbFile; asMasterFilename: string): boolean;
/// <summary>Converts aiFormID from a load-order-relative form ID (like that returned by FormID) to a form ID relative to aeFile's master list (like that returned by FixedFormID). See also: FileFormIDtoLoadOrderFormID.</summary>
function LoadOrderFormIDtoFileFormID(aeFile: IwbFile; aiFormID: cardinal): cardinal;
/// <summary>Returns the aiIndex-th master file for aeFile.</summary>
function MasterByIndex(aeFile: IwbFile; aiIndex: integer): IwbFile;
/// <summary>Returns the number of master files that aeFile has.</summary>
function MasterCount(aeFile: IwbFile): cardinal;
/// <summary>Returns the MGEF or GMST record in aeFile that has the specified editor ID. For all other record types, use something like MainRecordByEditorID(GroupBySignature(f, 'ECZN'), 'RandomEncounterZone1').</summary>
function RecordByEditorID(aeFile: IwbFile; asEditorID: string): IwbMainRecord;
/// <summary>Returns the main record in aeFile that has the specified form ID, or Nil if no records match. The form ID must be local to the file (see FixedFormID).</summary>
function RecordByFormID(aeFile: IwbFile; aiFormID: integer; abAllowInjected: boolean): IwbMainRecord;
/// <summary>Returns the aiIndex-th record in aeFile.</summary>
function RecordByIndex(aeFile: IwbFile; aiIndex: integer): IwbMainRecord;
/// <summary>Returns the number of records that aeFile has.</summary>
function RecordCount(aeFile: IwbFile): cardinal;
/// <summary>Modifies the ESM flag for aeFile. See also: GetIsESM.</summary>
procedure SetIsESM(aeFile: IwbFile; abFlag: boolean);
/// <summary>Attempts to sort the masters for aeFile by their place in the current load order.</summary>
procedure SortMasters(aeFile: IwbFile);

// ********************************************************************
// IwbMainRecord Functions
// ********************************************************************

/// <summary>If aeRecord is a reference, this function returns the IwbMainRecord of its base form. Otherwise, the function returns Nil.</summary>
function BaseRecord(aeRecord: IwbMainRecord): IwbMainRecord;
/// <summary>Appears to return the load-order-relative form ID of aeRecord.</summary>
function BaseRecordID(aeRecord: IwbMainRecord): cardinal;
/// <summary>Changes aeRecord's signature to asNewSignature. No other information is modified.</summary>
procedure ChangeFormSignature(aeRecord: IwbMainRecord; asNewSignature: string);
/// <summary>Returns the group that aeRecord contains, if any. For example, a WRLD record will be followed by a GRUP containing the worldspace's CELLs, and you would use this function to retrieve that group.</summary>
function ChildGroup(aeRecord: IwbMainRecord): IwbGroupRecord;
/// <summary>Attempts to change aeRecord's form ID from aiOldFormID to aiNewFormID, and returns True if the operation succeeds.</summary>
function CompareExchangeFormID(aeRecord: IwbMainRecord; aiOldFormID: cardinal; aiNewFormID: cardinal): boolean;
/// <summary>Returns the record's editor ID.</summary>
function EditorID(aeRecord: IwbMainRecord): string;
/// <summary>Returns the local FormID of the record. Local records will not have a load-order prefix (i.e. 0x00FFFFFF), and overrides will have a prefix relative to the record's file's masters. See also: FormID, GetLoadOrderFormID.</summary>
function FixedFormID(aeRecord: IwbMainRecord): cardinal;
/// <summary>Returns the record's form ID. See also: FixedFormID, GetLoadOrderFormID.</summary>
function FormID(aeRecord: IwbMainRecord): cardinal;
/// <summary>Returns the value of the Version Control Info 1 field. See also: SetFormVCS1.</summary>
function GetFormVCS1(aeRecord: IwbMainRecord): cardinal;
/// <summary>Returns the value of the Version Control Info 2 field. See also: SetFormVCS2.</summary>
function GetFormVCS2(aeRecord: IwbMainRecord): cardinal;
/// <summary>Get Form Version field from the record's header. See also: SetFormVersion.</summary>
function GetFormVersion(aeRecord: IwbMainRecord): cardinal;
/// <summary>If aeRecord is an exterior cell, this function will return its grid coordinates as a TwbGridCell; you can access the coordinates by checking returnValue.x and returnValue.y.</summary>
function GetGridCell(aeRecord: IwbMainRecord): TwbGridCell;
/// <summary>Checks the record's "deleted" flag. See also: SetIsDeleted.</summary>
function GetIsDeleted(aeRecord: IwbMainRecord): boolean;
/// <summary>Checks the record's "initially disabled" flag. See also: SetIsInitiallyDisabled.</summary>
function GetIsInitiallyDisabled(aeRecord: IwbMainRecord): boolean;
/// <summary>Checks the record's "persistent" flag. See also: SetIsPersistent.</summary>
function GetIsPersistent(aeRecord: IwbMainRecord): boolean;
/// <summary>Checks the record's "visible when distant" flag. See also: SetIsVisibleWhenDistant.</summary>
function GetIsVisibleWhenDistant(aeRecord: IwbMainRecord): boolean;
/// <summary>Returns the record's form ID relative to the current load order. See also: FixedFormID, SetLoadOrderFormID.</summary>
function GetLoadOrderFormID(aeRecord: IwbMainRecord): cardinal;
/// <summary>If aeRecord is a reference (or a subtype, like ACHR), this function will return its position.</summary>
function GetPosition(aeRecord: IwbMainRecord): TwbVector;
/// <summary>If aeRecord is a reference (or a subtype, like ACHR), this function will return its rotation.</summary>
function GetRotation(aeRecord: IwbMainRecord): TwbVector;
/// <summary>Checks whether aeRecord is a Fallout 4 reference that has precombined mesh data generated. See also: PrecombinedMesh.</summary>
function HasPrecombinedMesh(aeRecord: IwbMainRecord): boolean;
/// <summary>See also: WinningOverride.</summary>
function HighestOverrideOrSelf(): IwbMainRecord;
/// <summary>Returns True if aeRecord is a master, and false if it is an override or not an IwbMainRecord. See also: Master, MasterOrSelf.</summary>
function IsMaster(aeRecord: IwbMainRecord): boolean;
/// <summary>Returns True if aeRecord is the last loaded override for its master. See also: Master, MasterOrSelf.</summary>
function IsWinningOverride(aeRecord: IwbMainRecord): boolean;
/// <summary>FIXME - DOCUMENT ME!</summary>
function Master(aeRecord: IwbMainRecord): IwbMainRecord;
/// <summary>If aeRecord is an override, the function returns the master record that it overrides. Otherwise, the function returns aeRecord itself. See also: IsMaster, IsWinningOverride.</summary>
function MasterOrSelf(aeRecord: IwbMainRecord): IwbMainRecord;
/// <summary>Returns the aiIndex-th override of aeRecord.</summary>
function OverrideByIndex(aeRecord: IwbMainRecord; aiIndex: integer): IwbMainRecord;
/// <summary>Returns the number of records that override aeRecord.</summary>
function OverrideCount(aeRecord: IwbMainRecord): cardinal;
/// <summary>Returns the path to aeRecord's precombined mesh file, if aeRecord is a Fallout 4 reference that could have that data (i.e. not a placed actor). See also: HasPrecombinedMesh.</summary>
function PrecombinedMesh(aeRecord: IwbMainRecord): string;
/// <summary>Returns the aiIndex-th record that references aeRecord.</summary>
function ReferencedByIndex(aeRecord: IwbMainRecord; aiIndex: integer): IwbMainRecord;
/// <summary>Returns the number of records that refer to aeRecord.</summary>
function ReferencedByCount(aeRecord: IwbMainRecord): cardinal;
/// <summary>Sets the record's editor ID, and then returns it.</summary>
function SetEditorID(aeRecord: IwbMainRecord): string;
/// <summary>Set Form Version field for the record's header. See also: GetFormVersion.</summary>
procedure SetFormVersion(aeRecord: IwbMainRecord; aiVersion: cardinal);
/// <summary>Modifies the record's "deleted" flag. See also: GetIsDeleted.</summary>
function SetIsDeleted(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
/// <summary>Modifies the record's "initially disabled" flag. See also: GetIsInitiallyDisabled.</summary>
function SetIsInitiallyDisabled(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
/// <summary>Modifies the record's "persistent" flag. See also: GetIsPersistent.</summary>
function SetIsPersistent(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
/// <summary>Modifies the record's "visible when distant" flag. See also: GetIsVisibleWhenDistant.</summary>
function SetIsVisibleWhenDistant(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
/// <summary>Modifies the record's form ID, with the specified ID relative to the current load order. See also: GetLoadOrderFormID.</summary>
function SetLoadOrderFormID(aeRecord: IwbMainRecord; aiFormID: cardinal): cardinal;
/// <summary>Modifies the Version Control Info 1 field. See also: GetFormVCS1.</summary>
procedure SetFormVCS1(aeRecord: IwbMainRecord; aiValue: cardinal);
/// <summary>Modifies the Version Control Info 2 field. See also: GetFormVCS2.</summary>
procedure SetFormVCS2(aeRecord: IwbMainRecord; aiValue: cardinal);
/// <summary>Returns the record's signature, a four-character code such as NPC_ or DIAL.</summary>
/// <param name="aeRecord">Record to get a signature from</param>
/// <returns>Signature of element</returns>
/// <remarks>If element doesn't have a signature, an empty string is returned</remarks>
function Signature(aeRecord: IwbMainRecord): string;
/// <summary>Appears to be the same as BuildRef, except that it aborts if references are already in the middle of being built.</summary>
procedure UpdateRefs();
/// <summary>Returns the last loaded override for aeRecord. See also: HighestOverrideOrSelf.</summary>
/// <param name="aeRecord">A record</param>
/// <returns>Winning override record</returns>
function WinningOverride(aeRecord: IwbMainRecord): IwbMainRecord;

// ********************************************************************
// IwbGroupRecord Functions
// ********************************************************************

/// <summary>If aeGroup is a child group, this function returns the main record that it is associated with. For example, a Dialogue Topic (DIAL) is followed by a group (GRUP) that contains its Infos (INFO); and passing that GRUP to this function would retrieve the DIAL. Cells (CELL) and Worldspaces (WRLD) have their contents set up similarly to Dialogue Topics, so this function will work with them as well.</summary>
function ChildrenOf(aeGroup: IwbGroupRecord): IwbMainRecord;
/// <summary>Finds the group record inside another group. The aiType value should match the group-type values used in the file format. The "Worldspace browser.pas" script uses FindChildGroup(ChildGroup(cell), 9, cell); to get the "Temporary" group within a CELL.</summary>
function FindChildGroup(aeGroup: IwbGroupRecord; aiType: integer; aeMainRecord: IwbMainRecord): IwbGroupRecord;
/// <summary>Returns the raw group label, as specified in the file format.</summary>
function GroupLabel(aeGroup: IwbGroupRecord): cardinal;
/// <summary>Returns the raw group type, as specified in the file format.</summary>
function GroupType(): integer;
/// <summary>Searches aeGroup for a main record whose editor ID is asEditorID and returns the matching record or Nil. This is not a performant function.</summary>
function MainRecordByEditorID(aeGroup: IwbGroupRecord; asEditorID: string): IwbMainRecord;

// ********************************************************************
// IwbResource Functions
// ********************************************************************

/// <summary>Fills akContainers with the full filenames (directory + name) of all loaded BSA and BA2 files, as well as the name of the Data directory. akContainers can be a TwbFastStringList or a TStringList.</summary>
procedure ResourceContainerList(akContainers: TwbFastStringList);
/// <summary>Retrieves the resource named asFilename from the resource container named asContainerName (see ResourceContainerList), and saves that resource to the specified file path asPathOut. The "Assets browser.pas" script uses this to let users extract a resource from a BSA/BA2.</summary>
procedure ResourceCopy(asContainerName: string; asFilename: string; asPathOut: string);
/// <summary>Fills akContainers with a list of the loaded containers (BSA, BA2, Data directory) that a file named asFilename appears in. The "Assets browser.pas" script uses this to allow users to decide which version of a file to view, when the file is overridden at least once within their load order.</summary>
function ResourceCount(asFilename: string; akContainers: TStrings): cardinal;
/// <summary>Checks whether any loaded container has a file with the specified name.</summary>
function ResourceExists(asFilename: string): boolean;
/// <summary>Accesses the container with the full filename asContainerName (see ResourceContainerList), and adds a list of all contained filenames to akContainers. Note that added entries are unsorted, and there may be duplicates among them.</summary>
procedure ResourceList(asContainerName: string; akContainers: TStrings);
/// <summary>asFilename should be formatted similar to the other Resource-oriented xEdit scripts. asContainerName should be filled with a string generated by the function ResourceContainerList. The ResourceOpenData function should only be used in conjunction with NifTextureList, as ResourceCopy removes any other need for this function.</summary>
function ResourceOpenData(asContainerName: string; asFilename: string): TBytesStream;

// ********************************************************************
// Misc functions
// ********************************************************************

/// <summary>FIXME - DOCUMENT ME!</summary>
procedure LocalizationGetStringsFromFile(asFilename: string; akListOut: TStrings);
/// <summary>A wrapper for Windows.AlphaBlend which returns its result.</summary>
function wbAlphaBlend(akDestinationDeviceContext: IInterface; aiDestinationX: integer; aiDestinationY: integer; aiDestinationWidth: integer; aiDestinationHeight: integer; akSourceDeviceContext: IInterface; aiSourceX: integer; aiSourceY: integer; aiSourceWidth: integer; aiSourceHeight: integer; aiAlpha: integer): boolean;
/// <summary>See also: wbPositionToGridCell, wbSubBlockFromGridCell, wbGridCellToGroupLabel, wbIsInGridCell.</summary>
function wbBlockFromSubBlock(akSubBlock: TwbGridCell): TwbGridCell;
/// <summary>See also: wbCRC32File, wbSHA1Data, wbSHA1File, wbMD5Data, wbMD5File.</summary>
function wbCRC32Data(akData: TBytes): cardinal;
/// <summary>See also: wbCRC32Data, wbSHA1Data, wbSHA1File, wbMD5Data, wbMD5File.</summary>
function wbCRC32File(asFilename: string): cardinal;
/// <summary>FIXME - DOCUMENT ME!</summary>
function wbCRC32Resource(asContainerName: string; asFileName: string): cardinal;
/// <summary>Searches for sibling records to aeREFR whose base records' signatures match asSignatures, and adds them to akOutList. Further filtering can be done with aiFlags: specify 1 to exclude deleted references, 2 to exclude initially disabled references, and 4 to exclude references that have an enable parent.</summary>
procedure wbFindREFRsByBase(aeREFR: IwbMainRecord; asSignatures: string; aiFlags: integer; akOutList: TList);
/// <summary>Flips the image data contained in akBitmap based on the specified axes. Specify 1 to flip horizontally, 2 to flip vertically, or 0 to flip on both axes.</summary>
procedure wbFlipBitmap(akBitmap: TBitmap; aiAxes: integer);
/// <summary>Adds sibling records of aeRecord to akOutList if their signatures match asSignatures. If abIncludeOverrides is not True, then overrides will not be included in the result.</summary>
procedure wbGetSiblingRecords(aeRecord: IwbElement; asSignatures: string; abIncludeOverrides: boolean; akOutList: TList);
/// <summary>Returns an integer of the format 0xXXXXYYYY. See also: wbBlockFromSubBlock, wbPositionToGridCell, wbIsInGridCell, wbSubBlockFromGridCell.</summary>
function wbGridCellToGroupLabel(akGridCell: TwbGridCell): cardinal;
/// <summary>See also: wbBlockFromSubBlock, wbGridCellToGroupLabel, wbPositionToGridCell, wbSubBlockFromGridCell.</summary>
function wbIsInGridCell(akPosition: TwbVector; akGridCell: TwbGridCell): boolean;
/// <summary>See also: wbCRC32Data, wbCRC32File, wbMD5File, SHA1Data, wbSH1Data.</summary>
function wbMD5Data(akData: TBytes): cardinal;
/// <summary>Calculation time is about 2.5 times longer than CRC32. See also: wbCRC32Data, wbCRC32File, wbMD5Data, SHA1Data, wbSH1Data.</summary>
function wbMD5File(asFilename: string): cardinal;
/// <summary>akResourceType can be any of the following values: resMesh, resTexture, resSound, resMusic.</summary>
function wbNormalizeResourceName(asResourceName: string; akResourceType: TGameResourceType): string;
/// <summary>Converts akPosition to grid coordinates. In practice, this is done by dividing the physical coordinates by 4096, the lateral length and width of a cell. See also: wbBlockFromSubBlock, wbGridCellToGroupLabel, wbIsInGridCell, wbSubBlockFromGridCell.</summary>
function wbPositionToGridCell(akPosition: TwbVector): TwbGridCell;
/// <summary>See also: wbCRC32Data, wbCRC32File, SHA1File, wbMD5Data, wbMD5File.</summary>
function wbSHA1Data(akData: TBytes): cardinal;
/// <summary>Calculation time is about two times longer than CRC32. See also: wbCRC32Data, wbCRC32File, SHA1Data, wbMD5Data, wbMD5File.</summary>
function wbSHA1File(asFilename: string): cardinal;
/// <summary>Checks if any of the strings in akList contains asSubstring. Returns the index of the first matching entry, or -1. Checks are case-insensitive.</summary>
function wbStringListInString(akList: TStringList; asSubstring: string): integer;
/// <summary>See also: wbBlockFromSubBlock, wbGridCellToGroupLabel, wbIsInGridCell, wbPositionToGridCell.</summary>
function wbSubBlockFromGridCell(akGridCell: TwbGridCell): TwbGridCell;


// ********************************************************************
// NIF functions
// ********************************************************************

/// <summary>Retrieves block information from the NIF file in akData, and adds it to akListOut. Each added index in akListOut will match up with a string key of the form "BlockName=BlockType" and (as an object) a pointer to the NIF block's index number. Returns True if the operation succeeded.</summary>
function NifBlockList(akData: TBytes; akListOut: TStrings): boolean;
/// <summary>Searches the NIF file in akData for all texture paths, and adds them to akListOut. Returns True if the operation succeeded.</summary>
function NifTextureList(akData: TBytes; akListOut: TStrings): boolean;
/// <summary>Searches the NIF file in akData for all texture paths, and adds them to akListOut. Returns True if the operation succeeded.</summary>
function NifTextureListResource(akData: Variant; akListOut: TStrings): boolean;
/// <summary>Searches the NIF file in akData for all texture paths, and adds them to akListOut. Textures are only added if none of the relevant NiTriShape's UV sets have UVs greater than afUVRange or less than -afUVRange. Returns True if the operation succeeded.</summary>
function NifTextureListUVRange(akData: TBytes; afUVRange: Single; akListOut: TStrings): boolean;

// ********************************************************************
// DDS functions
// ********************************************************************

/// <summary>Modifies akBitmapOut to contain the DDS information sourced from akStream. Returns True if the operation succeeds.</summary>
function wbDDSStreamToBitmap(akStream: TStream; akBitmapOut: TBitmap): boolean;
/// <summary>Modifies akBitmapOut to contain the DDS information sourced from akData. Returns True if the operation succeeds.</summary>
function wbDDSDataToBitmap(akData: TBytes; akBitmapOut: TBitmap): boolean;
/// <summary>Modifies akBitmapOut to contain the DDS information sourced from the resource akUnknown. Returns True if the operation succeeds.</summary>
function wbDDSResourceToBitmap(akUnknown: IInterface; akBitmapOut: TBitmap): boolean;

implementation

// Dummy implementations to make Delphi compile successful.
// During script execution, actual xEdit implementations of these functions will be called instead.

// ********************************************************************
// Global Variables
// ********************************************************************

function DataPath:String;
begin
  Result := '';
end;

function ProgramPath:	String;
begin
  Result := '';
end;

function ScriptsPath:	String;
begin
  Result := '';
end;

function ScriptArgs:	String;
begin
  Result := '';
end;

function FileCount:	Integer;
begin
  Result := 0;
end;

function wbAppName: String;
begin
  Result := '';
end;

function wbGameName: String;
begin
  Result := '';
end;

function wbVersionNumber:	Integer;
begin
  Result := 0;
end;

// ********************************************************************
// Global Functions
// ********************************************************************

procedure AddMessage(asMessage: string);
begin
end;

function Assigned(aeElement: IwbElement): boolean; overload;
begin
  Result := false;
end;

function Assigned(aObject: TObject): Boolean; overload;
begin
  Result := false;
end;

function ObjectToElement(akObject: TObject): IInterface;
begin
  Result := Nil;
end;

function FileByIndex(aiFile: integer): IwbFile;
begin
  Result := Nil;
end;

function FileByLoadOrder(aiLoadOrder: integer): IwbFile;
begin
  Result := Nil;
end;

function FullPathToFilename(asFilename: string): string;
begin
  Result := '';
end;

procedure EnableSkyrimSaveFormat();
begin
end;

procedure GetRecordDefNames(akList: TStrings);
begin
end;

procedure JumpTo(aeElement: IwbElement; unknown: boolean);
begin
end;

procedure wbFilterStrings(akListIn: TStrings; akListOut: TStrings; asFilter: String);
begin
end;

procedure wbRemoveDuplicateStrings(akList: TStringList);
begin
end;

// ********************************************************************
// IwbElement Functions
// ********************************************************************

function BaseName(aeElement: IwbElement): string;
begin
  Result := '';
end;

procedure BuildRef(aeElement: IwbElement);
begin
end;

function CanContainFormIDs(aeElement: IwbElement): boolean;
begin
  Result := false;
end;

function CanMoveDown(aeElement: IwbElement): boolean;
begin
  Result := false;
end;

function CanMoveUp(aeElement: IwbElement): boolean;
begin
  Result := false;
end;

function Check(aeElement: IwbElement): string;
begin
  Result := '';
end;

procedure ClearElementState(aeElement: IwbElement; aiState: TwbElementState);
begin
end;

function ContainingMainRecord(aeElement: IwbElement): IwbMainRecord;
begin
  Result := Nil;
end;

function DefType(aeElement: IwbElement): TwbDefType;
begin
  Result := Nil;
end;

function DisplayName(aeElement: IwbElement): string;
begin
  Result := '';
end;

function ElementAssign(aeContainer: IwbContainer; aiIndex: integer; aeSource: IwbElement; abOnlySK: boolean): IwbElement;
begin
  Result := Nil;
end;

function ElementType(aeElement: IwbElement): TwbElementType;
begin
  Result := Nil;
end;

function EnumValues(aeElement: IwbElement): string;
begin
  Result := '';
end;

function Equals(aeElement1: IwbElement; aeElement2: IwbElement): boolean;
begin
  Result := false;
end;

function FlagValues(aeElement: IwbElement): string;
begin
  Result := '';
end;

function FullPath(aeElement: IwbElement): string;
begin
  Result := '';
end;

function GetContainer(aeElement: IwbElement): IwbContainer;
begin
  Result := Nil;
end;

function GetEditValue(aeElement: IwbElement): string;
begin
  Result := '';
end;

function GetElementState(aeElement: IwbElement; aiState: TwbElementState): TwbElementState;
begin
  Result := Nil;
end;

function GetFile(aeElement: IwbElement): IwbFile;
begin
  Result := Nil;
end;

function GetNativeValue(aeElement: IwbElement): Variant;
begin
  Result := 0;
end;

function IsEditable(aeElement: IwbElement): boolean;
begin
  Result := false;
end;

function IsInjected(aeElement: IwbElement): boolean;
begin
  Result := false;
end;

function LinksTo(aeElement: IwbElement): IwbElement;
begin
  Result := Nil;
end;

procedure MarkModifiedRecursive(aeElement: IwbElement);
begin
end;

procedure MoveDown(aeElement: IwbElement);
begin
end;

procedure MoveUp(aeElement: IwbElement);
begin
end;

function Name(aeElement: IwbElement): string;
begin
  Result := '';
end;

function Path(aeElement: IwbElement): string;
begin
  Result := '';
end;

function PathName(aeElement: IwbElement): string;
begin
  Result := '';
end;

procedure Remove(aeElement: IwbElement);
begin
end;

procedure ReportRequiredMasters(aeElement: IwbElement; akListOut: TStrings; akUnknown1: boolean; akUnknown2: boolean);
begin
end;

function SetEditValue(aeElement: IwbElement; asValue: string): string;
begin
  Result := '';
end;

function SetElementState(aeElement: IwbElement; aiState: TwbElementState): TwbElementState;
begin
  Result := Nil;
end;

function SetNativeValue(aeElement: IwbElement; avValue: variant): string;
begin
  Result := '';
end;

procedure SetToDefault(aeElement: IwbElement);
begin
end;

function ShortName(aeElement: IwbElement): string;
begin
  Result := '';
end;

function SortKey(aeElement: IwbElement): string;
begin
  Result := '';
end;

function wbCopyElementToFile(aeElement: IwbElement; aeFile: IwbFile; abAsNew: boolean; abDeepCopy: boolean): IwbElement;
begin
  Result := Nil;
end;

function wbCopyElementToFileWithPrefix(aeElement: IwbElement; aeFile: IwbFile; abAsNew: boolean; abDeepCopy: boolean; akUnknown1: IInterface; akUnknown2: IInterface; akUnknown3: IInterface): IwbElement;
begin
  Result := Nil;
end;

function wbCopyElementToRecord(aeElement: IwbElement; aeRecord: IwbMainRecord; abAsNew: boolean; abDeepCopy: boolean): IwbElement;
begin
  Result := Nil;
end;


// ********************************************************************
// IwbContainer Functions
// ********************************************************************

function Add(aeContainer: IwbContainer; asNameOrSignature: string; abSilent: boolean): IwbElement;
begin
  Result := Nil;
end;

procedure AddElement(aeContainer: IwbContainer; aeElement: IwbElement);
begin
end;

function AdditionalElementCount(aeContainer: IwbContainer): integer;
begin
  Result := 0;
end;

function ContainerStates(aeContainer: IwbContainer): byte;
begin
  Result := 0;
end;

function ElementByIndex(aeContainer: IwbContainer; aiIndex: integer): IwbElement;
begin
  Result := Nil;
end;

function ElementByName(aeContainer: IwbContainer; asName: string): IwbElement;
begin
  Result := Nil;
end;

function ElementByPath(aeContainer: IwbContainer; asPath: string): IwbElement;
begin
  Result := Nil;
end;

function ElementBySignature(aeContainer: IwbContainer; asSignature: string): IwbElement;
begin
  Result := Nil;
end;

function ElementCount(aeContainer: IwbContainer): integer;
begin
  Result := 0;
end;

function ElementExists(aeContainer: IwbContainer; asName: string): boolean;
begin
  Result := false;
end;

function GetElementEditValues(aeContainer: IwbContainer; asPath: string): string;
begin
  Result := '';
end;

function GetElementNativeValues(aeContainer: IwbContainer; asPath: string): Variant;
begin
  Result := 0;
end;

function IndexOf(aeContainer: IwbContainer; aeChild: IwbElement): integer;
begin
  Result := 0;
end;

function InsertElement(aeContainer: IwbContainer; aiPosition: integer; aeElement: IwbElement): integer;
begin
  Result := 0;
end;

function IsSorted(aeContainer: IwbSortableContainer): boolean;
begin
  Result := false;
end;

function LastElement(aeContainer: IwbContainer): IwbElement;
begin
  Result := Nil;
end;

function RemoveByIndex(aeContainer: IwbContainer; aiIndex: integer; abMarkModified: boolean): IwbElement;
begin
  Result := Nil;
end;

function RemoveElement(aeContainer: IwbContainer; avChild: Variant): IwbElement;
begin
  Result := Nil;
end;

procedure ReverseElements(aeContainer: IwbContainer);
begin
end;

procedure SetElementEditValues(aeContainer: IwbContainer; asPath: string; asValue: string);
begin
end;

procedure SetElementNativeValues(aeContainer: IwbContainer; asPath: string; avValue: Variant);
begin
end;

// ********************************************************************
// IwbFile Functions
// ********************************************************************

procedure AddMasterIfMissing(aeFile: IwbFile; asMasterFilename: string);
begin
end;

function AddNewFileName(asFileName: string): IwbFile;
begin
  Result := Nil;
end;

procedure CleanMasters(aeFile: IwbFile);
begin
end;

function FileFormIDtoLoadOrderFormID(aeFile: IwbFile; aiFormID: cardinal): cardinal;
begin
  Result := 0;
end;

procedure FileWriteToStream(aeFile: IwbFile; akOutStream: TStream);
begin
end;

function GetFileName(aeFile: IwbFile): string;
begin
  Result := '';
end;

function GetIsESM(aeFile: IwbFile): boolean;
begin
  Result := false;
end;

function GetLoadOrder(aeFile: IwbFile): integer;
begin
  Result := 0;
end;

function GetNewFormID(aeFile: IwbFile): cardinal;
begin
  Result := 0;
end;

function GroupBySignature(aeFile: IwbFile; asSignature: string): IwbGroupRecord;
begin
  Result := Nil;
end;

function HasGroup(aeFile: IwbFile; asSignature: string): boolean;
begin
  Result := false;
end;

function HasMaster(aeFile: IwbFile; asMasterFilename: string): boolean;
begin
  Result := false;
end;

function LoadOrderFormIDtoFileFormID(aeFile: IwbFile; aiFormID: cardinal): cardinal;
begin
  Result := 0;
end;

function MasterByIndex(aeFile: IwbFile; aiIndex: integer): IwbFile;
begin
  Result := Nil;
end;

function MasterCount(aeFile: IwbFile): cardinal;
begin
  Result := 0;
end;

function RecordByEditorID(aeFile: IwbFile; asEditorID: string): IwbMainRecord;
begin
  Result := Nil;
end;

function RecordByFormID(aeFile: IwbFile; aiFormID: integer; abAllowInjected: boolean): IwbMainRecord;
begin
  Result := Nil;
end;

function RecordByIndex(aeFile: IwbFile; aiIndex: integer): IwbMainRecord;
begin
  Result := Nil;
end;

function RecordCount(aeFile: IwbFile): cardinal;
begin
  Result := 0;
end;

procedure SetIsESM(aeFile: IwbFile; abFlag: boolean);
begin
end;

procedure SortMasters(aeFile: IwbFile);
begin
end;

// ********************************************************************
// IwbMainRecord Functions
// ********************************************************************

function BaseRecord(aeRecord: IwbMainRecord): IwbMainRecord;
begin
  Result := Nil;
end;

function BaseRecordID(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

procedure ChangeFormSignature(aeRecord: IwbMainRecord; asNewSignature: string);
begin
end;

function ChildGroup(aeRecord: IwbMainRecord): IwbGroupRecord;
begin
  Result := Nil;
end;

function CompareExchangeFormID(aeRecord: IwbMainRecord; aiOldFormID: cardinal; aiNewFormID: cardinal): boolean;
begin
  Result := false;
end;

function EditorID(aeRecord: IwbMainRecord): string;
begin
  Result := '';
end;

function FixedFormID(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function FormID(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function GetFormVCS1(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function GetFormVCS2(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function GetFormVersion(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function GetGridCell(aeRecord: IwbMainRecord): TwbGridCell;
begin
  Result := Nil;
end;

function GetIsDeleted(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function GetIsInitiallyDisabled(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function GetIsPersistent(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function GetIsVisibleWhenDistant(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function GetLoadOrderFormID(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function GetPosition(aeRecord: IwbMainRecord): TwbVector;
begin
  Result := Nil;
end;

function GetRotation(aeRecord: IwbMainRecord): TwbVector;
begin
  Result := Nil;
end;

function HasPrecombinedMesh(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function HighestOverrideOrSelf(): IwbMainRecord;
begin
  Result := Nil;
end;

function IsMaster(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function IsWinningOverride(aeRecord: IwbMainRecord): boolean;
begin
  Result := false;
end;

function Master(aeRecord: IwbMainRecord): IwbMainRecord;
begin
  Result := Nil;
end;

function MasterOrSelf(aeRecord: IwbMainRecord): IwbMainRecord;
begin
  Result := Nil;
end;

function OverrideByIndex(aeRecord: IwbMainRecord; aiIndex: integer): IwbMainRecord;
begin
  Result := Nil;
end;

function OverrideCount(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function PrecombinedMesh(aeRecord: IwbMainRecord): string;
begin
  Result := '';
end;

function ReferencedByIndex(aeRecord: IwbMainRecord; aiIndex: integer): IwbMainRecord;
begin
  Result := Nil;
end;

function ReferencedByCount(aeRecord: IwbMainRecord): cardinal;
begin
  Result := 0;
end;

function SetEditorID(aeRecord: IwbMainRecord): string;
begin
  Result := '';
end;

procedure SetFormVersion(aeRecord: IwbMainRecord; aiVersion: cardinal);
begin
end;

function SetIsDeleted(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
begin
  Result := false;
end;

function SetIsInitiallyDisabled(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
begin
  Result := false;
end;

function SetIsPersistent(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
begin
  Result := false;
end;

function SetIsVisibleWhenDistant(aeRecord: IwbMainRecord; abFlag: boolean): boolean;
begin
  Result := false;
end;

function SetLoadOrderFormID(aeRecord: IwbMainRecord; aiFormID: cardinal): cardinal;
begin
  Result := 0;
end;

procedure SetFormVCS1(aeRecord: IwbMainRecord; aiValue: cardinal);
begin
end;

procedure SetFormVCS2(aeRecord: IwbMainRecord; aiValue: cardinal);
begin
end;

function Signature(aeRecord: IwbMainRecord): string;
begin
  Result := '';
end;

procedure UpdateRefs();
begin
end;

function WinningOverride(aeRecord: IwbMainRecord): IwbMainRecord;
begin
  Result := Nil;
end;

// ********************************************************************
// IwbGroupRecord Functions
// ********************************************************************

function ChildrenOf(aeGroup: IwbGroupRecord): IwbMainRecord;
begin
  Result := Nil;
end;

function FindChildGroup(aeGroup: IwbGroupRecord; aiType: integer; aeMainRecord: IwbMainRecord): IwbGroupRecord;
begin
  Result := Nil;
end;

function GroupLabel(aeGroup: IwbGroupRecord): cardinal;
begin
  Result := 0;
end;

function GroupType(): integer;
begin
  Result := 0;
end;

function MainRecordByEditorID(aeGroup: IwbGroupRecord; asEditorID: string): IwbMainRecord;
begin
  Result := Nil;
end;

// ********************************************************************
// IwbResource Functions
// ********************************************************************

procedure ResourceContainerList(akContainers: TwbFastStringList);
begin
end;

procedure ResourceCopy(asContainerName: string; asFilename: string; asPathOut: string);
begin
end;

function ResourceCount(asFilename: string; akContainers: TStrings): cardinal;
begin
  Result := 0;
end;

function ResourceExists(asFilename: string): boolean;
begin
  Result := false;
end;

procedure ResourceList(asContainerName: string; akContainers: TStrings);
begin
end;

function ResourceOpenData(asContainerName: string; asFilename: string): TBytesStream;
begin
  Result := Nil;
end;

// ********************************************************************
// Misc functions
// ********************************************************************

procedure LocalizationGetStringsFromFile(asFilename: string; akListOut: TStrings);
begin
end;

function wbAlphaBlend(akDestinationDeviceContext: IInterface; aiDestinationX: integer; aiDestinationY: integer; aiDestinationWidth: integer; aiDestinationHeight: integer; akSourceDeviceContext: IInterface; aiSourceX: integer; aiSourceY: integer; aiSourceWidth: integer; aiSourceHeight: integer; aiAlpha: integer): boolean;
begin
  Result := false;
end;

function wbBlockFromSubBlock(akSubBlock: TwbGridCell): TwbGridCell;
begin
  Result := Nil;
end;

function wbCRC32Data(akData: TBytes): cardinal;
begin
  Result := 0;
end;

function wbCRC32File(asFilename: string): cardinal;
begin
  Result := 0;
end;

function wbCRC32Resource(asContainerName: string; asFileName: string): cardinal;
begin
  Result := 0;
end;

procedure wbFindREFRsByBase(aeREFR: IwbMainRecord; asSignatures: string; aiFlags: integer; akOutList: TList);
begin
end;

procedure wbFlipBitmap(akBitmap: TBitmap; aiAxes: integer);
begin
end;

procedure wbGetSiblingRecords(aeRecord: IwbElement; asSignatures: string; abIncludeOverrides: boolean; akOutList: TList);
begin
end;

function wbGridCellToGroupLabel(akGridCell: TwbGridCell): cardinal;
begin
  Result := 0;
end;

function wbIsInGridCell(akPosition: TwbVector; akGridCell: TwbGridCell): boolean;
begin
  Result := false;
end;

function wbMD5Data(akData: TBytes): cardinal;
begin
  Result := 0;
end;

function wbMD5File(asFilename: string): cardinal;
begin
  Result := 0;
end;

function wbNormalizeResourceName(asResourceName: string; akResourceType: TGameResourceType): string;
begin
  Result := '';
end;

function wbPositionToGridCell(akPosition: TwbVector): TwbGridCell;
begin
  Result := Nil;
end;

function wbSHA1Data(akData: TBytes): cardinal;
begin
  Result := 0;
end;

function wbSHA1File(asFilename: string): cardinal;
begin
  Result := 0;
end;

function wbStringListInString(akList: TStringList; asSubstring: string): integer;
begin
  Result := 0;
end;

function wbSubBlockFromGridCell(akGridCell: TwbGridCell): TwbGridCell;
begin
  Result := Nil;
end;

// ********************************************************************
// NIF functions
// ********************************************************************

function NifBlockList(akData: TBytes; akListOut: TStrings): boolean;
begin
  Result := false;
end;

function NifTextureList(akData: TBytes; akListOut: TStrings): boolean;
begin
  Result := false;
end;

function NifTextureListResource(akData: Variant; akListOut: TStrings): boolean;
begin
  Result := false;
end;

function NifTextureListUVRange(akData: TBytes; afUVRange: Single; akListOut: TStrings): boolean;
begin
  Result := false;
end;

// ********************************************************************
// DDS functions
// ********************************************************************

function wbDDSStreamToBitmap(akStream: TStream; akBitmapOut: TBitmap): boolean;
begin
  Result := false;
end;

function wbDDSDataToBitmap(akData: TBytes; akBitmapOut: TBitmap): boolean;
begin
  Result := false;
end;

function wbDDSResourceToBitmap(akUnknown: IInterface; akBitmapOut: TBitmap): boolean;
begin
  Result := false;
end;

end.
