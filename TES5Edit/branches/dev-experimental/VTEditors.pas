{----------------------------------------------------------}
{           Simple Editors for VirtualStringTree           }
{               by Constantine Yannakopoulos               }
{----------------------------------------------------------}
{         This software is distributed "AS IS",            }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. }
{----------------------------------------------------------}

unit VTEditors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Spin,
  VirtualTrees;

{$I Compilers.inc}

type
  TCustomEditLinkClass = class of TCustomEditLink;

  TIntfOwnedPersistent = class(TPersistent, IUnknown)
  protected {private}
    FOwner: TPersistent;
    FOwnerInterface: IUnknown;
    FRefCount: Integer;
    FManaged: Boolean;
  protected
    function GetOwner: TPersistent; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(AOwner: TPersistent); overload; virtual;
    constructor Create(AManaged: Boolean = False); overload;    // if AManaged = True it is a ref-counted object
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    property Owner: TPersistent read FOwner;
    property RefCount: Integer read FRefCount;
    property Managed: Boolean read FManaged;
  end;

  TVirtualStringTreeHacker = class(TVirtualStringTree);

  TCustomEditLink = class(TIntfOwnedPersistent, IVTEditLink)
  protected {private}
    FEdit: TWinControl;
    FTree: TVirtualStringTreeHacker;
    FNode: PVirtualNode;
    FColumn: Integer;
    FTextBounds: TRect;
    FOldEditText: string;
    FStopping: Boolean;
    FOldWndProc: TWndMethod;
    function GetLink: IVTEditLink;
    function GetTree: TCustomVirtualStringTree;
  protected
    function CreateEditControl: TWinControl; virtual; abstract;
    function GetEditText: WideString; virtual;
    procedure SetEditText(const Value: WideString); virtual;
    procedure PrepareEditControl; virtual;

    procedure CMAutoAdjust(var Message: TMessage); message CM_AUTOADJUST;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMRelease(var Message: TMessage); message CM_RELEASE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;

    procedure EditWndProc(var Message: TMessage); virtual;

    procedure AutoAdjustSize; virtual;
    function IsMultiLine: Boolean; virtual;

    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure DoExit(Sender: TObject);
    function Modified: Boolean; virtual;
    procedure StopEdit; virtual;

    function GetHookableWindowProc: TWndMethod; virtual;
    procedure SetHookableWindowProc(const Value: TWndMethod); virtual;

    property Tree: TCustomVirtualStringTree read GetTree;
    property EditControl: TWinControl read FEdit;
    property Node: PVirtualNode read FNode;
    property Column: Integer read FColumn;
    property Stopping: Boolean read FStopping;
    property HookableWindowProc: TWndMethod
      read GetHookableWindowProc
      write SetHookableWindowProc;
  public
    destructor Destroy; override;
    class function GetName: string; virtual;

    procedure DefaultHandler(var Message); override;

    property Link: IVTEditLink read GetLink;
  published
  protected
    { IVTEditLink }
    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(ATree: TBaseVirtualTree; ANode: PVirtualNode; AColumn: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(Rect: TRect); virtual; stdcall;

    procedure AfterBeginEdit; virtual;
  end;

  TEditEditLink = class(TCustomEditLink)
  protected {private}
    FReadOnly: Boolean;
  protected
    function CreateEditControl: TWinControl; override;
    procedure PrepareEditControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
    procedure EditWndProc(var Message: TMessage); override;
    procedure KeyPress(Sender: TObject; var Key: Char);
  public
    constructor Create(AReadOnly: Boolean = False); overload;
  published
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
  end;

  TMemoEditLink = class(TCustomEditLink)
  protected {private}
    FReadOnly: Boolean;
    FExtent: TPoint;
  protected
    function CreateEditControl: TWinControl; override;
    procedure PrepareEditControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
    function IsMultiLine: Boolean; override;
  public
    constructor Create(AReadOnly: Boolean = False);  overload;
    procedure SetBounds(R: TRect); override; stdcall;
  published
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ExtentX: Integer read FExtent.X write FExtent.X default 0;
    property ExtentY: Integer read FExtent.Y write FExtent.Y default 0;
  end;

  TSpinEditLink = class(TCustomEditLink)
  protected {private}
    FReadOnly: Boolean;
    FEditorEnabled: Boolean;
    FIncrement: Integer;
    FMinValue: Integer;
    FMaxValue: Integer;
    procedure KeyPress(Sender: TObject; var Key: Char);
  protected
    function CreateEditControl: TWinControl; override;
    procedure PrepareEditControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
  public
    constructor Create(AOwner: TPersistent); override;
    constructor Create(AEditorEnabled: Boolean = True; AIncrement: Integer = 1; AMinValue: Integer = 0; AMaxValue: Integer = 0);  overload;
  published
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Integer read FIncrement write FIncrement default 1;
    property MinValue: Integer read FMinValue write FMinValue default 0;
    property MaxValue: Integer read FMaxValue write FMaxValue default 0;
  end;

  TAutoCompleteMode = (acNone, acComplete, acLimit);

  TComboEditLink = class;

  IComboCustomDraw = interface ['{3B63A965-89BB-4C1E-988C-DE61726F0C82}']
    procedure ComboDrawItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ComboMeasureItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; var Height: Integer); 
  end;

  TComboEditLink = class(TCustomEditLink)
  protected {private}
    FStyle: TComboBoxStyle;
    FPickList: TStringList;
    FAutoCompleteMode: TAutoCompleteMode;
    FSorted: Boolean;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditChange(Sender: TObject);
    procedure DoAutoComplete(var Key: Char);
    function GetPickList: TStrings;
    procedure SetPickList(const Value: TStrings);
  protected
    function CreateEditControl: TWinControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
    procedure PrepareEditControl; override;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure ComboDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState); virtual;
    procedure ComboMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer); virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    constructor Create(const AList: string; AStyle: TComboBoxStyle; ASorted: Boolean = False); overload;
    constructor Create(APickList: TStrings; AStyle: TComboBoxStyle; ASorted: Boolean = False); overload;
    destructor Destroy; override;
    procedure SetBounds(R: TRect); override;
  published
    property Style: TComboBoxStyle read FStyle write FStyle default csDropDown;
    property Sorted: Boolean read FSorted write FSorted default False;
    property PickList: TStrings read GetPickList write SetPickList;
    property AutoCompleteMode: TAutoCompleteMode read FAutoCompleteMode write FAutoCompleteMode default acNone;
  end;

  TDateEditLink = class(TCustomEditLink)
  protected {private}
    FDateFormat: string;
    FDateSeparator: Char;
    FKind: TDateTimeKind;
  protected
    function CreateEditControl: TWinControl; override;
    procedure PrepareEditControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
  public
    constructor Create(AKind: TDateTimeKind; const ADateFormat: string = ''; ADateSeparator: Char = #0);
  published
    property DateFormat: string read FDateFormat write FDateFormat;
    property DateSeparator: Char read FDateSeparator write FDateSeparator default #0;
    property Kind: TDateTimeKind read FKind write FKind default dtkDate;
  end;

  TCheckEditLink = class(TCustomEditLink)
  protected {private}
    FAllowGrayed: Boolean;
    FValueFalse: string;
    FValueTrue: string;
    FValueGrayed: string;
  protected
  protected
    function CreateEditControl: TWinControl; override;
    procedure PrepareEditControl; override;
    function GetEditText: WideString; override;
    procedure SetEditText(const Value: WideString); override;
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property ValueFalse: string read FValueFalse write FValueFalse;
    property ValueTrue: string read FValueTrue write FValueTrue;
    property ValueGrayed: string read FValueGrayed write FValueGrayed;
  end;

procedure RegisterEditLink(ALinkClass: TCustomEditLinkClass);
procedure RevokeEditLink(ALinkClass: TCustomEditLinkClass);
function GetEditLinkClass(const Name: string): TCustomEditLinkClass;
procedure GetEditLinkClasses(Strings: TStrings);

implementation

uses
  TypInfo,
  Types;

{$IFNDEF DELPHI_5_UP}

function AnsiSameText(const S1, S2: string): Boolean;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PChar(S1),
    Length(S1), PChar(S2), Length(S2)) = 2;
