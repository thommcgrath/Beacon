#tag Window
Begin BeaconDialog DocumentExportWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   DefaultLocation =   "1"
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   675
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinimumHeight   =   400
   MinimumWidth    =   848
   MinWidth        =   848
   Placement       =   1
   Resizable       =   True
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Export"
   Type            =   "8"
   Visible         =   True
   Width           =   900
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Finished"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin CodeArea ContentArea
      AcceptTabs      =   False
      Alignment       =   "0"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowStyledText =   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "Source Code Pro"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
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
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      TextFont        =   "Source Code Pro"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   900
   End
   Begin UITweaks.ResizedPushButton SaveButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Save As…"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin ReactionButton CopyButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Copy All"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin UITweaks.ResizedPushButton RewriteClipboardButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Update Clipboard"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   140
   End
   Begin Timer ClipboardWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   "2"
      Period          =   1000
      RunMode         =   "2"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedPushButton RewriteFileButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Update File…"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin FadedSeparator TopSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
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
      Tooltip         =   ""
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   900
   End
   Begin PopupMenu MapMenu
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      SelectedRowIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin ProgressWheel RewritingSpinner
      AllowAutoDeactivate=   True
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
      Tooltip         =   ""
      Top             =   22
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
   Begin Label RewritingStatusLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   22
      Transparent     =   False
      Underline       =   False
      Value           =   "Building config…"
      Visible         =   False
      Width           =   161
   End
   Begin FadedSeparator BottomSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
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
      Tooltip         =   ""
      Top             =   614
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   900
   End
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
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
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   442
   End
   Begin Beacon.Rewriter GameIniRewriter
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter GameUserSettingsRewriter
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter FileRewriter
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Rewriter ClipboardRewriter
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Self.ClipboardRewriter.Cancel
		  Self.FileRewriter.Cancel
		  Self.GameIniRewriter.Cancel
		  Self.GameUserSettingsRewriter.Cancel
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckButtons()
		  Dim Rewriting As Boolean = Self.IsRewriting
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
		  Dim Mode As String = Self.CurrentMode
		  If Mode = "" Then
		    Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		    Return
		  End If
		  
		  Dim Board As New Clipboard
		  If Board.TextAvailable = False Then
		    Self.SetClipboardButtonCaption(False, Self.RewriteClipboard)
		    Return
		  End If
		  
		  Dim SearchingFor As String
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
		  Dim Rewriters(3) As Beacon.Rewriter
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
		  Dim Win As New DocumentExportWindow
		  Win.mDocument = Document
		  
		  Dim Maps() As Beacon.Map = Document.Maps
		  If Maps.LastRowIndex = 0 Then
		    Win.MapMenu.AddRow(Maps(0).Name, Maps(0).Mask)
		  ElseIf Maps.LastRowIndex > 0 Then
		    Win.MapMenu.AddRow("All Maps", Beacon.Maps.All.Mask)
		    For Each Map As Beacon.Map In Maps
		      Win.MapMenu.AddRow(Map.Name, Map.Mask)
		    Next
		  End If
		  If Win.MapMenu.RowCount > 0 Then
		    Win.MapMenu.SelectedRowIndex = 0
		  End If
		  
		  Win.Setup()
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea()
		  Dim IntendedContent As String
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
		  Self.mCurrentProfile = New Beacon.GenericServerProfile(Self.mDocument.Title, Self.CurrentMask)
		  
		  Dim Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  
		  Self.GameIniRewriter.Rewrite("", Beacon.RewriteModeGameIni, Self.mDocument, Identity, False, Self.mCurrentProfile)
		  Self.GameUserSettingsRewriter.Rewrite("", Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Identity, False, Self.mCurrentProfile)
		  
		  Dim CLIDict As New Dictionary
		  Dim Groups() As Beacon.ConfigGroup = Self.mDocument.ImplementedConfigs
		  For Each Group As Beacon.ConfigGroup In Groups
		    Dim Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self.mDocument, Identity, Self.mCurrentProfile)
		    If Options <> Nil And Options.LastRowIndex > -1 Then
		      Beacon.ConfigValue.FillConfigDict(CLIDict, Options)
		    End If
		  Next
		  Dim Maps() As Beacon.Map = Beacon.Maps.ForMask(Self.mCurrentProfile.Mask)
		  Dim QuestionParameters As String
		  If Maps.LastRowIndex = 0 Then
		    QuestionParameters = Maps(0).Identifier + "?listen"
		  Else
		    QuestionParameters = "Map?listen"
		  End If
		  If CLIDict.HasKey("?") Then
		    Dim Dict As Dictionary = CLIDict.Value("?")
		    Dim Keys() As Variant = Dict.Keys
		    For Each Key As Variant In Keys
		      Dim Arr() As String = Dict.Value(Key)
		      QuestionParameters = QuestionParameters + "?" + Arr.Join("?")
		    Next
		  End If
		  Dim Parameters(0) As String
		  Parameters(0) = """" + QuestionParameters + """"
		  If CLIDict.HasKey("-") Then
		    Dim Dict As Dictionary = CLIDict.Value("-")
		    Dim Keys() As Variant = Dict.Keys
		    For Each Key As Variant In Keys
		      Dim Arr() As String = Dict.Value(Key)
		      For Each Command As String In Arr
		        Parameters.Append("-" + Command)
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
			  Value = ReplaceLineEndings(Value, EndOfLine)
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
			  Dim Mask As UInt64
			  If Self.MapMenu.SelectedRowIndex = -1 Then
			    Mask = Beacon.Maps.All.Mask
			  Else
			    Mask = Self.MapMenu.RowTag(Self.MapMenu.SelectedRowIndex)
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
		Private mCurrentProfile As Beacon.GenericServerProfile
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
		Sub Pressed()
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveButton
	#tag Event
		Sub Pressed()
		  Dim Dialog As New SaveFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  If Dialog.SuggestedFileName = "" Then
		    Return
		  End If
		  
		  Dim File As FolderItem = Dialog.ShowModal()
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
		Sub Pressed()
		  Dim Board As New Clipboard
		  Board.Text = Self.ContentArea.Value
		  Self.mLastRewrittenHash = EncodeHex(MD5(Board.Text))
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RewriteClipboardButton
	#tag Event
		Sub Pressed()
		  Dim Board As New Clipboard
		  Self.ClipboardRewriter.Rewrite(Board.Text, Self.CurrentMode, Self.mDocument, App.IdentityManager.CurrentIdentity, True, Self.mCurrentProfile)
		  
		  Self.mLastRewrittenHash = ""
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardWatcher
	#tag Event
		Sub Run()
		  Self.CheckClipboard()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RewriteFileButton
	#tag Event
		Sub Pressed()
		  Dim Mode As String = Self.CurrentMode
		  Dim RequiredHeader As String
		  Select Case Mode
		  Case Beacon.RewriteModeGameIni
		    RequiredHeader = "[" + Beacon.ShooterGameHeader + "]"
		  Case Beacon.RewriteModeGameUserSettingsIni
		    RequiredHeader = "[" + Beacon.ServerSettingsHeader + "]"
		  Else
		    Return
		  End Select
		  
		  Dim Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  Dialog.ActionButtonCaption = "Update"
		  
		  Dim File As FolderItem = Dialog.ShowModal()
		  If File = Nil Or Not File.Exists Then
		    Return
		  End If
		  
		  Dim Content As String
		  Try
		    Dim InStream As TextInputStream = TextInputStream.Open(File)
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
#tag Events MapMenu
	#tag Event
		Sub SelectionChanged()
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(IconCommandLine, "Command Line", "cli")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
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
		  If Me.Errored = True Or Self.mFileDestination = Nil Or Self.mFileDestination.Write(Me.UpdatedContent) = False Then
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
		  
		  Dim Board As New Clipboard
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
#tag ViewBehavior
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType="MenuBar"
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
