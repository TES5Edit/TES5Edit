program TESVESSE;

{$R 'Resource.res' 'Resource.rc'}

uses
  Forms,
  System.UITypes,
  System.Types,
  uMain in 'uMain.pas' {fMain},
  VTAccessibilityFactory in 'Units\VTAccessibilityFactory.pas',
  Helper in 'Units\Helper.pas',
  uESSFile in 'Units\uESSFile.pas',
  VirtualTrees in 'Units\VirtualTrees.pas',
  VistaProgressBar in 'Units\VistaProgressBar.pas',
  GlassButton in 'Units\GlassButton.pas',
  XPMenu in 'Units\XPMenu.pas',
  HexEdit in 'Units\HexEdit.pas',
  uCompare in 'Forms\uCompare.pas' {fCompare};

{$R *.res}

{$WARN SYMBOL_PLATFORM OFF}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