end;

procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;
  P.Free;
end;

{$ENDIF}

var
  LinkClasses: TStringList = nil;

{ TIntfOwnedPersistent }

constructor TIntfOwnedPersistent.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FManaged := True;
end;

constructor TIntfOwnedPersistent.Create(AManaged: Boolean = False);
begin
  Create(nil);
  FManaged := AManaged;
end;

procedure TIntfOwnedPersistent.AfterConstruction;
begin
  inherited;
  if GetOwner <> nil then
    GetOwner.GetInterface(IUnknown, FOwnerInterface);
  if not FManaged then
    InterlockedDecrement(FRefCount);
end;

procedure TIntfOwnedPersistent.BeforeDestruction; 
begin
  Assert(FManaged or (FRefCount = 0),
    Format('%s instance has RefCount <> 0 during destruction.', [ClassName]));
end;

class function TIntfOwnedPersistent.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TIntfOwnedPersistent(Result).FRefCount := 1;
end;

function TIntfOwnedPersistent.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TIntfOwnedPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TIntfOwnedPersistent._AddRef: Integer;
begin
  if FOwnerInterface <> nil then
    Result := FOwnerInterface._AddRef
  else if not FManaged then
    Result := InterlockedIncrement(FRefCount)
  else
    Result := -1;
