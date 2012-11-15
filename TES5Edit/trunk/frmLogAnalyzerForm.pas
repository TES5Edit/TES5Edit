unit frmLogAnalyzerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, VirtualEditTree;

type
  TfrmLogAnalyzer = class(TForm)
    pnlTop: TPanel;
    btnFileSelect: TButton;
    btnAnalyze: TButton;
    LabeledEdit1: TLabeledEdit;
    dlgOpen: TOpenDialog;
    edLogSize: TLabeledEdit;
    Label1: TLabel;
    pnlClient: TPanel;
    vstForms: TVirtualEditTree;
    Splitter1: TSplitter;
    memoText: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TLogType = (
    TES4RuntimeScriptProfiler,
    TES5Papyrus
  );

var
  frmLogAnalyzer: TfrmLogAnalyzer;

implementation

{$R *.dfm}

end.
