#tag DesktopWindow
Begin BeaconSubview DashboardPane Implements NotificationKit.Receiver
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   556
   HelpTag         =   ""
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
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   808
   Begin UITweaks.ResizedPushButton NewFileButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "New Project…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   278
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedPushButton OpenFileButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Open Project…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   410
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopLabel VersionLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   229
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Version X"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   307
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   350
   End
   Begin DesktopLabel CopyrightLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "© 2016-?1 The ZAZ Studios, All Rights Reserved."
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   516
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin DesktopLabel SyncLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   229
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Engrams Updated Y"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   329
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   350
   End
   Begin ControlCanvas TitleCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   86
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   279
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   137
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
   Begin LinkLabel WebsiteLink
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   229
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      ShowAsLink      =   True
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "https://usebeacon.app/"
      TextAlignment   =   2
      TextColor       =   &c0000FF00
      Tooltip         =   ""
      Top             =   275
      Transparent     =   True
      Underline       =   True
      URL             =   ""
      Visible         =   True
      Width           =   350
   End
   Begin DesktopProgressBar EngramImportIndicator
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   20
      Indeterminate   =   True
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   229
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumValue    =   100
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   351
      Transparent     =   False
      Value           =   0.0
      Visible         =   False
      Width           =   350
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportBegin, DataUpdater.Notification_ImportStopped, DataUpdater.Notification_OnlineCheckBegin, DataUpdater.Notification_OnlineCheckError, DataUpdater.Notification_OnlineCheckStopped, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ViewTitle = "Home"
		  
		  Self.mMainGroup = New ControlGroup(TitleCanvas, VersionLabel, NewFileButton, OpenFileButton, SyncLabel, WebsiteLink, EngramImportIndicator)
		  Self.mCopyrightGroup = New ControlGroup(CopyrightLabel)
		  
		  Self.MinimumHeight = Self.mMainGroup.Height + Self.mCopyrightGroup.Height + 100
		  Self.MinimumWidth = Max(Self.mMainGroup.Width, Self.mCopyrightGroup.Width) + 40
		  
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportBegin, DataUpdater.Notification_ImportStopped, DataUpdater.Notification_OnlineCheckBegin, DataUpdater.Notification_OnlineCheckError, DataUpdater.Notification_OnlineCheckStopped, IdentityManager.Notification_IdentityChanged)
		  
		  Self.UpdateEngramStatus
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Self.mCopyrightGroup <> Nil Then
		    Var Left As Integer = (Self.Width - Self.mCopyrightGroup.Width) / 2
		    Var Top As Integer = Self.Height - (Self.mCopyrightGroup.Height + 20)
		    Var DeltaX As Integer = Left - Self.mCopyrightGroup.Left
		    Var DeltaY As Integer = Top - Self.mCopyrightGroup.Top
		    Self.mCopyrightGroup.Offset(DeltaX, DeltaY)
		  End If
		  
		  If Self.mMainGroup <> Nil Then
		    Var AvailableTop As Integer = 60
		    Var AvailableBottom As Integer
		    If Self.mCopyrightGroup <> Nil Then
		      AvailableBottom = Self.mCopyrightGroup.Top - 20
		    Else
		      AvailableBottom = Self.CopyrightLabel.Top - 20
		    End If
		    Var AvailableHeight As Integer = AvailableBottom - AvailableTop
		    
		    Var Left As Integer = (Self.Width - Self.mMainGroup.Width) / 2
		    Var Top As Integer = AvailableTop + Max((AvailableHeight - Self.mMainGroup.Height) / 3, 0)
		    Var DeltaX As Integer = Left - Self.mMainGroup.Left
		    Var DeltaY As Integer = Top - Self.mMainGroup.Top
		    Self.mMainGroup.Offset(DeltaX, DeltaY)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case DataUpdater.Notification_ImportBegin, DataUpdater.Notification_ImportStopped, DataUpdater.Notification_OnlineCheckBegin, DataUpdater.Notification_OnlineCheckError, DataUpdater.Notification_OnlineCheckStopped
		    Self.UpdateEngramStatus()
		  Case IdentityManager.Notification_IdentityChanged
		    Self.TitleCanvas.Refresh
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEngramStatus(LastSync As DateTime = Nil)
		  If DataUpdater.IsCheckingOnline Then
		    Self.SyncLabel.Text = "Checking for database updates…"
		    Self.EngramImportIndicator.Visible = True
		    Return
		  ElseIf DataUpdater.IsImporting Then
		    Self.SyncLabel.Text = "Importing database updates…"
		    Self.EngramImportIndicator.Visible = True
		    Return
		  End If
		  
		  If IsNull(LastSync) Then
		    LastSync = App.OldestSyncDateTime
		  End If
		  If IsNull(LastSync) Then
		    Self.SyncLabel.Text = "Databases are empty"
		  Else
		    Self.SyncLabel.Text = "Databases updated " + LastSync.ToString(Locale.Current, DateTime.FormatStyles.Long, DateTime.FormatStyles.Short) + " UTC"
		  End If
		  Self.EngramImportIndicator.Visible = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event NewDocument()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCopyrightGroup As ControlGroup
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainGroup As ControlGroup
	#tag EndProperty


#tag EndWindowCode

#tag Events NewFileButton
	#tag Event
		Sub Pressed()
		  RaiseEvent NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenFileButton
	#tag Event
		Sub Pressed()
		  App.ShowOpenDocument(Self.TrueWindow)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionLabel
	#tag Event
		Sub Opening()
		  Me.Text = "Version " + App.BuildVersion
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CopyrightLabel
	#tag Event
		Sub Opening()
		  Var BuildDate As DateTime = App.BuildDateTime
		  Var Year As Integer = BuildDate.Year
		  Me.Text = Language.ReplacePlaceholders(Me.Text, Year.ToString(Locale.Raw, "0000"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TitleCanvas
	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  Var TitleIcon As Picture
		  If (App.IdentityManager.CurrentIdentity Is Nil) = False And App.IdentityManager.CurrentIdentity.OmniFlags > 0 Then
		    TitleIcon = If(Color.IsDarkMode, LogoOmniDark, LogoOmniColor)
		  Else
		    TitleIcon = If(Color.IsDarkMode, LogoDark, LogoColor)
		  End If
		  G.DrawPicture(TitleIcon, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WebsiteLink
	#tag Event
		Sub Opening()
		  Me.Text = Beacon.WebURL()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  System.GotoURL(Me.Text)
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
