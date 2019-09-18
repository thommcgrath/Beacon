#tag Window
Begin LibrarySubview LibraryPaneMenu Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
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
		Sub Closing()
		  NotificationKit.Ignore(Self, Preferences.Notification_OnlineTokenChanged, Preferences.Notification_OnlineStateChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
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
		    If App.IdentityManager.CurrentIdentity = Nil Or App.IdentityManager.CurrentIdentity.LoginKey = "" Then
		      Links.Append("Sign In" : "beacon://signin")
		    Else
		      Links.Append(App.IdentityManager.CurrentIdentity.LoginKey : "")
		      Links.Append("Manage Account" : "beacon://showaccount")
		      Links.Append("Sign Out" : "beacon://signout")
		    End If
		  End If
		  Links.Append(Nil)
		  
		  Links.Append("Admin Spawn Codes" : "beacon://spawncodes")
		  Links.Append("Report a Problem" : "beacon://reportproblem")
		  
		  Self.SetContents(Links)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetContents(Links() As Pair)
		  If Self.mLabelsBound = Links.LastRowIndex Then
		    // Possibly unchanged
		    Dim Changed As Boolean
		    For I As Integer = 0 To Links.LastRowIndex
		      If If(Links(I) <> Nil, Links(I).Left, "") <> Self.Labels(I).Value And If(Links(I) <> Nil, Links(I).Right, "") <> Self.Labels(I).URL Then
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
		  
		  For I As Integer = 0 To Links.LastRowIndex
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
		    Self.Labels(I).Value = If(Links(I) <> Nil, Links(I).Left, "")
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
		Sub Pressed(index as Integer)
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
		    ShowURL(Beacon.WebURL("/account/auth.php?session_id=" + Preferences.OnlineToken + "&return=" + EncodeURLComponent(Beacon.WebURL("/account/"))))
		  Case "beacon://spawncodes"
		    App.ShowSpawnCodes()
		  Case "beacon://reportproblem"
		    App.ShowBugReporter()
		  Case "beacon://exit"
		    Quit
		  Case "beacon://signout"
		    Preferences.OnlineEnabled = False
		    Preferences.OnlineToken = ""
		    App.IdentityManager.CurrentIdentity = Nil
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="TabStop"
		Visible=true
		Group="Position"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
