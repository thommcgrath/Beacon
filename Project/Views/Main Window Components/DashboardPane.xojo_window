#tag Window
Begin BeaconSubview DashboardPane Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   808
   Begin UITweaks.ResizedPushButton NewFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "New Project…"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   278
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedPushButton OpenFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Open Project…"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   410
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin Label VersionLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   307
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   350
   End
   Begin Label CopyrightLabel
      AutoDeactivate  =   True
      Bold            =   False
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "© 2016-?1 The ZAZ Studios, All Rights Reserved."
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   516
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin Label SyncLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   329
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   350
   End
   Begin ControlCanvas TitleCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   86
      HelpTag         =   ""
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
      Top             =   137
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin LinkLabel WebsiteLink
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TextAlign       =   1
      TextColor       =   &c0000FF00
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   275
      Transparent     =   True
      Underline       =   True
      URL             =   ""
      Visible         =   True
      Width           =   350
   End
   Begin ProgressBar EngramImportIndicator
      AllowAutoDeactivate=   True
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
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   351
      Transparent     =   False
      Value           =   0.0
      Visible         =   False
      Width           =   350
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, Beacon.DataSource.Notification_DatabaseUpdated, Beacon.DataSource.Notification_ImportStarted, Beacon.DataSource.Notification_ImportSuccess, Beacon.DataSource.Notification_ImportFailed, IdentityManager.Notification_IdentityChanged, Beacon.DataSource.Notification_SyncStarted, Beacon.DataSource.Notification_SyncFinished)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.ViewTitle = "Home"
		  
		  Self.mMainGroup = New ControlGroup(TitleCanvas, VersionLabel, NewFileButton, OpenFileButton, SyncLabel, WebsiteLink, EngramImportIndicator)
		  Self.mCopyrightGroup = New ControlGroup(CopyrightLabel)
		  
		  Self.MinimumHeight = Self.mMainGroup.Height + Self.mCopyrightGroup.Height + 100
		  Self.MinimumWidth = Max(Self.mMainGroup.Width, Self.mCopyrightGroup.Width) + 40
		  
		  NotificationKit.Watch(Self, Beacon.DataSource.Notification_DatabaseUpdated, Beacon.DataSource.Notification_ImportStarted, Beacon.DataSource.Notification_ImportSuccess, Beacon.DataSource.Notification_ImportFailed, IdentityManager.Notification_IdentityChanged, Beacon.DataSource.Notification_SyncStarted, Beacon.DataSource.Notification_SyncFinished)
		  
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
		  Case Beacon.DataSource.Notification_DatabaseUpdated, Beacon.DataSource.Notification_ImportFailed, Beacon.DataSource.Notification_ImportStarted, Beacon.DataSource.Notification_ImportSuccess, Beacon.DataSource.Notification_SyncStarted, Beacon.DataSource.Notification_SyncFinished
		    Var LastSync As DateTime = Notification.UserData
		    Self.UpdateEngramStatus(LastSync)
		  Case IdentityManager.Notification_IdentityChanged
		    Self.TitleCanvas.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEngramStatus(LastSync As DateTime = Nil)
		  Var Sources() As Beacon.DataSource = App.DataSources
		  For Each Source As Beacon.DataSource In Sources
		    If Source.Syncing Then
		      Self.SyncLabel.Text = Source.Identifier + ": Checking for game data updates…"
		      Self.EngramImportIndicator.Visible = True
		      Return
		    ElseIf Source.Importing Then
		      Self.SyncLabel.Text = Source.Identifier + ": Importing game data…"
		      Self.EngramImportIndicator.Visible = True
		      Return
		    End If
		  Next Source
		  
		  If IsNull(LastSync) Then
		    LastSync = App.NewestSyncDate
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
		Sub Action()
		  RaiseEvent NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenFileButton
	#tag Event
		Sub Action()
		  App.ShowOpenDocument(Self.TrueWindow)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionLabel
	#tag Event
		Sub Open()
		  Me.Text = "Version " + App.BuildVersion
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CopyrightLabel
	#tag Event
		Sub Open()
		  Var BuildDate As DateTime = App.BuildDateTime
		  Var Year As Integer = BuildDate.Year
		  Me.Text = Language.ReplacePlaceholders(Me.Text, Year.ToString(Locale.Raw, "0000"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SyncLabel
	#tag Event
		Sub Open()
		  Var LastSync As DateTime = Ark.DataSource.SharedInstance.LastSync
		  If IsNull(LastSync) Then
		    Me.Text = "No engram data available"
		  Else
		    Me.Text = "Engrams updated " + LastSync.ToString(Locale.Current, DateTime.FormatStyles.Long, DateTime.FormatStyles.Short) + " UTC"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TitleCanvas
	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
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
		Sub Open()
		  Me.Text = Beacon.WebURL()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  System.GotoURL(Me.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
