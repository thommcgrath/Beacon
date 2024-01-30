#tag DesktopWindow
Begin PalworldDiscoveryView PalworldFilesDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   142
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
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
      Top             =   102
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
      Top             =   102
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
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
      Text            =   "Choose your Palworld game files"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedTextField SettingsIniPathField
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
   Begin UITweaks.ResizedLabel SettingsIniLabel
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
      Text            =   "PalWorldSettings.ini"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   139
   End
   Begin UITweaks.ResizedPushButton SettingsIniChooseButton
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
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.SettingsIniLabel.Text = Palworld.ConfigFileSettings + ":"
		  BeaconUI.SizeToFit(Self.SettingsIniLabel)
		  
		  Var FieldsLeft As Integer = Self.SettingsIniLabel.Right + 12
		  Var FieldsWidth As Integer = Self.Width - (Self.SettingsIniLabel.Width + Self.SettingsIniChooseButton.Width + 64)
		  
		  Var SettingsIniGroup As New ControlGroup(Self.SettingsIniLabel, Self.SettingsIniPathField, Self.SettingsIniChooseButton)
		  SettingsIniGroup.Top = Self.MessageLabel.Bottom + 20
		  Self.SettingsIniPathField.Left = FieldsLeft
		  Self.SettingsIniPathField.Width = FieldsWidth
		  Self.SettingsIniChooseButton.Left = Self.SettingsIniPathField.Right + 12
		  
		  Self.ActionButton.Top = SettingsIniGroup.Bottom + 20
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
		  Case ConfigFileType.SettingsIni
		    Self.mSettingsIniFile = File
		    Self.SettingsIniPathField.Text = File.NativePath
		    Self.SettingsIniPathField.Tooltip = File.NativePath
		  End Select
		  Self.ActionButton.Enabled = (Self.mSettingsIniFile Is Nil) = False
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
		  
		  Content = Content.GuessEncoding("/Script/")
		  Var SettingsIniPos As Integer = Content.IndexOf(Palworld.HeaderPalworldSettings)
		  
		  If SettingsIniPos > -1 Then
		    Return ConfigFileType.SettingsIni
		  Else
		    Select Case File.Name
		    Case Palworld.ConfigFileSettings
		      Return ConfigFileType.SettingsIni
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
		    
		    Contents = Contents.GuessEncoding("/Script/")
		    
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
		Private Sub ShowFileChooser(DesiredType As ConfigFileType)
		  Var Filename As String
		  Select Case DesiredType
		  Case ConfigFileType.SettingsIni
		    Filename = Palworld.ConfigFileSettings
		  Else
		    Return
		  End Select
		  
		  Var Dialog As New OpenFileDialog
		  If (Self.mSettingsIniFile Is Nil) = False Then
		    Dialog.InitialFolder = Self.mSettingsIniFile.Parent
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
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSettingsIniFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = GameUserSettingsIniIndex, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SettingsIniIndex, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ConfigFileType, Flags = &h21
		Other
		SettingsIni
	#tag EndEnum


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As New Palworld.ServerProfile(Local.Identifier, Language.DefaultServerName(Palworld.Identifier))
		  If (Self.mSettingsIniFile Is Nil) = False Then
		    Profile.SettingsIniPath = BookmarkedFolderItem.CreateSaveInfo(Self.mSettingsIniFile)
		    If Profile.SecondaryName.IsEmpty Then
		      Profile.SecondaryName = Self.mSettingsIniFile.PartialPath
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
#tag Events SettingsIniChooseButton
	#tag Event
		Sub Pressed()
		  Self.ShowFileChooser(ConfigFileType.SettingsIni)
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
