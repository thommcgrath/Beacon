#tag DesktopWindow
Begin PalworldDiscoveryView PalworldClipboardDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   396
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
      Text            =   "Paste the contents of your PalWorldSettings.ini file here."
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
      Period          =   500
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
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
		Sub Cleanup()
		  For Idx As Integer = Self.mTempFiles.LastIndex DownTo 0
		    If (Self.mTempFiles(Idx) Is Nil) = False And Self.mTempFiles(Idx).Exists Then
		      Try
		        Self.mTempFiles(Idx).Remove
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Removing temporary file")
		      End Try
		    End If
		    Self.mTempFiles.RemoveAt(Idx)
		  Next
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
		  Content = Content.GuessEncoding("/Script/")
		  Var SettingsIniPos As Integer = Content.IndexOf(Palworld.HeaderPalworldSettings)
		  
		  If SettingsIniPos > -1 Then
		    Return ConfigFileType.SettingsIni
		  End If
		  
		  Return ConfigFileType.Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea()
		  Var SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  Select Case Self.Switcher.SelectedIndex
		  Case Self.SettingsIniIndex
		    Self.ConfigArea.Text = Self.mSettingsIniContent
		  Else
		    Self.ConfigArea.Text = ""
		  End Select
		  Self.mSettingUp = SettingUp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSwitcherForType(Type As ConfigFileType)
		  If Type = ConfigFileType.SettingsIni And Self.Switcher.SelectedIndex <> Self.SettingsIniIndex Then
		    Self.Switcher.SelectedIndex = Self.SettingsIniIndex
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempFiles() As FolderItem
	#tag EndProperty


	#tag Constant, Name = SettingsIniIndex, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ConfigFileType, Flags = &h21
		Other
		  SettingsIni
		GameUserSettingsIni
	#tag EndEnum


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As New Palworld.ServerProfile(Local.Identifier, Language.DefaultServerName(Palworld.Identifier))
		  
		  If Self.mSettingsIniContent.IsEmpty = False Then
		    Var TempFile As FolderItem = FolderItem.TemporaryFile
		    Self.mTempFiles.Add(TempFile)
		    Try
		      TempFile.Write(Self.mSettingsIniContent)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Import error", "Beacon was unable to write the temporary " + Palworld.ConfigFileSettings + " file necessary to import.")
		      Return
		    End Try
		    Profile.SettingsIniPath = BookmarkedFolderItem.CreateSaveInfo(TempFile)
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
		  Me.Add(IconFileIni, Palworld.ConfigFileSettings, Palworld.ConfigFileSettings)
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.SettingsIniIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Self.RefreshContentArea()
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
#tag Events TextChangeDelayTrigger
	#tag Event
		Sub Action()
		  Self.ActionButton.Enabled = (Self.mSettingsIniContent.IsEmpty = False)
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
		    Case Self.SettingsIniIndex
		      Self.mSettingsIniContent = TextValue
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
		  Palworld.SetupCodeEditor(Me)
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
