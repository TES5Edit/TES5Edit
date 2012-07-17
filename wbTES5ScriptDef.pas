{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}
unit wbTES5ScriptDef;

interface

uses
  wbImplementation,
  wbInterface,
  wbBSA,
  Types, Classes, SysUtils, Math, Variants,

  // I don't know which things are not needed
  Windows, Messages, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  IniFiles, TypInfo, ActiveX, Buttons, ActnList,
  ShellAPI,
  Direct3D9, D3DX9,
{$IFDEF DX3D}
  RenderUnit, Direct3D9, D3DX9, DXUT,
{$ENDIF}
  AppEvnts,
  Mask,
  ShlObj, Registry;

  implementation

end.
