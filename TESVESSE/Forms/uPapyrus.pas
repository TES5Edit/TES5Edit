unit uPapyrus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uESSFile, ExtCtrls, StdCtrls, ComCtrls, uHelper, GlassButton,
  VistaProgressBar, CommCtrl, RichEdit;

const
  WM_READY = WM_USER + 1;

type
  TLog = procedure(R: TRichEdit; S: string; C: TColor = clBlack);

  TfPapyrus = class(TForm)
    pnMenu: TPanel;
    sdExport: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnBreakClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    rdLog: TRichEdit;
    OldProc: TWndMethod;
    pP, pV: ^TPapyrus;
    bBreak: Boolean;
    bAll: Boolean;
    btnBreak, btnExport: TGlassButton;
    pbProcess: TVistaProgressBar;
    procedure Start(var Msg: TMsg); message WM_READY;
    procedure NewProc(var Message: TMessage);
  public
    procedure CopyVariables(var P, V: TPapyrus; All: Boolean = False);
  end;

function GetStringIndex(S: string; var P: TPapyrus): integer;
function GetInstanceDataIndex(Index: Integer; var P: TPapyrus): integer;
function GetReferenceDataIndex(Index: Integer; var P: TPapyrus): integer;
function GetArrayDataIndex(Index: Integer; var P: TPapyrus): integer;
function GetActiveDataIndex(Index: Integer; var P: TPapyrus): integer;

function GetInstanceIndex(D: Integer; var P: TPapyrus): integer;
function GetReferenceIndex(D: Integer; var P: TPapyrus): integer;
function GetArrayIndex(D: Integer; var P: TPapyrus): integer;
function GetActiveIndex(D: Integer; var P: TPapyrus): integer;

implementation

uses
  uMain, Math, uCmpPapyrus;

{$R *.dfm}

procedure Log(R: TRichEdit; S: string; C: TColor = clBlack);
begin
  with R do
  begin
    SelStart := Length(Text);
    SelAttributes.Color := C;
    SelText := S + #10;
    if Pos(#13, S) <> 0 then
      SelText := #10;
    SelStart := Length(Text);
    Perform(EM_SCROLLCARET, 0, 0);
    Application.ProcessMessages;
  end;
end;

procedure TfPapyrus.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := btnBreak.ImageIdx = 9;
  if not bBreak then
  begin
    bBreak := True;
    btnBreak.Enabled := False;
  end;
end;

procedure TfPapyrus.FormCreate(Sender: TObject);
begin
  OldProc := WindowProc;
  WindowProc := NewProc;
  rdLog := TRichEdit50.Create(Self);
  with rdLog do
  begin
    Parent := Self;
    Align := alClient;
    BevelOuter := bvSpace;
    Color := 16250871;
    Ctl3D := False;
    ParentCtl3D := False;
    MaxLength := $7FFFFFF0;
    ReadOnly := True;
    ScrollBars := ssBoth;
    TabOrder := 0;
    WordWrap := False;
  end;
  
  btnBreak := CreateButton('Break', True, clBlack, pnMenu.ClientWidth - 77, 2, 25, 75, 8, 1, [akRight, akTop], Self, pnMenu, fMain.imImages, btnBreakClick, nil);
  pbProcess := TVistaProgressBar.Create(Self);
  with pbProcess do
  begin
    Parent := Self;
    Align := alBottom;
    Height := 16;
    Position := 0;
  end;
  bBreak := False;
end;

procedure TfPapyrus.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_READY, 0, 0);
end;

procedure TfPapyrus.NewProc(var Message: TMessage);
begin
  if (Message.Msg in [WM_CLOSE, WM_QUERYENDSESSION]) and not bBreak then
  begin
    bBreak := True;
    btnBreak.Enabled := False;
  end
  else
    OldProc(Message);
end;

procedure TfPapyrus.btnBreakClick(Sender: TObject);
begin
  bBreak := True;
  btnBreak.Enabled := False;
end;