end;

function TIntfOwnedPersistent._Release: Integer;
begin
  if FOwnerInterface <> nil then
    Result := FOwnerInterface._Release
  else if not FManaged then
  begin
    Result := InterlockedDecrement(FRefCount);
    if Result <= 0 then Destroy;
  end
  else
    Result := -1;
end;

{ TCustomEditLink }

type
  TWinControlAccess = class(TWinControl);

procedure TCustomEditLink.DefaultHandler(var Message);
begin
  FOldWndProc(TMessage(Message));
end;

destructor TCustomEditLink.Destroy;
begin
  FreeAndNil(FEdit);
  inherited Destroy;
end;

class function TCustomEditLink.GetName: string;
var
  I: Integer;
begin
  Result := ClassName;
  if Result[1] = 'T' then Delete(Result, 1, 1);
  I := Pos('EditLink', Result);
  if I = Length(Result) - 7 then SetLength(Result, Length(Result) - 8);
end;

function TCustomEditLink.GetTree: TCustomVirtualStringTree;
begin
  Result := FTree;
end;

function TCustomEditLink.IsMultiLine: Boolean;
begin
  Result := Assigned(FNode) and (vsMultiline in FNode.States);
end;

procedure TCustomEditLink.AfterBeginEdit;
begin
  {can be override}
end;

procedure TCustomEditLink.AutoAdjustSize;
begin
  {can be override}
end;

function TCustomEditLink.BeginEdit: Boolean;
begin
  Result := not FStopping;
  if Result then
  begin
    FEdit.Show;
    FEdit.SetFocus;
    FOldWndProc := HookableWindowProc;
    HookableWindowProc := EditWndProc;
    FOldEditText := GetEditText;
    AfterBeginEdit;
  end;
end;

function TCustomEditLink.CancelEdit: Boolean;
begin
  Result := not FStopping;
  if Result then
  try
    FStopping := True;
    FEdit.Hide;
    FTree.CancelEditNode;
    StopEdit;
  finally
    FStopping := False;
  end;
end;

procedure TCustomEditLink.CMAutoAdjust(var Message: TMessage);
begin
  AutoAdjustSize;
end;

procedure TCustomEditLink.CMExit(var Message: TMessage);
begin
  if not FStopping then with FTree do begin
    if (toAutoAcceptEditChange in TreeOptions.StringOptions) then
      DoEndEdit
    else
      DoCancelEdit;
  end else
    inherited;
end;

procedure TCustomEditLink.CMRelease(var Message: TMessage);
begin
  //is this ever called?
  inherited;
end;

procedure TCustomEditLink.CNCommand(var Message: TWMCommand);
begin
  if not FStopping and Assigned(FEdit) and Assigned(FTree) and (Message.NotifyCode = EN_UPDATE) and
    not (toGridExtensions in FTree.TreeOptions.MiscOptions) and
    not IsMultiLine then
    // Instead directly calling AutoAdjustSize it is necessary on Win9x/Me to decouple this notification message
    // and eventual resizing. Hence we use a message to accomplish that.
    if Win32Platform = VER_PLATFORM_WIN32_NT then
      AutoAdjustSize
    else
      PostMessage(FEdit.Handle, CM_AUTOADJUST, 0, 0);
end;

function TCustomEditLink.EndEdit: Boolean;
begin
  Result := not FStopping;
  if Result then
  try
    FStopping := True;
    if Modified then FTree.Text[FNode, FColumn, True] := GetEditText;
    //!!!FTree.EndEditNode;
    StopEdit;
  finally
    FStopping := False;
  end;
end;

function TCustomEditLink.GetBounds: TRect;
begin
  Result := FEdit.BoundsRect;
end;

function TCustomEditLink.PrepareEdit(ATree: TBaseVirtualTree; ANode: PVirtualNode; AColumn: TColumnIndex): Boolean;
var
  s: string;
