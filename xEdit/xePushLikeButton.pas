{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xePushLikeButton;

{$I xeDefines.inc}

interface

uses
  Winapi.Messages,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.StdCtrls;

type
  TButton = class(Vcl.StdCtrls.TButton)
  private
    FChecked: Boolean;
    FPushLike: Boolean;
    procedure SetPushLike(Value: Boolean);
    procedure Toggle;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;

    class constructor Create;
    class destructor Destroy;
  protected
    procedure SetButtonStyle(ADefault: Boolean); override; final;
    procedure CreateParams(var Params: TCreateParams); override; final;
    procedure CreateWnd; override; final;

    function GetChecked: Boolean; override; final;
    procedure SetChecked(Value: Boolean); override; final;
  published
    property Checked;
    property PushLike: Boolean read FPushLike write SetPushLike;
  end;

  TPushLikeButtonStyleHook = class(TButtonStyleHook)
  strict protected
    procedure DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean); override; final;
  end;

implementation

uses
  Vcl.Themes,

  Winapi.Windows;

procedure TButton.SetButtonStyle(ADefault: Boolean);
begin
  if not FPushLike then inherited;
  { Else, do nothing - avoid setting style to BS_PUSHBUTTON }
end;

class constructor TButton.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TButton, TPushLikeButtonStyleHook);
end;

procedure TButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FPushLike then
  begin
    Params.Style := Params.Style or BS_PUSHLIKE  or BS_CHECKBOX;
    Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TButton.CreateWnd;
begin
  inherited CreateWnd;
  if FPushLike then
    SendMessage(Handle, BM_SETCHECK, Integer(FChecked), 0);
end;

class destructor TButton.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TButton, TPushLikeButtonStyleHook);
end;

procedure TButton.CNCommand(var Message: TWMCommand);
begin
  if FPushLike and (Message.NotifyCode = BN_CLICKED) then
    Toggle
  else
    inherited;
end;

procedure TButton.Toggle;
begin
  Checked := not FChecked;
end;

function TButton.GetChecked: Boolean;
begin
  Result := FChecked;
end;

procedure TButton.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if FPushLike then
    begin
      if HandleAllocated then
        SendMessage(Handle, BM_SETCHECK, Integer(Checked), 0);
      if not ClicksDisabled then Click;
    end;
  end;
end;

procedure TButton.SetPushLike(Value: Boolean);
begin
  if Value <> FPushLike then
  begin
    FPushLike := Value;
    RecreateWnd;
  end;
end;

{ TPushLikeButtonStyleHook }

procedure TPushLikeButtonStyleHook.DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean);
begin
  if (Control is TButton) and TButton(Control).PushLike and TButton(Control).FChecked then
    FPressed := True;
  inherited;
end;

end.