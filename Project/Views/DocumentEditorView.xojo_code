#tag Class
Protected Class DocumentEditorView
Inherits BeaconSubview
Implements NotificationKit.Receiver, ObservationKit.Observer
	#tag Event
		Sub CleanupDiscardedChanges()
		  Self.CleanupAutosave()
		  
		  RaiseEvent CleanupDiscardedChanges()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  RaiseEvent Close
		  
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged)
		  
		  If (Self.Project Is Nil) = False Then
		    Self.Project.RemoveObserver(Self, "Title")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSaveAs.Enabled = True
		  
		  RaiseEvent EnableMenuItems()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged)
		  
		  If (Self.Project Is Nil) = False Then
		    Self.Project.AddObserver(Self, "Title")
		  End If
		  
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  Call RaiseEvent ShouldSave
		  
		  If Self.mController.CanWrite And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeTransient Then  
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		    Self.mController.Save()
		  Else
		    Self.SaveAs()
		  End If
		  Return True
		End Function
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


	#tag Method, Flags = &h1
		Protected Sub Autosave()
		  If Not Self.Project.Modified Then
		    Return
		  End If
		  
		  Var File As BookmarkedFolderItem = Self.AutosaveFile(True)
		  If (File Is Nil) = False And (Self.mController.SaveACopy(Beacon.ProjectURL.URLForFile(File)) Is Nil) = False  Then
		    Self.mAutosaveTimer.Reset
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutosaveFile(CreateFolder As Boolean = False) As BookmarkedFolderItem
		  If Self.Project Is Nil Then
		    Return Nil
		  End If
		  
		  If Self.mAutosaveFile Is Nil Or Not Self.mAutosaveFile.Exists Then
		    If (Self.mController.AutosaveURL Is Nil) = False Then
		      Try
		        Self.mAutosaveFile = Self.mController.AutosaveURL.File
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Self.mAutosaveFile Is Nil Or Not Self.mAutosaveFile.Exists Then
		      Var Folder As FolderItem = App.AutosaveFolder(CreateFolder)
		      If Folder = Nil Then
		        Return Nil
		      End If
		      Self.mAutosaveFile = New BookmarkedFolderItem(Folder.Child(Self.Project.UUID + Beacon.FileExtensionProject))
		    End If
		  End If
		  
		  Return Self.mAutosaveFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupAutosave()
		  Var AutosaveFile As FolderItem = Self.AutosaveFile()
		  If AutosaveFile <> Nil And AutosaveFile.Exists Then
		    Try
		      AutosaveFile.Remove
		    Catch Err As IOException
		      App.Log("Autosave " + AutosaveFile.NativePath + " did not delete: " + Err.Message + " (code: " + Err.ErrorNumber.ToString + ")")
		      Try
		        Var Destination As FolderItem = SpecialFolder.Temporary.Child("Beacon Autosave")
		        If Not Destination.Exists Then
		          Destination.CreateFolder
		        End If
		        Destination = Destination.Child(v4UUID.Create + ".beacon")
		        AutosaveFile.MoveTo(Destination)
		      Catch DeeperError As RuntimeException
		        App.Log("And unable to move the file to system temp for cleanup later: " + DeeperError.Message + " (code: " + DeeperError.ErrorNumber.ToString + ")")
		      End Try
		    End Try
		    Self.mAutosaveFile = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Controller As Beacon.ProjectController)
		  Self.mController = Controller
		  AddHandler Controller.WriteSuccess, WeakAddressOf mController_WriteSuccess
		  AddHandler Controller.WriteError, WeakAddressOf mController_WriteError
		  Self.ViewTitle = Controller.Name
		  Self.UpdateViewIcon
		  
		  Self.ViewID = Controller.URL.Hash
		  
		  Self.mAutosaveTimer = New Timer
		  Self.mAutosaveTimer.Period = 60000
		  Self.mAutoSaveTimer.RunMode = Timer.RunModes.Multiple
		  AddHandler mAutosaveTimer.Action, WeakAddressOf mAutosaveTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Controller() As Beacon.ProjectController
		  Return Self.mController
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Controller As Beacon.ProjectController) As DocumentEditorView
		  #if DebugBuild
		    #Pragma Warning "Does not detect project type"
		  #else
		    #Pragma Error "Does not detect project type"
		  #endif
		  Return New ArkDocumentEditorView(Controller)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.mController <> Nil Then
		    RemoveHandler Self.mController.WriteSuccess, WeakAddressOf mController_WriteSuccess
		    RemoveHandler Self.mController.WriteError, WeakAddressOf mController_WriteError
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  If (Self.mController Is Nil) = False And (Self.mController.Project Is Nil) = False Then
		    Return Self.mController.Project.GameID
		  End If
		End Function
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
		  
		  If Reason.Encoding = Nil Then
		    Reason = Reason.GuessEncoding
		  End If
		  
		  // This has been made thread safe
		  Self.ShowAlert("Uh oh, the project " + Sender.Name + " did not save!", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.ProjectController)
		  If Not Self.Closed Then
		    Self.Changed = (Sender.Project Is Nil) = False And Sender.Project.Modified
		    Self.ViewTitle = Sender.Name
		    Self.Progress = BeaconSubview.ProgressNone
		    If (Self.LinkedOmniBarItem Is Nil) = False And (Self.LinkedOmniBarItem.Name <> Self.mController.URL.Hash) Then
		      Self.LinkedOmniBarItem.Name = Self.mController.URL.Hash
		    End If
		    Self.UpdateViewIcon()
		  End If
		  
		  Preferences.AddToRecentDocuments(Sender.URL)
		  
		  Self.ViewID = Sender.URL.Hash
		  
		  If Sender.Project Is Nil Or Sender.Project.Modified = False Then
		    // Safe to cleanup the autosave
		    Self.CleanupAutosave()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged
		    RaiseEvent IdentityChanged()
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
		    Self.Changed = True
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Beacon.Project
		  Return Self.mController.Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveAs()
		  Select Case DocumentSaveToCloudWindow.Present(Self.TrueWindow, Self.mController)
		  Case DocumentSaveToCloudWindow.StateSaved
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Case DocumentSaveToCloudWindow.StateSaveLocal
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = Self.mController.Name + Beacon.FileExtensionProject
		    Dialog.Filter = BeaconFileTypes.BeaconDocument
		    
		    Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
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
		    Self.mController.SaveAs(Beacon.ProjectURL.URLForFile(New BookmarkedFolderItem(File)))
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchToEditor(EditorName As String)
		  RaiseEvent SwitchToEditor(EditorName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateViewIcon()
		  Select Case Self.mController.URL.Scheme
		  Case Beacon.ProjectURL.TypeCloud
		    Self.ViewIcon = IconCloudDocument
		  Case Beacon.ProjectURL.TypeWeb
		    Self.ViewIcon = IconCommunityDocument
		  Else
		    Self.ViewIcon = Nil
		  End Select
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
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IdentityChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldSave() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SwitchToEditor(EditorName As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAutosaveFile As BookmarkedFolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoSaveTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.ProjectController
	#tag EndProperty


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
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
			Type="Boolean"
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
