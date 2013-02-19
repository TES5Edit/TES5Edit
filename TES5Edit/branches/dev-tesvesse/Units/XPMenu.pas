unit XPMenu;

interface

uses
  Windows, Graphics, Controls, Classes, SysUtils;

type
  TXPMenu = class(TComponent)
  private
    FOwner: TComponent;
    FActive: Boolean;
    FSelectedBackColor: TColor;
    FSelectedFontColor: TColor;
    FSeparatorColor: TColor;
    FBackColor: TColor;
    FFontColor: TColor;
    FCheckSignColor: TColor;
    FCheckedColor: TColor;
    FDisabledFontColor: TColor;
    procedure SetActive(Value: boolean);
  protected
    procedure MenuDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure MenuMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetDrawItemEventHandlers;
  published
    property Active: boolean read FActive Write SetActive;
    property BackColor: TColor read FBackColor Write FBackColor;
    property SelectedBackColor: TColor read FSelectedBackColor Write FSelectedBackColor;
    property FontColor: TColor read FFontColor Write FFontColor;
    property SelectedFontColor: TColor read FSelectedFontColor Write FSelectedFontColor;
    property DisabledFontColor: TColor read FDisabledFontColor Write FDisabledFontColor;
    property SeparatorColor: TColor read FSeparatorColor Write FSeparatorColor;
    property CheckedColor: TColor read FCheckedColor Write FCheckedColor;
    property CheckedSignColor: TColor read FCheckSignColor Write FCheckSignColor;
  end;

implementation

uses
  Menus;

constructor TXPMenu.Create(AOwner: TComponent);
begin
  inherited;
  FOwner := AOwner;
  FBackColor := $00F1F1F1;
  FSelectedBackColor := $00EFD3C6;
  FFontColor := clBlack;
  FSelectedFontColor := clNavy;
  FDisabledFontColor := clGray;
  FSeparatorColor := $00D1D1D1;
  FCheckedColor := clGray;
  FCheckSignColor := $00A56D39;
  Active := True;
end;

procedure TXPMenu.SetActive(Value: boolean);
var
  i,j: integer;
begin
  if (FActive <> Value) then
  begin
    FActive := Value;
    with FOwner do
    begin
      SetDrawItemEventHandlers;
      for i := 0 to ComponentCount - 1 do
      begin
        if (Components[i] is TMenu) then
          TMenu(Components[i]).OwnerDraw := FActive;
        if (Components[i] is TMainMenu) then
          with Components[i] as TMainMenu do
            for j := 0 to Items.Count - 1 do
              if Items[j].Visible then
              begin
                Items[j].Visible := False;
                Items[j].Visible := True;
              end;
      end;
    end;
  end;
end;

procedure SetMenuDrawItem(Active: Boolean; MenuItem: TMenuItem; MenuDrawItem: TAdvancedMenuDrawItemEvent; MenuMeasureItem: TMenuMeasureItemEvent);
var
  i: integer;
begin
  if Active then
  begin
    MenuItem.OnAdvancedDrawItem := MenuDrawItem;
    MenuItem.OnMeasureItem := MenuMeasureItem;
  end
  else
  begin
    MenuItem.OnAdvancedDrawItem := nil;
    MenuItem.OnMeasureItem := nil;
  end;
  for i := 0 to MenuItem.Count - 1 do
    SetMenuDrawItem(Active, MenuItem.Items[i], MenuDrawItem, MenuMeasureItem);
end;

procedure TXPMenu.MenuMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Height := Height + 8;
end;

procedure TXPMenu.SetDrawItemEventHandlers;
var
  i, j: integer;
begin
  with FOwner do
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TMenu) then
        for j := 0 to (Components[i] as TMenu).Items.Count - 1 do
          SetMenuDrawItem(FActive, (Components[i] as TMenu).Items[j], MenuDrawItem, MenuMeasureItem);
end;

procedure GrayBitmap(var FBitmap: TBitmap);
var
  ybLine: PByteArray;
  x, y: integer;
  g: Byte;
begin
  FBitmap.PixelFormat := pf24bit;
  for y := 0 to FBitmap.Height - 1 do
  begin
    ybLine := FBitmap.ScanLine[y];
    for x := 0 to FBitmap.Width - 1 do
    begin
      g := (ybLine[x * 3] + ybLine[x * 3 + 1] + ybLine[x * 3 + 2]) div 3;
      ybLine[x * 3] := g;
      ybLine[x * 3 + 1] := g;
      ybLine[x * 3 + 2] := g;
    end;
  end;
  FBitmap.TransparentColor := FBitmap.Canvas.Pixels[0, FBitmap.Height - 1];
end;

procedure LightBitmap(var FBitmap: TBitmap);
var
  ybLine: PByteArray;
  x, y: integer;
