#tag Window
Begin DiscoveryView LocalDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      ScrollbarHorizontal=   False
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
      ButtonStyle     =   "0"
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
      ButtonStyle     =   "0"
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
      ButtonStyle     =   "0"
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
      EraseBackground =   False
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
      Scope           =   0
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
      EraseBackground =   True
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
      Scope           =   0
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 400
		  Self.ConfigArea.Text = ""
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


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem, DetectSibling As Boolean = True)
		  Dim Content As String = Self.ReadIniFile(File)
		  If Content = "" Then
		    Return
		  End If
		  
		  Content  = Content.DefineEncoding(Encodings.UTF8)
		  Dim Type As ConfigFileType = Self.DetectConfigType(Content)
		  Self.SetSwitcherForType(Type)
		  
		  If Self.ConfigArea.Text.Len <> 0 Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Would you like to replace the existing content, or add this file to it?"
		    Select Case Type
		    Case ConfigFileType.GameIni
		      Dialog.Explanation = "The selected file would replace or become added to your Game.ini content."
		    Case ConfigFileType.GameUserSettingsIni
		      Dialog.Explanation = "The selected file would replace or become added to your GameUserSettings.ini content."
		    Case ConfigFileType.Other
		      Dialog.Explanation = "Beacon was unable to determine which config file was selected."
		    End Select
		    Dialog.ActionButton.Caption = "Replace"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Caption = "Add To"
		    Dialog.AlternateActionButton.Visible = True
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    
		    Select Case Choice
		    Case Dialog.ActionButton
		      Self.ConfigArea.Text = Content.Trim
		    Case Dialog.CancelButton
		      Return
		    Case Dialog.AlternateActionButton
		      Self.ConfigArea.Text = Self.ConfigArea.Text + EndOfLine + Content.Trim
		    End Select
		  Else
		    Self.ConfigArea.Text = Content.Trim
		  End If
		  
		  If Not DetectSibling Then
		    Return
		  End If
		  
		  Dim OtherFilename As String
		  Select Case Type
		  Case ConfigFileType.GameIni
		    OtherFilename = "GameUserSettings.ini"
		  Case ConfigFileType.GameUserSettingsIni
		    OtherFilename = "Game.ini"
		  Else
		    Return
		  End Select
		  
		  Dim OtherFile As FolderItem = File.Parent.Child(OtherFilename)
		  If OtherFile <> Nil And OtherFile.Exists Then
		    Self.AddFile(OtherFile, False)
		  End If
		  
		  #if false
		    If Self.mCurrentConfigType <> ConfigFileType.Combo Then
		      Dim Other As FolderItem
		      Dim Type As ConfigFileType = Self.DetectConfigType(Content)
		      Select Case Type
		      Case ConfigFileType.GameIni    
		        Self.mGameIniFile = File
		        If Self.mCurrentConfigType <> ConfigFileType.GameUserSettingsIni Then
		          Other = File.Parent.Child("GameUserSettings.ini")
		          Self.mGameUserSettingsFile = Other
		        End If
		      Case ConfigFileType.GameUserSettingsIni    
		        Self.mGameUserSettingsFile = File
		        If Self.mCurrentConfigType <> ConfigFileType.GameIni Then
		          Other = File.Parent.Child("Game.ini")
		          Self.mGameIniFile = Other
		        End If
		      End Select
		      If Other <> Nil And Other.Exists Then
		        Dim AdditionalContent As String = Self.ReadIniFile(Other)
		        If AdditionalContent <> "" Then
		          Content = Content + EndOfLine + EndOfLine + AdditionalContent.DefineEncoding(Encodings.UTF8)
		        End If
		      End If
		    End If
		    
		    If Self.ConfigArea.Text = "" Then
		      Self.ConfigArea.Text = Content
		    Else
		      Self.ConfigArea.Text = Self.ConfigArea.Text.Trim + EndOfLine + EndOfLine + Content
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(Content As String, File As FolderItem = Nil) As ConfigFileType
		  Dim GameIniPos As Integer = Content.InStr(Beacon.ShooterGameHeader)
		  Dim SettingsIniPos As Integer = Content.InStr(Beacon.ServerSettingsHeader)
		  
		  If GameIniPos > 0 And SettingsIniPos = 0 Then
		    Return ConfigFileType.GameIni
		  ElseIf SettingsIniPos > 0 And GameIniPos = 0 Then
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
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    #Pragma BreakOnExceptions Default
		    Dim Contents As String = Stream.ReadAll()
		    Stream.Close
		    Return Contents
		  Catch Err As IOException
		    #Pragma BreakOnExceptions Default
		    If Prompt = False Or TargetMacOS = False Then
		      Return ""
		    End If
		    
		    Dim Dialog As New OpenDialog
		    Dialog.InitialDirectory = File.Parent
		    Dialog.SuggestedFileName = File.Name
		    Dialog.PromptText = "Select your " + File.Name + " file if you want to import it too"
		    Dialog.ActionButtonCaption = "Import"
		    Dialog.Filter = BeaconFileTypes.IniFile
		    
		    Dim Selected As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If Selected = Nil Then
		      Return ""
		    End If
		    
		    Return Self.ReadIniFile(Selected, False)
		  End Try
		End Function
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
		Private mGameUserSettingsIniContent As String
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
		      Self.mGameIniContent = Me.Text.Trim
		    Case Self.GameUserSettingsIniIndex
		      Self.mGameUserSettingsIniContent = Me.Text.Trim
		    End Select
		  End If
		  
		  Self.ActionButton.Enabled = Self.mGameIniContent.Len > 0 Or Self.mGameUserSettingsIniContent.Len > 0
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
		  Dim Engines(0) As Beacon.DiscoveryEngine
		  Engines(0) = New Beacon.LocalDiscoveryEngine(Self.mGameIniContent.ToText, Self.mGameUserSettingsIniContent.ToText)
		  Self.ShouldFinish(Engines)
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
		  If Self.mGameIniContent.Len > 0 And Self.mGameUserSettingsIniContent.Len > 0 And Self.ShowConfirm("Both files are already selected", "You can select another file if you really want to, but both Game.ini and GameUserSettings.ini files are already present.", "Add Another", "Cancel") = False Then
		    Return
		  End If
		  
		  Dim Dialog As New OpenDialog
		  Dialog.SuggestedFileName = If(Self.mGameIniContent.Len > 0, "GameUserSettings.ini", "Game.ini")
		  Dialog.Filter = BeaconFileTypes.IniFile
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
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
		Sub Change()
		  Dim SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  Select Case Me.SelectedIndex
		  Case Self.GameIniIndex
		    Self.ConfigArea.Text = Self.mGameIniContent
		  Case Self.GameUserSettingsIniIndex
		    Self.ConfigArea.Text = Self.mGameUserSettingsIniContent
		  Else
		    Self.ConfigArea.Text = ""
		  End Select
		  Self.mSettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Dim Type As ConfigFileType = Self.DetectConfigType(Content)
		  Self.SetSwitcherForType(Type)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
