unit uCmpPapyrus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uESSFile, ExtCtrls, StdCtrls, ComCtrls, uHelper, GlassButton,
  VistaProgressBar, CommCtrl, RichEdit, uPapyrus;

type
  TRichEdit50 = class(TRichEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  TfCmpPapyrus = class(TForm)
    pnMenu: TPanel;
    sdExport: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnBreakClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure btnExportClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    rdLog: TRichEdit;
    OldProc: TWndMethod;
    P1, P2: TPapyrus;
    sN1, sN2: string;
    bBreak: Boolean;
    btnBreak, btnExport, btnShow1, btnShow2: TGlassButton;
    pbProcess: TVistaProgressBar;
    procedure Start(var Msg: TMsg); message WM_READY;
    procedure Log(R: TStrings; S: string; V: Boolean = False; C: TColor = clBlack; F: TFontStyles = []; L: Boolean = False; M: Boolean = False);
    procedure NewProc(var Message: TMessage);
  public
    procedure Compare(var yP1, yP2: TBytes; aP1, aP2: string);
  end;

implementation

uses
  uMain, Math, uViewer;

{$R *.dfm}

var
  FRichEditModule: THandle;
  FVersion: integer;

procedure TRichEdit50.CreateParams(var params: TCreateParams);
const
  RichEdit10ModuleName = 'Riched32.dll';
  RichEdit20ModuleName = 'Riched20.dll';
  RichEdit41ModuleName = 'msftedit.dll';
  CHideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  CHideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
begin
  if FRichEditModule = 0 then
  begin
    FVersion := 4;
    FRichEditModule := LoadLibrary(RichEdit41ModuleName);
    if FRichEditModule <= HINSTANCE_ERROR then
    begin
      FVersion := 2;
      FRichEditModule := LoadLibrary(RichEdit20ModuleName);
      if FRichEditModule <= HINSTANCE_ERROR then
      begin
        FVersion := 1;
        FRichEditModule := LoadLibrary(RichEdit10ModuleName);
        if FRichEditModule <= HINSTANCE_ERROR then
        begin
          FVersion := 0;
          FRichEditModule := 0;
        end;
      end;
    end;
  end;
  inherited CreateParams(Params);
  case FVersion of
    4: CreateSubClass(Params, 'RICHEDIT50W');
    2: CreateSubClass(Params, 'RICHEDIT20W');
    else
      CreateSubClass(Params, 'RICHEDIT');
  end;
  with Params do
  begin
    Style := Style or CHideScrollBars[HideScrollBars] or CHideSelections[HideSelection];
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TfCmpPapyrus.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

var
  LastColor: TColor = clBlack;
  bBold: Boolean = False;
  bItalic: Boolean = False;

procedure TfCmpPapyrus.Log(R: TStrings; S: string; V: Boolean = False; C: TColor = clBlack; F: TFontStyles = []; L: Boolean = False; M: Boolean = False);
var
  sColor, sTmp: string;
begin
  if not M then
    with R do
    begin
      if Count = 0 then
      begin
        Add('{\rtf1{\fonttbl{\f0\fnil Tahoma;}}');
        Add('{\colortbl ;\red0\green0\blue0;\red0\green0\blue255;\red0\green0\blue128;\red255\green0\blue0;\red128\green0\blue128;}');
      end;
      if C <> LastColor then
      begin
        sColor := '\cf1';
        case C of
          clBlue: sColor := '\cf2';
          clNavy: sColor := '\cf3';
          clRed: sColor := '\cf4';
          clPurple: sColor := '\cf5';
        end;
        LastColor := C;
      end
      else
        sColor := '';
      if (fsBold in F) and not bBold then
      begin
        sColor := sColor + '\b';
        bBold := True;
      end
      else
        if not (fsBold in F) and bBold then
        begin
          sColor := sColor + '\b0';
          bBold := False;
        end;
      if (fsItalic in F) and not bItalic then
      begin
        sColor := sColor + '\i';
        bItalic := True;
      end
      else
        if not (fsItalic in F) and bItalic then
        begin
          sColor := sColor + '\i0';
          bItalic := False;
        end;
      if sColor <> '' then
        sColor := sColor + ' ';
      sTmp := S;
      if Pos(#13, sTmp) = 1 then
      begin
        if Count > 2 then
          Add('\par ');
        sTmp := Copy(sTmp, 2, Length(sTmp));
      end;
      if Pos(#13, sTmp) = Length(sTmp) then
      begin
        System.Delete(sTmp, Length(sTmp), 1);
        rdLog.Tag := 1;
      end
      else
        rdLog.Tag := 0;
      if Count = 2 then
        Add('\viewkind4\uc1\pard\f0\fs16 ' + sColor + sTmp)
      else
        Add('\par ' + sColor + sTmp);
      if rdLog.Tag = 1 then
        Add('\par ');
      if L then
      begin
        sColor := '';
        if bBold then
          sColor := '\b0';
        bBold := False;
        if bItalic then
          sColor := '\i0';
        bItalic := False;
        if sColor <> '' then
          sColor := sColor + ' ';
        Add('\par ' + sColor + '}');
      end;
    end;
  if V or M then
    with rdLog do
    begin
      if Pos(#13, S) = 1 then
      begin
        SelText := #10;
        S := Copy(S, 2, Length(S));
      end;
      if Pos(#13, S) = Length(s) then
      begin
        Delete(S, Length(S), 1);
        rdLog.Tag := 1;
      end
      else
        rdLog.Tag := 0;
      SelStart := Length(Text);
      SelAttributes.Color := C;
      SelAttributes.Style := F;
      SelText := S + #10;
      if rdLog.Tag <> 0 then
        SelText := #10;
      SelStart := Length(Text);
      Perform(EM_SCROLLCARET, 0, 0);
    end;
end;

procedure TfCmpPapyrus.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := btnBreak.ImageIdx = 9;
  if not bBreak then
  begin
    bBreak := True;
    btnBreak.Enabled := False;
  end;
  if CanClose then
    Release;
end;

procedure TfCmpPapyrus.FormCreate(Sender: TObject);
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
    MaxLength := $7FFFFFF0;
    ParentCtl3D := False;
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

procedure TfCmpPapyrus.NewProc(var Message: TMessage);
begin
  if (Message.Msg in [WM_CLOSE, WM_QUERYENDSESSION]) and not bBreak then
  begin
    bBreak := True;
    btnBreak.Enabled := False;
  end
  else
    OldProc(Message);
end;

procedure TfCmpPapyrus.FormDestroy(Sender: TObject);
begin
  ClearPapyrus(P2);
  ClearPapyrus(P1);
end;

procedure TfCmpPapyrus.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_READY, 0, 0);
end;

procedure TfCmpPapyrus.btnBreakClick(Sender: TObject);
begin
  bBreak := True;
  btnBreak.Enabled := False;
end;

procedure TfCmpPapyrus.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfCmpPapyrus.Compare(var yP1, yP2: TBytes; aP1, aP2: string);
begin
  pbProcess.Max := 100;
  pbProcess.Position := 0;
  pbProcess.Visible := True;
  LoadPapyrusData(P1, yP1);
  LoadPapyrusData(P2, yP2);
  sN1 := aP1;
  sN2 := aP2;
  Show;
end;

function CmpStrings(var N: TString; var P: TPapyrus): integer;
{$IF Defined(USEREGION)}{$REGION 'CmpStrings'}{$IFEND}
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(P.yStrings) - 1 do
    if N.sName = P.yStrings[i]^.sName then
    begin
      Result := i;
      Break;
    end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function CmpScripts(var S: TScript; var P, N: TPapyrus; F: PInt= nil): integer;
{$IF Defined(USEREGION)}{$REGION 'CmpScripts'}{$IFEND}
var
  i, j: integer;
  sN, sT: string;
begin
  Result := -1;
  sN := GetName(S.iName, N);
  sT := GetName(S.iSType, N);
  for i := 0 to Length(P.yScripts) - 1 do
    if (sN = GetName(P.yScripts[i]^.iName, P)) and (sT = GetName(P.yScripts[i]^.iSType, P)) and (S.iParameterCount = P.yScripts[i]^.iParameterCount) then
    begin
      Result := i + 1;
      if Assigned(F) then
        F^ := i;
      for j := 0 to S.iParameterCount - 1 do
        if (GetName(S.yParameters[j]^.iName, N) <> GetName(P.yScripts[i]^.yParameters[j]^.iName, P)) or
           (GetName(S.yParameters[j]^.iSType, N) <> GetName(P.yScripts[i]^.yParameters[j]^.iSType, P)) then
        begin
          Result := 0;
          Break;
        end;
      Break;
    end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetScriptName(var S: TScript; var N: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetScriptName'}{$IFEND}
begin
  Result := GetName(S.iSType, N);
  if Result <> '' then
    Result := Result + ' ';
  Result := Result + GetName(S.iName, N);
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetScriptParameter(var S: TScript; P: integer; var N: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetScriptParameter'}{$IFEND}
begin
  if P < S.iParameterCount then
  begin
    Result := GetName(S.yParameters[P]^.iSType, N) + ' ' + GetName(S.yParameters[P]^.iName, N);
    if P < (S.iParameterCount - 1) then
      Result := Result + ','
    else
      Result := Result + ')'
  end
  else
    Result := '';
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function CmpInstance(var S: TInstance; var D: TData; var P, N: tPapyrus; F: PInt = nil): integer;
{$IF Defined(USEREGION)}{$REGION 'CmpInstance'}{$IFEND}
var
  i, j, k: integer;
begin
  Result := -1;
  for i := 0 to Length(P.yInstances) - 1 do
    with P.yInstances[i]^ do
      if (GetName(S.iScript, N) = GetName(iScript, P)) and (S.iUnknow1 = iUnknow1) and (S.iUnknow2 = iUnknow2) and (RefIDCompare (S.rRef, rRef) = 0) and (S.iUsed = iUsed) then
      begin
        Result := i + 1;
        k := GetInstanceDataIndex(i, P);
        if k = -1 then
          Result := -2
        else
        begin
          if Assigned(F) then
            F^ := k;
          with P.yInstanceData[k]^ do
            if not ((D.iFlag = iFlag) and (D.iMemberCount = iMemberCount) and (D.iData1 = iData1) and (D.iData2 = iData2)) then
              Result := -3
            else
              for j := 0 to D.iMemberCount - 1 do
              begin
                if D.yMembers[j]^.iType <> yMembers[j]^.iType then
                  Result := -4;
                if Result > 0 then
                  case D.yMembers[j]^.iType of
                    1, 11:
                      if (GetName(D.yMembers[j]^.iReference, N) <> GetName(yMembers[j]^.iReference, P)) or (D.yMembers[j]^.iData <> yMembers[j]^.iData) then
                        Result := -4;
                    2:
                    begin
                      if GetName(D.yMembers[j]^.iData, N) <> GetName(yMembers[j]^.iData, P) then
                         Result := -4;
                    end
                  else
                    if D.yMembers[j]^.iData <> yMembers[j]^.iData then
                      Result := -4
                  end;
                if Result <= 0 then
                  Break;
              end;
        end;
        Break;
      end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetScriptDefinition(var S: TInstance; var N: TPapyrus; R: PInt = nil): string;
{$IF Defined(USEREGION)}{$REGION 'GetScriptDefinition'}{$IFEND}
var
  sN: string;
  i: integer;
begin
  Result := '';
  sN := GetName(S.iScript, N);
  for i := 0 to Length(N.yScripts) - 1 do
    with N.yScripts[i]^ do
      if sN = GetName(iName, N) then
      begin
        Result := GetScriptName(N.yScripts[i]^, N);
        if Assigned(R) then
          R^ := i;
        Break;
      end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetScriptData(var S: TData; var N: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetScriptData'}{$IFEND}
begin
  Result := '[F: ' + IntToHex(S.iFlag, 2) + ' R: ' + IntToHex(S.iReference, 4);
  if S.iFlag = $F then
    Result := Result + ' D1: ' + IntToHex(S.iData1, 8) + ' D2: ' + IntToHex(S.iData2, 8) + ']'
  else
    Result := Result + ' D: ' + IntToHex(S.iData1, 8) + ']';
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetMemberDefinition(var S: TData; M, D: integer; var N: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetMemberDefinition'}{$IFEND}
begin
  Result := '';
  if (M < S.iMemberCount) and (D < Length(N.yScripts)) then
    if S.iMemberCount >= N.yScripts[D]^.iParameterCount  then
      if M < (S.iMemberCount - N.yScripts[D]^.iParameterCount) then
      begin
        Result := GetDataType(S.yMembers[M]^.iType);
        if S.yMembers[M]^.iType in [1, 11] then
          Result := Result + ' ' + GetName(S.yMembers[M]^.iReference, N);
      end
      else
        Result := GetName(N.yScripts[D]^.yParameters[M - (S.iMemberCount - N.yScripts[D]^.iParameterCount)]^.iSType, N) + ' ' + GetName(N.yScripts[D]^.yParameters[M - (S.iMemberCount - N.yScripts[D]^.iParameterCount)]^.iName, N)
    else
    begin
      Result := GetDataType(S.yMembers[M]^.iType);
      if S.yMembers[M]^.iType in [1, 11] then
        Result := Result + ' ' + GetName(S.yMembers[M]^.iReference, N);
    end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetMemberData(var S: TData; M: integer; var N: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetMemberData'}{$IFEND}
begin
  if M < S.iMemberCount then
    with S.yMembers[M]^ do
      case iType  of
        1, 11: Result := GetName(iReference, N) + ' 0x' + IntToHex(iData, 8);
        2: Result := '"' + GetName(iData, N) + '"';
        0, 3, 5: Result := IntToStr(iData);
        4: Result := FloatToStr(iData);
        else
          Result := '0x' + IntToHex(iData, 8);
      end
  else
    Result := '';
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TfCmpPapyrus.Start(var Msg: TMsg);
var
  i, j, p, m, d, f, iMax, iAct: integer;
  sMax, sP1, sP2: string;
  msT: TMemoryStream;
  slR: TStrings;

  function SetState: Boolean;
  begin
    Inc(iAct);
    p := Round(iAct / (iMax - 1) * 100);
    if p > pbProcess.Position then
      pbProcess.Position := p;
    pnMenu.Caption := '  ' + IntToStr(iAct + 1) + sMax;
    Application.ProcessMessages;
    Result := bBreak;
  end;
begin
  slR := TStringList.Create;
  try
    Log(slR, 'Start compare process at: ' + DateTimeToStr(Now), True, clBlue);
    iAct := 0;
    iMax := Length(P1.yStrings) + Length(P1.yScripts) + Length(P1.yInstances);
    sMax := '/' + IntToStr(iMax);
    {$IF Defined(USEREGION)}{$REGION 'Compare strings'}{$IFEND}
    Log(slR, #13'Compare strings: [' + sN1 + '] in [' + sN2 + ']', True, clNavy);
    if not bBreak then
      for i := 0 to Length(P1.yStrings) - 1 do
      begin
        if CmpStrings(P1.yStrings[i]^, P2) = -1 then
          Log(slR, 'String only in [' + sN1 + '] ' + IntToStr(i) + ': "' + P1.yStrings[i]^.sName + '"', True);
        if SetState then
          Break;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'Compare scripts'}{$IFEND}
    Log(slR, #13'Compare scripts: [' + sN1 + '] in [' + sN2 + ']', True, clNavy);
    if not bBreak then
      for i := 0 to Length(P1.yScripts) - 1 do
      begin
        p := CmpScripts(P1.yScripts[i]^, P2, P1, @f);
        if not (p > 0) then
        begin
          if p = -1 then
            Log(slR, 'Scripts only in [' + sN1 + '] ' + IntToStr(i) + #13, True)
          else
            Log(slR, 'Different parameters in scripts in [' + sN1 + '] ' + IntToStr(i) + ' and [' + sN2 + '] ' + IntToStr(f) + #13, True);
          Log(slR, '  ' + GetScriptName(P1.yScripts[i]^, P1) + '(', False, clBlack, [fsBold, fsItalic]);
          for j := 0 to P1.yScripts[i]^.iParameterCount - 1 do
            if p = -1 then
              Log(slR, '    ' + GetScriptParameter(P1.yScripts[i]^, j, P1), False, clBlack, [fsItalic])
            else
            begin
              sP1 := GetScriptParameter(P1.yScripts[i]^, j, P1);
              sP2 := GetScriptParameter(P2.yScripts[f]^, j, P2);
              if sP1 <> sP2 then
                Log(slR, '    ' + GetScriptParameter(P1.yScripts[i]^, j, P1), False, clRed, [fsItalic])
              else
                Log(slR, '    ' + GetScriptParameter(P1.yScripts[i]^, j, P1), False, clBlack, [fsItalic])
            end;
          Log(slR, '');
        end;
        if SetState then
          Break;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    {$IF Defined(USEREGION)}{$REGION 'Compare script instances'}{$IFEND}
    Log(slR, #13'Compare scripts instances with its data: [' + sN1 + '] in [' + sN2 + ']', True, clNavy);
    if not bBreak then
      for i := 0 to Length(P1.yInstances) - 1 do
      begin
        p := GetInstanceDataIndex(i, P1);
        if p = 1 then
          Log(slR, 'Can''t find script data for instance in [' + sN1 + '] ' + IntToStr(i) + ' Script: "' + GetName(P1.yInstances[i]^.iScript, P1) + '"'#13, True, clRed)
        else
        begin
          m := CmpInstance(P1.yInstances[i]^, P1.yInstanceData[p]^, P2, P1, @f);
          if not (m > 0) then
          begin
            case m of
              -1: Log(slR, 'Script instance only in [' + sN1 + '] ' + IntToStr(i) + #13);
              -2: Log(slR, 'Script instance hasn''t data in [' + sN2 + '] for [' + sN1 + '] ' + IntToStr(i) + #13);
              -3: Log(slR, 'Different in script instance data in [' + sN1 + '] ' + IntToStr(i) + ' and [' + sN2 + '] ' + IntToStr(f) + #13);
              -4: Log(slR, 'Different in script member data in [' + sN1 + '] ' + IntToStr(i) + ' and [' + sN2 + '] ' + IntToStr(f) + #13);
            end;
            sP1 := GetScriptDefinition(P1.yInstances[i]^, P1, @d);
            if sP1 <> '' then
            begin
              Log(slR, '  ' + sP1, False, clBlack, [fsBold, fsItalic]);
              if m = -3 then
                Log(slR, '    ' + GetScriptData(P1.yInstanceData[p]^, P1) + ' <> ' +GetScriptData(P2.yInstanceData[f]^, P2), False, clRed, [fsItalic])
              else
                Log(slR, '    ' + GetScriptData(P1.yInstanceData[p]^, P1), False, clBlack, [fsItalic]);
              for j := 0 to P1.yInstanceData[p]^.iMemberCount - 1 do
                if (m = -1) or (m = -2) then
                  Log(slR, '    ' + GetMemberDefinition(P1.yInstanceData[p]^, j, d, P1) + ' = ' + GetMemberData(P1.yInstanceData[p]^, j, P1), False, clBlack, [fsItalic])
                else
                begin
                  sP1 := GetMemberData(P1.yInstanceData[p]^, j, P1);
                  sP2 := GetMemberData(P2.yInstanceData[f]^, j, P2);
                  if sP1 <> sP2 then
                    Log(slR, '    ' + GetMemberDefinition(P1.yInstanceData[p]^, j, d, P1) + ' = ' + sP1 + ' <> ' + sP2, False, clRed, [fsItalic])
                  else
                    Log(slR, '    ' + GetMemberDefinition(P1.yInstanceData[p]^, j, d, P1) + ' = ' + sP1, False, clBlack, [fsItalic])
                end;
              Log(slR, '');
            end
            else
              Log(slR, 'Can''t find script definition for [' + sN1 + '] ' + IntToStr(i) + ' Script: "' + GetName(P1.yInstances[i]^.iScript, P1) + '"'#13, True);
          end;
        end;
        if SetState then
          Break;
      end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
    btnBreak.Visible := False;
    pbProcess.Visible := False;
    pnMenu.Caption := '  Loading report. Please wait...';
    Log(slR, #13'End compare process at: ' + DateTimeToStr(Now), True, clBlue, [], True);
    Application.ProcessMessages;
    msT := TMemoryStream.Create;
    try
      slR.SaveToStream(msT);
      msT.Position := 0;
      rdLog.Lines.LoadFromStream(msT);
    finally
      msT.Free;
    end;
    pnMenu.Caption := '';
    with btnBreak do
    begin
      Caption := 'Close';
      OnClick := btnCloseClick;
      ImageIdx := 9;
      Enabled := True;
      Visible := True;
    end;
    btnExport := CreateButton('Export log', True, clBlack, 2, 2, 25, 85, 1, 1, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnExportClick, nil);
    btnShow1 := CreateButton('Show 1st', True, clBlack, btnExport.Left + btnExport.Width + 4, 2, 25, 85, 6, 2, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnShowClick, nil);
    btnShow2 := CreateButton('Show 2nd', True, clBlack, btnShow1.Left + btnShow1.Width + 4, 2, 25, 85, 6, 3, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnShowClick, nil);
  finally
    slR.Free;
  end;
end;

procedure TfCmpPapyrus.btnExportClick(Sender: TObject);
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

procedure TfCmpPapyrus.btnShowClick(Sender: TObject);
var
  D: TBytes;
begin
  if Sender = btnShow1 then
    SavePapyrusData(P1, D)
  else
    SavePapyrusData(P2, D);
  try
    with TfViewer.Create(Application) do
    begin
      if Sender = btnShow1 then
        Caption := 'Papyrus Viewer [' + sN1 + ']'
      else
        Caption := 'Papyrus Viewer [' + sN2 + ']';
      LoadPapyrusData(Papyrus, D);
      FillTreePapyrus;
      Show;
    end;
  finally
    SetLength(D, 0);
  end;
end;

end.
