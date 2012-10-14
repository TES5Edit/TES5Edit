{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit VirtualEditTree;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, ActiveX, VirtualTrees, VTEditors,
  StdCtrls, ComCtrls;

type
  TVirtualEditableColumn = class;
  TCustomVirtualEditTree = class;

  TEditLinkName = type string;   

  TComboDrawItemEvent = procedure(Sender: TCustomVirtualEditTree; Column: TVirtualEditableColumn; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState) of object;
  TComboMeasureItemEvent = procedure (Sender: TCustomVirtualEditTree; Column: TVirtualEditableColumn; Control: TComboBox; Index: Integer; var Height: Integer) of object;

  TVirtualEditableColumn = class(TVirtualTreeColumn, IUnknown)
  protected {private}
    FEditable: Boolean;
    FLink: TCustomEditLink;
    function GetEditLinkName: TEditLinkName;
    procedure SetEditLinkName(const Value: TEditLinkName);
    procedure SetLink(const Value: TCustomEditLink);
  protected
    function CanEdit(Node: PVirtualNode): Boolean; virtual;
    function CreateEditor(Node: PVirtualNode): IVTEditLink; virtual;
  protected
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // IComboCustomDraw
    procedure ComboDrawItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState); virtual;
    procedure ComboMeasureItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; var Height: Integer); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Editable: Boolean read FEditable write FEditable default True;
    property EditLinkName: TEditLinkName read GetEditLinkName write SetEditLinkName;
    property EditLink: TCustomEditLink read FLink write SetLink;
  end;

  TVTEditHeader = class(TVTHeader)
  protected {private}
    FLink: TCustomEditLink;
    function GetEditLinkName: TEditLinkName;
    procedure SetEditLinkName(const Value: TEditLinkName);
    procedure SetLink(const Value: TCustomEditLink);
  protected
    function CreateEditor(Node: PVirtualNode): IVTEditLink; virtual;
  protected
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    destructor Destroy; override;
  published
    property EditLinkName: TEditLinkName read GetEditLinkName write SetEditLinkName;
    property EditLink: TCustomEditLink read FLink write SetLink;
  end;

  TCustomVirtualEditTree = class(TCustomVirtualStringTree)
  protected {private}
    FOnComboDrawItem: TComboDrawItemEvent;
    FOnComboMeasureItem: TComboMeasureItemEvent;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  protected
    function GetHeaderClass: TVTHeaderClass; override;
    function GetColumnClass: TVirtualTreeColumnClass; override;
    function DoCreateEditor(Node: PVirtualNode; Column: TColumnIndex): IVTEditLink; override;
    procedure DoComboDrawItem(Sender: TVirtualEditableColumn; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState); virtual;
    procedure DoComboMeasureItem(Sender: TVirtualEditableColumn; Control: TComboBox; Index: Integer; var Height: Integer); virtual;

    property OnColumnComboDrawItem: TComboDrawItemEvent read FOnComboDrawItem write FOnComboDrawItem;
    property OnColumnComboMeasureItem: TComboMeasureItemEvent read FOnComboMeasureItem write FOnComboMeasureItem;
  public
    function CanEdit(Node: PVirtualNode; Column: TColumnIndex): Boolean; override;
  end;

  TVirtualEditTree = class(TCustomVirtualEditTree)
  protected {private}
    function GetHeader: TVTEditHeader;
    procedure SetHeader(Value: TVTEditHeader);
    function GetOptions: TStringTreeOptions;
    procedure SetOptions(const Value: TStringTreeOptions);
  protected
    function GetOptionsClass: TTreeOptionsClass; override;
  public
    property Canvas;
    property DragSelection;
    property DragColumn;
  published
    property AccessibleName;
    property Action;
    property Align;
    property Alignment;
    property Anchors;
    property AnimationDuration;
    property AutoExpandDelay;
    property AutoScrollDelay;
    property AutoScrollInterval;
    property Background;
    property BackgroundOffsetX;
    property BackgroundOffsetY;
    property BiDiMode;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderStyle;
    property BottomSpace;
    property ButtonFillMode;
    property ButtonStyle;
    property BorderWidth;
    property ChangeDelay;
    property CheckImageKind;
    property ClipboardFormats;
    property Color;
    property Colors;
    property Constraints;
    property Ctl3D;
    property CustomCheckImages;
    property DefaultNodeHeight;
    property DefaultPasteMode;
    property DefaultText;
    property DragCursor;
    property DragHeight;
    property DragKind;
    property DragImageKind;
    property DragMode;
    property DragOperations;
    property DragType;
    property DragWidth;
    property DrawSelectionMode;
    property EditDelay;
    property Enabled;
    property Font;
    property Header: TVTEditHeader read GetHeader write SetHeader;
    property HintAnimation;
    property HintMode;
    property HotCursor;
    property Images;
    property IncrementalSearch;
    property IncrementalSearchDirection;
    property IncrementalSearchStart;
    property IncrementalSearchTimeout;
    property Indent;
    property LineMode;
    property LineStyle;
    property Margin;
    property NodeAlignment;
    property NodeDataSize;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RootNodeCount;
    property ScrollBarOptions;
    property SelectionBlendFactor;
    property SelectionCurveRadius;
    property ShowHint;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property TextMargin;
    property TreeOptions: TStringTreeOptions read GetOptions write SetOptions;
    property Visible;
    property WantTabs;

    property OnAdvancedHeaderDraw;
    property OnAfterCellPaint;
    property OnAfterItemErase;
    property OnAfterItemPaint;
    property OnAfterPaint;
    property OnBeforeCellPaint;
    property OnBeforeItemErase;
    property OnBeforeItemPaint;
    property OnBeforePaint;
    property OnChange;
    property OnChecked;
    property OnCheckHotTrack;
    property OnChecking;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnClick;
    property OnColumnDblClick;
    property OnColumnResize;
    property OnCompareNodes;
    {$ifdef COMPILER_5_UP}
      property OnContextPopup;
    {$endif COMPILER_5_UP}
    property OnCreateDataObject;
    property OnCreateDragManager;
    property OnCreateEditor;
    property OnDblClick;
    property OnDragAllowed;
    property OnDragOver;
    property OnDragDrop;
    property OnEditCancelled;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnFocusChanged;
    property OnFocusChanging;
    property OnFreeNode;
    property OnGetCellIsEmpty;
    property OnGetCursor;
    property OnGetHeaderCursor;
    property OnGetText;
    property OnGetEditText;
    property OnPaintText;
    property OnGetHelpContext;
    property OnGetImageIndex;
    property OnGetImageIndexEx;
    property OnGetHint;
    property OnGetLineStyle;
    property OnGetNodeDataSize;
    property OnGetPopupMenu;
    property OnGetUserClipboardFormats;
    property OnHeaderClick;
    property OnHeaderDblClick;
    property OnHeaderDragged;
    property OnHeaderDraggedOut;
    property OnHeaderDragging;
    property OnHeaderDraw;
    property OnHeaderDrawQueryElements;
    property OnHeaderMouseDown;
    property OnHeaderMouseMove;
    property OnHeaderMouseUp;
    property OnHotChange;
    property OnAdvHotChange;
    property OnIncrementalSearch;
    property OnInitChildren;
    property OnInitNode;
    property OnKeyAction;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLoadNode;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnNewText;
    property OnNodeCopied;
    property OnNodeCopying;
    property OnNodeMoved;
    property OnNodeMoving;
    property OnPaintBackground;
    property OnRenderOLEData;
    property OnResetNode;
    property OnResize;
    property OnSaveNode;
    property OnScroll;
    property OnShortenString;
    property OnShowScrollbar;
    property OnStartDock;
    property OnStartDrag;
    property OnStateChange;
    property OnStructureChange;
    property OnUpdating;
    property OnColumnComboDrawItem;
    property OnColumnComboMeasureItem;
  end;

