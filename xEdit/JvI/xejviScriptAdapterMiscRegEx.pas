{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterMiscRegEx;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,
  System.RegularExpressionsConsts,
  System.RegularExpressionsCore;

{ TPerlRegEx }

{type
  TJvInterpreterPerlRegExEvents = class(TJvInterpreterEvent)
  private
    procedure OnReplace(Sender: TObject; var ReplaceWith: UTF8String);
  end;

procedure TJvInterpreterPerlRegExEvents.OnReplace(Sender: TObject; var ReplaceWith: UTF8String);
begin
  CallFunction(nil, [O2V(Sender), ReplaceWith]);
  ReplaceWith := Args.Values[1];
end;}

procedure TPerlRegEx_Compile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Compile;
end;

procedure TPerlRegEx_Read_Compiled(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Compiled;
end;

procedure TPerlRegEx_ComputeReplacement(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).ComputeReplacement);
end;

procedure TPerlRegEx_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TPerlRegEx.Create);
end;

procedure TPerlRegEx_EscapeRegExChars(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).EscapeRegExChars(String(Args.Values[0]));
end;

procedure TPerlRegEx_FoundMatch(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).FoundMatch;
end;

procedure TPerlRegEx_GroupCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupCount;
end;

procedure TPerlRegEx_Read_GroupLengths(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupLengths[Args.Values[0]];
end;

procedure TPerlRegEx_Read_GroupOffsets(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).GroupOffsets[Args.Values[0]];
end;

procedure TPerlRegEx_Read_Groups(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Args.Values[0] < 0 then
    JvInterpreterError(ieArrayIndexOutOfBounds, -1);
  Value := String(TPerlRegEx(Args.Obj).Groups[Args.Values[0]]);
end;

procedure TPerlRegEx_Match(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Match;
end;

procedure TPerlRegEx_MatchAgain(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchAgain;
end;

procedure TPerlRegEx_MatchedLength(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchedLength;
end;

procedure TPerlRegEx_MatchedOffset(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).MatchedOffset;
end;

procedure TPerlRegEx_MatchedText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).MatchedText);
end;

procedure TPerlRegEx_NamedGroup(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).NamedGroup(String(Args.Values[0]));
end;

procedure TPerlRegEx_Read_Options(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := S2V(Byte(TPerlRegEx(Args.Obj).Options));
end;

procedure TPerlRegEx_Write_Options(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Options := TPerlRegExOptions(Byte(V2S(Value)));
end;

procedure TPerlRegEx_Read_RegEx(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).RegEx);
end;

procedure TPerlRegEx_Write_RegEx(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).RegEx := String(Value);
end;

procedure TPerlRegEx_Replace(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Replace);
end;

procedure TPerlRegEx_ReplaceAll(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).ReplaceAll;
end;

procedure TPerlRegEx_Read_Replacement(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Replacement);
end;

procedure TPerlRegEx_Write_Replacement(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Replacement := String(Value);
end;

procedure TPerlRegEx_Split(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Split(TStrings(V2O(Args.Values[0])), Args.Values[1]);
end;

procedure TPerlRegEx_SplitCapture(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).SplitCapture(TStrings(V2O(Args.Values[0])), Args.Values[1]);
end;

procedure TPerlRegEx_Read_Start(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Start;
end;

procedure TPerlRegEx_Write_Start(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Start := Value;
end;

procedure TPerlRegEx_Read_Stop(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Stop;
end;

procedure TPerlRegEx_Write_Stop(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Stop := Value;
end;

procedure TPerlRegEx_StoreGroups(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).StoreGroups;
end;

procedure TPerlRegEx_Study(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Study;
end;

procedure TPerlRegEx_Read_Studied(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TPerlRegEx(Args.Obj).Studied;
end;

procedure TPerlRegEx_Read_Subject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).Subject);
end;

procedure TPerlRegEx_Write_Subject(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TPerlRegEx(Args.Obj).Subject := String(Value);
end;

procedure TPerlRegEx_SubjectLeft(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).SubjectLeft);
end;

procedure TPerlRegEx_SubjectRight(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := String(TPerlRegEx(Args.Obj).SubjectRight);
end;

{ Registration }

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { TPerlRegExOptions }
    AddConst('RegularExpressionsCore', 'preCaseLess', Ord(preCaseLess));
    AddConst('RegularExpressionsCore', 'preMultiLine', Ord(preMultiLine));
    AddConst('RegularExpressionsCore', 'preSingleLine', Ord(preSingleLine));
    AddConst('RegularExpressionsCore', 'preExtended', Ord(preExtended));
    AddConst('RegularExpressionsCore', 'preAnchored', Ord(preAnchored));
    AddConst('RegularExpressionsCore', 'preUnGreedy', Ord(preUnGreedy));
    AddConst('RegularExpressionsCore', 'preNoAutoCapture', Ord(preNoAutoCapture));
    AddConst('RegularExpressionsCore', 'preNotBOL', Ord(preNotBOL));
    AddConst('RegularExpressionsCore', 'preNotEOL', Ord(preNotEOL));
    AddConst('RegularExpressionsCore', 'preNotEmpty', Ord(preNotEmpty));

    { TPerlRegEx }
    AddClass('RegularExpressionsCore', TPerlRegEx, 'TPerlRegEx');
    AddGet(TPerlRegEx, 'Compile', TPerlRegEx_Compile, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Compiled', TPerlRegEx_Read_Compiled, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'ComputeReplacement', TPerlRegEx_ComputeReplacement, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Create', TPerlRegEx_Create, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'EscapeRegExChars', TPerlRegEx_EscapeRegExChars, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'FoundMatch', TPerlRegEx_FoundMatch, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'GroupCount', TPerlRegEx_GroupCount, 0, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'GroupLengths', TPerlRegEx_Read_GroupLengths, 1, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'GroupOffsets', TPerlRegEx_Read_GroupOffsets, 1, [varEmpty], varEmpty);
    AddIGet(TPerlRegEx, 'Groups', TPerlRegEx_Read_Groups, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Match', TPerlRegEx_Match, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchAgain', TPerlRegEx_MatchAgain, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedLength', TPerlRegEx_MatchedLength, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedOffset', TPerlRegEx_MatchedOffset, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'MatchedText', TPerlRegEx_MatchedText, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'NamedGroup', TPerlRegEx_NamedGroup, 1, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Options', TPerlRegEx_Read_Options, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Options', TPerlRegEx_Write_Options, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'RegEx', TPerlRegEx_Read_RegEx, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'RegEx', TPerlRegEx_Write_RegEx, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'Replace', TPerlRegEx_Replace, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'ReplaceAll', TPerlRegEx_ReplaceAll, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Replacement', TPerlRegEx_Read_Replacement, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Replacement', TPerlRegEx_Write_Replacement, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'Split', TPerlRegEx_Split, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'SplitCapture', TPerlRegEx_SplitCapture, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Start', TPerlRegEx_Read_Start, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Start', TPerlRegEx_Write_Start, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'Stop', TPerlRegEx_Read_Stop, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Stop', TPerlRegEx_Write_Stop, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'StoreGroups', TPerlRegEx_StoreGroups, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Study', TPerlRegEx_Study, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Studied', TPerlRegEx_Read_Studied, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'Subject', TPerlRegEx_Read_Subject, 0, [varEmpty], varEmpty);
    AddSet(TPerlRegEx, 'Subject', TPerlRegEx_Write_Subject, 0, [varEmpty]);
    AddGet(TPerlRegEx, 'SubjectLeft', TPerlRegEx_SubjectLeft, 0, [varEmpty], varEmpty);
    AddGet(TPerlRegEx, 'SubjectRight', TPerlRegEx_SubjectRight, 0, [varEmpty], varEmpty);
    //AddEvent('RegularExpressionsCore', TPerlRegEx, 'TNotifyEvent');
    //AddEvent('RegularExpressionsCore', TPerlRegEx, 'TPerlRegExReplaceEvent');
    //AddHandler('RegularExpressionsCore', 'TNotifyEvent', TJvInterpreterClassesEvent, @TJvInterpreterClassesEvent.NotifyEvent);
    //AddHandler('RegularExpressionsCore', 'TPerlRegExReplaceEvent', TJvInterpreterPerlRegExEvents, @TJvInterpreterPerlRegExEvents.OnReplace);
  end;
end;

end.
