unit FileContainerDesign;

interface

procedure Register;

implementation

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  DesignIntf,
  DesignMenus,
  DesignEditors,
  FileContainer;

type
  TFileContainerEditor = class(TComponentEditor)
  protected
  {--- IComponentEditor --}
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;

    procedure DoLoad;
    procedure DoSave;
    procedure DoClear;
  end;

procedure Register;
begin
  ForceDemandLoadState(dlDisable);
  RegisterComponents('Additional', [TFileContainer]);
  RegisterComponentEditor(TFileContainer, TFileContainerEditor);
end;

{ TFileContainerEditor }

procedure TFileContainerEditor.DoClear;
begin
  (Component as TFileContainer).Data := nil;
  Designer.Modified;
end;

procedure TFileContainerEditor.DoLoad;
var
  FileName: string;
begin
  if PromptForFileName(FileName) then begin
    (Component as TFileContainer).LoadFromFile(FileName);
    Designer.Modified;
  end;
end;

procedure TFileContainerEditor.DoSave;
var
  FileName: string;
begin
  if PromptForFileName(FileName, '', '', '', '', True) then
    (Component as TFileContainer).SaveToFile(FileName);
end;

procedure TFileContainerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: DoLoad;
    1: DoSave;
    2: DoClear;
  end;
end;

function TFileContainerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Load';
    1: Result := 'Save';
    2: Result := 'Clear';
  end;
end;

function TFileContainerEditor.GetVerbCount: Integer;
begin
  Result := 0;
  if Assigned(Component) and (Component is TFileContainer) then begin
    Result := 1;
    if Length(TFileContainer(Component).Data) > 0 then
      Result := 3;
  end;
end;

end.
