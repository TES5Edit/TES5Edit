{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbCommandLine;

{$I wbDefines.inc}

interface

uses
  SysUtils;

function wbFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
function wbFindCmdLineParam(var   aStartIndex : Integer;
                            const aChars      : TSysCharSet;
                              out aValue      : string)
                                              : Boolean; overload;
function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
function wbFindCmdLineParam(var aStartIndex : Integer;
                            out aValue      : string)
                                            : Boolean; overload;


implementation


function wbFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or (s[1] in aChars) then begin
      Delete(s, 1, 1);
      if s.StartsWith(aSwitch + ':', aIgnoreCase) then begin
        aValue := Copy(s, Length(aSwitch) + 2, High(Integer));
        Exit(True);
      end;
      if aIgnoreCase then begin
        if SameText(s, aSwitch) then
          Exit(True)
      end else
        if s = aSwitch then
          Exit(True);
    end;
  end;
end;

function wbFindCmdLineParam(var   aStartIndex : Integer;
                            const aChars      : TSysCharSet;
                              out aValue      : string)
                                              : Boolean; overload;
var
  i : Integer;
  s : string;
begin
  Result := False;
  aValue := '';
  for i := aStartIndex to ParamCount do begin
    s := ParamStr(i);
    if (aChars = []) or (s[1] in aChars) then // skipped
      Inc(aStartIndex)
    else begin
      aValue := ParamStr(i);
      aStartIndex := i+1;
      Result := True;
      break;
    end
  end;
end;

function wbFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aSwitch, SwitchChars, True, aValue);
end;

function wbFindCmdLineParam(var aStartIndex : Integer;
                            out aValue      : string)
                                            : Boolean; overload;
begin
  Result := wbFindCmdLineParam(aStartIndex, SwitchChars, aValue);
end;

end.