begin
  Result := not FStopping;
  if Result then
  begin
    FTree := TVirtualStringTreeHacker(ATree as TCustomVirtualStringTree);
    FNode := ANode;
    FColumn := AColumn;
    FreeAndNil(FEdit);
    FEdit := CreateEditControl;
    Result := Assigned(FEdit);
    if Result then
      with FEdit do
      begin
        Visible := False;
        Parent := Tree;
        TWinControlAccess(EditControl).OnKeyDown := KeyDown;
        TWinControlAccess(EditControl).OnExit := DoExit;
        FEdit.BoundsRect := FTree.GetDisplayRect(FNode, FColumn, False);
        s := FTree.Text[FNode, FColumn, True];
        FTree.GetTextInfo(FNode, FColumn, TWinControlAccess(EditControl).Font, FTextBounds, True, s);
        PrepareEditControl;
        SetEditText(s);
      end;
  end;
end;

procedure TCustomEditLink.ProcessMessage(var Message: TMessage);
begin
  HookableWindowProc(Message);
end;

procedure TCustomEditLink.SetBounds(Rect: TRect);
var
  L, R: Integer;
  NodeRect: TRect;
begin
  if not (toGridExtensions in TVirtualStringTree(FTree).TreeOptions.MiscOptions) then
  begin
    NodeRect := FTree.GetDisplayRect(FNode, FColumn, True);
    Rect.Left := NodeRect.Left;
    TVirtualStringTree(FTree).Header.Columns.GetColumnBounds(FColumn, L, R);
    Rect.Right := R;
  end;
  FEdit.BoundsRect := Rect;
end;

function TCustomEditLink.GetEditText: WideString;
var
  Len: Integer;
begin
  Len := GetWindowTextLengthW(FEdit.Handle);
  SetLength(Result, Len);
  if Len > 0 then
    GetWindowTextW(FEdit.Handle, @Result[1], Len);
end;

function TCustomEditLink.GetHookableWindowProc: TWndMethod;
begin
  Result := FEdit.WindowProc;
end;

procedure TCustomEditLink.SetEditText(const Value: WideString);
begin
  SetWindowTextW(FEdit.Handle, PWideChar(Value));
end;

procedure TCustomEditLink.SetHookableWindowProc(const Value: TWndMethod);
begin
  FEdit.WindowProc := Value;
end;

procedure TCustomEditLink.PrepareEditControl;
begin
end;

procedure TCustomEditLink.EditWndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TCustomEditLink.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      FTree.CancelEditNode;
    VK_RETURN:
      if Shift = [] then
        FTree.EndEditNode
      else
        Exit;
  else
    Exit;
  end;
  Key := 0;
end;

procedure TCustomEditLink.DoExit(Sender: TObject);
begin
  if not FStopping then FTree.EndEditNode;
end;

function TCustomEditLink.Modified: Boolean;
begin
  Result := GetEditText <> FOldEditText;
end;

procedure TCustomEditLink.StopEdit;
begin
  if Assigned(FEdit) then
  begin
    FEdit.Hide;
    HookableWindowProc := FOldWndProc;
    FEdit.Parent := nil;
  end;
end;

procedure TCustomEditLink.WMChar(var Message: TWMChar);
begin
  if not (Message.CharCode in [VK_ESCAPE, VK_TAB]) then
    inherited;
end;

procedure TCustomEditLink.WMDestroy(var Message: TWMDestroy);
begin
  // If editing stopped by other means than accept or cancel then we have to do default processing for
  // pending changes.
  if not FStopping then
    with FTree do
      if (toAutoAcceptEditChange in TreeOptions.StringOptions) and Modified then
        Text[FNode, FColumn, True] := GetEditText;

  inherited;
end;

procedure TCustomEditLink.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;

  Message.Result := Message.Result or DLGC_WANTALLKEYS or DLGC_WANTTAB or DLGC_WANTARROWS;
end;

procedure TCustomEditLink.WMKeyDown(var Message: TWMKeyDown);

// Handles some control keys.

var
  Shift: TShiftState;
  EndEdit: Boolean;
  Tree: TVirtualStringTreeHacker;

begin
  case Message.CharCode of
    VK_ESCAPE:
      begin
        Tree := FTree;
        Tree.DoCancelEdit;
        Tree.SetFocus;
      end;
    VK_RETURN:
      begin
        EndEdit := not (vsMultiline in FNode.States);
        if not EndEdit then begin
          // If a multiline node is being edited the finish editing only if Ctrl+Enter was pressed,
          // otherwise allow to insert line breaks into the text.
          Shift := KeyDataToShiftState(Message.KeyData);
          EndEdit := ssCtrl in Shift;
        end;
        if EndEdit then begin
          Tree := FTree;
          Tree.InvalidateNode(FNode);
          Tree.DoEndEdit;
          Tree.SetFocus;
        end;
      end;
    VK_UP:
      begin
        if not IsMultiLine then
          Message.CharCode := VK_LEFT;
        inherited;
      end;
    VK_DOWN:
      begin
        if not IsMultiLine then
          Message.CharCode := VK_RIGHT;
        inherited;
      end;
  else
    inherited;
  end;
