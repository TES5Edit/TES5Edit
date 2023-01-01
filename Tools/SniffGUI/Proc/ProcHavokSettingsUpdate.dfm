object FrameHavokSettings: TFrameHavokSettings
  Left = 0
  Top = 0
  Width = 481
  Height = 306
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 481
    Height = 41
    Align = alTop
    AutoSize = False
    Caption = 
      'Update Material and Radius in bhkShape* nodes and Havok settings' +
      ' in bhkRigidBody* nodes. Leave empty values to not update. If Ma' +
      'ss=0 then Inertia Tensor matrix will be zeroed.'
    TabOrder = 0
  end
  object edSettings: TValueListEditor
    AlignWithMargins = True
    Left = 4
    Top = 41
    Width = 465
    Height = 265
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 12
    Margins.Bottom = 0
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goAlwaysShowEditor, goThumbTracking, goFixedRowClick]
    Strings.Strings = (
      'Material='
      'Radius='
      'Layer='
      'Mass='
      'Linear Damping='
      'Angular Damping='
      'Max Linear Velocity='
      'Max Angular Velocity='
      'Friction='
      'Restitution='
      'Motion System='
      'Deactivator Type='
      'Solver Deactivation='
      'Motion Quality=')
    TabOrder = 1
    OnGetPickList = edSettingsGetPickList
    ColWidths = (
      150
      292)
  end
end
