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
   Height          =   675
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   848
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Export"
   Visible         =   True
   Width           =   900
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
      Left            =   784
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
      Top             =   635
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
      Height          =   553
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
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
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   "0"
      UseFocusRing    =   True
      Visible         =   True
      Width           =   900
   End
   Begin UITweaks.ResizedPushButton SaveButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Save As…"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   128
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin ReactionButton CopyButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Copy All"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin UITweaks.ResizedPushButton RewriteClipboardButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Update Clipboard"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   358
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   140
   End
   Begin Timer ClipboardWatcher
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   1000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedPushButton RewriteFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Update File…"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   236
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
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
      Left            =   0
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
      Width           =   900
   End
   Begin PopupMenu ProfileMenu
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
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin ProgressWheel RewritingSpinner
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   864
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   22
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
      Left            =   691
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Building config…"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   22
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   161
   End
   Begin FadedSeparator BottomSeparator
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
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   614
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   900
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
      Left            =   229
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
      Width           =   442
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
   Begin UITweaks.ResizedPushButton ConfigSetTestButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Config Sets"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   510
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   98
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
		  Var Rewriting As Boolean = Self.IsRewriting
		  Self.RewriteFileButton.Enabled = Rewriting = False And (Self.Switcher.SelectedIndex = 1 Or Self.Switcher.SelectedIndex = 2)
		  Self.CopyButton.Enabled = Rewriting = False And Self.ContentArea.Value <> ""
		  Self.SaveButton.Enabled = Self.CopyButton.Enabled And Self.CurrentMode <> ""
		  
		  If Self.RewritingSpinner.Visible <> Rewriting Then
		    Self.RewritingSpinner.Visible = Rewriting
		    Self.RewritingStatusLabel.Visible = Rewriting
		  End If
		  
		  Self.CheckClipboard()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckClipboard()
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
		    #if TargetMacOS
		      Win.ProfileMenu.AddSeparator
		    #endif
		  End If
		  
		  Var Maps() As Beacon.Map = Document.Maps
		  If Maps.LastRowIndex = 0 Then
		    Win.ProfileMenu.AddRow(Maps(0).Name, New Beacon.GenericServerProfile(Maps(0).Name, Maps(0).Mask))
		  ElseIf Maps.LastRowIndex > 0 Then
		    Win.ProfileMenu.AddRow("All Maps", New Beacon.GenericServerProfile("All Maps", Beacon.Maps.All.Mask))
		    For Each Map As Beacon.Map In Maps
		      Win.ProfileMenu.AddRow(Map.Name, New Beacon.GenericServerProfile(Map.Name, Map.Mask))
		    Next
		  End If
		  
		  If Win.ProfileMenu.RowCount > 0 Then
		    Win.ProfileMenu.SelectedRowIndex = 0
		  End If
		  
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
		  If Self.RewriteClipboardButton = Nil Then
		    Return
		  End If
		  
		  If Self.RewriteClipboardButton.Enabled <> Enabled Then
		    Self.RewriteClipboardButton.Enabled = Enabled
		  End If
		  If Self.RewriteClipboardButton.Caption <> Caption Then
		    Self.RewriteClipboardButton.Caption = Caption
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Setup()
		  If Self.mDocument = Nil Or Self.GameIniRewriter.ThreadState <> Thread.ThreadStates.NotRunning Or Self.GameUserSettingsRewriter.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Self.mGameIniContent = ""
		  Self.mGameUserSettingsContent = ""
		  Self.mCommandLineContent = ""
		  Self.mLastRewrittenHash = ""
		  If Self.ProfileMenu.SelectedRowIndex = -1 Then
		    Self.mCurrentProfile = New Beacon.GenericServerProfile(Self.mDocument.Title, Beacon.Maps.All.Mask)
		  Else
		    Self.mCurrentProfile = Self.ProfileMenu.RowTagAt(Self.ProfileMenu.SelectedRowIndex)
		  End If
		  
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
#tag Events SaveButton
	#tag Event
		Sub Action()
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
	#tag EndEvent
#tag EndEvents
#tag Events CopyButton
	#tag Event
		Sub Action()
		  Var Content As String = Self.ContentArea.Value
		  If Not Self.CanCopy(Content, Self.CurrentFilename) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Board.Text = Content
		  Self.mLastRewrittenHash = EncodeHex(MD5(Board.Text))
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RewriteClipboardButton
	#tag Event
		Sub Action()
		  Var Board As New Clipboard
		  Self.ClipboardRewriter.Rewrite(Board.Text, Self.CurrentMode, Self.mDocument, App.IdentityManager.CurrentIdentity, True, Self.mCurrentProfile)
		  
		  Self.mLastRewrittenHash = ""
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardWatcher
	#tag Event
		Sub Action()
		  Self.CheckClipboard()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RewriteFileButton
	#tag Event
		Sub Action()
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
		    Self.ShowAlert("Unable to update clipboard", "There was an error trying to rewrite the ini content on the clipboard.")
		    Return
		  End If
		  
		  If Not Self.CanCopy(Me.UpdatedContent, Me.Mode) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Board.Text = Me.UpdatedContent
		  
		  Self.mLastRewrittenHash = EncodeHex(Crypto.MD5(Me.UpdatedContent))
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetTestButton
	#tag Event
		Sub Action()
		  Self.mDocument.ConfigSetStates = ConfigSetSelectorDialog.Present(Self, Self.mDocument.ConfigSetStates)
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