end;

function TCustomEditLink.GetLink: IVTEditLink;
begin
  GetInterface(IVTEditLink, Result);
end;

{ TEditEditLink }

constructor TEditEditLink.Create(AReadOnly: Boolean = False);
begin
  Create(nil);
  FReadOnly := AReadOnly;
end;

function TEditEditLink.CreateEditControl: TWinControl;
begin
  Result := TEdit.Create(nil);
end;

procedure TEditEditLink.EditWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_KEYDOWN:
      case TWMKeyDown(Message).CharCode of
        VK_UP:   TWMKeyDown(Message).CharCode := VK_LEFT;
        VK_DOWN: TWMKeyDown(Message).CharCode := VK_RIGHT;
      end;
  end;
  inherited;
end;

procedure TEditEditLink.KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#13, #27] then Key := #0; // Eliminate beep
end;

function TEditEditLink.GetEditText: WideString;
begin
  Result := TEdit(FEdit).Text;
end;

procedure TEditEditLink.PrepareEditControl;
begin
  inherited;
  with TEdit(FEdit) do
  begin
    ReadOnly := FReadOnly;
    OnKeyPress := KeyPress;
  end;
end;

procedure TEditEditLink.SetEditText(const Value: WideString);
begin
  TEdit(FEdit).Text := Value;
end;

type
  TLinkComboBox = class(TComboBox)
  end;

{ TComboEditLink }

constructor TComboEditLink.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FPickList := TStringList.Create;
end;

constructor TComboEditLink.Create(const AList: string; AStyle: TComboBoxStyle;
  ASorted: Boolean = False);
begin
  Create(nil);
  FSorted := ASorted;
  FStyle := AStyle;
  FPickList.CommaText := AList;
  FAutoCompleteMode := acComplete;
end;

constructor TComboEditLink.Create(APickList: TStrings; AStyle: TComboBoxStyle;
  ASorted: Boolean = False);
begin
  Create(nil);
  FSorted := ASorted;
  FStyle := AStyle;
  FAutoCompleteMode := acComplete;
  if Assigned(APickList) then FPickList.AddStrings(APickList);
end;

function TComboEditLink.CreateEditControl: TWinControl;
begin
  Result := TLinkComboBox.Create(nil);
  with TLinkComboBox(Result) do begin
    Ctl3D := False;
  end;
end;

destructor TComboEditLink.Destroy;
begin
  FreeAndNil(FPickList);
  inherited;
end;

procedure TComboEditLink.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      if (FStyle = csSimple) or not TLinkComboBox(EditControl).DroppedDown then
      begin
        Tree.EndEditNode;
        Key := 0;
      end;
    VK_ESCAPE:
      if (FStyle = csSimple) or not TLinkComboBox(EditControl).DroppedDown then
      begin
        Tree.CancelEditNode;
        Key := 0;
      end;
  end;
end;

procedure TComboEditLink.ComboDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  I: IComboCustomDraw;
begin
  if Supports(FOwnerInterface, IComboCustomDraw, I) then
    I.ComboDrawItem(Self, TLinkComboBox(Control), Index, Rect, State);
end;

procedure TComboEditLink.ComboMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
var
  I: IComboCustomDraw;
begin
  if Supports(FOwnerInterface, IComboCustomDraw, I) then
    I.ComboMeasureItem(Self, TLinkComboBox(Control), Index, Height);
end;

function TComboEditLink.GetEditText: WideString;
begin
  Result := TLinkComboBox(EditControl).Text;
end;

procedure TComboEditLink.PrepareEditControl;
begin
  inherited;
  with TLinkComboBox(EditControl) do
  begin
    Sorted := FSorted;
    Style := FStyle;
    Items := FPickList;
    OnKeyPress := EditKeyPress;
    OnChange := EditChange;
    if Style in [csOwnerDrawFixed, csOwnerDrawVariable] then
    begin
      OnDrawItem := ComboDrawItem;
      OnMeasureItem := ComboMeasureItem;
    end;
  end;
end;

procedure TComboEditLink.SetEditText(const Value: WideString);
begin
  with TLinkComboBox(EditControl) do
    if Style = csDropDownList then
      ItemIndex := Items.IndexOf(Value)
    else
      Text := Value;
end;

procedure TComboEditLink.SetBounds(R: TRect);
begin
  if FStyle = csSimple then
    R.Bottom := R.Top + 104;
  inherited SetBounds(R);
