object frmDeveloperMessage: TfrmDeveloperMessage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'A message from the developer'
  ClientHeight = 615
  ClientWidth = 864
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    864
    615)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 760
    Top = 582
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Open Patreon'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object reMain: TJvRichEdit
    Left = 8
    Top = 8
    Width = 848
    Height = 568
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Hello, I'#39'm ElminsterAU, the original developer of xEdit.'
      ''
      
        'Thank you for taking the time to read this message. It will be s' +
        'hown only once after major updates of xEdit. (Or if you reset th' +
        'e settings where the information is stored that '
      'it has already been shown.) '
      ''
      
        'Some years ago, when it became clear to me that I (due to work c' +
        'ommittments and the imminent birth of our twins) would not have ' +
        'the necessary spare time to adequately '
      
        'maintain (much less continue to improve) xEdit, I made the decis' +
        'ion to open source the program.  Thankfully a group of dedicated' +
        ' people took up the job of maintaining xEdit, '
      
        'foremost Hlp, Zilav, Sharlikran, and Sheson, with contributions ' +
        'from a number of other people.  They have done a fantastic job a' +
        'nd I'#39'm very grateful for everything they '
      
        'have done, and continue doing, to maintain and extend xEdit.  It' +
        ' is truly amazing to see the small tool, that I built originally' +
        ' for myself over a decade ago, evolve into the full '
      'blown editor that it is today.'
      ''
      
        'Recently I'#39've found myself with some spare time (thanks to the t' +
        'wins having started school) and used that time to review the cur' +
        'rent status of xEdit.  After perusing the '
      
        'issue tracker on GitHub and discussions with Hlp, Zilav, and Sha' +
        'rlikran, I found that there were a number of overdue, non-trivia' +
        'l, improvements to xEdit that required a more '
      
        'in-depth understanding of the internal architecture.  I decided,' +
        ' with an initial schedule of one free week, to work through a nu' +
        'mber of what seemed to be easy fixes and '
      
        'enhancements to the system.  However, what started out as just a' +
        'dding ESL support has grown into a very major update over the en' +
        'suing months and included taking extra '
      
        'time off my fulltime job. The results of which you have now in f' +
        'ront if you.'
      ''
      
        'This incredible progress has only been possible by diverting mos' +
        't of the time I usually spend on paid work to xEdit development.' +
        '  As I am sure you will understand, this is '
      
        'simply not sustainable for me in the long term.  Hence I'#39've star' +
        'ted a Patreon for which the aim is to get enough financial suppo' +
        'rt to allow me to continue working full-time on '
      
        'xEdit development.  Your support is essential for future support' +
        ' of, and continuation of feature additions to, xEdit.'
      ''
      
        'At all times xEdit is, and will continue to be, freely available' +
        ' on NexusMods and GitHub. But the amount of time I will be able ' +
        'to spend on its support and further development '
      
        'directly depends upon your support.  Your support as one of my p' +
        'atrons will be recognized via a special role on the xEdit Discor' +
        'd and the knowledge that you are providing '
      
        'invaluable support for making the ongoing support, development, ' +
        'and improvement of xEdit possible.'
      ''
      
        'I love working on xEdit and interacting with the modding communi' +
        'ty through the xEdit Discord, and I would greatly appreciate you' +
        'r support to make this happen.  We can '
      
        'together ensure a bright and vibrant future for xEdit with faste' +
        'r development cycle times and much improved testing and feature ' +
        'enhancements and additions. '
      ''
      
        'I would like to thank you in advance for your support of my Patr' +
        'eon, and look forward to interacting with you on the xEdit Disco' +
        'rd.'
      ''
      'ElminsterAU')
    ReadOnly = True
    ScrollBars = ssVertical
    SelText = ''
    StreamFormat = sfRichText
    TabOrder = 1
    WantReturns = False
  end
  object btnCancel: TButton
    Left = 658
    Top = 582
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    Enabled = False
    ModalResult = 2
    TabOrder = 2
  end
  object tmrEnableButton: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrEnableButtonTimer
    Left = 424
    Top = 320
  end
end