begin
  FBitmap.PixelFormat := pf24bit;
  for y := 0 to FBitmap.Height - 1 do
  begin
    ybLine := FBitmap.ScanLine[y];
    for x := 0 to FBitmap.Width - 1 do
    begin
      ybLine[x * 3] := $FF - Round(0.8 * Abs($FF - ybLine[x * 3]));
      ybLine[x * 3 + 1] := $FF - Round(0.8 * Abs($FF - ybLine[x * 3 + 1]));
      ybLine[x * 3 + 2] := $FF - Round(0.8 * Abs($FF - ybLine[x * 3 + 2]));
    end;
  end;
  FBitmap.TransparentColor := FBitmap.Canvas.Pixels[0, FBitmap.Height - 1];
end;

procedure DarkBitmap(var FBitmap: TBitmap);
var
  ybLine: PByteArray;
  x, y: integer;
begin
  FBitmap.PixelFormat := pf24bit;
  for y := 0 to FBitmap.Height - 1 do
  begin
    ybLine := FBitmap.ScanLine[y];
    for x := 0 to FBitmap.Width - 1 do
    begin
      ybLine[x * 3] := Round(0.8 * ybLine[x * 3]);
      ybLine[x * 3 + 1] := Round(0.8 * ybLine[x * 3 + 1]);
      ybLine[x * 3 + 2] := Round(0.8 * ybLine[x * 3 + 2]);
    end;
  end;
  FBitmap.TransparentColor := FBitmap.Canvas.Pixels[0, FBitmap.Height - 1];
end;

procedure TXPMenu.MenuDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
var
  Text: string;
  Bitmap: TBitmap;
  IconRect, TextRect, CheckRect: TRect;
  i, TextFormat: integer;
  MenuItem: TMenuItem;
  bFlatMenu: Boolean;
