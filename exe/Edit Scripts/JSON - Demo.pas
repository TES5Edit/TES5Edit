{
  Demo of JsonDataObjects library used by xEdit
  
  Check source code for available API calls
  https://github.com/ahausladen/JsonDataObjects
}
unit JsonDemo;

procedure Demo1;
var
  Obj: TJsonObject;
begin
  Obj := TJsonBaseObject.Parse('{ "foo": "bar", "array": [ 10, 20 ] }');
  try
    AddMessage(Obj.S['foo']);
    AddMessage(IntToStr(Obj.A['array'].Count));
    AddMessage(IntToStr(Obj.A['array'].I[0]));
    AddMessage(IntToStr(Obj.A['array'].I[1]));
    
    //procedure LoadFromFile(const FileName: string; Utf8WithoutBOM: Boolean = True);
    //procedure SaveToFile(const FileName: string; Compact: Boolean = True; Encoding: TEncoding = nil; Utf8WithoutBOM: Boolean = True);
    //Obj.SaveToFile('c:\Demo1.json', False, TEncoding.UTF8, True);
  finally
    Obj.Free;
  end;
end;

procedure Demo2;
var
  Obj, ChildObj: TJsonObject;
begin
  Obj := TJsonObject.Create;
  try
    // easy access
    Obj['foo'] := 'bar';
    // normal (and faster) access
    Obj.S['bar'] := 'foo';
    // automatic array creation, Obj is the owner of 'array'
    Obj.A['array'].Add(10);
    Obj.A['array'].Add(20);
    // automatic object creation, 'array' is the owner of ChildObj
    ChildObj := Obj.A['array'].AddObject;
    ChildObj['value'] := 12.3;
    // automatic array creation, ChildObj is the owner of 'subarray'
    ChildObj.A['subarray'].Add(100);
    ChildObj.A['subarray'].Add(200);

    AddMessage(Obj.ToJSON({Compact:=}False));
  finally
    Obj.Free;
  end;
end;

procedure Demo3;
var
  Obj, ClonedObj: TJsonObject;
begin
  Obj := TJsonObject.Parse('{ "foo": [ "bar", {}, null, true, false, { "key": "value" } ] }');
  try
    ClonedObj := TJsonObject.Create;
    try
      // Make a copy of Obj
      ClonedObj.Assign(Obj);
      AddMessage(ClonedObj.ToJSON(False));
    finally
      ClonedObj.Free;
    end;
  finally
    Obj.Free;
  end;
end;

procedure DemoFO4;
var
  Obj: TJsonObject;
begin
  if wbGameMode <> gmFO4 then begin
    AddMessage('Demo is available in FO4Edit only.');
    Exit;
  end;
  
  // loading from BSA/BA2
  Obj := TJsonObject.Create;
  try
    Obj.LoadFromResource('meshes\clothes\wastelander\glovesf.ssf');
    AddMessage(Obj.ToJSON({Compact:=}False));
  finally
    Obj.Free;
  end;
end;


function Initialize: Integer;
begin
  SetJDOLineBreak(#13#10);  // default #10
  //SetJDOIndentChar(#9); // default #9
  //SetJDOUseUtcTime(True); // default True
  //SetJDONullConvertsToValueTypes(False); // default False
  
  AddMessage('---------- Demo1 ----------');
  Demo1;

  AddMessage('---------- Demo2 ----------');
  Demo2;
  
  AddMessage('---------- Demo3 ----------');
  Demo3;

  AddMessage('---------- Demo FO4 ----------');
  DemoFO4;

  Result := 1;
end;

end.
