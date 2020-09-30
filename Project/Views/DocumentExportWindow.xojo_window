#tag Window
Begin BeaconDialog DocumentExportWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   600
   MinimizeButton  =   False
   MinWidth        =   848
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Export"
   Visible         =   True
   Width           =   848
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Finished"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   732
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   560
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin CodeArea ContentArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   428
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   251
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   True
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "Source Code Pro"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   111
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   "0"
      UseFocusRing    =   True
      Visible         =   True
      Width           =   597
   End
   Begin FadedSeparator TopSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   597
   End
   Begin UITweaks.ResizedPopupMenu ProfileMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin ProgressWheel RewritingSpinner
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   562
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
   Begin Label RewritingStatusLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Building config…"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   562
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   182
   End
   Begin FadedSeparator LeftSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   600
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   250
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   597
   End
   Begin Beacon.Rewriter GameIniRewriter
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter GameUserSettingsRewriter
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter FileRewriter
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter ClipboardRewriter
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin OmniBar ExportToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   50
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   61
      Transparent     =   True
      Visible         =   True
      Width           =   597
   End
   Begin FadedSeparator BottomSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   539
      Transparent     =   True
      Visible         =   True
      Width           =   597
   End
   Begin Label SettingsHeaderLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Export Settings"
      Visible         =   True
      Width           =   210
   End
   Begin Label ProfileLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Value           =   "Server:"
      Visible         =   True
      Width           =   210
   End
   Begin Label MapLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Value           =   "Map:"
      Visible         =   True
      Width           =   210
   End
   Begin UITweaks.ResizedPopupMenu MapMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin Label ConfigSetsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      Value           =   "Config Sets:"
      Visible         =   True
      Width           =   210
   End
   Begin UITweaks.ResizedPushButton ConfigSetsButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   140
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel ConfigSetsField
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   218
      Transparent     =   False
      Underline       =   False
      Value           =   "Base"
      Visible         =   True
      Width           =   210
   End
   Begin CheckBox MapOverrideCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Override Server's Map"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -128
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   "0"
      Width           =   210
   End
   Begin CheckBox ConfigSetsOverrideCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Override Server's Config Sets"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -96
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   "0"
      Width           =   210
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.ClipboardRewriter.Cancel
		  Self.FileRewriter.Cancel
		  Self.GameIniRewriter.Cancel
		  Self.GameUserSettingsRewriter.Cancel
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CanCopy(Content As String, Filename As String, Verb As String = "Copy") As Boolean
		  Var MissingHeaders() As String = Beacon.ValidateIniContent(Content, Filename)
		  Var MissingCount As Integer = MissingHeaders.Count
		  If MissingCount > 0 Then
		    Var Message As String = "This content is missing required groups. Do you want to " + Verb.Lowercase + " it anyway?"
		    Var Explanation As String = "The " + MissingHeaders.EnglishOxfordList + " " + If(MissingCount = 1, "group is", "groups are") + " missing. Ark will not start up correctly if this file is used in its current state. Use the ""Rewrite Clipboard"" or ""Update File"" buttons to have Beacon correctly update your existing ini content."
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, Verb + " Anyway", "Cancel", "Help")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Action
		      Return True
		    Case BeaconUI.ConfirmResponses.Cancel
		      Return False
		    Case BeaconUI.ConfirmResponses.Alternate
		      ShowURL(Beacon.WebURL("/help/updating_your_server_manually"))
		      Return False
		    End Select
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckButtons()
		  If Self.ExportToolbar.IndexOf("SmartCopy") = -1 Then
		    Return
		  End If
		  
		  Var ClipboardRewriting As Boolean = Self.ClipboardRewriter.ThreadState <> Thread.ThreadStates.NotRunning
		  Self.ExportToolbar.Item("SmartCopy").Enabled = Not ClipboardRewriting
		  Self.ExportToolbar.Item("SmartCopy").Caption = If(ClipboardRewriting, "Working…", "Smart Copy")
		  
		  Var FileRewriting As Boolean = Self.FileRewriter.ThreadState <> Thread.ThreadStates.NotRunning
		  Self.ExportToolbar.Item("SmartSave").Enabled = Not FileRewriting
		  Self.ExportToolbar.Item("SmartSave").Caption = If(FileRewriting, "Working…", "Smart Save")
		  
		  Self.ExportToolbar.Item("LazyCopy").Enabled = Self.ContentArea.Value <> ""
		  Self.ExportToolbar.Item("LazySave").Enabled = Self.ExportToolbar.Item("LazyCopy").Enabled And Self.CurrentMode <> ""
		  
		  Var Rewriting As Boolean = Self.IsRewriting
		  If Self.RewritingSpinner.Visible <> Rewriting Then
		    Self.RewritingSpinner.Visible = Rewriting
		    Self.RewritingStatusLabel.Visible = Rewriting
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckClipboard()
		  #if false
		    Var Mode As String = Self.CurrentMode
		    If Mode = "" Then
		      Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		      Return
		    End If
		    
		    Var Board As New Clipboard
		    If Board.TextAvailable = False Then
		      Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		      Return
		    End If
		    
		    Var SearchingFor As String
		    Select Case Mode
		    Case Beacon.RewriteModeGameIni
		      SearchingFor = "[" + Beacon.ShooterGameHeader + "]"
		    Case Beacon.RewriteModeGameUserSettingsIni
		      SearchingFor = "[" + Beacon.ServerSettingsHeader + "]"
		    Else
		      Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		      Return
		    End Select
		    
		    If Board.Text.IndexOf(SearchingFor) <= -1 Then
		      Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		      Return
		    End If
		    
		    If EncodeHex(Crypto.MD5(Board.Text)) = Self.mLastRewrittenHash Then
		      Self.SetClipboardButtonCaption(False, Self.ReadyForPaste)
		      Return
		    End If
		    
		    If Self.ClipboardRewriter.ThreadState <> Thread.ThreadStates.NotRunning Then
		      Self.SetClipboardButtonCaption(False, Self.UpdatingClipboard)
		      Return
		    End If
		    
		    Self.SetClipboardButtonCaption(True, Self.RewriteClipboard)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoCopy()
		  Var Content As String = Self.ContentArea.Value
		  If Not Self.CanCopy(Content, Self.CurrentFilename) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Board.Text = Content
		  Self.mLastRewrittenHash = EncodeHex(MD5(Board.Text))
		  
		  Self.ShowAlert(Self.CurrentFilename + " has been copied!", "You are ready to paste it wherever you need it.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSave()
		  If Not Self.CanCopy(Self.ContentArea.Value, Self.CurrentFilename, "Save") Then
		    Return
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  If Dialog.SuggestedFileName = "" Then
		    Return
		  End If
		  
		  Var File As FolderItem = Dialog.ShowModal()
		  If File = Nil Then
		    Return
		  End If
		  
		  If Not File.Write(Self.ContentArea.Value) Then
		    Self.ShowAlert("Unable to write to " + File.DisplayName, "Check file permissions and disk space.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSmartCopy()
		  Var Mode As String = Self.CurrentMode
		  If Mode.IsEmpty Then
		    Self.ShowAlert(SmartCopyUnavailableMessage, SmartCopyUnavailableExplanation)
		    Return
		  End If
		  
		  Var Filename As String = Self.CurrentFilename
		  Var Board As New Clipboard
		  If Board.TextAvailable = False Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyInstructionsMessage, Filename), Language.ReplacePlaceholders(SmartCopyInstructionsExplanation, Filename))
		    Return
		  End If
		  
		  If Self.ClipboardRewriter.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.ShowAlert(SmartCopyBusyMessage, SmartCopyBusyExplanation)
		    Return
		  End If
		  
		  Var SearchingFor As String
		  Select Case Mode
		  Case Beacon.RewriteModeGameIni
		    SearchingFor = "[" + Beacon.ShooterGameHeader + "]"
		  Case Beacon.RewriteModeGameUserSettingsIni
		    SearchingFor = "[" + Beacon.ServerSettingsHeader + "]"
		  End Select
		  
		  Var ClipboardContents As String = Board.Text
		  If ClipboardContents.IndexOf(SearchingFor) <= -1 Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyInstructionsMessage, Filename), Language.ReplacePlaceholders(SmartCopyInstructionsExplanation, Filename))
		    Return
		  End If
		  
		  If EncodeHex(Crypto.MD5(ClipboardContents)) = Self.mLastRewrittenHash Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyReadyMessage, Filename), Language.ReplacePlaceholders(SmartCopyReadyExplanation, Filename))
		    Return
		  End If
		  
		  Self.ClipboardRewriter.Rewrite(ClipboardContents, Self.CurrentMode, Self.mDocument, App.IdentityManager.CurrentIdentity, True, Self.mCurrentProfile)
		  Self.mLastRewrittenHash = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSmartSave()
		  Var Mode As String = Self.CurrentMode
		  Var RequiredHeader As String
		  Select Case Mode
		  Case Beacon.RewriteModeGameIni
		    RequiredHeader = "[" + Beacon.ShooterGameHeader + "]"
		  Case Beacon.RewriteModeGameUserSettingsIni
		    RequiredHeader = "[" + Beacon.ServerSettingsHeader + "]"
		  Else
		    Return
		  End Select
		  
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  Dialog.ActionButtonCaption = "Update"
		  
		  Var File As FolderItem = Dialog.ShowModal()
		  If File = Nil Or Not File.Exists Then
		    Return
		  End If
		  
		  Var Content As String
		  Try
		    Var InStream As TextInputStream = TextInputStream.Open(File)
		    Content = InStream.ReadAll()
		    InStream.Close
		  Catch Err As IOException
		    Self.ShowAlert("Unable to open " + File.DisplayName, "Beacon was unable to read the current content of the file to rewriting. The file has not been changed.")
		    Return
		  End Try
		  Content = Content.GuessEncoding
		  
		  If Content.IndexOf(RequiredHeader) <= -1 Then
		    Self.ShowAlert("Incorrect ini file detected.", "Beacon is expecting to find the " + RequiredHeader + " header in this file before rewriting, but cannot find it. Make sure you select the correct file config file.")
		    Return
		  End If
		  
		  Self.FileRewriter.Rewrite(Content, Self.CurrentMode, Self.mDocument, App.IdentityManager.CurrentIdentity, True, Self.mCurrentProfile)
		  Self.mFileDestination = File
		  
		  Self.CheckButtons()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsRewriting() As Boolean
		  Var Rewriters(3) As Beacon.Rewriter
		  Rewriters(0) = Self.ClipboardRewriter
		  Rewriters(1) = Self.FileRewriter
		  Rewriters(2) = Self.GameIniRewriter
		  Rewriters(3) = Self.GameUserSettingsRewriter
		  
		  For Each Rewriter As Beacon.Rewriter In Rewriters
		    If Rewriter.ThreadState <> Thread.ThreadStates.NotRunning Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Document As Beacon.Document)
		  Var Win As New DocumentExportWindow
		  Win.mDocument = Document
		  
		  Var ProfileBound As Integer = Document.ServerProfileCount - 1
		  If ProfileBound > -1 Then
		    For I As Integer = 0 To ProfileBound
		      Var Profile As Beacon.ServerProfile = Document.ServerProfile(I)
		      Win.ProfileMenu.AddRow(Profile.Name, Profile)
		    Next
		    
		    Var MapLabelTop As Integer = Win.MapLabel.Top
		    Win.MapLabel.Top = Win.MapOverrideCheck.Top
		    Win.MapOverrideCheck.Top = MapLabelTop
		    Win.MapMenu.Enabled = Not Win.MapOverrideCheck.Value
		    
		    Var ConfigLabelTop As Integer = Win.ConfigSetsLabel.Top
		    Win.ConfigSetsLabel.Top = Win.ConfigSetsOverrideCheck.Top
		    Win.ConfigSetsOverrideCheck.Top = ConfigLabelTop
		    Win.ConfigSetsField.Enabled = Not Win.ConfigSetsOverrideCheck.Value
		    Win.ConfigSetsButton.Enabled = Not Win.ConfigSetsOverrideCheck.Value
		    
		    Win.ProfileMenu.SelectedRowIndex = 0
		  Else
		    Win.ProfileMenu.SelectedRowIndex = -1
		    Win.ProfileMenu.Enabled = False
		    Win.ProfileLabel.Enabled = False
		  End If
		  
		  Var Maps() As Beacon.Map = Document.Maps
		  If Maps.LastRowIndex = 0 Then
		    Win.MapMenu.AddRow(Maps(0).Name, Maps(0).Mask)
		    Win.MapMenu.SelectedRowIndex = 0
		  ElseIf Maps.LastRowIndex > 0 Then
		    Win.MapMenu.AddRow("All Maps", Beacon.Maps.All.Mask)
		    For Each Map As Beacon.Map In Maps
		      Win.MapMenu.AddRow(Map.Name, Map.Mask)
		    Next
		    Win.MapMenu.SelectedRowIndex = 0
		  End If
		  
		  Win.UpdateConfigSetControls()
		  
		  Win.Setup()
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea()
		  Var IntendedContent As String
		  Select Case Self.Switcher.SelectedIndex
		  Case 1
		    IntendedContent = Self.mGameUserSettingsContent
		  Case 2
		    IntendedContent = Self.mGameIniContent
		  Case 3
		    IntendedContent = Self.mCommandLineContent
		  End Select
		  If Self.ContentArea.Value <> IntendedContent Then
		    Self.ContentArea.Value = IntendedContent
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetClipboardButtonCaption(Enabled As Boolean, Caption As String)
		  If Self.ExportToolbar = Nil Then
		    Return
		  End If
		  
		  If Self.ExportToolbar.Item("SmartCopy").Enabled <> Enabled Then
		    Self.ExportToolbar.Item("SmartCopy").Enabled = Enabled
		  End If
		  If Self.ExportToolbar.Item("SmartCopy").Caption <> Caption Then
		    Self.ExportToolbar.Item("SmartCopy").Caption = Caption
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Setup()
		  If Self.mDocument = Nil Or Self.GameIniRewriter.ThreadState <> Thread.ThreadStates.NotRunning Or Self.GameUserSettingsRewriter.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Var Profile As Beacon.ServerProfile
		  If Self.ProfileMenu.SelectedRowIndex > -1 Then
		    Profile = Beacon.ServerProfile(Self.ProfileMenu.RowTagAt(Self.ProfileMenu.SelectedRowIndex)).Clone // We need to work on a copy
		    
		    If Self.MapOverrideCheck.Value And Self.MapMenu.SelectedRowIndex > -1 Then
		      Profile.Mask = Self.MapMenu.RowTagAt(Self.MapMenu.SelectedRowIndex)
		    End If
		    
		    If Self.ConfigSetsOverrideCheck.Value Then
		      Profile.ConfigSetStates = Self.mDocument.ConfigSetStates
		    End If
		  ElseIf Self.MapMenu.SelectedRowIndex > -1 Then
		    Profile = New Beacon.GenericServerProfile(Self.mDocument.Title, Self.MapMenu.RowTagAt(Self.MapMenu.SelectedRowIndex))
		    Profile.ConfigSetStates = Self.mDocument.ConfigSetStates
		  Else
		    Return
		  End If
		  Self.mCurrentProfile = Profile
		  
		  Self.mGameIniContent = ""
		  Self.mGameUserSettingsContent = ""
		  Self.mCommandLineContent = ""
		  Self.mLastRewrittenHash = ""
		  
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  
		  Self.GameIniRewriter.Rewrite("", Beacon.RewriteModeGameIni, Self.mDocument, Identity, False, Self.mCurrentProfile)
		  Self.GameUserSettingsRewriter.Rewrite("", Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Identity, False, Self.mCurrentProfile)
		  
		  Var CLIDict As New Dictionary
		  Var Groups() As Beacon.ConfigGroup = Self.mDocument.ImplementedConfigs
		  For Each Group As Beacon.ConfigGroup In Groups
		    Var Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self.mDocument, Identity, Self.mCurrentProfile)
		    If Options <> Nil And Options.LastRowIndex > -1 Then
		      Beacon.ConfigValue.FillConfigDict(CLIDict, Options)
		    End If
		  Next
		  Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Self.mCurrentProfile.Mask)
		  Var QuestionParameters As String
		  If Maps.LastRowIndex = 0 Then
		    QuestionParameters = Maps(0).Identifier + "?listen"
		  Else
		    QuestionParameters = "Map?listen"
		  End If
		  If CLIDict.HasKey("?") Then
		    Var Dict As Dictionary = CLIDict.Value("?")
		    Var Keys() As Variant = Dict.Keys
		    For Each Key As Variant In Keys
		      Var Arr() As String = Dict.Value(Key)
		      QuestionParameters = QuestionParameters + "?" + Arr.Join("?")
		    Next
		  End If
		  Var Parameters(0) As String
		  Parameters(0) = """" + QuestionParameters + """"
		  If CLIDict.HasKey("-") Then
		    Var Dict As Dictionary = CLIDict.Value("-")
		    Var Keys() As Variant = Dict.Keys
		    For Each Key As Variant In Keys
		      Var Arr() As String = Dict.Value(Key)
		      For Each Command As String In Arr
		        Parameters.AddRow("-" + Command)
		      Next
		    Next
		  End If
		  Self.mCommandLineContent = Parameters.Join(" ")
		  
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateConfigSetControls()
		  If Self.mDocument.ConfigSetCount > 1 Then
		    Var States() As Beacon.ConfigSetState = Self.mDocument.ConfigSetStates
		    Var EnabledSets() As String
		    For Each State As Beacon.ConfigSetState In States
		      If State.Enabled Then
		        EnabledSets.AddRow(State.Name)
		      End If
		    Next
		    
		    Self.ConfigSetsField.Value = EnabledSets.EnglishOxfordList()
		  Else
		    Self.ConfigSetsField.Value = Beacon.Document.BaseConfigSetName
		    Self.ConfigSetsField.Enabled = False
		    Self.ConfigSetsButton.Enabled = False
		    Self.ConfigSetsLabel.Enabled = False
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.ReplaceLineEndings(EndOfLine)
			  If Self.mCurrentContent <> Value Then
			    Self.mCurrentContent = Value
			    Self.ContentArea.Value = Value
			    Self.CheckClipboard()
			  End If
			End Set
		#tag EndSetter
		CurrentContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Select Case Self.Switcher.SelectedIndex
			  Case 1
			    Return "GameUserSettings.ini"
			  Case 2
			    Return "Game.ini"
			  Else
			    Return ""
			  End Select
			End Get
		#tag EndGetter
		Private CurrentFilename As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var Mask As UInt64
			  If Self.ProfileMenu.SelectedRowIndex = -1 Then
			    Mask = Beacon.Maps.All.Mask
			  Else
			    Mask = Beacon.ServerProfile(Self.ProfileMenu.RowTagAt(Self.ProfileMenu.SelectedRowIndex)).Mask
			  End If
			  Return Mask
			End Get
		#tag EndGetter
		Private CurrentMask As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Self.Switcher = Nil Then
			    Return ""
			  End If
			  
			  Select Case Self.Switcher.SelectedIndex
			  Case 1
			    Return Beacon.RewriteModeGameUserSettingsIni
			  Case 2
			    Return Beacon.RewriteModeGameIni
			  End Select
			End Get
		#tag EndGetter
		Private CurrentMode As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCommandLineContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileDestination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRewrittenHash As String
	#tag EndProperty


	#tag Constant, Name = ReadyForPaste, Type = String, Dynamic = False, Default = \"Ready for Paste!", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RewriteClipboard, Type = String, Dynamic = False, Default = \"Rewrite Clipboard", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyBusyExplanation, Type = String, Dynamic = False, Default = \"Smart Copy is not available while the \"Building Config\" message appears in the bottom left corner of the window.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyBusyMessage, Type = String, Dynamic = False, Default = \"Please wait a moment before using Smart Copy.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyErrorExplanation, Type = String, Dynamic = False, Default = \"Smart Copy was unable to prepare your \?1 file. No changes have been made.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyErrorMessage, Type = String, Dynamic = False, Default = \"Smart Copy encountered an error.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyInstructionsExplanation, Type = String, Dynamic = False, Default = \"Once you have copied your \?1 contents\x2C return here and press the Smart Copy button again.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyInstructionsMessage, Type = String, Dynamic = False, Default = \"To use Smart Copy\x2C first copy your entire \?1 file.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyReadyExplanation, Type = String, Dynamic = False, Default = \"You are now ready to paste your \?1 content wherever you need it.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyReadyMessage, Type = String, Dynamic = False, Default = \"Your \?1 content has been copied.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyUnavailableExplanation, Type = String, Dynamic = False, Default = \"Smart Copy can only be used with Game.ini and GameUserSettings.ini content.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyUnavailableMessage, Type = String, Dynamic = False, Default = \"Smart Copy is not available for this content.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UpdatingClipboard, Type = String, Dynamic = False, Default = \"Working\xE2\x80\xA6", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentArea
	#tag Event
		Function ShouldCopy() As Boolean
		  If Me.SelectionLength <> Me.Value.Length Then
		    Return True
		  End If
		  
		  Var Content As String = Me.Value
		  Return Self.CanCopy(Content, Self.CurrentFilename)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ProfileMenu
	#tag Event
		Sub Change()
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(IconCommandLine, "Command Line", "cli")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameIniRewriter
	#tag Event
		Sub Finished()
		  If Not Me.Errored Then
		    Self.mGameIniContent = Me.UpdatedContent
		  End If
		  
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameUserSettingsRewriter
	#tag Event
		Sub Finished()
		  If Not Me.Errored Then
		    Self.mGameUserSettingsContent = Me.UpdatedContent
		  End If
		  
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FileRewriter
	#tag Event
		Sub Finished()
		  Var Errored As Boolean
		  If Me.Errored = False And (Self.mFileDestination Is Nil) = False Then
		    If Self.CanCopy(Me.UpdatedContent, Me.Mode, "Save") Then
		      If Self.mFileDestination.Write(Me.UpdatedContent) = False Then
		        Errored = True
		      End If
		    End If
		  Else
		    Errored = True
		  End If
		  If Errored Then
		    Self.ShowAlert("Unable to update file", "There was an error trying to rewrite the ini content in the selected file.")
		  End If
		  
		  Self.mFileDestination = Nil
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardRewriter
	#tag Event
		Sub Finished()
		  If Me.Errored Then
		    Self.CheckButtons()
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyErrorMessage, Me.Mode), Language.ReplacePlaceholders(SmartCopyErrorExplanation, Me.Mode))
		    Return
		  End If
		  
		  If Not Self.CanCopy(Me.UpdatedContent, Me.Mode) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Board.Text = Me.UpdatedContent
		  
		  Self.mLastRewrittenHash = EncodeHex(Crypto.MD5(Me.UpdatedContent))
		  Self.CheckButtons()
		  Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyReadyMessage, Me.Mode), Language.ReplacePlaceholders(SmartCopyReadyExplanation, Me.Mode))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ExportToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("SmartCopy", "Smart Copy", IconToolbarSmartCopy, "Uses your copied ini file to correctly copy the updated version."))
		  Me.Append(OmniBarItem.CreateButton("SmartSave", "Smart Save", IconToolbarSmartSaveToDisk, "Allows you to select a file on your computer which Beacon will update with the latest changes."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("LazyCopy", "Copy", IconToolbarCopy, "Copies the current ini content to your clipboard."))
		  Me.Append(OmniBarItem.CreateButton("LazySave", "Save", IconToolbarSaveToDisk, "Saves the current ini content to your computer."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "SmartCopy"
		    Self.DoSmartCopy()
		  Case "SmartSave"
		    Self.DoSmartSave()
		  Case "LazyCopy"
		    Self.DoCopy()
		  Case "LazySave"
		    Self.DoSave()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapMenu
	#tag Event
		Sub Change()
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetsButton
	#tag Event
		Sub Action()
		  Self.mDocument.ConfigSetStates = ConfigSetSelectorDialog.Present(Self, Self.mDocument.ConfigSetStates)
		  Self.UpdateConfigSetControls()
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapOverrideCheck
	#tag Event
		Sub Action()
		  Self.MapMenu.Enabled = Me.Value
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetsOverrideCheck
	#tag Event
		Sub Action()
		  Self.ConfigSetsField.Enabled = Me.Value
		  Self.ConfigSetsButton.Enabled = Me.Value
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentContent"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
