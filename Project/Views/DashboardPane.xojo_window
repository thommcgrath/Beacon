#tag Window
Begin BeaconSubview DashboardPane Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   556
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
   Width           =   808
   Begin UITweaks.ResizedPushButton NewFileButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "New Beacon File…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
   End
   Begin UITweaks.ResizedPushButton OpenFileButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Open Beacon File…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   243
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
   End
   Begin ControlCanvas LogoCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Enabled         =   True
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
      Tooltip         =   ""
      Top             =   53
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   128
   End
   Begin Label VersionLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "1"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   275
      Transparent     =   True
      Underline       =   False
      Value           =   "Version X"
      Visible         =   True
      Width           =   350
   End
   Begin Label CopyrightLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
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
      Text            =   "© 2016-2019 Thom McGrath, All Rights Reserved."
      TextAlign       =   "1"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   516
      Transparent     =   True
      Underline       =   False
      Value           =   "© 2016-2019 Thom McGrath, All Rights Reserved."
      Visible         =   True
      Width           =   350
   End
   Begin Label SyncLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "1"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   297
      Transparent     =   True
      Underline       =   False
      Value           =   "Engrams Updated Y"
      Visible         =   True
      Width           =   350
   End
   Begin ControlCanvas TitleCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   281
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
      Tooltip         =   ""
      Top             =   193
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   247
   End
   Begin LinkLabel WebsiteLink
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "1"
      TextAlignment   =   "2"
      TextColor       =   &c0000FF00
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   329
      Transparent     =   True
      Underline       =   True
      URL             =   ""
      Value           =   "https://beaconapp.cc/"
      Visible         =   True
      Width           =   350
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, LocalData.Notification_DatabaseUpdated, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ToolbarCaption = "Home"
		  
		  Self.mMainGroup = New ControlGroup(LogoCanvas, TitleCanvas, VersionLabel, NewFileButton, OpenFileButton, SyncLabel, WebsiteLink)
		  Self.mCopyrightGroup = New ControlGroup(CopyrightLabel)
		  
		  Self.MinimumHeight = Self.mMainGroup.Height + Self.mCopyrightGroup.Height + 100
		  Self.MinimumWidth = Max(Self.mMainGroup.Width, Self.mCopyrightGroup.Width) + 40
		  
		  NotificationKit.Watch(Self, LocalData.Notification_DatabaseUpdated, IdentityManager.Notification_IdentityChanged)
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
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_DatabaseUpdated
		    Dim LastSync As Date = Notification.UserData
		    If IsNull(LastSync) Then
		      LastSync = LocalData.SharedInstance.LastSync
		    End If
		    If IsNull(LastSync) Then
		      Self.SyncLabel.Value = "No engram data available"
		    Else
		      Self.SyncLabel.Value = "Engrams updated " + LastSync.ToString(Locale.Current, Date.FormatStyles.Long, Date.FormatStyles.Short) + " UTC"
		    End If
		  Case IdentityManager.Notification_IdentityChanged
		    Self.TitleCanvas.Invalidate
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
		Sub Pressed()
		  MainWindow.Documents.NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenFileButton
	#tag Event
		Sub Pressed()
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
		Sub Opening()
		  Me.Value = "Version " + App.BuildVersion
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SyncLabel
	#tag Event
		Sub Opening()
		  Dim LastSync As Date = LocalData.SharedInstance.LastSync
		  If IsNull(LastSync) Then
		    Me.Value = "No engram data available"
		  Else
		    Me.Value = "Engrams updated " + LastSync.ToString(Locale.Current, Date.FormatStyles.Long, Date.FormatStyles.Short) + " UTC"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TitleCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim TitleIcon As Picture
		  If App.IdentityManager.CurrentIdentity <> Nil And App.IdentityManager.CurrentIdentity.OmniVersion > 0 Then
		    TitleIcon = IconBeaconOmniText
		  Else
		    TitleIcon = IconBeaconText
		  End If
		  G.DrawPicture(BeaconUI.IconWithColor(TitleIcon, SystemColors.LabelColor), 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WebsiteLink
	#tag Event
		Sub Opening()
		  Me.Value = Beacon.WebURL()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  ShowURL(Me.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
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
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
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
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
