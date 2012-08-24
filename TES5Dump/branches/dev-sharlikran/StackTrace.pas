unit StackTrace;

interface
uses
SysUtils, Classes, JclDebug;
implementation
function GetExceptionStackInfoProc(P: PExceptionRecord): Pointer;
var
LLines: TStringList;
LText: String;
LResult: PChar;
begin
LLines := TStringList.Create;
try
JclLastExceptStackListToStrings(LLines, True, True, True, True);
LText := LLines.Text;
LResult := StrAlloc(Length(LText));
StrCopy(LResult, PChar(LText));
Result := LResult;
finally
LLines.Free;
end;
end;
function GetStackInfoStringProc(Info: Pointer): string;
begin
Result := string(PChar(Info));
end;
procedure CleanUpStackInfoProc(Info: Pointer);
begin
StrDispose(PChar(Info));
end;
initialization
// Start the Jcl exception tracking and register our Exception
// stack trace provider.
if JclStartExceptionTracking then
begin
Exception.GetExceptionStackInfoProc := GetExceptionStackInfoProc;
Exception.GetStackInfoStringProc := GetStackInfoStringProc;
Exception.CleanUpStackInfoProc := CleanUpStackInfoProc;
end;
finalization
// Stop Jcl exception tracking and unregister our provider.
if JclExceptionTrackingActive then
begin
Exception.GetExceptionStackInfoProc := nil;
Exception.GetStackInfoStringProc := nil;
Exception.CleanUpStackInfoProc := nil;
JclStopExceptionTracking;
end;
end.

