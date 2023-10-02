{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

program BSArchPro;

{$I baDefines.inc}

{$IFDEF EXCEPTION_LOGGING_ENABLED}
// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
{$ENDIF}

uses
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxExceptionHook,
  {$ENDIF}
  System.Classes,
  System.SysUtils,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Styles.Hooks,
  Vcl.Styles.Ext,
  Vcl.Styles.Utils.Menus,
  Vcl.Styles.Utils.Forms,
  Vcl.Styles.Utils.StdCtrls,
  Vcl.Styles.Utils.ComCtrls,
  Vcl.Styles.Utils.ScreenTips,
  Vcl.Styles.Utils.SysControls,
  Vcl.Styles.Utils.SysStyleHook,
  Vcl.Forms,
  Vcl.Dialogs,
  System.IOUtils,
  frmMain in 'BSArch\frmMain.pas' {FormMain},
  wbBSArchive in 'Core\wbBSArchive.pas',
  wbAssets in 'BSArch\wbAssets.pas',
  frmSearchReplace in 'BSArch\frmSearchReplace.pas' {FormSearchReplace},
  wbTaskProgress in 'Core\wbTaskProgress.pas' {FormTaskProgress},
  frmArchiveInfo in 'BSArch\frmArchiveInfo.pas' {FormArchiveInfo},
  frmPack in 'BSArch\frmPack.pas' {FormPack};

{$R *.res}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure bapInitStyles;
begin
  var Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Themes';
  if TDirectory.Exists(Path) then
    for var s in TDirectory.GetFiles(Path, '*.vsf' ) do try
      TStyleManager.LoadFromFile(s);
    except
      on E: Exception do
        ShowMessage(Format('Error loading theme file "%s": %s', [s, E.Message]));
    end;
end;

begin
  {$IFDEF EXCEPTION_LOGGING_ENABLED}
  nxEHAppVersion := 'BSArchPro v' + csBSAVersion;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'BSArchPro';
  bapInitStyles;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
