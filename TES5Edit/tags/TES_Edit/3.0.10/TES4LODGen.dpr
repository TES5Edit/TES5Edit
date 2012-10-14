program TES4LODGen;

uses
  nxReplacementMemoryManager,
  nxExceptionHook,
  Forms,
  Dialogs,
  SysUtils,
  wbInterface,
  wbImplementation,
  wbDefinitionsTES4,
//  wbDefinitionsFO3,
  frmLODGenMain in 'frmLODGenMain.pas' {frmMain};

{$R *.res}

begin
  SysUtils.DecimalSeparator := '.';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  wbReportMode := False;
  wbRotationFactor := 1.0;
  wbRotationScale := -1;

  if FindCmdLineSwitch('FO3') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FO3') then begin
    ShowMessage('FO3 is currently not supported.');
    Exit;
    {wbGameMode := gmFO3;
    wbAppName := 'FO3';
    wbGameName := 'Fallout3';
    wbVWDInTemporary := True;
    DefineFO3;}
  end else if FindCmdLineSwitch('TES4') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES4') then begin
    wbGameMode := gmTES4;
    wbAppName := 'TES4';
    wbGameName := 'Oblivion';
    DefineTES4;
  end else begin
    ShowMessage('Application name must start with FO3 or TES4 to select mode.');
    Exit;
  end;
  Application.Title := wbAppName + ' LOD Generator ' + VersionString;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
