#tag DesktopWindow
Begin PalworldServerViewContainer PalworldLocalServerView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   600
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
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   559
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   600
      Begin BeaconTextArea AdminNotesField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   519
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedLabel SettingsIniPathLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "PalWorldSettings.ini:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   172
      End
      Begin UITweaks.ResizedTextField SettingsIniPathField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   204
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   172
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   388
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   62
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin PalworldCommonServerSettingsView SettingsView
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   559
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         SettingUp       =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin UITweaks.ResizedPushButton SettingsIniClearButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Clear"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   490
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   62
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
   End
   Begin OmniBar ControlToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  BeaconUI.SizeToFit(Self.SettingsIniPathLabel)
		  BeaconUI.SizeToFit(Self.SettingsIniChooseButton)
		  BeaconUI.SizeToFit(Self.SettingsIniClearButton)
		  
		  Self.SizeUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.AdminNotesField.Text = Self.Profile.AdminNotes
		  
		  Var SettingsIniPath As String = Self.Profile.SettingsIniPath
		  If SettingsIniPath.IsEmpty = False Then
		    Try
		      Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(SettingsIniPath)
		      If (File Is Nil) = False Then
		        Self.SettingsIniPathField.Text = File.NativePath
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Self.SizeUI()
		  Self.SettingsView.RefreshUI()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DetectConfigType(File As FolderItem) As String
		  Var Content As String = File.Read
		  Content = Content.GuessEncoding("/Script/")
		  Var SettingsIniPos As Integer = Content.IndexOf(Palworld.HeaderPalworldSettings)
		  
		  If SettingsIniPos > -1 Then
		    Return Palworld.ConfigFileSettings
		  ElseIf (File Is Nil) = False Then
		    Select Case File.Name
		    Case Palworld.ConfigFileSettings
		      Return File.Name
		    End Select
		  End If
		  
		  Return "Unknown"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SizeUI()
		  Self.SettingsIniPathField.Left = Self.SettingsIniPathLabel.Right + 12
		  
		  Self.SettingsIniClearButton.Visible = Self.SettingsIniPathField.Text.IsEmpty = False
		  
		  If Self.SettingsIniClearButton.Visible Then
		    Self.SettingsIniClearButton.Left = Self.Width - (20 + Self.SettingsIniClearButton.Width)
		    Self.SettingsIniChooseButton.Left = Self.SettingsIniClearButton.Left - (12 + Self.SettingsIniChooseButton.Width)
		  Else
		    Self.SettingsIniChooseButton.Left = Self.Width - (20 + Self.SettingsIniChooseButton.Width)
		  End If
		  
		  Self.SettingsIniPathField.Width = Self.SettingsIniChooseButton.Left - (12 + Self.SettingsIniPathField.Left)
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  For Idx As Integer = 0 To Self.ControlToolbar.LastIndex
		    Self.ControlToolbar.Item(Idx).Toggled = Me.SelectedPanelIndex = Idx
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AdminNotesField
	#tag Event
		Sub TextChanged()
		  Self.Profile.AdminNotes = Me.Text
		  Self.Modified = Self.Profile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsIniChooseButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Palworld.ConfigFileSettings
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var DetectedType As String = Self.DetectConfigType(File)
		  If DetectedType <> Palworld.ConfigFileSettings And Self.ShowConfirm("The selected file does not appear to be a PalWorldSettings.ini file.", "You can still choose this file if you really want, but its content does not look like a PalWorldSettings.ini file. Proceed with caution.", "Use Anyway", "Cancel") = False Then
		    Return
		  End If
		  
		  Var Bookmark As New BookmarkedFolderItem(File.NativePath, FolderItem.PathModes.Native)
		  Self.Profile.SettingsIniPath = Bookmark.SaveInfo()
		  Self.Profile.SecondaryName = File.PartialPath
		  Self.SettingsIniPathField.Text = File.NativePath
		  Self.Modified = Self.Profile.Modified
		  Self.SizeUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsView
	#tag Event
		Sub Opening()
		  Me.Profile = Self.Profile
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContentsChanged()
		  Self.Modified = Me.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Palworld.Project
		  Return Self.Project
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SettingsIniClearButton
	#tag Event
		Sub Pressed()
		  Self.Profile.SettingsIniPath = ""
		  Self.Profile.SecondaryName = ""
		  Self.SettingsIniPathField.Text = ""
		  Self.Modified = Self.Profile.Modified
		  Self.SizeUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ControlToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTab("PageGeneral", "General"))
		  Me.Append(OmniBarItem.CreateTab("PageFiles", "Files"))
		  Me.Append(OmniBarItem.CreateTab("PageNotes", "Notes"))
		  Me.Item("PageGeneral").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "PageGeneral"
		    Self.Pages.SelectedPanelIndex = 0
		  Case "PageFiles"
		    Self.Pages.SelectedPanelIndex = 1
		  Case "PageNotes"
		    Self.Pages.SelectedPanelIndex = 2
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
