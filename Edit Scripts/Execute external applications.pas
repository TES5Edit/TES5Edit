{
  Execute external applications, optionally providing command line parameters that can
  depend for example on the current selected record.
  Can be hotkeyed (see Apply filter for cleaning.pas).
}
unit ShellExecuteDemo;

function Process(e: IInterface): integer;
begin
  
  // doesn't wait for application
  // returns application handle, if <= 32 then error occured, check WinAPI documentation
  ShellExecute(
    TForm(frmMain).Handle,                  // parent window handle, use 0 for none
    'open',                                 // verb
    'cmd.exe',                              // application
    '/K ECHO Selected element: ' + Name(e), // parameters
    '',                                     // working directory
    SW_SHOWNORMAL                           // window mode
  );
  
  // wait for application, returns exit code
  {
  AddMessage('Running application...');
  AddMessage('Exit code: ' + IntToStr(
    ShellExecuteWait(0, 'open', 'cmd.exe', '/K ECHO Type "exit 5" to close with the exit code 5', '', SW_SHOWNORMAL)
  ));
  } 

  // terminate script
  Result := 1;
end;

end.