end;

procedure TComboEditLink.EditKeyPress(Sender: TObject; var Key: Char);
begin
  DoAutoComplete(Key);
end;

procedure TComboEditLink.DoAutoComplete(var Key: Char);
var
  S, S1: string;
  I, St, L: Integer;
begin
  if (FStyle in [csDropDown, csSimple]) and (Key in [#32 .. #255]) then
    with TLinkComboBox(EditControl) do
      case FAutoCompleteMode of
        acComplete:
          begin
            St := SelStart;
            S := Copy(Text, 1, St) + Key;
            L := Length(S);
            with FPickList do
              for I := 0 to Count - 1 do
                if AnsiSameText(Copy(Strings[I], 1, L), S) then
                begin
                  S1 := S + Copy(Strings[I], Length(S) + 1, MaxInt);
                  TLinkComboBox(EditControl).Text := S1;
                  SelStart := St + 1;
                  SelLength := Length(S1) - St;
                  Key := #0;
                  Exit;
                end;
          end;
      end;
end;

procedure TComboEditLink.EditChange(Sender: TObject);
var
  S: string;
  I, St, Sl, L: Integer;
  List: TStringList;
begin
  if (FStyle in [csDropDown, csSimple]) then
    with TLinkComboBox(EditControl) do
      case FAutoCompleteMode of
        acLimit:
          begin
            S := Text;
            L := Length(S);
            St := SelStart;
            Sl := SelLength;
            List := TStringList.Create;
            try
              if L = 0 then
                List.AddStrings(FPickList)
              else
              begin
                with FPickList do
                  for I := 0 to Count - 1 do
                    if AnsiSameText(Copy(Strings[I], 1, L), S) then
                      List.Add(Strings[I]);
                end;
              if not Items.Equals(List) then Items.Assign(List);
              TLinkComboBox(EditControl).Text := S;
              SelStart := St;
              SelLength := Sl;
            finally
              List.Free;
            end;
          end;
      end;
end;

function TComboEditLink.GetPickList: TStrings;
begin
  Result := FPickList;
end;

procedure TComboEditLink.SetPickList(const Value: TStrings);
begin
  FPickList.Assign(Value);
end;

{ TDateEditLink }

constructor TDateEditLink.Create(AKind: TDateTimeKind; const ADateFormat: string = ''; ADateSeparator: Char = #0);
begin
  FKind := AKind;
  FDateFormat := ADateFormat;
  FDateSeparator := ADateSeparator;
end;

function TDateEditLink.CreateEditControl: TWinControl;
begin
  Result := TDateTimePicker.Create(nil);
end;

procedure TDateEditLink.PrepareEditControl;
begin
  inherited;
  TDateTimePicker(EditControl).Kind := FKind;
end;

function TDateEditLink.GetEditText: WideString;
var
  Sep: Char;
begin
  Sep := SysUtils.DateSeparator;
  try
    if FDateSeparator <> #0 then SysUtils.DateSeparator := FDateSeparator;
      if FDateFormat <> '' then
        Result := FormatDateTime(FDateFormat, TDateTimePicker(EditControl).DateTime)
      else
        case FKind of
          dtkDate: Result := DateToStr(TDateTimePicker(EditControl).DateTime);
          dtkTime: Result := TimeToStr(TDateTimePicker(EditControl).DateTime);
        end;
  finally
    SysUtils.DateSeparator := Sep;
  end;
end;

procedure TDateEditLink.SetEditText(const Value: WideString);
var
  DF: string;
  Sep: Char;
begin
  if Value <> '' then
  try
    DF := ShortDateFormat;
    Sep := SysUtils.DateSeparator;
    try
      if FDateFormat <> '' then ShortDateFormat := FDateFormat;
      if FDateSeparator <> #0 then SysUtils.DateSeparator := FDateSeparator;
      case FKind of
        dtkDate: TDateTimePicker(EditControl).Date := StrToDate(Value);
        dtkTime: TDateTimePicker(EditControl).Time := StrToTime(Value);
      end;
    finally
      ShortDateFormat := DF;
      SysUtils.DateSeparator := Sep;
    end;
  except
  end;
end;

{ TSpinEditLink }

type
  TLinkSpinEdit = class(TSpinEdit)
  protected
    function IsValidChar(Key: Char): Boolean; override;
  end;

function TLinkSpinEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := inherited IsValidChar(Key) or (Key in [#13, #27]);
end;

constructor TSpinEditLink.Create(AOwner: TPersistent);
begin
  inherited Create(nil);
  FEditorEnabled := True;
  Increment := 1;
end;

constructor TSpinEditLink.Create(AEditorEnabled: Boolean; AIncrement,
  AMinValue, AMaxValue: Integer);
begin
  Create(nil);
  FEditorEnabled := AEditorEnabled;
  FIncrement     := AIncrement;
  FMinValue      := AMinValue;
  FMaxValue      := AMaxValue;
end;

function TSpinEditLink.CreateEditControl: TWinControl;
begin
  Result := TLinkSpinEdit.Create(nil);
end;

procedure TSpinEditLink.PrepareEditControl;
begin
  inherited;
  with TSpinEdit(EditControl) do
  begin
    ReadOnly      := FReadOnly;
    EditorEnabled := FEditorEnabled;
    Increment     := FIncrement;
    MinValue      := FMinValue;
    MaxValue      := FMaxValue;
    OnKeyPress    := KeyPress;
  end;
end;

function TSpinEditLink.GetEditText: WideString;
begin
  Result := TSpinEdit(FEdit).Text;
end;

procedure TSpinEditLink.SetEditText(const Value: WideString);
begin
  TSpinEdit(FEdit).Text := Value;
end;

procedure TSpinEditLink.KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#13, #27] then Key := #0; // Eliminate beep
end;

{ TMemoEditLink }

constructor TMemoEditLink.Create(AReadOnly: Boolean);
begin
  Create(nil);
  FReadOnly := AReadOnly;
end;

type
  TSizeGrip = class(TCustomControl)
  protected {private}
    FCaptured: Boolean;
    FDragStartPos: TPoint;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TSizeGrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Anchors := [akRight, akBottom];
  Cursor := crSizeNWSE;
  Width := GetSystemMetrics(SM_CXVSCROLL);
  Height := GetSystemMetrics(SM_CYHSCROLL);
  ControlStyle := [csDoubleClicks];
  if SysLocale.FarEast and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    ImeMode := imDisable;
end;

procedure TSizeGrip.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TSizeGrip.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FCaptured := True;
  SetCaptureControl(Self);
  FDragStartPos := SmallPointToPoint(Message.Pos);
end;

procedure TSizeGrip.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  FCaptured := False;
  SetCaptureControl(nil);
end;

procedure TSizeGrip.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TSizeGrip.WMMouseMove(var Message: TWMMouseMove);
var
  NewW, NewH: integer;
begin
  inherited;
  if FCaptured then
  begin
    NewW := Parent.Width + Message.XPos - FDragStartPos.x;
    NewH := Parent.Height + Message.YPos - FDragStartPos.Y;
    if NewW < 16 then NewW := 16;
    if NewH < 16 then NewH := 16;
    MoveWindow(Parent.Handle, Parent.Left, Parent.Top, NewW, NewH, True);
    Application.ProcessMessages; // Give windows a chance to repaint.
  end;
end;

procedure TSizeGrip.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Tabstop := False;
  with Params do
  begin
    Style := WS_CHILD;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
  ControlStyle := ControlStyle - [csFramed];
end;

procedure TSizeGrip.CreateWnd;
var
  Rgn: HRGN;
  Triangle: array[0..2] of TPoint;
begin
  inherited;
  with ClientRect do
  begin
    Triangle[0].X := Right;
    Triangle[0].Y := Top;
    Triangle[1] := BottomRight;
    Triangle[2].X := Left;
    Triangle[2].Y := Bottom;
  end;
  Rgn := CreatePolygonRgn(Triangle, 3, ALTERNATE);
  SetWindowRgn(Handle, Rgn, True);
end;

procedure TSizeGrip.Paint;
begin
  inherited;
  DrawFrameControl(Canvas.Handle, ClientRect, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
end;

type
  TGripMemo = class(TMemo)
  protected {private}
    FGrip: TSizeGrip;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WndProc(var Message: TMessage); override;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TGripMemo.Create(AOwner: TComponent);
begin
  inherited;
  FGrip := TSizeGrip.Create(Self);
  with FGrip do
  begin
    Parent := Self;
    Left := Self.Width - Width - 1;
    Top := Self.Height - Height - 1;
    Anchors := [akRight, akBottom];
    Visible := True;
  end;
end;

procedure TGripMemo.CNCommand(var Message: TWMCommand);
begin
  inherited;
  with Message do
    if (NotifyCode = EN_CHANGE) or (NotifyCode = EN_UPDATE) or
       (NotifyCode = EN_HSCROLL) or (NotifyCode = EN_VSCROLL) then
    begin
      Invalidate;
      FGrip.Invalidate;
    end;
end;

procedure TGripMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FGrip.Invalidate;
end;

procedure TGripMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
  inherited;
  FGrip.Invalidate;
end;

procedure TGripMemo.WndProc(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
    WM_NOTIFY:
      if TWMNotify(Message).NMHdr.code = EN_UPDATE then
        FGrip.Invalidate;
  end;
end;

function TMemoEditLink.CreateEditControl: TWinControl;
begin
  Result := TGripMemo.Create(nil);
end;

function TMemoEditLink.GetEditText: WideString;
begin
  Result := TMemo(FEdit).Text;
end;

function TMemoEditLink.IsMultiLine: Boolean;
begin
  Result := True;
end;

procedure TMemoEditLink.PrepareEditControl;
begin
  inherited;
  with TMemo(FEdit) do
  begin
    Ctl3d := False;
    ReadOnly := FReadOnly;
    WordWrap := True;
  end;
end;

procedure TMemoEditLink.SetBounds(R: TRect);
var
  TreeRect: TRect;
begin
  if (FExtent.x > 0) or (FExtent.y > 0) then
  begin
    if FExtent.x > 0 then R.Right := R.Left + FExtent.x;
    if FExtent.y > 0 then R.Bottom := R.Top + FExtent.y;
  end
  else
    R.Bottom := R.Bottom + (R.Bottom - R.Top);

  TreeRect := FTree.ClientRect;
  if R.Bottom > TreeRect.Bottom then
    OffsetRect(R, 0, TreeRect.Bottom - R.Bottom);
  IntersectRect(R, TreeRect, R);
  inherited SetBounds(R);
end;

procedure TMemoEditLink.SetEditText(const Value: WideString);
begin
  with TMemo(FEdit) do
  begin
    Text := Value;
    SelectAll;
  end;
end;

{ Utility functions }

procedure RegisterEditLink(ALinkClass: TCustomEditLinkClass);
begin
  GlobalNameSpace.BeginWrite;
  try
    LinkClasses.Addobject(ALinkClass.GetName, TObject(ALinkClass));
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

procedure RevokeEditLink(ALinkClass: TCustomEditLinkClass);
var
  I: Integer;
begin
  GlobalNameSpace.BeginWrite;
  try
    I := LinkClasses.IndexOf(ALinkClass.GetName);
    if I >= 0 then
      LinkClasses.Delete(I);
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

function GetEditLinkClass(const Name: string): TCustomEditLinkClass;
var
  I: Integer;
begin
  GlobalNameSpace.BeginRead;
  try
    I := LinkClasses.IndexOf(Name);
    if I >= 0 then
      Result := TCustomEditLinkClass(LinkClasses.Objects[I])
    else
      Result := nil;
  finally
    GlobalNameSpace.EndRead;
  end;
end;

procedure GetEditLinkClasses(Strings: TStrings);
begin
  GlobalNameSpace.BeginRead;
  try
    Strings.AddStrings(LinkClasses);
  finally
    GlobalNameSpace.EndRead;
  end;
end;

{ TCheckEditLink }

constructor TCheckEditLink.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FValueFalse := BooleanIdents[False];
  FValueTrue := BooleanIdents[True];
end;

function TCheckEditLink.CreateEditControl: TWinControl;
begin
  Result := TCheckbox.Create(nil);
end;

function TCheckEditLink.GetEditText: WideString;
begin
  case TCheckbox(EditControl).State of
    cbChecked: Result := FValueTrue;
    cbUnchecked: Result := FValueFalse;
  else
    Result := FValueGrayed;
  end;
end;

procedure TCheckEditLink.PrepareEditControl;
begin
  inherited;
  TCheckbox(EditControl).AllowGrayed := FAllowGrayed;
end;

procedure TCheckEditLink.SetEditText(const Value: WideString);
begin
  if SameText(Value, FValueFalse) then
    TCheckbox(EditControl).Checked := False
  else if SameText(Value, FValueTrue) then
    TCheckbox(EditControl).Checked := True
  else if FAllowGrayed then
    TCheckbox(EditControl).State := cbGrayed
  else
    TCheckbox(EditControl).Checked := False;
end;

initialization

  LinkClasses := TStringList.Create;
  LinkClasses.Sorted := True;
  LinkClasses.Duplicates := dupError;

  RegisterEditLink(TEditEditLink);
  RegisterEditLink(TMemoEditLink);
  RegisterEditLink(TSpinEditLink);
  RegisterEditLink(TComboEditLink);
  RegisterEditLink(TDateEditLink);
  RegisterEditLink(TCheckEditLink);

finalization

  FreeAndNil(LinkClasses);

end.
