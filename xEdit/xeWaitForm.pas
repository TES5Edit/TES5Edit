{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit frmWaitForm;

{$I wbDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  wbInterface, StdCtrls, Buttons, ExtCtrls;

type
  TwbProgress = class;

  TfrmWait = class(TForm, IInterface, IwbWaitForm)
    plMessage: TPanel;
    Panel2: TPanel;
    plCancel: TPanel;
    bnCancel: TBitBtn;
    procedure bnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected {private}
    fwRefCount: Integer;

    fwCanceled     : Boolean;

    fwProgressHead : TwbProgress;
    fwProgressTail : TwbProgress;

    fwCanCancel    : Boolean;
    fwShowDelay    : Integer;
    fwUpdateDelay  : Integer;

    fwCreated      : UInt64;
    fwLastUpdate   : UInt64;

    procedure fwDoUpdate;
  protected
    {--- IInterface ---}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    {--- IwbWaitForm ---}
    function GetIsCanceled: Boolean;

    function CreateProgress(const aCaption : string;
                            const aStatus  : string;
                                  aMax     : Integer)
                                           : IwbProgress;
  public
    constructor Create(const aCaption     : string;
                       const aMessage     : string;
                             aCanCancel   : Boolean;
                             aShowDelay   : Integer;
                             aUpdateDelay : Integer); reintroduce;
    destructor Destroy; override;
  end;

  TwbProgress = class(TInterfacedObject, IwbProgress)
  protected {private}
    prgWait     : TfrmWait;
    prgWaitPrev : TwbProgress;
    prgWaitNext : TwbProgress;

    prgCaption  : string;
    prgMax      : Integer;
    prgPosition : Integer;
    prgStatus   : string;

    procedure prgAddToWait;
    procedure prgRemoveFromWait;
  protected
    {--- IwbProgress ---}
    procedure UpdateStatus(aPosition: Integer; const aStatus: string);
  public
    constructor Create(aWait: TfrmWait; const aCaption, aStatus: string; aMax: Integer);
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses
  frmViewMain;

function _CreateWaitForm(const aCaption     : string;
                         const aMessage     : string;
                               aCanCancel   : Boolean;
                               aShowDelay   : Integer = 0;
                               aUpdateDelay : Integer = 0)
                                            : IwbWaitForm;
begin
  Result := TfrmWait.Create(aCaption, aMessage, aCanCancel, aShowDelay, aUpdateDelay);
end;

{ TfrmWait }

procedure TfrmWait.bnCancelClick(Sender: TObject);
begin
  fwCanceled := True;
end;

constructor TfrmWait.Create(const aCaption, aMessage: string; aCanCancel: Boolean; aShowDelay, aUpdateDelay: Integer);
begin
  inherited Create(nil);
  Caption := aCaption;

  fwCanCancel := aCanCancel;
  fwShowDelay := aShowDelay;
  fwUpdateDelay := aUpdateDelay;

  fwCreated := GetTickCount64;
  fwLastUpdate := fwCreated;

  plCancel.Visible := fwCanCancel;
  plMessage.Caption := aMessage;
end;

function TfrmWait.CreateProgress(const aCaption, aStatus: string; aMax: Integer): IwbProgress;
begin
  Result := TwbProgress.Create(Self, aCaption, aStatus, aMax);
end;

destructor TfrmWait.Destroy;
begin
  while Assigned(fwProgressHead) do begin
    fwProgressHead.prgWait := nil;
    fwProgressHead := fwProgressHead.prgWaitNext;
  end;
  inherited;
end;

procedure TfrmWait.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);
end;

procedure TfrmWait.fwDoUpdate;
begin
  if (GetTickCount64 - fwUpdateDelay) > fwLastUpdate then begin

    //!!!

    fwLastUpdate := GetTickCount64;

    if not Visible then
      if (GetTickCount64 - fwShowDelay) > fwCreated then
        Show;

    Application.ProcessMessages;
  end;
end;

function TfrmWait.GetIsCanceled: Boolean;
begin
  Result := fwCanCancel and fwCanceled;
end;

function TfrmWait._AddRef: Integer;
begin
  Result := InterlockedIncrement(fwRefCount);
end;

function TfrmWait._Release: Integer;
begin
  Result := InterlockedDecrement(fwRefCount);
  if Result = 0 then begin
    Hide;
    Release;
  end;
end;

{ TwbProgress }

constructor TwbProgress.Create(aWait: TfrmWait; const aCaption, aStatus: string; aMax: Integer);
begin
  inherited Create;
  prgCaption := aCaption;
  prgStatus := aStatus;
  prgMax := aMax;
  prgWait := aWait;
  if Assigned(prgWait) then begin
    prgAddToWait;
    prgWait.fwDoUpdate;
  end;
end;

destructor TwbProgress.Destroy;
begin
  if Assigned(prgWait) then begin
    prgRemoveFromWait;
    prgWait.fwDoUpdate;
  end;
  inherited;
end;

procedure TwbProgress.prgAddToWait;
begin
  prgWaitPrev := prgWait.fwProgressTail;
  prgWait.fwProgressTail := Self;
  if Assigned(prgWaitPrev) then
    prgWaitPrev.prgWaitNext := Self;
  if not Assigned(prgWait.fwProgressHead) then
    prgWait.fwProgressHead := Self;
end;

procedure TwbProgress.prgRemoveFromWait;
begin
  if Assigned(prgWaitNext) then
    prgWaitNext.prgWaitPrev := prgWaitPrev
  else
    if prgWait.fwProgressTail = Self then
      prgWait.fwProgressTail := prgWaitPrev;

  if Assigned(prgWaitPrev) then
    prgWaitPrev.prgWaitNext := prgWaitNext
  else
    if prgWait.fwProgressHead = Self then
      prgWait.fwProgressHead := prgWaitNext;

  prgWaitNext := nil;
  prgWaitPrev := nil;
end;

procedure TwbProgress.UpdateStatus(aPosition: Integer; const aStatus: string);
begin
  if not Assigned(prgWait) then
    Exit;

  if aPosition > prgMax then
    aPosition := prgMax;
  prgPosition := aPosition;
  prgStatus := aStatus;
  prgWait.fwDoUpdate;
end;

initialization
//  wbCreateWaitForm := _CreateWaitForm;
end.

