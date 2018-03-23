program niftbupd;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  IOUtils,
  wbDataFormat,
  wbDataFormatNif,
  wbDataFormatNifTypes,
  wbNifMath;


function UpdateNifFile(const aFileName: string): Boolean;
var
  nif: TwbNifFile;
begin
  nif := TwbNifFile.Create;
  try

    try
     nif.LoadFromFile(aFileName);
    except
      on E: Exception do begin
        WriteLn('Error loading: ' + aFileName);
        WriteLn('  ' + E.Message);
      end;
    end;

    Result := nif.SpellAddUpdateTangents;
    if Result then
      nif.SaveToFile(aFileName);
  finally
    nif.Free;
  end;
end;

procedure Main;
var
  root, s: string;
  FileCount: Integer;
begin
  //UpdateNifFile(ExtractFilePath(ParamStr(0)) + 'meshes\fnv_DLC04BWalkSCOL04_cleanup.NIF'); Exit;

  WriteLn('Nif tangents/binormals updater v0.1 by zilav');
  WriteLn('Will add them if missing where appropriate');
  WriteLn('Processes all Oblivion, Fallout 3, New Vegas, Skyrim, Skyrim SE and Fallout 4 meshes in the current directory and subdirectories');
  WriteLn('');

  root := ExtractFilePath(ParamStr(0));
  root := IncludeTrailingPathDelimiter(root);
  FileCount := 0;
  WriteLn('Scanning: ' + root + '*.nif');
  WriteLn('');

  for s in TDirectory.GetFiles(root, '*.nif', TSearchOption.soAllDirectories) do
    if UpdateNifFile(s) then begin
      WriteLn('Updated: ' + s);
      Inc(FileCount);
    end;

  WriteLn('');
  WriteLn('[Done] Updated ' + IntToStr(FileCount) + ' files');
  //WriteLn('Press any key to exit');
  //ReadLn;
end;

begin
  SysUtils.FormatSettings.DecimalSeparator := '.';
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  //ReadLn;
end.