implementation

{ TVirtualEditableColumn }

constructor TVirtualEditableColumn.Create(ACollection: TCollection);
begin
  inherited;
  FEditable := True;
end;

destructor TVirtualEditableColumn.Destroy;
begin
  FreeAndNil(FLink);
  inherited;
end;

function TVirtualEditableColumn.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TVirtualEditableColumn._AddRef: Integer;
begin
  Result := -1;
end;

function TVirtualEditableColumn._Release: Integer;
begin
  Result := -1;
end;

procedure TVirtualEditableColumn.ComboDrawItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  TCustomVirtualEditTree(Owner.Header.Treeview).DoComboDrawItem(Self, Control, Index, Rect, State);
end;

procedure TVirtualEditableColumn.ComboMeasureItem(Sender: TComboEditLink; Control: TComboBox; Index: Integer; var Height: Integer);
begin
  TCustomVirtualEditTree(Owner.Header.Treeview).DoComboMeasureItem(Self, Control, Index, Height);
end;

procedure TVirtualEditableColumn.Assign(Source: TPersistent);
begin
  if Source is TVirtualEditableColumn then
  begin
    FEditable := TVirtualEditableColumn(Source).FEditable;
    EditLinkName := TVirtualEditableColumn(Source).EditLinkName;
  end
  else
    inherited;
end;

function TVirtualEditableColumn.GetEditLinkName: TEditLinkName;
begin
  if Assigned(FLink) then
    Result := FLink.GetName
  else
    Result := '';
end;

procedure TVirtualEditableColumn.SetEditLinkName(const Value: TEditLinkName);
var
  EditLinkClass: TCustomEditLinkClass;
begin
  FreeAndNil(FLink);
  EditLinkClass := GetEditLinkClass(Value);
  if Assigned(EditLinkClass) then
    FLink := EditLinkClass.Create(Self);
