#tag Window
Begin DiscoveryView LocalDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   396
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   600
   Begin Label SetupMessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Simple Config Import"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   6
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin CodeArea ConfigArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   193
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
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
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   True
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "Source Code Pro"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   151
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Next"
      Default         =   True
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ChooseFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select File"
      Default         =   False
      Enabled         =   True
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   93
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
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   28
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   600
   End
   Begin FadedSeparator FadedSeparator1
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   88
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   600
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   38
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Paste the contents of your Game.ini and/or GameUserSettings.ini files here. Only one file is required, but Beacon can do a better job with both files."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   101
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin ClipboardWatcher Watcher
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   500
      Scope           =   2
      TabPanelIndex   =   0
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
      Left            =   151
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   214
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 400
		  Self.ConfigArea.Value = ""
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.AcceptFileDrop(BeaconFileTypes.IniFile)
		  Self.ConfigArea.AcceptFileDrop(BeaconFileTypes.IniFile)
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Const NaturalMenuWidth = 200
		  
		  Var MinLeft As Integer = Self.ChooseFileButton.Left + Self.ChooseFileButton.Width + 12
		  Var MaxWidth As Integer = Self.CancelButton.Left - (MinLeft + 12)
		  Var MenuWidth As Integer = Min(NaturalMenuWidth, MaxWidth)
		  
		  Self.MapMenu.Width = MenuWidth
		  Self.MapMenu.Left = MinLeft + ((MaxWidth - MenuWidth) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem)
		  Self.AddFile(File, ConfigFileType.Other)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddFile(File As FolderItem, ForceType As ConfigFileType)
		  Var Content As String = Self.ReadIniFile(File).Trim
		  If Content = "" Then
		    Return
		  End If
		  
		  Content  = Content.DefineEncoding(Encodings.UTF8)
		  
		  Var Type As ConfigFileType = ForceType
		  If Type = ConfigFileType.Other Then
		    Type = Self.DetectConfigType(Content)
		    If Type = ConfigFileType.Other Then
		      Select Case Self.Switcher.SelectedIndex
		      Case Self.GameIniIndex
		        Type = ConfigFileType.GameIni
		      Case Self.GameUserSettingsIniIndex
		        Type = ConfigFileType.GameUserSettingsIni
		      End Select
		    End If
		  End If
		  
		  Var ExistingContent As String
		  Select Case Type
		  Case ConfigFileType.GameIni
		    ExistingContent = Self.mGameIniContent
		  Case ConfigFileType.GameUserSettingsIni
		    ExistingContent = Self.mGameUserSettingsIniContent
		  End Select
		  
		  If ExistingContent.IsEmpty = False Then
		    Var Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Would you like to replace the existing content, or add this file to it?"
		    Select Case Type
		    Case ConfigFileType.GameIni
		      Dialog.Explanation = "The selected file would replace or become added to your Game.ini content."
		    Case ConfigFileType.GameUserSettingsIni
		      Dialog.Explanation = "The selected file would replace or become added to your GameUserSettings.ini content."
		    End Select
		    Dialog.ActionButton.Caption = "Replace"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Caption = "Add To"
		    Dialog.AlternateActionButton.Visible = True
		    Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    
		    Select Case Choice
		    Case Dialog.ActionButton
		      // Do nothing
		    Case Dialog.CancelButton
		      Return
		    Case Dialog.AlternateActionButton
		      Content = ExistingContent.Trim + EndOfLine + EndOfLine + Content
		    End Select
		  End If
		  
		  Var OtherFilename, OtherContent As String
		  Var OtherType As ConfigFileType
		  Select Case Type
		  Case ConfigFileType.GameIni
		    Self.mGameIniFile = File
		    Self.mGameIniContent = Content
		    OtherFilename = "GameUserSettings.ini"
		    OtherContent = Self.mGameUserSettingsIniContent
		    OtherType = ConfigFileType.GameUserSettingsIni
		  Case ConfigFileType.GameUserSettingsIni
		    Self.mGameUserSettingsIniFile = File
		    Self.mGameUserSettingsIniContent = Content
		    OtherFilename = "Game.ini"
		    OtherContent = Self.mGameIniContent
		    OtherType = ConfigFileType.GameIni
		  End Select
		  
		  If OtherContent.IsEmpty = False Then
		    Self.RefreshContentArea(True)
		    Return
		  End If
		  
		  Var OtherFile As FolderItem = File.Parent.Child(OtherFilename)
		  If OtherFile <> Nil And OtherFile.Exists Then
		    Self.AddFile(OtherFile, OtherType)
		  End If
		  
		  Self.RefreshContentArea(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(Content As String, File As FolderItem = Nil) As ConfigFileType
		  Var GameIniPos As Integer = Content.IndexOf(Beacon.ShooterGameHeader)
		  Var SettingsIniPos As Integer = Content.IndexOf(Beacon.ServerSettingsHeader)
		  
		  If GameIniPos > -1 And SettingsIniPos = -1 Then
		    Return ConfigFileType.GameIni
		  ElseIf SettingsIniPos > -1 And GameIniPos = -1 Then
		    Return ConfigFileType.GameUserSettingsIni
		  ElseIf File <> Nil Then
		    Select Case File.Name
		    Case "Game.ini"
		      Return ConfigFileType.GameIni
		    Case "GameUserSettings.ini"
		      Return ConfigFileType.GameUserSettingsIni
		    End Select
		  End If
		  
		  Return ConfigFileType.Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDrop(Obj As DragItem)
		  Do
		    If Obj.FolderItemAvailable Then
		      Self.AddFile(Obj.FolderItem)
		    End If
		  Loop Until Not Obj.NextItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadIniFile(File As FolderItem, Prompt As Boolean = True) As String
		  Try
		    #Pragma BreakOnExceptions False
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    #Pragma BreakOnExceptions Default
		    Var Contents As String = Stream.ReadAll()
		    Stream.Close
		    
		    Contents = Contents.GuessEncoding
		    
		    Return Contents
		  Catch Err As IOException
		    #Pragma BreakOnExceptions Default
		    If Prompt = False Or TargetMacOS = False Then
		      Return ""
		    End If
		    
		    Var Dialog As New OpenFileDialog
		    Dialog.InitialFolder = File.Parent
		    Dialog.SuggestedFileName = File.Name
		    Dialog.PromptText = "Select your " + File.Name + " file if you want to import it too"
		    Dialog.ActionButtonCaption = "Import"
		    Dialog.Filter = BeaconFileTypes.IniFile
		    
		    Var Selected As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If Selected = Nil Then
		      Return ""
		    End If
		    
		    Return Self.ReadIniFile(Selected, False)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea(ChangeIfEmpty As Boolean = False)
		  Var SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  Select Case Self.Switcher.SelectedIndex
		  Case Self.GameIniIndex
		    If ChangeIfEmpty And Self.mGameIniContent.IsEmpty And Self.mGameUserSettingsIniContent.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.GameUserSettingsIniIndex
		    Else
		      Self.ConfigArea.Value = Self.mGameIniContent
		    End If
		  Case Self.GameUserSettingsIniIndex
		    If ChangeIfEmpty And Self.mGameIniContent.IsEmpty = False And Self.mGameUserSettingsIniContent.IsEmpty Then
		      Self.Switcher.SelectedIndex = Self.GameIniIndex
		    Else
		      Self.ConfigArea.Value = Self.mGameUserSettingsIniContent
		    End If
		  Else
		    Self.ConfigArea.Value = ""
		  End Select
		  Self.mSettingUp = SettingUp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSwitcherForType(Type As ConfigFileType)
		  If Type = ConfigFileType.GameIni And Self.Switcher.SelectedIndex <> Self.GameIniIndex Then
		    Self.Switcher.SelectedIndex = Self.GameIniIndex
		  ElseIf Type = ConfigFileType.GameUserSettingsIni And Self.Switcher.SelectedIndex <> Self.GameUserSettingsIniIndex Then
		    Self.Switcher.SelectedIndex = Self.GameUserSettingsIniIndex
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = GameIniIndex, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GameUserSettingsIniIndex, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ConfigFileType, Flags = &h21
		Other
		  GameIni
		GameUserSettingsIni
	#tag EndEnum


#tag EndWindowCode

#tag Events ConfigArea
	#tag Event
		Sub TextChange()
		  If Not Self.mSettingUp Then
		    Select Case Self.Switcher.SelectedIndex
		    Case Self.GameIniIndex
		      Self.mGameIniContent = Me.Value.Trim
		    Case Self.GameUserSettingsIniIndex
		      Self.mGameUserSettingsIniContent = Me.Value.Trim
		    End Select
		  End If
		  
		  Self.ActionButton.Enabled = (Self.mGameIniContent.IsEmpty Or Self.mGameUserSettingsIniContent.IsEmpty) = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var Profile As New Beacon.LocalServerProfile
		  Profile.Mask = Self.MapMenu.RowTagAt(Self.MapMenu.SelectedRowIndex)
		  If Self.mGameIniFile <> Nil And Self.mGameUserSettingsIniFile <> Nil Then
		    Profile.GameIniFile = New BookmarkedFolderItem(Self.mGameIniFile.NativePath, FolderItem.PathModes.Native)
		    Profile.GameUserSettingsIniFile = New BookmarkedFolderItem(Self.mGameUserSettingsIniFile.NativePath, FolderItem.PathModes.Native)
		  End If
		  
		  Var Data As New Beacon.DiscoveredData
		  Data.Profile = Profile
		  Data.GameIniContent = Self.mGameIniContent
		  Data.GameUserSettingsIniContent = Self.mGameUserSettingsIniContent
		  
		  Self.ShouldFinish(Data)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseFileButton
	#tag Event
		Sub Action()
		  If Self.mGameIniContent.Length > 0 And Self.mGameUserSettingsIniContent.Length > 0 And Self.ShowConfirm("Both files are already selected", "You can select another file if you really want to, but both Game.ini and GameUserSettings.ini files are already present.", "Add Another", "Cancel") = False Then
		    Return
		  End If
		  
		  Var Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = If(Self.mGameIniContent.Length > 0, "GameUserSettings.ini", "Game.ini")
		  Dialog.Filter = BeaconFileTypes.IniFile
		  
		  Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    Self.AddFile(File)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.GameUserSettingsIniIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.RefreshContentArea(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Var Type As ConfigFileType = Self.DetectConfigType(Content)
		  Self.SetSwitcherForType(Type)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapMenu
	#tag Event
		Sub Open()
		  Var Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    Me.AddRow(Map.Name, Map.Mask)
		  Next
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
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
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
