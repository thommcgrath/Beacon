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
      EraseBackground =   "False"
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
      EraseBackground =   "True"
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
      Enabled         =   True
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
		  Self.ConfigArea.Value = ""
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent

	#tag EventAPI2
		Sub Opening()
		  RaiseEvent Opening
		  Self.AcceptFileDrop(BeaconFileTypes.IniFile)
		  Self.ConfigArea.AcceptFileDrop(BeaconFileTypes.IniFile)
		  Self.SwapButtons()
		End Sub
	#tag EndEventAPI2


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem, DetectSibling As Boolean = True)
		  Dim Content As String = Self.ReadIniFile(File)
		  If Content = "" Then
		    Return
		  End If
		  
		  Content  = Content.DefineEncoding(Encodings.UTF8)
		  Dim Type As ConfigFileType = Self.DetectConfigType(Content)
		  Self.SetSwitcherForType(Type)
		  
		  If Self.ConfigArea.Value.Length <> 0 Then
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
		      Self.ConfigArea.Value = Content.Trim
		    Case Dialog.CancelButton
		      Return
		    Case Dialog.AlternateActionButton
		      Self.ConfigArea.Value = Self.ConfigArea.Value + EndOfLine + Content.Trim
		    End Select
		  Else
		    Self.ConfigArea.Value = Content.Trim
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
		  Dim GameIniPos As Integer = Content.IndexOf(Beacon.ShooterGameHeader)
		  Dim SettingsIniPos As Integer = Content.IndexOf(Beacon.ServerSettingsHeader)
		  
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
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    #Pragma BreakOnExceptions Default
		    Dim Contents As String = Stream.ReadAll()
		    Stream.Close
		    
		    Contents = Contents.GuessEncoding
		    
		    Return Contents
		  Catch Err As IOException
		    #Pragma BreakOnExceptions Default
		    If Prompt = False Or TargetMacOS = False Then
		      Return ""
		    End If
		    
		    Dim Dialog As New OpenFileDialog
		    Dialog.InitialFolder = File.Parent
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
		Event Opening()
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
	#tag EventAPI2
		Sub TextChanged()
		  If Not Self.mSettingUp Then
		    Select Case Self.Switcher.SelectedIndex
		    Case Self.GameIniIndex
		      Self.mGameIniContent = Me.Value.Trim
		    Case Self.GameUserSettingsIniIndex
		      Self.mGameUserSettingsIniContent = Me.Value.Trim
		    End Select
		  End If
		  
		  Self.ActionButton.Enabled = Self.mGameIniContent.Length > 0 Or Self.mGameUserSettingsIniContent.Length > 0
		End Sub
	#tag EndEventAPI2
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag EventAPI2
		Sub Pressed()
		  Dim Engines(0) As Beacon.DiscoveryEngine
		  Engines(0) = New Beacon.LocalDiscoveryEngine(Self.mGameIniContent, Self.mGameUserSettingsIniContent)
		  Self.ShouldFinish(Engines)
		End Sub
	#tag EndEventAPI2
#tag EndEvents
#tag Events CancelButton
	#tag EventAPI2
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEventAPI2
#tag EndEvents
#tag Events ChooseFileButton
	#tag EventAPI2
		Sub Pressed()
		  If Self.mGameIniContent.Length > 0 And Self.mGameUserSettingsIniContent.Length > 0 And Self.ShowConfirm("Both files are already selected", "You can select another file if you really want to, but both Game.ini and GameUserSettings.ini files are already present.", "Add Another", "Cancel") = False Then
		    Return
		  End If
		  
		  Dim Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = If(Self.mGameIniContent.Length > 0, "GameUserSettings.ini", "Game.ini")
		  Dialog.Filter = BeaconFileTypes.IniFile
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    Self.AddFile(File)
		  End If
		End Sub
	#tag EndEventAPI2
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.GameUserSettingsIniIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Dim SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  Select Case Me.SelectedIndex
		  Case Self.GameIniIndex
		    Self.ConfigArea.Value = Self.mGameIniContent
		  Case Self.GameUserSettingsIniIndex
		    Self.ConfigArea.Value = Self.mGameUserSettingsIniContent
		  Else
		    Self.ConfigArea.Value = ""
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
