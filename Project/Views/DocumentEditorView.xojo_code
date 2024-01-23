#tag Class
Protected Class DocumentEditorView
Inherits BeaconSubview
Implements NotificationKit.Receiver,ObservationKit.Observer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) )
	#tag Event
		Sub CleanupDiscardedChanges()
		  Self.CleanupAutosave()
		  
		  RaiseEvent CleanupDiscardedChanges()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Closing()
		  RaiseEvent Closing
		  
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged)
		  
		  If (Self.Project Is Nil) = False Then
		    Self.Project.RemoveObserver(Self, "Title")
		    Self.Project.RemoveObserver(Self, "Role")
		  End If
		  
		  Self.UnsubscribeFromProjectChannel()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ContentsChanged()
		  If Self.Project.ReadOnly Then
		    Return
		  End If
		  
		  RaiseEvent ContentsChanged
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSaveAs.Enabled = True
		  
		  RaiseEvent EnableMenuItems()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged)
		  
		  If (Self.Project Is Nil) = False Then
		    Self.Project.AddObserver(Self, "Title")
		    Self.Project.AddObserver(Self, "Role")
		  End If
		  
		  Self.SubscribeToProjectChannel()
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShouldSave(CloseWhenFinished As Boolean)
		  If Self.Project.ReadOnly Then
		    Self.ShowAlert("This is a read-only project", "Your access to this project does not allow saving.")
		    Return
		  End If
		  
		  Self.mCloseAfterSave = CloseWhenFinished
		  
		  RaiseEvent ShouldSave(CloseWhenFinished)
		  
		  If Self.mController.CanWrite And Self.mController.URL.Type <> Beacon.ProjectURL.TypeTransient Then  
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		    Self.mController.Save()
		  Else
		    Self.SaveAs()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  
		  If Self.mFirstShow Then
		    If Self.Project.PasswordDecrypted = False Then
		      Call CallLater.Schedule(1000, AddressOf ShowDecryptionError)
		    End If
		    Self.mFirstShow = False
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Call Self.SaveAs()
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ActiveConfigSet() As Beacon.ConfigSet
		  Return Self.Project.ActiveConfigSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActiveConfigSet(Assigns Value As Beacon.ConfigSet)
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Autosave()
		  If Self.Project.Modified = False Or Self.Project.ReadOnly Then
		    Return
		  End If
		  
		  If Self.mAutosaveURL Is Nil Then
		    Var AutosaveFolder As FolderItem = App.AutosaveFolder(True)
		    Var AutosaveFile As New BookmarkedFolderItem(AutosaveFolder.Child(Self.Project.ProjectId + Beacon.FileExtensionProject))
		    If AutosaveFile.Exists = False Then
		      Call AutosaveFile.Write("")
		    End If
		    
		    Self.mAutosaveURL = Beacon.ProjectURL.Create(Self.Project, AutosaveFile)
		    Self.mAutosaveURL.Autosave = True
		  End If
		  
		  Var AutosaveController As Beacon.ProjectController = Self.mController.SaveACopy(Self.mAutosaveURL)
		  If (AutosaveController Is Nil) = False Then
		    #if DebugBuild
		      System.DebugLog("Autosaved")
		    #endif
		    Self.mAutoSaveTimer.Reset
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupAutosave()
		  If Self.mAutosaveURL Is Nil Then
		    Return
		  End If
		  
		  Var AutosaveFile As BookmarkedFolderItem = Self.mAutosaveURL.File
		  If AutosaveFile Is Nil Or AutosaveFile.Exists = False Then
		    Return
		  End If
		  
		  Try
		    AutosaveFile.Remove
		  Catch Err As IOException
		    App.Log("Autosave " + AutosaveFile.NativePath + " did not delete: " + Err.Message + " (code: " + Err.ErrorNumber.ToString + ")")
		    
		    Try
		      Var Destination As FolderItem = SpecialFolder.Temporary.Child("Beacon Autosave")
		      If Not Destination.Exists Then
		        Destination.CreateFolder
		      End If
		      Destination = Destination.Child(Beacon.UUID.v4.StringValue + ".beacon")
		      AutosaveFile.MoveTo(Destination)
		    Catch DeeperError As RuntimeException
		      App.Log("And unable to move the file to system temp for cleanup later: " + DeeperError.Message + " (code: " + DeeperError.ErrorNumber.ToString + ")")
		    End Try
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Controller As Beacon.ProjectController)
		  Self.mFirstShow = True
		  
		  If Self.mEditorRefs Is Nil Then
		    Self.mEditorRefs = New Dictionary
		  End If
		  Self.mEditorRefs.Value(Controller.Project.ProjectId) = New WeakRef(Self)
		  
		  Self.mController = Controller
		  If (Self.mController.AutosaveURL Is Nil) = False Then
		    Self.mAutosaveURL = Self.mController.AutosaveURL
		    Self.mController.AutosaveURL = Nil
		  End If
		  
		  AddHandler Self.mController.WriteError, WeakAddressOf mController_WriteError
		  AddHandler Self.mController.WriteSuccess, WeakAddressOf mController_WriteSuccess
		  Self.ViewTitle = Controller.Name
		  Self.UpdateViewIcon
		  
		  Self.ViewID = Controller.URL.Path
		  
		  Self.mAutosaveTimer = New Timer
		  Self.mAutosaveTimer.Period = 60000
		  Self.mAutoSaveTimer.RunMode = Timer.RunModes.Multiple
		  AddHandler mAutosaveTimer.Action, WeakAddressOf mAutosaveTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Controller() As Beacon.ProjectController
		  Return Self.mController
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Controller As Beacon.ProjectController) As DocumentEditorView
		  Select Case Controller.GameId
		  Case Ark.Identifier
		    Return New ArkDocumentEditorView(Controller)
		  Case SDTD.Identifier
		    Return New SDTDDocumentEditorView(Controller)
		  Case ArkSA.Identifier
		    Return New ArkSADocumentEditorView(Controller)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentConfigName() As String
		  Return Self.mCurrentConfigName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentConfigName(Assigns Value As String)
		  Self.mCurrentConfigName = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If (Self.mEditorRefs Is Nil) = False And Self.mEditorRefs.HasKey(Self.Project.ProjectId) Then
		    Self.mEditorRefs.Remove(Self.Project.ProjectId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function EditorForProject(Project As Beacon.Project) As DocumentEditorView
		  If Project Is Nil Then
		    Return Nil
		  End If
		  
		  Return EditorForProject(Project.ProjectId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function EditorForProject(ProjectId As String) As DocumentEditorView
		  If mEditorRefs Is Nil Then
		    Return Nil
		  End If
		  
		  For Idx As Integer = 0 To mEditorRefs.KeyCount - 1
		    Var Key As Variant = mEditorRefs.Key(Idx)
		    Var Ref As WeakRef = mEditorRefs.Value(Key)
		    If (Ref Is Nil) = False And (Ref.Value Is Nil) = False And Ref.Value IsA DocumentEditorView And DocumentEditorView(Ref.Value).Project.ProjectId = ProjectId Then
		      Return DocumentEditorView(Ref.Value)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function EditorsForGameId(ParamArray GameIds() As String) As DocumentEditorView()
		  Var Editors() As DocumentEditorView
		  If mEditorRefs Is Nil Then
		    Return Editors
		  End If
		  
		  For Idx As Integer = 0 To mEditorRefs.KeyCount - 1
		    Var Key As Variant = mEditorRefs.Key(Idx)
		    Var Ref As WeakRef = mEditorRefs.Value(Key)
		    If (Ref Is Nil) = False And (Ref.Value Is Nil) = False And Ref.Value IsA DocumentEditorView And GameIds.IndexOf(DocumentEditorView(Ref.Value).Project.GameId) > -1 Then
		      Editors.Add(DocumentEditorView(Ref.Value))
		    End If
		  Next
		  
		  Return Editors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  If (Self.mController Is Nil) = False And (Self.mController.Project Is Nil) = False Then
		    Return Self.mController.Project.GameId
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ManageConfigSets()
		  If ConfigSetManagerWindow.Present(Self, Self.Project) = False Then
		    Return
		  End If
		  
		  Self.ActiveConfigSet = Self.ActiveConfigSet
		  Self.Modified = Self.Project.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAutosaveTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.Autosave()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteError(Sender As Beacon.ProjectController, Reason As String)
		  If Not Self.Closed Then
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  If Reason.Encoding Is Nil Then
		    Reason = Reason.DefineEncoding(Encodings.UTF8)
		  End If
		  
		  // This has been made thread safe
		  Self.ShowAlert("Uh oh, the project " + Sender.Name + " did not save!", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.ProjectController)
		  If Not Self.Closed Then
		    Self.Modified = (Sender.Project Is Nil) = False And Sender.Project.Modified
		    Self.ViewTitle = Sender.Name
		    Self.Progress = BeaconSubview.ProgressNone
		    If (Self.LinkedOmniBarItem Is Nil) = False And (Self.LinkedOmniBarItem.Name <> Self.mController.URL.Path) Then
		      Self.LinkedOmniBarItem.Name = Self.mController.URL.Path
		    End If
		    Self.UpdateViewIcon()
		  End If
		  
		  Preferences.AddToRecentDocuments(Sender.URL)
		  
		  Self.ViewID = Sender.URL.Path
		  
		  If Sender.Project Is Nil Or Sender.Project.Modified = False Then
		    // Safe to cleanup the autosave
		    Self.CleanupAutosave()
		  End If
		  
		  If Self.mCloseAfterSave Then
		    Self.RequestClose()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mMembersUpdateThread_Run(Sender As Thread)
		  Sender.YieldToNext
		  Try
		    Self.mController.UpdateProjectMembers
		  Catch Err As RuntimeException
		  End Try
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mMembersUpdateThread_UserInterfaceUpdate(Sender As Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.Lookup("Finished", False).BooleanValue = True Then
		        Self.Modified = Self.Project.Modified
		        Self.UpdateViewIcon()
		        Self.mMembersUpdateThread = Nil
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NewConfigSet()
		  Var NewSetName As String = ConfigSetNamingWindow.Present(Self)
		  If NewSetName.IsEmpty Then
		    Return
		  End If
		  
		  Var Set As Beacon.ConfigSet = Self.Project.ConfigSet(NewSetName)
		  If (Set Is Nil) = False Then
		    Self.ActiveConfigSet = Set
		    Self.ShowAlert("You have been switched to the " + NewSetName + " config set.", "This project already has a " + NewSetName + " config set, so it has been switched to.")
		    Return
		  End If
		  
		  Set = New Beacon.ConfigSet(NewSetName)
		  Self.Project.AddConfigSet(Set)
		  Self.ActiveConfigSet = Set
		  Self.Modified = Self.Project.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged
		    RaiseEvent IdentityChanged()
		    
		    Self.mSubscribedToProjectChannel = False
		    Self.SubscribeToProjectChannel()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused OldValue
		  #Pragma Unused NewValue
		  
		  Select Case Key
		  Case "Title"
		    Self.ViewTitle = Self.mController.Name
		    Self.Modified = True
		  Case "Role"
		    Self.UpdateViewIcon()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Beacon.Project
		  Return Self.mController.Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProjectChannel() As String
		  Var Project As Beacon.Project = Self.Project
		  If (Project Is Nil) = False Then
		    Return "project-" + Project.ProjectId.ReplaceAll("-", "").Lowercase
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_MembersUpdated(ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  #Pragma Unused Payload
		  
		  Var UpdateThread As New Thread
		  AddHandler UpdateThread.Run, AddressOf mMembersUpdateThread_Run
		  AddHandler UpdateThread.UserInterfaceUpdate, AddressOf mMembersUpdateThread_UserInterfaceUpdate
		  Self.mMembersUpdateThread = UpdateThread
		  UpdateThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_ProjectSaved(ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  
		  Var Json As Dictionary = Beacon.ParseJson(Payload)
		  Var User As Dictionary = Json.Value("user")
		  Var OtherUserId As String = User.Value("userId")
		  Var OtherUsername As String = User.Value("username")
		  
		  Var Message, Explanation As String
		  Var ProjectName As String = Self.Project.Title
		  If (App.IdentityManager Is Nil) = False And OtherUserId = App.IdentityManager.CurrentUserId Then
		    // User has the project open on two devices
		    Message = "The project '" + ProjectName + "' was just saved on another device"
		    If Self.Project.Modified = False Then
		      Explanation = "You should close this project and work on it from one device at a time."
		    Else
		      Explanation = "If you save now, your changes will overwrite the changes you just made on the other device. You should only work on a project from one device at a time."
		    End If
		  Else
		    // Two users have edited this project
		    Message = "The project '" + ProjectName + "' was just saved by " + OtherUsername
		    If Self.Project.Modified = False Then
		      Explanation = "You should close and reload this project to get the latest version."
		    Else
		      Explanation = "If you save now, your changes will overwrite the changes just made by " + OtherUsername + ". You should discard your changes and reload this project to safely continue working on this project."
		    End If
		  End If
		  
		  Self.RequestFrontmost
		  Self.ShowAlert(Message, Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveAs()
		  If Self.Project.ReadOnly Then
		    Self.ShowAlert("This is a read-only project", "Your access to this project does not allow saving.")
		    Return
		  End If
		  
		  Select Case DocumentSaveToCloudWindow.Present(Self.TrueWindow, Self.mController)
		  Case DocumentSaveToCloudWindow.StateSaved
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Case DocumentSaveToCloudWindow.StateSaveLocal
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = Self.mController.Name + Beacon.FileExtensionProject
		    Dialog.Filter = BeaconFileTypes.BeaconDocument
		    
		    Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    If Self.Project.Title.BeginsWith("Untitled Project") Then
		      Var Filename As String = File.Name
		      Var Extension As String = Beacon.FileExtensionProject
		      If Filename.EndsWith(Extension) Then
		        Filename = Filename.Left(Filename.Length - Extension.Length).Trim
		      End If
		      Self.Project.Title = Filename
		    End If
		    
		    Self.Project.NewIdentifier()
		    Call File.Write("")
		    Var Url As Beacon.ProjectURL = Beacon.ProjectURL.Create(Self.Project, New BookmarkedFolderItem(File))
		    Self.mController.SaveAs(Url)
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShowDecryptionError()
		  Var Project As Beacon.Project = Self.Project
		  If Project.PasswordDecrypted Then
		    Return
		  End If
		  
		  Self.RequestFrontmost() // Just in case
		  
		  Var Message As String = "Private data in this project could not be decrypted"
		  Var Explanation As String = "This can happen if you have done a password reset since the last time this project was saved."
		  If Self.Project.MemberCount > 1 Then
		    Explanation = Explanation + " Your project has other members that may have the project password. Ask another member to resave the project. If this isn't possible, the project will need a new encryption key, which will destroy its private data like server info."
		  Else
		    Explanation = Explanation + " Your project will need a new encryption key, which will destroy its private data like server info."
		  End If
		  Explanation = Explanation + " You will not be able to save changes to your project without an encryption key."
		  
		  If Self.ShowConfirm(Message, Explanation, "New Key", "Cancel") Then
		    Project.Password = Crypto.GenerateRandomBytes(32)
		  End If
		  
		  Self.Modified = Project.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SubscribeToProjectChannel()
		  If Self.mSubscribedToProjectChannel Then
		    Return
		  End If
		  
		  Select Case Self.mController.URL.Type
		  Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared
		    Var ProjectChannel As String = Self.ProjectChannel
		    If ProjectChannel.IsEmpty = False Then
		      App.Pusher.Subscribe(ProjectChannel)
		      App.Pusher.Listen(ProjectChannel, "project-saved", WeakAddressOf Pusher_ProjectSaved)
		      App.Pusher.Listen(ProjectChannel, "members-updated", WeakAddressOf Pusher_MembersUpdated)
		      Self.mSubscribedToProjectChannel = True
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchToEditor(EditorName As String)
		  RaiseEvent SwitchToEditor(EditorName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UnsubscribeFromProjectChannel()
		  If Not Self.mSubscribedToProjectChannel Then
		    Return
		  End If
		  
		  App.Pusher.Unsubscribe(Self.ProjectChannel)
		  App.Pusher.Ignore(ProjectChannel, "project-saved", WeakAddressOf Pusher_ProjectSaved)
		  App.Pusher.Ignore(ProjectChannel, "members-updated", WeakAddressOf Pusher_MembersUpdated)
		  Self.mSubscribedToProjectChannel = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateViewIcon()
		  If (Self.mController.Project Is Nil) = False And Self.mController.Project.ReadOnly Then
		    Self.ViewIcon = IconPreviewDocument
		  Else
		    Self.ViewIcon = Self.mController.URL.ViewIcon
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Beacon.ProjectURL
		  Return Self.mController.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "projects", "Projects")
		  Else
		    Return If(Lowercase, "project", "Project")
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CleanupDiscardedChanges()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContentsChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IdentityChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldSave(CloseWhenFinished As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SwitchToEditor(EditorName As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAutoSaveTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutosaveURL As Beacon.ProjectURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCloseAfterSave As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.ProjectController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentConfigName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mEditorRefs As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFirstShow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMembersUpdateThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubscribedToProjectChannel As Boolean
	#tag EndProperty


	#tag Constant, Name = LocalMinHeight, Type = Double, Dynamic = False, Default = \"400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LocalMinWidth, Type = Double, Dynamic = False, Default = \"500", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningMinimalExplanation, Type = String, Dynamic = True, Default = \"A \'Beacon Omni for Minimal Games\' license covers games which do not have the complexity to warrant their own license. As such\x2C there is no free version of Beacon for these games.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningMinimalMessage, Type = String, Dynamic = True, Default = \"Beacon\'s support for \?1 requires a \'Beacon Omni for Minimal Games\' license.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningPluralExplanation, Type = String, Dynamic = True, Default = \"The \?1 editors require a \'Beacon Omni for \?2\' license\x2C which you have not purchased. Beacon will not generate their content for your config files. Do you still want to continue\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningPluralMessage, Type = String, Dynamic = True, Default = \"You are using editors that will not be included in your config files.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningSingularExplanation, Type = String, Dynamic = True, Default = \"The \?1 editor requires a \'Beacon Omni for \?2\' license\x2C which you have not purchased. Beacon will not generate its content for your config files. Do you still want to continue\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniWarningSingularMessage, Type = String, Dynamic = True, Default = \"You are using an editor that will not be included in your config files.", Scope = Protected
	#tag EndConstant


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
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="500"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
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
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
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
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
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
			Name="IsFrontmost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
