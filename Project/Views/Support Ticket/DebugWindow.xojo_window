#tag DesktopWindow
Begin BeaconWindow DebugWindow Implements NotificationKit.Receiver
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "#WindowTitle"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin Beacon.Thread CollectionThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   400
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   600
      Begin DesktopLabel ClockLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#ClockCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   148
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel ProjectsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#ProjectsCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel LicensesLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#LicensesCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel UserLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#UserCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel VersionLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         Text            =   "#VersionCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel NetworkLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#NetworkCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel CollectingLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#CollectingCaption"
         TextAlignment   =   2
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel NetworkField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
      Begin DesktopLabel ClockField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   148
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
      Begin DesktopLabel UserField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
      Begin DesktopLabel VersionField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
      Begin DesktopLabel LicenseField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   0
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
      Begin DesktopLabel ProjectField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   0
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   448
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		  
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.Resize()
		  Self.CollectionThread.DebugIdentifier = "DebugWindow.CollectionThread"
		  Self.CollectionThread.Start
		  
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub mResizeTask_Completed(Sender As AnimationKit.MoveTask)
		  #Pragma Unused Sender
		  
		  Self.Pages.SelectedPanelIndex = Self.PageResults
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged
		    Self.UpdateIdentityInfo()
		    
		    Var Width As Integer = Self.Width
		    Var Height As Integer = Self.Height
		    Self.UpdateLayout(Width, Height)
		    Self.Width = Width
		    Self.Height = Height
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present()
		  If mInstance Is Nil Then
		    mInstance = New DebugWindow
		  End If
		  mInstance.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Self.CollectingLabel.Top = (Self.Height - Self.CollectingLabel.Height) / 2.5
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateIdentityInfo()
		  Var IdentityManager As IdentityManager = App.IdentityManager
		  If IdentityManager Is Nil Then
		    Self.UserField.Text = Self.NoUserCaption
		    Self.UpdateLicenses(Nil)
		    Return
		  End If
		  
		  Var CurrentUser As Beacon.Identity = IdentityManager.CurrentIdentity
		  If CurrentUser Is Nil Then
		    Self.UserField.Text = Self.NoUserCaption
		    Self.UpdateLicenses(Nil)
		    Return
		  End If
		  
		  Self.UserField.Text = CurrentUser.Username(True)
		  Self.UpdateLicenses(CurrentUser)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLayout(ByRef Width As Integer, ByRef Height As Integer)
		  BeaconUI.SizeToFit(Self.ClockLabel, Self.LicensesLabel, Self.NetworkLabel, Self.ProjectsLabel, Self.UserLabel, Self.VersionLabel)
		  
		  Var FieldsLeft As Integer = Self.ClockLabel.Right + 12
		  
		  Var Fields() As DesktopLabel = Array(Self.ClockField, Self.NetworkField, Self.UserField, Self.VersionField)
		  For Idx As Integer = 0 To Self.mLicenseFieldCount - 1
		    Fields.Add(Self.LicenseField(Idx))
		  Next
		  For Idx As Integer= 0 To Self.mProjectFieldCount - 1
		    Fields.Add(Self.ProjectField(Idx))
		  Next
		  BeaconUI.SizeToFit(Fields)
		  
		  Self.ClockField.Left = FieldsLeft
		  Self.NetworkField.Left = FieldsLeft
		  Self.UserField.Left = FieldsLeft
		  Self.VersionField.Left = FieldsLeft
		  
		  Var NextTop As Integer = Self.UserField.Bottom + 12
		  For Idx As Integer = 0 To Self.mLicenseFieldCount - 1
		    Self.LicenseField(Idx).Left = FieldsLeft
		    Self.LicenseField(Idx).Top = NextTop
		    NextTop = Self.LicenseField(Idx).Bottom + 12
		  Next
		  
		  Self.ProjectsLabel.Top = NextTop
		  For Idx As Integer= 0 To Self.mProjectFieldCount - 1
		    Self.ProjectField(Idx).Left = FieldsLeft
		    Self.ProjectField(Idx).Top = NextTop
		    NextTop = Self.ProjectField(Idx).Bottom + 12
		  Next
		  
		  Self.ClockLabel.Top = NextTop
		  Self.ClockField.Top = NextTop
		  Self.NetworkLabel.Top = Self.ClockLabel.Bottom + 12
		  Self.NetworkField.Top = Self.NetworkLabel.Top
		  
		  Width = Self.ClockField.Right + 20
		  Height = Self.NetworkField.Bottom + 20
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLicenses(Identity As Beacon.Identity)
		  Var Licenses() As String
		  
		  If (Identity Is Nil) = False Then
		    Var IdentityLicenses() As Beacon.OmniLicense = Identity.Licenses
		    For Each License As Beacon.OmniLicense In IdentityLicenses
		      Licenses.Add(License.Description)
		    Next
		  End If
		  
		  Var FieldCount As Integer = Max(1, Licenses.Count)
		  If Self.mLicenseFieldCount > FieldCount Then
		    For Idx As Integer = Self.mLicenseFieldCount DownTo FieldCount - 1
		      Self.LicenseField(Idx - 1).Close
		    Next
		  ElseIf Self.mLicenseFieldCount < FieldCount Then
		    For Idx As Integer = Self.mLicenseFieldCount + 1 To FieldCount
		      Var Field As DesktopLabel = New LicenseField
		      Call Field.Text // To silence the warning
		    Next
		  End If
		  Self.mLicenseFieldCount = FieldCount
		  If Licenses.Count = 0 Then
		    Self.LicenseField(0).Text = Self.NoLicensesCaption
		  Else
		    For Idx As Integer = 0 To Licenses.LastIndex
		      Self.LicenseField(Idx).Text = Licenses(Idx)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateProjects()
		  Var Views() As DocumentEditorView = App.MainWindow.DocumentEditors
		  Var ProjectNames() As String
		  For Each View As DocumentEditorView In Views
		    Var Project As Beacon.Project = View.Project
		    If Project Is Nil Then
		      Continue
		    End If
		    ProjectNames.Add(Language.GameName(View.GameId) + ": " + Project.Title)
		  Next
		  
		  Var FieldCount As Integer = Max(1, ProjectNames.Count)
		  If Self.mProjectFieldCount > FieldCount Then
		    For Idx As Integer = Self.mProjectFieldCount DownTo FieldCount - 1
		      Self.ProjectField(Idx - 1).Close
		    Next
		  ElseIf Self.mProjectFieldCount < FieldCount Then
		    For Idx As Integer = Self.mProjectFieldCount + 1 To FieldCount
		      Var Field As DesktopLabel = New ProjectField
		      Call Field.Text // To silence the warning
		    Next
		  End If
		  Self.mProjectFieldCount = FieldCount
		  
		  If ProjectNames.Count = 0 Then
		    Self.ProjectField(0).Text = Self.NoProjectsCaption
		  Else
		    For Idx As Integer = 0 To ProjectNames.LastIndex
		      Self.ProjectField(Idx).Text = ProjectNames(Idx)
		    Next
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mInstance As DebugWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLicenseFieldCount As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectFieldCount As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResizeTask As AnimationKit.MoveTask
	#tag EndProperty


	#tag Constant, Name = ClockCaption, Type = String, Dynamic = True, Default = \"Clock:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CollectingCaption, Type = String, Dynamic = True, Default = \"Collecting Debug Info\xE2\x80\xA6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FastClockCaption, Type = String, Dynamic = True, Default = \"fast by \?1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LicensesCaption, Type = String, Dynamic = True, Default = \"Licenses:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NetworkCaption, Type = String, Dynamic = True, Default = \"Network:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NetworkNoProblemsCaption, Type = String, Dynamic = True, Default = \"No problems detected", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NetworkProblemsCaption, Type = String, Dynamic = True, Default = \"Could not connect", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NoLicensesCaption, Type = String, Dynamic = True, Default = \"None", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NoProjectsCaption, Type = String, Dynamic = True, Default = \"None", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NoUserCaption, Type = String, Dynamic = True, Default = \"None", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageCollecting, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageResults, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ProjectsCaption, Type = String, Dynamic = True, Default = \"Open Projects:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SlowClockCaption, Type = String, Dynamic = True, Default = \"slow by \?1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UserCaption, Type = String, Dynamic = True, Default = \"User:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VersionCaption, Type = String, Dynamic = True, Default = \"Version:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WindowTitle, Type = String, Dynamic = True, Default = \"Diagnostic Information", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CollectionThread
	#tag Event
		Sub Run()
		  Var Details As New Dictionary
		  
		  Var Request As New BeaconAPI.Request("/now", "GET")
		  Request.RequiresAuthentication = False
		  
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  Details.Value("System Clock") = Floor(DateTime.Now.SecondsFrom1970) // Do this after the request to minimize latency differences
		  If Response.Success Then
		    Details.Value("Network") = True
		    
		    Try
		      Var Payload As New JSONItem(Response.Content)
		      Details.Value("Official Clock") = Payload.Value("unixEpoch")
		    Catch Err As RuntimeException
		    End Try
		  Else
		    Details.Value("Network") = False
		  End If
		  
		  Details.Value("Event") = "Finished"
		  Me.AddUserInterfaceUpdate(Details)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var EventName As String = Update.Lookup("Event", "")
		    Select Case EventName
		    Case "Finished"
		      Var NetworkSuccess As Boolean = Update.Value("Network")
		      Self.NetworkField.Text = If(NetworkSuccess, Self.NetworkNoProblemsCaption, Self.NetworkProblemsCaption)
		      
		      Var SystemEpoch As Double = Update.Value("System Clock")
		      Var SystemClock As New DateTime(SystemEpoch, New TimeZone(0))
		      Var ClockText As String = SystemClock.SQLDateTime + " GMT"
		      If Update.HasKey("Official Clock") Then
		        Var OfficialEpoch As Double = Update.Value("Official Clock")
		        Var Delta As Double = SystemEpoch - OfficialEpoch
		        If Delta >= 65 Then
		          ClockText = ClockText + " (" + Language.ReplacePlaceholders(Self.FastClockCaption, Beacon.SecondsToString(Delta)) + ")"
		        ElseIf Delta <= -65 Then
		          ClockText = ClockText + " (" + Language.ReplacePlaceholders(Self.SlowClockCaption, Beacon.SecondsToString(Abs(Delta))) + ")"
		        End If
		      End If
		      Self.ClockField.Text = ClockText
		      
		      Self.VersionField.Text = App.Version
		      Self.UpdateIdentityInfo()
		      Self.UpdateProjects()
		      
		      Var NewWidth As Integer = Self.Width
		      Var NewHeight As Integer = Self.Height
		      Self.UpdateLayout(NewWidth, NewHeight)
		      
		      Self.mResizeTask = New AnimationKit.MoveTask(Self)
		      Self.mResizeTask.Left = Self.Left - ((NewWidth - Self.Width) / 2)
		      Self.mResizeTask.Width = NewWidth
		      Self.mResizeTask.Height = NewHeight
		      Self.mResizeTask.DurationInSeconds = 0.15
		      Self.mResizeTask.Curve = AnimationKit.Curve.CreateEaseOut
		      AddHandler Self.mResizeTask.Completed, WeakAddressOf mResizeTask_Completed
		      Self.mResizeTask.Run
		    End Select
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
