{
  Detect circular previous info PNAM links in INFO records
}
unit CheckForCircularINFOs;

var
  slINFOs: TStringList;

function Initialize: integer;
begin
  slINFOs := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  info: IInterface;
begin
  if Signature(e) <> 'INFO' then
    Exit;

  slINFOs.Clear;
  info := e;
  
  while True do begin
    slINFOs.Add(FullPath(info));
    info := WinningOverride(LinksTo(ElementBySignature(info, 'PNAM')));

    if not Assigned(info) then
      Exit;
    
    if slINFOs.IndexOf(FullPath(info)) <> -1 then begin
      AddMessage('Circular link detected for ' + Name(e));
      Exit;
    end;
  end;
end;

function Finalize: integer;
begin
  slINFOs.Free;
end;

end.