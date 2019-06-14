#tag Window
Begin LibrarySubview LibraryPaneMenu Implements NotificationKit.Receiver
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
   Height          =   300
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
   Width           =   300
   Begin LinkLabel Labels
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   0
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
      ShowAsLink      =   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlign       =   0
      TextColor       =   &c0000FF00
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   True
      URL             =   ""
      Visible         =   True
      Width           =   260
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, Preferences.Notification_OnlineTokenChanged, Preferences.Notification_OnlineStateChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.RebuildMenu()
		  NotificationKit.Watch(Self, Preferences.Notification_OnlineTokenChanged, Preferences.Notification_OnlineStateChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case Preferences.Notification_OnlineTokenChanged, Preferences.Notification_OnlineStateChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished
		    Self.RebuildMenu()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RebuildMenu()
		  Dim Links() As Pair
		  Links.Append("Check for Updates" : "beacon://action/checkforupdate")
		  Links.Append("Update Engrams" : "beacon://action/checkforengrams")
		  If Preferences.OnlineEnabled Then
		    If UserCloud.IsBusy Then
		      Links.Append("Syncing Cloud Files…" : "")
		    Else
		      Links.Append("Sync Cloud Files" : "beacon://syncusercloud")
		    End If
		  End If
		  Links.Append("Release Notes" : "beacon://releasenotes")
		  Links.Append(Nil)
		  
		  If Not Preferences.OnlineEnabled Then
		    Links.Append("Enable Cloud && Community" : "beacon://enableonline")
		  Else
		    If App.Identity = Nil Or App.Identity.LoginKey = "" Then
		      Links.Append("Sign In" : "beacon://signin")
		    Else
		      Links.Append(App.Identity.LoginKey : "")
		      Links.Append("Manage Account" : "beacon://showaccount")
		      Links.Append("Sign Out" : "beacon://signout")
		    End If
		  End If
		  Links.Append(Nil)
		  
		  Links.Append("Admin Spawn Codes" : "beacon://spawncodes")
		  Links.Append("Report a Problem" : "beacon://reportproblem")
		  Links.Append("Make a Donation" : "beacon://makedonation")
		  
		  Self.SetContents(Links)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetContents(Links() As Pair)
		  If Self.mLabelsBound = Links.Ubound Then
		    // Possibly unchanged
		    Dim Changed As Boolean
		    For I As Integer = 0 To Links.Ubound
		      If If(Links(I) <> Nil, Links(I).Left, "") <> Self.Labels(I).Text And If(Links(I) <> Nil, Links(I).Right, "") <> Self.Labels(I).URL Then
		        Changed = True
		        Exit For I
		      End If
		    Next
		    If Not Changed Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Self.mLabelsBound DownTo 1
		    If Self.Labels(I) <> Nil Then
		      Self.Labels(I).Close
		    End If
		  Next
		  Self.mLabelsBound = 0
		  
		  For I As Integer = 0 To Links.Ubound
		    Dim LastBottom As Integer = 20
		    If I > 0 Then
		      LastBottom = Self.Labels(I - 1).Top + Self.Labels(I - 1).Height
		    End If
		    
		    If I > Self.mLabelsBound Then
		      Dim NewLabel As New Labels
		      Self.mLabelsBound = NewLabel.Index
		    End If
		    
		    Self.Labels(I).Top = LastBottom
		    Self.Labels(I).Height = 20
		    Self.Labels(I).Left = 20
		    Self.Labels(I).Width = Self.Width - 40
		    Self.Labels(I).Visible = Links(I) <> Nil And Links(I).Left <> ""
		    Self.Labels(I).Text = If(Links(I) <> Nil, Links(I).Left, "")
		    Self.Labels(I).ShowAsLink = If(Links(I) <> Nil, Links(I).Right <> "", False)
		    Self.Labels(I).URL = If(Links(I) <> Nil, Links(I).Right, "")
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLabelsBound As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events Labels
	#tag Event
		Sub Action(index as Integer)
		  Dim URL As String = Self.Labels(Index).URL
		  If URL = "" Then
		    Return
		  End If
		  
		  Select Case URL
		  Case "beacon://releasenotes"
		    App.ShowReleaseNotes()
		  Case "beacon://enableonline"
		    Dim WelcomeWindow As New UserWelcomeWindow(False)
		    WelcomeWindow.ShowModal()
		  Case "beacon://signin"
		    Dim WelcomeWindow As New UserWelcomeWindow(True)
		    WelcomeWindow.ShowModal()
		  Case "beacon://showaccount"
		    ShowURL(Beacon.WebURL("/account/auth.php?session_id=" + Preferences.OnlineToken + "&return=" + Beacon.EncodeURLComponent(Beacon.WebURL("/account/"))))
		  Case "beacon://spawncodes"
		    App.ShowSpawnCodes()
		  Case "beacon://reportproblem"
		    App.ShowBugReporter()
		  Case "beacon://makedonation"
		    App.ShowDonation()
		  Case "beacon://exit"
		    Quit
		  Case "beacon://signout"
		    Preferences.OnlineEnabled = False
		    Preferences.OnlineToken = ""
		    App.Identity = Nil
		    Self.RebuildMenu()
		    Dim WelcomeWindow As New UserWelcomeWindow(False)
		    WelcomeWindow.ShowModal()
		  Case "beacon://syncusercloud"
		    UserCloud.Sync(True)
		    Return // So the pane doesn't close
		  Else
		    If Beacon.IsBeaconURL(URL) Then
		      Call App.HandleURL(URL, True)
		    Else
		      ShowURL(URL)
		    End If
		  End Select
		  
		  Self.CloseLibrary()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