end;

function TVirtualEditableColumn.CanEdit(Node: PVirtualNode): Boolean;
begin
  Result := FEditable;
end;

function TVirtualEditableColumn.CreateEditor(Node: PVirtualNode): IVTEditLink;
begin
  if Assigned(FLink) then
    Result := FLink.Link
  else
    Result := TStringEditLink.Create;
end;

procedure TVirtualEditableColumn.SetLink(const Value: TCustomEditLink);
begin
  FLink.Assign(Value);
end;

{ TCustomVirtualEditTree }

procedure TCustomVirtualEditTree.WMChar(var Message: TWMChar);
begin
  with Message do
    if (CharCode in [Ord(^H), 32..255] -
        [VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_BACK, VK_TAB,
         VK_ADD, VK_SUBTRACT, VK_MULTIPLY, VK_DIVIDE, VK_ESCAPE, VK_SPACE, Ord('+'), Ord('-'), Ord('*'), Ord('/')])
        and not Assigned(EditLink) then
      if Assigned(FocusedNode) and EditNode(FocusedNode, FocusedColumn) and Assigned(EditLink) then
      begin
        EditLink.ProcessMessage(TMessage(Message));
        Message.CharCode := 0;
      end;
  inherited;
end;

function TCustomVirtualEditTree.GetHeaderClass: TVTHeaderClass;
begin
  Result := TVTEditHeader;
end;

function TCustomVirtualEditTree.GetColumnClass: TVirtualTreeColumnClass;
begin
  Result := TVirtualEditableColumn;
end;

function TCustomVirtualEditTree.CanEdit(Node: PVirtualNode;
  Column: TColumnIndex): Boolean;
begin
  Result := inherited CanEdit(Node, Column);
  if Result and (Column >= 0) then
    Result := TVirtualEditableColumn(Header.Columns[Column]).Editable;
end;

function TCustomVirtualEditTree.DoCreateEditor(Node: PVirtualNode;
  Column: TColumnIndex): IVTEditLink;
begin
  Result := nil;
  if Assigned(OnCreateEditor) then
    OnCreateEditor(Self, Node, Column, Result);
  if (Result = nil) then
    if Column >= 0 then
      Result := TVirtualEditableColumn(Header.Columns[Column]).CreateEditor(Node)
    else
      Result := TVTEditHeader(Header).CreateEditor(Node)
  else
    Result := inherited DoCreateEditor(Node, Column);
end;

procedure TCustomVirtualEditTree.DoComboDrawItem(Sender: TVirtualEditableColumn; Control: TComboBox; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Assigned(FOnComboDrawItem) then FOnComboDrawItem(Self, Sender, Control, Index, Rect, State);
end;

procedure TCustomVirtualEditTree.DoComboMeasureItem(Sender: TVirtualEditableColumn; Control: TComboBox; Index: Integer; var Height: Integer);
begin
  if Assigned(FOnComboMeasureItem) then FOnComboMeasureItem(Self, Sender, Control, Index, Height);
end;

{ TVirtualEditTree }

function TVirtualEditTree.GetOptionsClass: TTreeOptionsClass;
begin
  Result := TStringTreeOptions;
end;

function TVirtualEditTree.GetOptions: TStringTreeOptions;
begin
  Result := TStringTreeOptions(inherited TreeOptions);
end;

procedure TVirtualEditTree.SetOptions(const Value: TStringTreeOptions);
begin
  inherited TreeOptions := Value;
end;

function TVirtualEditTree.GetHeader: TVTEditHeader;
begin
  Result := TVTEditHeader(inherited Header);
end;

procedure TVirtualEditTree.SetHeader(Value: TVTEditHeader);
begin
  inherited Header := Value;
end;

{ TVTEditHeader }

destructor TVTEditHeader.Destroy;
begin
  FreeAndNil(FLink);
  inherited;
end;

function TVTEditHeader.GetEditLinkName: TEditLinkName;
begin
  if Assigned(FLink) then
    Result := FLink.GetName
  else
    Result := '';
end;

procedure TVTEditHeader.SetEditLinkName(const Value: TEditLinkName);
var
  EditLinkClass: TCustomEditLinkClass;
begin
  FreeAndNil(FLink);
  EditLinkClass := GetEditLinkClass(Value);
  if Assigned(EditLinkClass) then
    FLink := EditLinkClass.Create(Self);
end;

procedure TVTEditHeader.SetLink(const Value: TCustomEditLink);
begin
  FLink.Assign(Value);
end;

function TVTEditHeader.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TVTEditHeader._AddRef: Integer;
begin
  Result := -1;
end;

function TVTEditHeader._Release: Integer;
begin
  Result := -1;
end;

function TVTEditHeader.CreateEditor(Node: PVirtualNode): IVTEditLink;
begin
  if Assigned(FLink) then
    Result := FLink.Link
  else
    Result := TStringEditLink.Create;
end;

end.
