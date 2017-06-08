#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  If Self.LaunchOnQuit <> Nil And Self.LaunchOnQuit.Exists Then
		    Self.Log("Launching " + Self.LaunchOnQuit.NativePath)
		    Self.LaunchOnQuit.Launch
		  End If
		  
		  Self.Log("Beacon finished gracefully")
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileNew.Enable
		  FileNewPreset.Enable
		  FileOpen.Enable
		  FileImport.Enable
		  
		  Dim Counter As Integer = 1
		  For I As Integer = 0 To WindowCount - 1
		    Dim Win As Window = Window(I)
		    If Win IsA BeaconWindow Then
		      BeaconWindow(Win).UpdateWindowMenu()
		      Counter = Counter + 1
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function HandleAppleEvent(theEvent As AppleEvent, eventClass As String, eventID As String) As Boolean
		  If eventClass = "GURL" And eventID = "GURL" Then
		    Dim URL As String = theEvent.StringParam("----")
		    Return Self.HandleURL(URL)
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub NewDocument()
		  Dim Win As New DocWindow
		  Win.Show
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  #if TargetMacOS
		    Self.Log("Beacon " + Str(Self.NonReleaseVersion, "-0") + " for Mac.")
		  #elseif TargetWin32
		    Self.Log("Beacon " + Str(Self.NonReleaseVersion, "-0") + " for Windows.")
		  #endif
		  
		  Self.mLocalData = New LocalData
		  Beacon.Data = Self.mLocalData
		  
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  If IdentityFile.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(IdentityFile)
		    Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Contents.ToText)
		    Dim Identity As Beacon.Identity = Beacon.Identity.Import(Dict)
		    Self.mIdentity = Identity
		  End If
		  If Self.mIdentity = Nil Then
		    Self.Log("Creating new identity")
		    Dim Identity As New Beacon.Identity
		    Dim Dict As Xojo.Core.Dictionary = Identity.Export
		    
		    Dim Contents As Text = Xojo.Data.GenerateJSON(Dict)
		    
		    Dim Stream As TextOutputStream = TextOutputStream.Create(IdentityFile)
		    Stream.Write(Contents)
		    Stream.Close
		    Self.mIdentity = Identity
		  End If
		  Self.Log("Identity is " + Self.mIdentity.Identifier)
		  
		  Self.mUpdateChecker = New UpdateChecker
		  AddHandler Self.mUpdateChecker.UpdateAvailable, WeakAddressOf Self.mUpdateChecker_UpdateAvailable
		  AddHandler Self.mUpdateChecker.NoUpdate, WeakAddressOf Self.mUpdateChecker_NoUpdate
		  Self.mUpdateChecker.Check(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  If Item.IsType(BeaconFileTypes.JsonFile) Then
		    Try
		      Dim Stream As TextInputStream = TextInputStream.Open(Item)
		      Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		      Stream.Close
		      
		      If Self.mLocalData.Import(Content.ToText) Then
		        // Imported
		        For I As Integer = 0 To WindowCount - 1
		          If Window(I) IsA AboutWindow Then
		            AboutWindow(Window(I)).Update()
		            Exit For I
		          End If
		        Next
		        
		        Dim LastSync As Xojo.Core.Date = Self.mLocalData.LastSync
		        
		        Dim Dialog As New MessageDialog
		        Dialog.Title = ""
		        Dialog.Message = "Engram database has been updated"
		        Dialog.Explanation = "Engrams, loot sources, and presets are now current as of " + LastSync.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Long, Xojo.Core.Date.FormatStyles.Short) + " UTC."
		        Call Dialog.ShowModal
		        Return
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		    
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Unable to import engram data"
		    Dialog.Explanation = "Sorry about that. The file may not be correctly formatted."
		    Call Dialog.ShowModal
		    
		    Return
		  End If
		  
		  If Item.IsType(BeaconFileTypes.BeaconPreset) Then
		    PresetWindow.Present(Item)
		    Return
		  End If
		  
		  If Item.IsType(BeaconFileTypes.BeaconDocument) Or Item.IsType(BeaconFileTypes.IniFile) Then
		    Dim Win As New DocWindow(Item)
		    Win.Show
		    Return
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to open file"
		  Dialog.Explanation = "Beacon doesn't know what to do with the file " + Item.Name
		  Call Dialog.ShowModal
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Error)
		  Dim Stack() As Xojo.Core.StackFrame = Error.CallStack
		  Dim Location As String = "Unknown"
		  If UBound(Stack) >= 0 Then
		    Location = Stack(0).Name
		  End If
		  Dim Reason As String = Error.Reason
		  If Reason = "" Then
		    Reason = Error.Message
		  End If
		  
		  Self.Log("Unhandled " + Info.FullName + " in " + Location + ": " + Reason)
		  
		  Return False
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileImport() As Boolean Handles FileImport.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.JsonFile
			
			Dim File As FolderItem = Dialog.ShowModal
			If File <> Nil Then
			If File.IsType(BeaconFileTypes.BeaconPreset) Then
			Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
			If Preset <> Nil Then
			Beacon.Data.SavePreset(Preset)
			PresetManagerWindow.ShowPreset(Preset)
			Else
			Dim Alert As New MessageDialog
			Alert.Title = ""
			Alert.Message = "Unable to import preset"
			Alert.Explanation = "Sorry about that. The file may not be correctly formatted."
			Call Alert.ShowModal
			End If
			Else
			Self.OpenDocument(File)
			End If
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			Self.NewDocument()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewPreset() As Boolean Handles FileNewPreset.Action
			PresetWindow.Present()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset
			
			Dim File As FolderItem = Dialog.ShowModal()
			If File <> Nil Then
			Self.OpenDocument(File)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAboutBeacon() As Boolean Handles HelpAboutBeacon.Action
			AboutWindow.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAdminSpawnCodes() As Boolean Handles HelpAdminSpawnCodes.Action
			ShowURL(Beacon.WebURL + "/spawncodes.php")
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpCheckforUpdates() As Boolean Handles HelpCheckforUpdates.Action
			UpdateWindow.Present()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpMakeADonation() As Boolean Handles HelpMakeADonation.Action
			ShowURL(Beacon.WebURL + "/donate.php")
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpReportAProblem() As Boolean Handles HelpReportAProblem.Action
			Beacon.ReportAProblem()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowDeveloperTools() As Boolean Handles WindowDeveloperTools.Action
			DeveloperWindow.SharedWindow.Show()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowPresetLibrary() As Boolean Handles WindowPresetLibrary.Action
			PresetManagerWindow.SharedWindow.Show
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Dim AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Dim CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Dim AppFolder As FolderItem = CompanyFolder.Child("Beacon")
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As FolderItem)
		  If Folder.Exists Then
		    If Not Folder.Directory Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String) As Boolean
		  Dim Prefix As String = Beacon.URLScheme + "://"
		  Dim PrefixLength As Integer = Len(Prefix)
		  
		  If Left(URL, PrefixLength) <> Prefix Then
		    Return False
		  End If
		  
		  If Mid(URL, PrefixLength, 8) = "/action/" Then
		    Dim Instructions As String = Mid(URL, PrefixLength + 8)
		    Dim ParamsPos As Integer = InStr(Instructions, "?") - 1
		    Dim Params As String
		    If ParamsPos > -1 Then
		      Params = Mid(Instructions, ParamsPos + 1)
		      Instructions = Left(Instructions, ParamsPos)
		    End If
		    
		    Select Case Instructions
		    Case "showdocuments"
		      DeveloperWindow.SharedWindow.ShowPage(0, Params)
		    Case "showmods"
		      DeveloperWindow.SharedWindow.ShowPage(1, Params)
		    Case "showidentity"
		      DeveloperWindow.SharedWindow.ShowPage(2, Params)
		    Case "showguide"
		      DeveloperWindow.SharedWindow.ShowPage(3, Params)
		    Case "showapibuilder"
		      DeveloperWindow.SharedWindow.ShowPage(4, Params)
		    Case "showpresets"
		      PresetManagerWindow.SharedWindow.Show()
		    Else
		      Break
		    End Select
		  Else
		    URL = ReplaceAll(URL, "thezaz.com/beacon/documents.php/", "thezaz.com/beacon/api/document.php/")
		    
		    Dim FileURL As String = "https://" + Mid(URL, PrefixLength + 1)
		    DocumentDownloadWindow.Begin(FileURL.ToText)
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Identity(Assigns Value As Beacon.Identity)
		  Self.mIdentity = Value
		  
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  Dim Writer As New Beacon.JSONWriter(Value.Export, IdentityFile)
		  Writer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocalData() As LocalData
		  Return Self.mLocalData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  If Self.mLogLock = Nil Then
		    Self.mLogLock = New CriticalSection
		  End If
		  
		  Self.mLogLock.Enter
		  
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim LogFile As FolderItem = Self.ApplicationSupport.Child("Events.log")
		  Dim Stream As TextOutputStream = TextOutputStream.Append(LogFile)
		  Stream.WriteLine(Now.ToText + Str(Now.Nanosecond / 1000000000, ".0000000000") + " " + Now.TimeZone.Abbreviation + Chr(9) + Message)
		  Stream.Close
		  
		  Self.mLogLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateChecker_NoUpdate(Sender As UpdateChecker)
		  #Pragma Unused Sender
		  
		  If Self.Preferences.BooleanValue("Has Shown Subscribe Dialog") = False Then
		    SubscribeDialog.Present()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateChecker_UpdateAvailable(Sender As UpdateChecker, Version As String, Notes As String, URL As String, Signature As String)
		  #Pragma Unused Sender
		  
		  UpdateWindow.Present(Version, Notes, URL, Signature)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Preferences() As Preferences
		  If Self.mPreferences = Nil Then
		    Self.mPreferences = New DesktopPreferences(Self.ApplicationSupport.Child("Preferences.json"))
		  End If
		  Return Self.mPreferences
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourcesFolder() As FolderItem
		  #if TargetMacOS
		    Return Self.ExecutableFile.Parent.Parent.Child("Resources")
		  #else
		    Dim Parent As FolderItem = Self.ExecutableFile.Parent
		    If Parent.Child("Resources").Exists Then
		      Return Parent.Child("Resources")
		    Else
		      Dim Name As String = Left(Self.ExecutableFile.Name, Len(Self.ExecutableFile.Name) - 4)
		      Return Parent.Child(Name + " Resources")
		    End If
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		LaunchOnQuit As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalData As LocalData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreferences As Preferences
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateChecker As UpdateChecker
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
