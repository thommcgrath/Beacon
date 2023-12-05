#tag DesktopWindow
Begin ArkSADiscoveryView ArkSAFilesDiscoveryView
   AllowAutoDeactivate=   "True"
   AllowFocus      =   "False"
   AllowFocusRing  =   "False"
   AllowTabs       =   "True"
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   Composited      =   "False"
   DefaultLocation =   2
   Enabled         =   "True"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   200
   ImplicitInstance=   True
   Index           =   "-2147483648"
   InitialParent   =   ""
   Left            =   "0"
   LockBottom      =   "True"
   LockLeft        =   "True"
   LockRight       =   "True"
   LockTop         =   "True"
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   TabIndex        =   "0"
   TabPanelIndex   =   "0"
   TabStop         =   "True"
   Title           =   "Untitled"
   Tooltip         =   ""
   Top             =   "0"
   Transparent     =   "True"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Next"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   160
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   160
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPopupMenu MapMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   171
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   128
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   214
   End
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      Text            =   "Choose your Ark: Survival Ascended game files"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedTextField GameIniPathField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   171
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   297
   End
   Begin UITweaks.ResizedTextField GameUserSettingsIniPathField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   171
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   297
   End
   Begin UITweaks.ResizedLabel GameIniLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Game.ini"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   139
   End
   Begin UITweaks.ResizedLabel GameUserSettingsIniLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "GameUserSettings.ini"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   139
   End
   Begin UITweaks.ResizedLabel MapLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Map:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   128
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   139
   End
   Begin UITweaks.ResizedPushButton GameIniChooseButton
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
      Italic          =   False
      Left            =   480
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedPushButton GameUserSettingsIniChooseButton
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
      Italic          =   False
      Left            =   480
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.GameIniLabel.Text = ArkSA.ConfigFileGame + ":"
		  Self.GameUserSettingsIniLabel.Text = ArkSA.ConfigFileGameUserSettings + ":"
		  BeaconUI.SizeToFit(Self.GameIniLabel, Self.GameUserSettingsIniLabel, Self.MapLabel)
		  
		  Var FieldsLeft As Integer = Self.GameIniLabel.Right + 12
		  Var FieldsWidth As Integer = Self.Width - (Self.GameIniLabel.Width + Self.GameIniChooseButton.Width + 64)
		  
		  Var GameIniGroup As New ControlGroup(Self.GameIniLabel, Self.GameIniPathField, Self.GameIniChooseButton)
		  GameIniGroup.Top = Self.MessageLabel.Bottom + 20
		  Self.GameIniPathField.Left = FieldsLeft
		  Self.GameIniPathField.Width = FieldsWidth
		  Self.GameIniChooseButton.Left = Self.GameIniPathField.Right + 12
		  
		  Var GameUserSettingsIniGroup As New ControlGroup(Self.GameUserSettingsIniLabel, Self.GameUserSettingsIniPathField, Self.GameUserSettingsIniChooseButton)
		  GameUserSettingsIniGroup.Top = GameIniGroup.Bottom + 12
		  Self.GameUserSettingsIniPathField.Left = FieldsLeft
		  Self.GameUserSettingsIniPathField.Width = FieldsWidth
		  Self.GameUserSettingsIniChooseButton.Left = Self.GameUserSettingsIniPathField.Right + 12
		  
		  Var MapGroup As New ControlGroup(Self.MapLabel, Self.MapMenu)
		  MapGroup.Top = GameUserSettingsIniGroup.Bottom + 12
		  Self.MapMenu.Left = FieldsLeft
		  
		  Self.ActionButton.Top = MapGroup.Bottom + 20
		  Self.CancelButton.Top = Self.ActionButton.Top
		  
		  Self.DesiredHeight = Self.ActionButton.Bottom + 20
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.AcceptFileDrop(BeaconFileTypes.IniFile)
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem)
		  Self.AddFile(File, ConfigFileType.Other)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddFile(File As FolderItem, ForceType As ConfigFileType)
		  If ForceType = ConfigFileType.Other Then
		    ForceType = Self.DetectConfigType(File)
		  End If
		  
		  Select Case ForceType
		  Case ConfigFileType.GameIni
		    Self.mGameIniFile = File
		    Self.GameIniPathField.Text = File.NativePath
		    Self.GameIniPathField.Tooltip = File.NativePath
		  Case ConfigFileType.GameUserSettingsIni
		    Self.mGameUserSettingsIniFile = File
		    Self.GameUserSettingsIniPathField.Text = File.NativePath
		    Self.GameUserSettingsIniPathField.Tooltip = File.NativePath
		  End Select
		  Self.ActionButton.Enabled = (Self.mGameIniFile Is Nil) = False Or (Self.mGameUserSettingsIniFile Is Nil) = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(File As FolderItem) As ConfigFileType
		  Var Content As String
		  Try
		    Content = File.Read
		  Catch Err As RuntimeException
		    Return ConfigFileType.Other
		  End Try
		  
		  Content = Content.GuessEncoding("/script/")
		  Var GameIniPos As Integer = Content.IndexOf(ArkSA.HeaderShooterGame)
		  Var SettingsIniPos As Integer = Content.IndexOf(ArkSA.HeaderServerSettings)
		  
		  If GameIniPos > -1 And SettingsIniPos = -1 Then
		    Return ConfigFileType.GameIni
		  ElseIf SettingsIniPos > -1 And GameIniPos = -1 Then
		    Return ConfigFileType.GameUserSettingsIni
		  Else
		    Select Case File.Name
		    Case ArkSA.ConfigFileGame
		      Return ConfigFileType.GameIni
		    Case ArkSA.ConfigFileGameUserSettings
		      Return ConfigFileType.GameUserSettingsIni
		    Else
		      Return ConfigFileType.Other
		    End Select
		  End If
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
		    
		    Contents = Contents.GuessEncoding("/script/")
		    
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
		    
		    Var Selected As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		    If Selected = Nil Then
		      Return ""
		    End If
		    
		    Return Self.ReadIniFile(Selected, False)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowFileChooser(DesiredType As ConfigFileType, SearchForSibling As Boolean)
		  Var Filename As String
		  Select Case DesiredType
		  Case ConfigFileType.GameIni
		    Filename = ArkSA.ConfigFileGame
		  Case ConfigFileType.GameUserSettingsIni
		    Filename = ArkSA.ConfigFileGameUserSettings
		  Else
		    Return
		  End Select
		  
		  Var Dialog As New OpenFileDialog
		  If (Self.mGameUserSettingsIniFile Is Nil) = False Then
		    Dialog.InitialFolder = Self.mGameUserSettingsIniFile.Parent
		  ElseIf (Self.mGameIniFile Is Nil) = False Then
		    Dialog.InitialFolder = Self.mGameIniFile.Parent
		  End If
		  Dialog.SuggestedFileName = Filename
		  Dialog.Filter = BeaconFileTypes.IniFile
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Type As ConfigFileType = Self.DetectConfigType(File)
		  If Type <> DesiredType Then
		    Var Force As Boolean = Self.ShowConfirm("The chosen file may not be a " + Filename + " file.", "Beacon searched in the file, but it does not look like a normal " + Filename + " file. Do you still want to import it?", "Import Anyway", "Cancel")
		    If Force = False Then
		      Return
		    End If
		  End If
		  
		  Self.AddFile(File, DesiredType)
		  
		  If SearchForSibling = False Then
		    Return
		  End If
		  
		  Var Parent As FolderItem = File.Parent
		  Select Case DesiredType
		  Case ConfigFileType.GameIni
		    Var Sibling As FolderItem = Parent.Child(ArkSA.ConfigFileGameUserSettings)
		    If (Sibling Is Nil) = False And Sibling.Exists Then
		      Try
		        Call Sibling.Read()
		        Self.AddFile(Sibling, ConfigFileType.GameUserSettingsIni)
		        Return
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If Self.ShowConfirm("Select your " + ArkSA.ConfigFileGameUserSettings + " file too?", "Your " + ArkSA.ConfigFileGame + " file is set. Do you want to choose your " + ArkSA.ConfigFileGameUserSettings + " file now?", "Choose", "Not Now") Then
		      Self.ShowFileChooser(ConfigFileType.GameUserSettingsIni, False)
		    End If
		  Case ConfigFileType.GameUserSettingsIni
		    Var Sibling As FolderItem = Parent.Child(ArkSA.ConfigFileGame)
		    If (Sibling Is Nil) = False And Sibling.Exists Then
		      Try
		        Call Sibling.Read
		        Self.AddFile(Sibling, ConfigFileType.GameIni)
		        Return
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If Self.ShowConfirm("Select your " + ArkSA.ConfigFileGame + " file too?", "Your " + ArkSA.ConfigFileGameUserSettings + " file is set. Do you want to choose your " + ArkSA.ConfigFileGame + " file now?", "Choose", "Not Now") Then
		      Self.ShowFileChooser(ConfigFileType.GameIni, False)
		    End If
		  End Select
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mGameIniFile As FolderItem
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

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As New ArkSA.ServerProfile(Local.Identifier, Language.DefaultServerName(ArkSA.Identifier))
		  Profile.Mask = Self.MapMenu.RowTagAt(Self.MapMenu.SelectedRowIndex)
		  If (Self.mGameUserSettingsIniFile Is Nil) = False Then
		    Profile.GameUserSettingsIniPath = BookmarkedFolderItem.CreateSaveInfo(Self.mGameUserSettingsIniFile)
		    Profile.SecondaryName = Self.mGameUserSettingsIniFile.PartialPath
		  End If
		  If (Self.mGameIniFile Is Nil) = False Then
		    Profile.GameIniPath = BookmarkedFolderItem.CreateSaveInfo(Self.mGameIniFile)
		    If Profile.SecondaryName.IsEmpty Then
		      Profile.SecondaryName = Self.mGameIniFile.PartialPath
		    End If
		  End If
		  Self.ShouldFinish(Profile)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapMenu
	#tag Event
		Sub Opening()
		  Var Maps() As ArkSA.Map = ArkSA.Maps.All
		  For Each Map As ArkSA.Map In Maps
		    Me.AddRow(Map.Name, Map.Mask)
		  Next
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameIniChooseButton
	#tag Event
		Sub Pressed()
		  Self.ShowFileChooser(ConfigFileType.GameIni, Self.mGameUserSettingsIniFile Is Nil)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameUserSettingsIniChooseButton
	#tag Event
		Sub Pressed()
		  Self.ShowFileChooser(ConfigFileType.GameUserSettingsIni, Self.mGameIniFile Is Nil)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
