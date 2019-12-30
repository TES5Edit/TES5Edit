{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeLegendForm;

{$I xeDefines.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.IniFiles,
  wbInterface;

type
  TfrmLegend = class(TForm)
    dgLegend: TDrawGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dgLegendDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    CellSizeCalc: Integer;
  public
    Settings: TMemIniFile;
  end;

var
  frmLegend: TfrmLegend;

implementation

{$R *.dfm}

uses
  Math,
  xeMainForm;

procedure TfrmLegend.dgLegendDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s: string;
  i, j: Integer;
  ConflictAll : TConflictAll;
  ConflictThis : TConflictThis;
begin
  case CellSizeCalc of
    0: begin
      CellSizeCalc := 1;
      j := 0;
      with dgLegend.Canvas do
        for i := 1 to Pred(dgLegend.RowCount) do
          j := Max(j, TextWidth(wbNameConflictAll[TConflictAll(i)]+'oo'));
      dgLegend.ColWidths[0] := j;

      with dgLegend.Canvas do
        for i := 1 to Pred(dgLegend.ColCount) do
          dgLegend.ColWidths[i] := TextWidth(wbNameConflictThis[TConflictThis(i)]+'oo');
      CellSizeCalc := 2;
       with dgLegend, CellRect(Pred(ColCount), Pred(RowCount)) do begin
        Self.ClientWidth := Right+2;
        Self.ClientHeight := Bottom+2;
      end;
      dgLegend.Invalidate;
    end;
    1: dgLegend.Canvas.FillRect(Rect);
    2: begin
      with dgLegend.Canvas do begin
        if aCol = 0 then begin
          s := wbNameConflictAll[TConflictAll(aRow)];
          TextRect(Rect, s, [tfCenter, tfVerticalCenter, tfSingleLine]);
        end else begin
          s := wbNameConflictThis[TConflictThis(aCol)];
          if ARow > 0 then begin
            ConflictAll := TConflictAll(aRow);
            ConflictThis := TConflictThis(aCol);
            if ConflictAll >= caNoConflict then
              Brush.Color := wbLighter(ConflictAllToColor(ConflictAll), 0.85)
            else
              Brush.Color := clWindow;
            Font.Color := wbDarker(ConflictThisToColor(ConflictThis));
            FillRect(Rect);
          end;
          TextRect(Rect, s, [tfCenter, tfVerticalCenter, tfSingleLine]);
        end;
        if not (gdFocused in State) then
          if (aRow = dgLegend.Row) and (aCol = dgLegend.Col) then
            DrawFocusRect(Rect);
      end;
    end;
  end;
end;

procedure TfrmLegend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfrmLegend.FormCreate(Sender: TObject);
var
  lLeft, lTop, lWidth, lHeight : Integer;
  lRect: TRect;
begin
  DoubleBuffered := True;
  dgLegend.DoubleBuffered := True;
  wbApplyFontAndScale(Self);

  Settings := frmMain.Settings;

  if Assigned(Settings) then begin
    lLeft := Settings.ReadInteger(Name, 'Left', 0);
    lTop := Settings.ReadInteger(Name, 'Top', 0);
    lWidth := Settings.ReadInteger(Name, 'Width', 0);
    lHeight := Settings.ReadInteger(Name, 'Height', 0);
    if (lWidth > 100) and (lHeight > 100) then begin
      lRect := Screen.DesktopRect;
      if (lLeft+16 >= lRect.Left) and
         (lTop+16 >= lRect.Top) and
         ((lLeft + lWidth)-16 <= lRect.Right) and
         ((lTop + lHeight)-16 <= lRect.Bottom)
      then begin
        Left := lLeft;
        Top := lTop;
        Width := lWidth;
        Height := lHeight;
        Position := poDesigned;
      end;
    end;
    WindowState := TWindowState(Settings.ReadInteger(Name, 'WindowState', Integer(WindowState)));
    if WindowState = wsMaximized then
      Position := poDesigned;
  end;

  dgLegend.Align := alNone;
  dgLegend.BoundsRect := Rect(0, 0, 6000, 3000);
  dgLegend.ColCount := Succ(Ord(High(TConflictThis)));
  dgLegend.RowCount := Succ(Ord(High(TConflictAll)));
end;

procedure TfrmLegend.FormDestroy(Sender: TObject);
begin
  if frmLegend = Self then
    frmLegend := nil;
end;

procedure TfrmLegend.FormHide(Sender: TObject);
begin
  if Assigned(frmMain) then begin
    frmMain.bnLegend.Down := False;

    if Assigned(Settings) then begin
      if WindowState <> wsMinimized then
        Settings.WriteInteger(Name, 'WindowState', Integer(WindowState));
      if WindowState = wsNormal then begin
        Settings.WriteInteger(Name, 'Left', Left);
        Settings.WriteInteger(Name, 'Top', Top);
        Settings.WriteInteger(Name, 'Width', Width);
        Settings.WriteInteger(Name, 'Height', Height);
      end;
      Settings.UpdateFile;
    end;
  end;
end;

procedure TfrmLegend.FormShow(Sender: TObject);
var
  lLeft, lTop, lWidth, lHeight : Integer;
  lRect: TRect;
begin
  if Assigned(Settings) then begin
    lLeft := Settings.ReadInteger(Name, 'Left', 0);
    lTop := Settings.ReadInteger(Name, 'Top', 0);
    lWidth := Settings.ReadInteger(Name, 'Width', 0);
    lHeight := Settings.ReadInteger(Name, 'Height', 0);
    if (lWidth > 100) and (lHeight > 100) then begin
      lRect := Screen.DesktopRect;
      if (lLeft+16 >= lRect.Left) and
         (lTop+16 >= lRect.Top) and
         ((lLeft + lWidth)-16 <= lRect.Right) and
         ((lTop + lHeight)-16 <= lRect.Bottom)
      then begin
        Left := lLeft;
        Top := lTop;
        Position := poDesigned;
      end;
    end;
    WindowState := TWindowState(Settings.ReadInteger(Name, 'WindowState', Integer(WindowState)));
    if WindowState = wsMaximized then
      Position := poDesigned;
  end;
end;

end.