begin
  SystemParametersInfo(SPI_GETFLATMENU,0,@bFlatMenu,0);
  Bitmap := TBitmap.Create;
  try
    Bitmap.Transparent := True;
    if Sender is TMenuItem then
    begin
      MenuItem := Sender as TMenuItem;
      Text := #32 + MenuItem.Caption;
      if MenuItem.ImageIndex <> -1 then
        if Assigned(MenuItem.Parent.SubMenuImages) then
          MenuItem.Parent.SubMenuImages.GetBitmap(MenuItem.ImageIndex, Bitmap)
        else
          MenuItem.Parent.GetParentMenu.Images.GetBitmap(MenuItem.ImageIndex, Bitmap);
      if MenuItem.Parent.GetParentMenu.IsRightToLeft then
      begin
        IconRect := Rect(ARect.Right - 20, ARect.Top, ARect.Right, ARect.Bottom);
        TextRect := Rect(ARect.Left, ARect.Top, ARect.Right - 20, ARect.Bottom);
      end
      else
      begin
        IconRect := Rect(ARect.Left, ARect.Top, ARect.Left + 20, ARect.Bottom);
        TextRect := Rect(ARect.Left + 20, ARect.Top, ARect.Right, ARect.Bottom);
      end;
      ACanvas.Brush.Color := FBackColor;
      ACanvas.FillRect(TextRect);
      if (MenuItem.Parent.GetParentMenu is TMainMenu) then
        for i := 0 to MenuItem.GetParentMenu.Items.Count - 1 do
          if MenuItem.GetParentMenu.Items[i] = MenuItem then
          begin
            if bFlatMenu then
              ACanvas.Brush.Color := clMenuBar
            else
              ACanvas.Brush.Color := clMenu;
            ACanvas.FillRect(ARect);
            if (MenuItem.ImageIndex = -1) and (MenuItem.Bitmap.Width = 0) then
            begin
              TextRect := ARect;
              Break;
            end;
          end;
      if bFlatMenu then
        ACanvas.Brush.Color := clMenuBar
      else
        ACanvas.Brush.Color := clMenu;
      ACanvas.FillRect(IconRect);
      if MenuItem.Enabled then
        ACanvas.Font.Color := FFontColor
      else
      begin
        ACanvas.Font.Color := FDisabledFontColor;
        GrayBitmap(Bitmap);
      end;
      if (odSelected in State) or (odHotLight in State) then
      begin
        ACanvas.Brush.Style := bsSolid;
        if (MenuItem.GetParentComponent is TMainMenu) and (odSelected in State) and not MenuItem.Parent.GetParentMenu.IsRightToLeft then
        begin
          if bFlatMenu then
            ACanvas.Brush.Color := clMenuBar
          else
            ACanvas.Brush.Color := clMenu;
          ACanvas.FillRect(TextRect);
          ACanvas.Pen.Color := ColorToRGB(clBtnShadow);
          for i := 0 to 3 do
          begin
            ACanvas.Pen.Color := ACanvas.Pen.Color + $101010;
            ACanvas.Polyline([Point(ARect.Right - 3 + i, ARect.Top + 4 + 3* i), Point(ARect.Right - 3 + i, ARect.Bottom)]);
          end;
          ACanvas.Pen.Color := clBtnShadow;
        end
        else
        begin
          ACanvas.Brush.Color := FSelectedBackColor;
          if (MenuItem.GetParentComponent is TMainMenu) and not MenuItem.Parent.GetParentMenu.IsRightToLeft then
            ACanvas.FillRect(Rect(TextRect.Left, TextRect.Top, TextRect.Right - 3, TextRect.Bottom))
          else
            ACanvas.FillRect(TextRect);
          ACanvas.Pen.Color := FSelectedFontColor;
        end;
        ACanvas.Brush.Style := bsClear;
        if (MenuItem.GetParentComponent is TMainMenu) and not MenuItem.Parent.GetParentMenu.IsRightToLeft then
          if odSelected in State then
            ACanvas.Polyline([Point(ARect.Left, ARect.Bottom - 1), Point(ARect.Left, ARect.Top), Point(ARect.Right - 4, ARect.Top), Point(ARect.Right - 4, ARect.Bottom)])
          else
            ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right - 3, ARect.Bottom)
        else
          ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
        if MenuItem.Enabled then
          ACanvas.Font.Color := FSelectedFontColor;
      end;
      if MenuItem.Checked then
      begin
        ACanvas.Pen.Color := FCheckedColor;
        ACanvas.Brush.Style := bsClear;
        if Bitmap.Width = 0 then
        begin
          ACanvas.RoundRect(IconRect.Left + 5, IconRect.Top + 5, IconRect.Right - 5, IconRect.Bottom - 5, 3, 3);
          CopyRect(CheckRect, IconRect);
          InflateRect(CheckRect, -7, -7);
          ACanvas.Brush.Color := FCheckSignColor;
          ACanvas.FillRect(CheckRect);
        end
        else
        begin
          ACanvas.Brush.Color := FCheckSignColor;
          ACanvas.RoundRect(IconRect.Left, IconRect.Top, IconRect.Right, IconRect.Bottom, 3, 3);
        end;
      end;
      if Assigned(Bitmap) then
      begin
        if (odSelected in State) or (odHotLight in State) then
          if MenuItem.Enabled then
            LightBitmap(Bitmap)
          else
            DarkBitmap(Bitmap);
        if (IconRect.Right - IconRect.Left) > Bitmap.Width then
          IconRect.Left := IconRect.Left + (IconRect.Right - IconRect.Left - Bitmap.Width) div 2;
        if (IconRect.Bottom - IconRect.Top) > Bitmap.Height then
          IconRect.Top := IconRect.Top + (IconRect.Bottom - IconRect.Top - Bitmap.Height) div 2;
        ACanvas.Draw(IconRect.Left,IconRect.Top, Bitmap);
      end;
      if not MenuItem.IsLine then
      begin
        SetBkMode(ACanvas.Handle, TRANSPARENT);
        ACanvas.Font.Name := 'Tahoma';
        ACanvas.Font.Style := [];
        if MenuItem.Parent.GetParentMenu.IsRightToLeft then
        begin
          ACanvas.Font.Charset := ARABIC_CHARSET;
          TextFormat := DT_RIGHT + DT_RTLREADING
        end
        else
          TextFormat := 0;
        TextFormat := TextFormat + DT_VCENTER + DT_SINGLELINE;
        if MenuItem.Default then
          ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
        inc(TextRect.Left, 2);
        DrawTextEx(ACanvas.Handle, PChar(Text), Length(Text), TextRect, TextFormat, nil);
        Text := ShortCutToText(MenuItem.ShortCut) + ' ';
        if MenuItem.Parent.GetParentMenu.IsRightToLeft then
          TextFormat := DT_LEFT
        else
          TextFormat := DT_RIGHT;
        TextFormat := TextFormat + DT_VCENTER + DT_SINGLELINE;
        DrawTextEx(ACanvas.Handle, PChar(Text), Length(Text), TextRect, TextFormat, nil);
      end
      else
      begin
        ACanvas.Pen.Color := FSeparatorColor;
        ACanvas.MoveTo(ARect.Left + 10, TextRect.Top + Round((TextRect.Bottom - TextRect.Top) / 2));
        ACanvas.LineTo(ARect.Right - 2, TextRect.Top + Round((TextRect.Bottom - TextRect.Top) / 2));
      end;
    end;
  finally
    Bitmap.Free;
  end;
end;

destructor TXPMenu.Destroy;
begin
  Active := False;
  inherited;
end;

end.

