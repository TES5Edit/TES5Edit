program TESVESSE;

{$R 'Resource.res' 'Resource.rc'}

uses
  Forms,
  uMain in 'uMain.pas' {fMain},
  VTAccessibilityFactory in 'Units\VTAccessibilityFactory.pas',
  uHelper in 'Units\uHelper.pas',
  uESSFile in 'Units\uESSFile.pas',
  VirtualTrees in 'Units\VirtualTrees.pas',
  VistaProgressBar in 'Units\VistaProgressBar.pas',
  GlassButton in 'Units\GlassButton.pas',
  XPMenu in 'Units\XPMenu.pas',
  HexEdit in 'Units\HexEdit.pas',
  uViewer in 'Forms\uViewer.pas' {fViewer},
  uCompare in 'Forms\uCompare.pas' {fCompare},
  uCmpPapyrus in 'Forms\uCmpPapyrus.pas' {fCmpPapyrus},
  uPapyrus in 'Forms\uPapyrus.pas' {fPapyrus},
  uFormIDArray in 'Forms\uFormIDArray.pas' {fAddFormIDArray},
  uAddInstance in 'Forms\Papyrus\uAddInstance.pas' {fAddInstance},
  uAddForm in 'Forms\uAddForm.pas' {fAddForm},
  uAddScript in 'Forms\Papyrus\uAddScript.pas' {fAddScript},
  uView in 'Units\uView.pas',
  uPapyrusDataView in 'Forms\uPapyrusDataView.pas' {fPapyrusDataView};

{$R *.res}

{$WARN SYMBOL_PLATFORM OFF}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.ModalPopupMode := pmAuto;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
