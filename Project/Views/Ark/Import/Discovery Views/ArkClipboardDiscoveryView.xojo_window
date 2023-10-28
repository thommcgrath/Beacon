#tag DesktopWindow
Begin ArkDiscoveryView ArkClipboardDiscoveryView
   AllowAutoDeactivate=   "True"
   AllowFocus      =   "False"
   AllowFocusRing  =   "False"
   AllowTabs       =   "True"
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   Composited      =   "False"
   DefaultLocation =   2
   DoubleBuffer    =   "False"
   Enabled         =   "True"
   EraseBackground =   "True"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   396
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   356
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Shelf Switcher
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
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
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   600
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   38
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Paste the contents of your Game.ini and/or GameUserSettings.ini files here. Only one file is required, but Beacon can do a better job with both files."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   73
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
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   356
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   214
   End
   Begin Timer TextChangeDelayTrigger
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopRectangle BorderRect
      AllowAutoDeactivate=   True
      BorderColor     =   &c000000
      BorderThickness =   1.0
      CornerSize      =   0.0
      Enabled         =   True
      FillColor       =   &cFFFFFF
      Height          =   221
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   123
      Transparent     =   False
      Visible         =   True
      Width           =   560
      Begin CodeEditor ConfigArea
         AutoDeactivate  =   True
         Enabled         =   True
         HasBorder       =   False
         Height          =   219
         HorizontalScrollPosition=   0
         Index           =   -2147483648
         InitialParent   =   "BorderRect"
         Left            =   21
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectionLength =   0
         ShowInfoBar     =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   124
         VerticalScrollPosition=   0
         Visible         =   True
         Width           =   558
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 450
		  Self.ConfigArea.Text = ""
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DetectConfigType(Content As String) As ConfigFileType
		  Content = Content.GuessEncoding
		  Var GameIniPos As Integer = Content.IndexOf(Ark.HeaderShooterGame)
		  Var SettingsIniPos As Integer = Content.IndexOf(Ark.HeaderServerSettings)
		  
		  If GameIniPos > -1 And SettingsIniPos = -1 Then
		    Return ConfigFileType.GameIni
		  ElseIf SettingsIniPos > -1 And GameIniPos = -1 Then
		    Return ConfigFileType.GameUserSettingsIni
		  End If
		  
		  Return ConfigFileType.Other
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
		      Self.ConfigArea.Text = Self.mGameIniContent
		    End If
		  Case Self.GameUserSettingsIniIndex
		    If ChangeIfEmpty And Self.mGameIniContent.IsEmpty = False And Self.mGameUserSettingsIniContent.IsEmpty Then
		      Self.Switcher.SelectedIndex = Self.GameIniIndex
		    Else
		      Self.ConfigArea.Text = Self.mGameUserSettingsIniContent
		    End If
		  Else
		    Self.ConfigArea.Text = ""
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

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As New Ark.ServerProfile(Local.Identifier, Language.DefaultServerName(Ark.Identifier))
		  Profile.Mask = Self.MapMenu.RowTagAt(Self.MapMenu.SelectedRowIndex)
		  
		  If Self.mGameIniContent.IsEmpty = False Then
		    Var TempFile As FolderItem = FolderItem.TemporaryFile
		    Try
		      TempFile.Write(Self.mGameIniContent)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Import error", "Beacon was unable to write the temporary " + Ark.ConfigFileGame + " file necessary to import.")
		      Return
		    End Try
		    Profile.GameIniPath = BookmarkedFolderItem.CreateSaveInfo(TempFile)
		  End If
		  
		  If Self.mGameUserSettingsIniContent.IsEmpty = False Then
		    Var TempFile As FolderItem = FolderItem.TemporaryFile
		    Try
		      TempFile.Write(Self.mGameUserSettingsIniContent)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Import error", "Beacon was unable to write the temporary " + Ark.ConfigFileGameUserSettings + " file necessary to import.")
		      Return
		    End Try
		    Profile.GameUserSettingsIniPath = BookmarkedFolderItem.CreateSaveInfo(TempFile)
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
#tag Events Switcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconFileIniFilled, Ark.ConfigFileGameUserSettings, Ark.ConfigFileGameUserSettings)
		  Me.Add(IconFileIni, Ark.ConfigFileGame, Ark.ConfigFileGame)
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.GameUserSettingsIniIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
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
		Sub Opening()
		  Var Maps() As Ark.Map = Ark.Maps.All
		  For Each Map As Ark.Map In Maps
		    Me.AddRow(Map.Name, Map.Mask)
		  Next
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextChangeDelayTrigger
	#tag Event
		Sub Action()
		  Self.ActionButton.Enabled = (Self.mGameIniContent.IsEmpty And Self.mGameUserSettingsIniContent.IsEmpty) = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BorderRect
	#tag Event
		Sub Opening()
		  Me.BorderColor = SystemColors.SeparatorColor
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigArea
	#tag Event
		Sub TextChanged()
		  If Not Self.mSettingUp Then
		    Var TextValue As String = Me.Text.Trim(Chr(0), Chr(10), Chr(13), Chr(32))
		    Select Case Self.Switcher.SelectedIndex
		    Case Self.GameIniIndex
		      Self.mGameIniContent = TextValue
		    Case Self.GameUserSettingsIniIndex
		      Self.mGameUserSettingsIniContent = TextValue
		    End Select
		  End If
		  
		  If Self.TextChangeDelayTrigger.RunMode = Timer.RunModes.Single Then
		    Self.TextChangeDelayTrigger.Reset
		  Else
		    Self.TextChangeDelayTrigger.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SetupNeeded()
		  Ark.SetupCodeEditor(Me)
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