procedure TfPapyrus.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfPapyrus.CopyVariables(var P, V: TPapyrus; All: Boolean = False);
begin
  pbProcess.Max := 100;
  pbProcess.Position := 0;
  pbProcess.Visible := True;
  pP := @P;
  pV := @V;
  bAll := All;
  ShowModal;
end;

function GetInstanceDataIndex(Index: Integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if Index < Length(P.yInstances) then
    if (Index < Length(P.yInstanceData)) and (P.yInstances[Index]^.iID = P.yInstanceData[Index]^.iID) then
      Result := Index
    else
      for i := 0 to Length(P.yInstanceData) - 1 do
        if P.yInstances[Index]^.iID = P.yInstanceData[i]^.iID then
        begin
          Result := i;
          Break;
        end;
end;

function GetReferenceDataIndex(Index: Integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if Index < Length(P.yReferences) then
    if (Index < Length(P.yReferenceData)) and (P.yReferences[Index]^.iID = P.yReferenceData[Index]^.iID) then
      Result := Index
    else
      for i := 0 to Length(P.yReferenceData) - 1 do
        if P.yReferences[Index]^.iID = P.yReferenceData[i]^.iID then
        begin
          Result := i;
          Break;
        end;
end;

function FindInstanceIndex(var T: TInstance; S: string; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(P.yInstances) - 1 do
    with P.yInstances[i]^ do
      if (GetName(iScript, P) = S) and (iUnknow1 = T.iUnknow1) and (iUnknow2 = T.iUnknow2) and (RefIDCompare(rRef, T.rRef) = 0) and (iUsed = T.iUsed) then
      begin
        Result := i;
        Break;
      end;
end;

function GetStringIndex(S: string; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(P.yStrings) - 1 do
    with P.yStrings[i]^ do
      if sName = S then
      begin
        Result := i + 1;
        Break;
      end;
end;

function GetInstanceIndex(D: integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if D <> 0 then
    for i := 0 to Length(P.yInstances) - 1 do
      with P.yInstances[i]^ do
        if iID = D then
        begin
          Result := i;
          Break;
        end;
end;

function GetReferenceIndex(D: integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if D <> 0 then
    for i := 0 to Length(P.yReferences) - 1 do
      with P.yReferences[i]^ do
        if iID = D then
        begin
          Result := i;
          Break;
        end;
end;

function GetArrayIndex(D: integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if D <> 0 then
    for i := 0 to Length(P.yArrays) - 1 do
      with P.yArrays[i]^ do
        if iID = D then
        begin
          Result := i;
          Break;
        end;
end;

function GetActiveIndex(D: integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if D <> 0 then
    for i := 0 to Length(P.yActives) - 1 do
      with P.yActives[i]^ do
        if iID = D then
        begin
          Result := i;
          Break;
        end;
end;

function GetArrayDataIndex(Index: Integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if Index < Length(P.yArrays) then
    if (Index < Length(P.yArrayData)) and (P.yArrays[Index]^.iID = P.yArrayData[Index]^.iID) then
      Result := Index
    else
      for i := 0 to Length(P.yArrayData) - 1 do
        if P.yArrays[Index]^.iID = P.yArrayData[i]^.iID then
        begin
          Result := i;
          Break;
        end;
end;

function GetActiveDataIndex(Index: Integer; var P: TPapyrus): integer;
var
  i: integer;
begin
  Result := -1;
  if Index < Length(P.yActives) then
    if (Index < Length(P.yActiveData)) and (P.yActives[Index]^.iID = Integer(P.yActiveData[Index]^.iID)) then
      Result := Index
    else
      for i := 0 to Length(P.yActiveData) - 1 do
        if P.yActives[Index]^.iID = Integer(P.yActiveData[i]^.iID) then
        begin
          Result := i;
          Break;
        end;
end;

function SetStrings(S: string; var P: TPapyrus; Old: integer; Add: Boolean; R: TRichEdit = nil): integer;
begin
  if S = '' then
    Result := 0
  else
  begin
    Result := GetStringIndex(S, P);
    if Result = -1 then
      if Add then
      begin
        Inc(P.iStringCount);
        Result := Length(P.yStrings) + 1;
        SetLength(P.yStrings, Result);
        New(P.yStrings[Result - 1]);
        P.yStrings[Result - 1]^.sName := S;
        if Assigned(R) then
          Log(R, 'W01: Added string to Main Papyrus. String: ' + P.yStrings[Length(P.yStrings) - 1]^.sName, clPurple);
      end
      else
        Result := Old;
  end;
end;

function GetMemberReference(D: integer; var P: TPapyrus): string;
var
  i: integer;
begin
  i := GetInstanceIndex(D, P);
  if i <> -1 then
    Result := GetName(P.yInstances[i]^.iScript, P)
  else
    Result := '';
end;

function SimpleObject(Data: TData): boolean;
var
  i: integer;
begin
  Result := Data.iMemberCount = 0;
  if not Result then
  begin
    Result := True;
    for i := 0 to Data.iMemberCount - 1 do
      if Data.yMembers[i]^.iType in [11..15] then
      begin
        Result := False;
        Break;
      end;
  end;
end;

function SetReferenceFromOther(iRef: integer; var iD: integer; var P, V: TPapyrus; All: Boolean; R: TRichEdit = nil): integer;
var
  i, tP, tV, dV: integer;
begin
  Result := 0;
  if iRef = 0 then
  begin
    if iD <> 0 then
      Result := -1; //reference is null but member indicate to object
    iD := 0;
  end
  else
    begin
      tV := GetInstanceIndex(iRef, V);  //find reference in values table
      if tV <> -1 then //reference exists in values table
      begin
        tP := FindInstanceIndex(V.yInstances[tV]^, GetName(V.yInstances[tV]^.iScript, V), P); //find reference in member table
        if tP <> -1 then //reference exists in member table
          iD := P.yInstances[tP]^.iID
        else //if member indicate to object try add reference to member table
          if iD <> 0 then
            if All then
            begin
              dV := GetInstanceDataIndex(tV, V);
              if dV <> -1 then
                if not SimpleObject(V.yInstanceData[dV]^) then
                  Result := -4 //Reference to complex object
                else
                begin
                  Inc(P.iInstanceCount); //add table element
                  SetLength(P.yInstances, Length(P.yInstances) + 1);
                  New(P.yInstances[Length(P.yInstances) - 1]);
                  P.yInstances[Length(P.yInstances) - 1]^ := V.yInstances[tV]^;
                  iD := P.yInstances[Length(P.yInstances) - 1]^.iID; //Set reference to table
                  SetLength(P.yInstanceData, Length(P.yInstances)); //add data element
                  New(P.yInstanceData[Length(P.yInstances) - 1]);
                  with P.yInstanceData[Length(P.yInstances) - 1]^ do
                  begin
                    iID := V.yInstanceData[dV]^.iID;
                    iFlag := V.yInstanceData[dV]^.iFlag;
                    iReference := SetStrings(GetName(V.yInstanceData[dV]^.iReference, V), P, iReference, All, R);
                    iData1 := V.yInstanceData[dV]^.iData1;
                    iData2 := V.yInstanceData[dV]^.iData2;
                    iMemberCount := V.yInstanceData[dV]^.iMemberCount;
                    SetLength(yMembers, iMemberCount);
                    for i := 0 to iMemberCount - 1 do
                    begin
                      New(yMembers[i]);
                      yMembers[i]^ := V.yInstanceData[dV]^.yMembers[i]^;
                      case V.yInstanceData[dV]^.yMembers[i]^.iType of
                       1: begin
                            Result := SetReferenceFromOther(V.yInstanceData[dV]^.yMembers[i]^.iData, yMembers[i]^.iData, P, V, All, R);
                            yMembers[i]^.iReference := SetStrings(GetName(V.yInstanceData[dV]^.yMembers[i]^.iReference, V), P, yMembers[i]^.iReference, All, R)
                          end;
                       2: yMembers[i]^.iData := SetStrings(GetName(V.yInstanceData[dV]^.yMembers[i]^.iData, V), P, yMembers[i]^.iData, All, R);
                      end;
                    end;
                    if Assigned(R) then
                      Log(R, 'W03: Added object instance to Main Papyrus. Object: [0x' + IntToHex(V.yInstanceData[dV]^.iID, 8) + '] ' + IntToStr(V.yInstanceData[dV]^.iID), clPurple);
                  end;
                end
              else
                Result := -3; //can't find data index for value reference
            end
            else
              Result := -3; //can't find data index for value reference
      end
      else
        if All then
        begin
          tV := GetReferenceIndex(iRef, V);  //find reference in values table
          if tV <> -1 then //object exists in values table
            if GetReferenceIndex(iRef, P) = -1 then
            begin
              dV := GetReferenceDataIndex(tV, V);
              if dV <> -1 then
                if not SimpleObject(V.yReferenceData[dV]^) then
                  Result := -4 //Reference to complex object
                else
                begin
                  Inc(P.iReferenceCount); //add table element
                  SetLength(P.yReferences, Length(P.yReferences) + 1);
                  New(P.yReferences[Length(P.yReferences) - 1]);
                  P.yReferences[Length(P.yReferences) - 1]^ := V.yReferences[tV]^;
                  iD := P.yReferences[Length(P.yReferences) - 1]^.iID; //Set reference to table
                  SetLength(P.yReferenceData, Length(P.yReferences)); //add data element
                  New(P.yReferenceData[Length(P.yReferences) - 1]);
                  with P.yReferenceData[Length(P.yReferences) - 1]^ do
                  begin
                    iID := V.yReferenceData[dV]^.iID;
                    iFlag := V.yReferenceData[dV]^.iFlag;
                    iReference := SetStrings(GetName(V.yReferenceData[dV]^.iReference, V), P, iReference, All, R);
                    iData1 := V.yReferenceData[dV]^.iData1;
                    iData2 := V.yReferenceData[dV]^.iData2;
                    iMemberCount := V.yReferenceData[dV]^.iMemberCount;
                    SetLength(yMembers, iMemberCount);
                    for i := 0 to iMemberCount - 1 do
                    begin
                      New(yMembers[i]);
                      yMembers[i]^ := V.yReferenceData[dV]^.yMembers[i]^;
                      case V.yReferenceData[dV]^.yMembers[i]^.iType of
                       1: begin
                            Result := SetReferenceFromOther(V.yReferenceData[dV]^.yMembers[i]^.iData, yMembers[i]^.iData, P, V, All, R);
                            yMembers[i]^.iReference := SetStrings(GetName(V.yReferenceData[dV]^.yMembers[i]^.iReference, V), P, yMembers[i]^.iReference, All, R);
                          end;
                       2: yMembers[i]^.iData := SetStrings(GetName(V.yReferenceData[dV]^.yMembers[i]^.iData, V), P, yMembers[i]^.iData, All, R);
                      end;
                    end;
                    if Assigned(R) then
                      Log(R, 'W04: Added object reference to Main Papyrus. Object: [0x' + IntToHex(V.yReferenceData[dV]^.iID, 8) + '] ' + IntToStr(V.yReferenceData[dV]^.iID), clPurple);
                  end;
                end
              else
                Result := -3; //can't find data index for value reference
            end
            else
              iD := iRef
          else
            if iD <> 0 then
              Result := -2; //reference not exists in value table but member indicate to object
        end
        else
          if iD <> 0 then
            Result := -2; //reference not exists in value table but member indicate to object
    end;
end;

function PM(sT, sM, sV, sA, sP1, sP2: string): string; //Prepare Message
begin
  Result := sT + sM + sA + sP1 + '} ' + sV + sA + sP2 + '}';
end;

function AddArray(var A: integer; var P, N: TPapyrus; All: Boolean; R: TRichEdit = nil): integer;
var
  i: integer;
begin
  Result := GetArrayDataIndex(A, N);
  with P do
    if Result <> -1 then
    begin
      Inc(iArrayCount);
      SetLength(yArrays, iArrayCount);
      New(yArrays[iArrayCount - 1]);
      yArrays[iArrayCount - 1]^ := N.yArrays[A]^;
      with yArrays[iArrayCount - 1]^ do
        if iType in [1, 11] then
          iReference := SetStrings(GetName(N.yArrays[A]^.iReference, N), P, iReference, All, R);
      SetLength(yArrayData, iArrayCount);
      New(yArrayData[iArrayCount - 1]);
      with yArrayData[iArrayCount - 1]^ do
      begin
        iID := N.yArrays[A]^.iID;
        SetLength(yMembers, N.yArrays[A]^.iMemberCount);
        for i := 0 to N.yArrays[A]^.iMemberCount - 1 do
        begin
          New(yMembers[i]);
          yMembers[i]^ :=  N.yArrayData[Result]^.yMembers[i]^;
          case N.yArrays[A]^.iType of
            1, 11:
            begin
              case SetReferenceFromOther(N.yArrayData[Result]^.yMembers[i]^.iData, yMembers[i]^.iData, P, N, All, R) of
                -1: Log(R, 'W62: Values data reference to null but member indicate to object. Member: ' + IntToStr(i) + '. Member reference type: ' + GetName(N.yArrayData[Result]^.yMembers[i]^.iData, N), clPurple);
                -2: Log(R, 'W63: Values object not exists but member indicate to object. Member: ' + IntToStr(i) + '. Member reference type: ' + GetName(N.yArrayData[Result]^.yMembers[i]^.iData, N), clPurple);
                -3: Log(R, 'E64: Can''t find data index for reference. Member: ' + IntToStr(i) + '. Member reference type: ' + GetName(N.yArrayData[Result]^.yMembers[i]^.iData, N), clRed);
                -4: Log(R, 'E65: Reference to complex object. Member: ' + IntToStr(i) + '. Member reference type: ' + GetName(N.yArrayData[Result]^.yMembers[i]^.iData, N), clRed);
              end;
              yMembers[i]^.iReference := SetStrings(GetName(N.yArrayData[Result]^.yMembers[i]^.iReference, N), P, yMembers[i]^.iReference, All, R);
            end;
            2: yMembers[i]^.iData := SetStrings(GetName(N.yArrayData[Result]^.yMembers[i]^.iData, N), P, yMembers[i]^.iData, All, R)
          end;
        end;
      end;
      if Assigned(R) then
        Log(R, 'W64: Added array to Main Papyrus. Array: [0x' + IntToHex(yArrays[iArrayCount - 1]^.iID, 8) + '] ' + IntToStr(yArrays[iArrayCount - 1]^.iID), clPurple);
      Result := Length(yArrayData) - 1;
    end;
end;

procedure TfPapyrus.Start(var Msg: TMsg);
var
  i, j, k, iP, iV, aP, aV: integer;
  sMain, sVal, sP, sV: string;
begin
  Log(rdLog, 'Start copying process at: ' + DateTimeToStr(Now) + #13, clBlue);
  i := 0;
  while i < (pP^.iInstanceCount - 1) do
  begin
    iP := GetInstanceDataIndex(i, pP^);
    sP := GetName(pP^.yInstances[iP]^.iScript, pP^);
    if iP <> -1 then
    begin
      sMain := 'Main: {' + IntToStr(iP) + ' Script: ' + sP + ', ';
      iV := FindInstanceIndex(pP^.yInstances[i]^, sP, pV^);
      if iV <> -1 then
      begin
        sV := GetName(pV^.yInstances[iV]^.iScript, pV^);
        sVal := 'Variables: {' + IntToStr(iV) + ' Script: ' + sV + ', ';
        iV := GetInstanceDataIndex(iV, pV^);
        if iV <> -1 then
        begin
          if pP^.yInstanceData[iP]^.iMemberCount <> pV^.yInstanceData[iV]^.iMemberCount then
            Log(rdLog, PM('E04: Inconsistent member count in script instances. ', sMain, sVal, ' Members count: ', IntToStr(pP^.yInstanceData[iP]^.iMemberCount), IntToStr(pV^.yInstanceData[iV]^.iMemberCount)), clRed)
          else
            with pP^.yInstanceData[iP]^ do
            begin
              iFlag := pV^.yInstanceData[iV]^.iFlag;
              iReference := SetStrings(GetName(pV^.yInstanceData[iV]^.iReference, pV^), pP^, iReference, bAll, rdLog);
              iData1 := pV^.yInstanceData[iV]^.iData1;
              iData2 := pV^.yInstanceData[iV]^.iData2;
              for j := 0 to pP^.yInstanceData[iP]^.iMemberCount - 1 do
                with yMembers[j]^ do
                  if (iType = pV^.yInstanceData[iV]^.yMembers[j]^.iType) then
                    case iType of
                      1: begin
                      {$IF Defined(USEREGION)}{$REGION 'Start 1'}{$IFEND}
                        case SetReferenceFromOther(pV^.yInstanceData[iV]^.yMembers[j]^.iData, iData, pP^, pV^, bAll, rdLog) of
                          -1: Log(rdLog, PM('W12: Values data reference to null but member indicate to object. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member reference type: ', GetName(iReference, pP^), GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^)), clPurple);
                          -2: Log(rdLog, PM('W13: Values object not exists but member indicate to object. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member reference type: ', GetName(iReference, pP^), GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^)), clPurple);
                          -3: Log(rdLog, PM('E14: Can''t find data index for reference. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member reference type: ', GetName(iReference, pP^), GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^)), clRed);
                          -4: Log(rdLog, PM('E15: Reference to complex object. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member reference type: ', GetName(iReference, pP^), GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^)), clRed);
                        end;
                        iReference := SetStrings(GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^), pP^, iReference, bAll, rdLog);
                      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
                      2: iData := SetStrings(GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iData, pV^), pP^, iData, bAll, rdLog);
                      0, 3..5: iData := pV^.yInstanceData[iV]^.yMembers[j]^.iData;
                      11: begin
                      {$IF Defined(USEREGION)}{$REGION 'Start 11'}{$IFEND}
                        iReference := SetStrings(GetName(pV^.yInstanceData[iV]^.yMembers[j]^.iReference, pV^), pP^, iReference, bAll, rdLog);
                        if (pP^.yInstanceData[iP]^.yMembers[j]^.iData <> 0) or (pV^.yInstanceData[iV]^.yMembers[j]^.iData <> 0) then
                        begin
                          aP := GetArrayIndex(pP^.yInstanceData[iP]^.yMembers[j]^.iData, pP^);
                          aV := GetArrayIndex(pV^.yInstanceData[iV]^.yMembers[j]^.iData, pV^);
                          if (aP = -1) and (aV <> -1) and bAll then
                            aP := AddArray(aV, pP^, pV^, bAll, rdLog);
                          if (aP <> -1) and (aV <> -1) then
                          begin
                            pP^.yArrays[aP]^.iMemberCount := pV^.yArrays[aV]^.iMemberCount;
                            aP := GetArrayDataIndex(aP, pP^);
                            aV := GetArrayDataIndex(aV, pV^);
                            if (aP <> -1) and (aV <> -1) then
                            begin
                              if  Length(pV^.yArrayData[aV]^.yMembers) <> Length(pP^.yArrayData[aP]^.yMembers) then
                                if Length(pV^.yArrayData[aV]^.yMembers) > Length(pP^.yArrayData[aP]^.yMembers) then
                                  while Length(pV^.yArrayData[aV]^.yMembers) > Length(pP^.yArrayData[aP]^.yMembers) do
                                  begin
                                    SetLength(pP^.yArrayData[aP]^.yMembers, Length(pP^.yArrayData[aP]^.yMembers) + 1);
                                    New(pP^.yArrayData[aP]^.yMembers[Length(pP^.yArrayData[aP]^.yMembers) - 1]);
                                  end
                                else
                                  while Length(pV^.yArrayData[aV]^.yMembers) < Length(pP^.yArrayData[aP]^.yMembers) do
                                  begin
                                    Dispose(pP^.yArrayData[aP]^.yMembers[Length(pP^.yArrayData[aP]^.yMembers) - 1]);
                                    SetLength(pP^.yArrayData[aP]^.yMembers, Length(pP^.yArrayData[aP]^.yMembers) - 1);
                                  end;
                              for k := 0 to Length(pP^.yArrayData[aP]^.yMembers) - 1 do
                              begin
                                case SetReferenceFromOther(pV^.yArrayData[aV]^.yMembers[k]^.iData, pP^.yArrayData[aP]^.yMembers[k]^.iData, pP^, pV^, bAll, rdLog) of
                                  -1: Log(rdLog, PM('W41: Values data reference to null but member indicate to object. Member: ' + IntToStr(k) + '. ', sMain, sVal, ' Member reference type: ', GetName(pP^.yInstanceData[aP]^.yMembers[k]^.iReference, pP^), GetName(pV^.yInstanceData[aV]^.yMembers[k]^.iReference, pV^)), clPurple);
                                  -2: Log(rdLog, PM('W42: Values object not exists but member indicate to object. Member: ' + IntToStr(k) + '. ', sMain, sVal, ' Member reference type: ', GetName(pP^.yInstanceData[aP]^.yMembers[k]^.iReference, pP^), GetName(pV^.yInstanceData[aV]^.yMembers[k]^.iReference, pV^)), clPurple);
                                  -3: Log(rdLog, PM('E43: Can''t find data index for reference. Member: ' + IntToStr(k) + '. ', sMain, sVal, ' Member reference type: ', GetName(pP^.yInstanceData[aP]^.yMembers[k]^.iReference, pP^), GetName(pV^.yInstanceData[aV]^.yMembers[k]^.iReference, pV^)), clRed);
                                  -4: Log(rdLog, PM('E44: Reference to complex object. Member: ' + IntToStr(k) + '. ', sMain, sVal, ' Member reference type: ', GetName(pP^.yInstanceData[aP]^.yMembers[k]^.iReference, pP^), GetName(pV^.yInstanceData[aV]^.yMembers[k]^.iReference, pV^)), clRed);
                                end;
                                pP^.yArrayData[aP]^.yMembers[k]^.iReference := SetStrings(GetName(pV^.yArrayData[aV]^.yMembers[k]^.iReference, pV^), pP^, iReference, bAll, rdLog);
                              end;
                            end
                            else
                              Log(rdLog, PM('E45: Inconsistent members data in script instances. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member array data index: ', IntToStr(aP), IntToStr(aV)), clRed);
                          end
                          else
                            Log(rdLog, PM('E46: Inconsistent members data in script instances. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member array index: ', IntToStr(aP), IntToStr(aV)), clRed);
                        end;
                      end;  {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
                      12..15: if (pP^.yInstanceData[iP]^.yMembers[j]^.iData <> 0) or (pV^.yInstanceData[iV]^.yMembers[j]^.iData <> 0) then
                      {$IF Defined(USEREGION)}{$REGION 'Start 12..15'}{$IFEND}
                      begin
                        aP := GetArrayIndex(pP^.yInstanceData[iP]^.yMembers[j]^.iData, pP^);
                        aV := GetArrayIndex(pV^.yInstanceData[iV]^.yMembers[j]^.iData, pV^);
                        if (aP = -1) and (aV <> -1) and bAll then
                          aP := AddArray(aV, pP^, pV^, bAll, rdLog);
                        if (aP <> -1) and (aV <> -1) then
                        begin
                          pP^.yArrays[aP]^.iMemberCount := pV^.yArrays[aV]^.iMemberCount;
                          aP := GetArrayDataIndex(aP, pP^);
                          aV := GetArrayDataIndex(aV, pV^);
                          if (aP <> -1) and (aV <> -1) then
                          begin
                            if  Length(pV^.yArrayData[aV]^.yMembers) <> Length(pP^.yArrayData[aP]^.yMembers) then
                              if Length(pV^.yArrayData[aV]^.yMembers) > Length(pP^.yArrayData[aP]^.yMembers) then
                                while Length(pV^.yArrayData[aV]^.yMembers) > Length(pP^.yArrayData[aP]^.yMembers) do
                                begin
                                  SetLength(pP^.yArrayData[aP]^.yMembers, Length(pP^.yArrayData[aP]^.yMembers) + 1);
                                  New(pP^.yArrayData[aP]^.yMembers[Length(pP^.yArrayData[aP]^.yMembers) - 1]);
                                end
                              else
                                while Length(pV^.yArrayData[aV]^.yMembers) < Length(pP^.yArrayData[aP]^.yMembers) do
                                begin
                                  Dispose(pP^.yArrayData[aP]^.yMembers[Length(pP^.yArrayData[aP]^.yMembers) - 1]);
                                  SetLength(pP^.yArrayData[aP]^.yMembers, Length(pP^.yArrayData[aP]^.yMembers) - 1);
                                end;
                            for k := 0 to Length(pP^.yArrayData[aP]^.yMembers) - 1 do
                            begin
                              pP^.yArrayData[aP]^.yMembers[k]^ := pV^.yArrayData[aV]^.yMembers[k]^;
                              if iType = 12 then
                                pP^.yArrayData[aP]^.yMembers[k]^.iData := SetStrings(GetName(pV^.yArrayData[aV]^.yMembers[k]^.iData, pV^), pP^, pP^.yArrayData[aP]^.yMembers[k]^.iData, bAll, rdLog);
                            end;
                          end
                          else
                            Log(rdLog, PM('E50: Inconsistent members data in script instances. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member array data index: ', IntToStr(aP), IntToStr(aV)), clRed);
                        end
                        else
                          Log(rdLog, PM('E51: Inconsistent members data in script instances. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member array index: ', IntToStr(aP), IntToStr(aV)), clRed);
                      end {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
                      else
                        Log(rdLog, 'Invalid type: ' + IntToStr(iType) + ' data: ' + IntToStr(iP) + ' member: ' + IntToStr(j));
                    end
                  else
                  begin
                    Log(rdLog, PM('E05: Inconsistent members data type in script instances. Member: ' + IntToStr(j) + '. ', sMain, sVal, ' Member type: ', GetDataType(iType), GetDataType(pV^.yInstanceData[iV]^.yMembers[j]^.iType)), clRed);
                    Break;
                  end;
            end;
        end
        else
          Log(rdLog, 'E03: Values data index not found for script instance: ' + IntToStr(i) + ' ' + sP, clRed);
      end
      else
        Log(rdLog, 'E02: Values instance index not found for script instance: ' + IntToStr(i) + ' ' + sP, clRed);
    end
    else
      Log(rdLog, 'E01: Main data index not found for script instance: ' + IntToStr(i) + ' ' + sP, clRed);
    k := Round(i / (pP^.iInstanceCount - 1) * 100);
    if k > pbProcess.Position then
      pbProcess.Position := k;
    pnMenu.Caption := '  ' + IntToStr(i + 1) + '/' + IntToStr(pP^.iInstanceCount);
    Application.ProcessMessages;
    if bBreak then
      Break;
    Inc(i);
  end;
  if bAll then
    pP^.iPapyrusRuntime := pV^.iPapyrusRuntime; 
  btnBreak.Visible := False;
  pbProcess.Visible := False;
  pnMenu.Caption := '';
  Log(rdLog, '');
  Log(rdLog, 'End copying process at: ' + DateTimeToStr(Now), clBlue);
  with btnBreak do
  begin
    Caption := 'Close';
    OnClick := btnCloseClick;
    ImageIdx := 9;
    Enabled := True;
    Visible := True;
  end;
  btnExport := CreateButton('Export log', True, clBlack, 2, 2, 25, 100, 1, 1, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnExportClick, nil);
end;

procedure TfPapyrus.btnExportClick(Sender: TObject);
var
  ms: TMemoryStream;
begin
  with sdExport do
    if Execute then
    begin
      case FilterIndex of
        1: if ExtractFileExt(FileName) = '' then
             FileName := FileName + '.RTF';
        2: if ExtractFileExt(FileName) = '' then
             FileName := FileName + '.TXT';
      end;
      if FilterIndex > 1 then
        with TStringList.Create do
        try
          Assign(rdLog.Lines);
          SaveToFile(FileName);
        finally
          Free;
        end
      else
      begin
        ms := TMemoryStream.Create;
        try
          rdLog.Lines.SaveToStream(ms);
          ms.SaveToFile(FileName);
        finally
          ms.Free;
        end;
      end;
    end;
end;

end.
