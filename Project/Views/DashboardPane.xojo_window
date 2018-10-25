#tag Window
Begin BeaconSubview DashboardPane Implements NotificationKit.Receiver
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
   Height          =   556
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
   Width           =   808
   Begin UITweaks.ResizedPushButton NewFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "New Beacon File…"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   260
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
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
   End
   Begin UITweaks.ResizedPushButton OpenFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Open Beacon File…"
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
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
   End
   Begin ControlCanvas LogoCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   128
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   340
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   53
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   128
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
      Top             =   276
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
      Left            =   229
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
      Text            =   "© 2016-2018 Thom McGrath, All Rights Reserved."
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   516
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   350
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
      Top             =   298
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
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   31
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   331
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   193
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   145
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
      Text            =   "https://beaconapp.cc/"
      TextAlign       =   1
      TextColor       =   &c0000FF00
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   330
      Transparent     =   True
      Underline       =   True
      URL             =   ""
      Visible         =   True
      Width           =   350
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, LocalData.Notification_DatabaseUpdated)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.ToolbarCaption = "Home"
		  
		  Self.mMainGroup = New ControlGroup(LogoCanvas, TitleCanvas, VersionLabel, NewFileButton, OpenFileButton, SyncLabel, WebsiteLink)
		  Self.mCopyrightGroup = New ControlGroup(CopyrightLabel)
		  
		  Self.MinHeight = Self.mMainGroup.Height + Self.mCopyrightGroup.Height + 100
		  Self.MinWidth = Max(Self.mMainGroup.Width, Self.mCopyrightGroup.Width) + 40
		  
		  NotificationKit.Watch(Self, LocalData.Notification_DatabaseUpdated)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Self.mCopyrightGroup <> Nil Then
		    Dim Left As Integer = (Self.Width - Self.mCopyrightGroup.Width) / 2
		    Dim Top As Integer = Self.Height - (Self.mCopyrightGroup.Height + 20)
		    Dim DeltaX As Integer = Left - Self.mCopyrightGroup.Left
		    Dim DeltaY As Integer = Top - Self.mCopyrightGroup.Top
		    Self.mCopyrightGroup.Offset(DeltaX, DeltaY)
		  End If
		  
		  If Self.mMainGroup <> Nil Then
		    Dim AvailableTop As Integer = 60
		    Dim AvailableBottom As Integer
		    If Self.mCopyrightGroup <> Nil Then
		      AvailableBottom = Self.mCopyrightGroup.Top - 20
		    Else
		      AvailableBottom = Self.CopyrightLabel.Top - 20
		    End If
		    Dim AvailableHeight As Integer = AvailableBottom - AvailableTop
		    
		    Dim Left As Integer = (Self.Width - Self.mMainGroup.Width) / 2
		    Dim Top As Integer = AvailableTop + Max((AvailableHeight - Self.mMainGroup.Height) / 3, 0)
		    Dim DeltaX As Integer = Left - Self.mMainGroup.Left
		    Dim DeltaY As Integer = Top - Self.mMainGroup.Top
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
		Function DashboardURL() As Text
		  Return Beacon.WebURL("/inapp/dashboard.php/" + Beacon.EncodeURLComponent(Preferences.OnlineToken) + "?build=" + App.NonReleaseVersion.ToText)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_DatabaseUpdated
		    Dim LastSync As Xojo.Core.Date = Notification.UserData
		    If LastSync = Nil Then
		      LastSync = LocalData.SharedInstance.LastSync
		    End If
		    If LastSync = Nil Then
		      Self.SyncLabel.Text = "No engram data available"
		    Else
		      Self.SyncLabel.Text = "Engrams updated " + LastSync.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Long, Xojo.Core.Date.FormatStyles.Short) + " UTC"
		    End If
		  End Select
		End Sub
	#tag EndMethod


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
		  MainWindow.Documents.NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenFileButton
	#tag Event
		Sub Action()
		  MainWindow.Documents.ShowOpenDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LogoCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.DrawPicture(LogoColor, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionLabel
	#tag Event
		Sub Open()
		  Me.Text = "Version " + App.ShortVersion + " (Build " + Str(App.NonReleaseVersion, "-0") + ")"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SyncLabel
	#tag Event
		Sub Open()
		  Dim LastSync As Xojo.Core.Date = LocalData.SharedInstance.LastSync
		  If LastSync = Nil Then
		    Me.Text = "No engram data available"
		  Else
		    Me.Text = "Engrams updated " + LastSync.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Long, Xojo.Core.Date.FormatStyles.Short) + " UTC"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TitleCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.DrawPicture(BeaconUI.IconWithColor(BeaconText,SystemColors.LabelColor), 0, 0)
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
		  ShowURL(Me.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
