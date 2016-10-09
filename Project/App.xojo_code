#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  If Self.LaunchOnQuit <> Nil And Self.LaunchOnQuit.Exists Then
		    Self.LaunchOnQuit.Launch
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileNew.Enable
		  FileOpen.Enable
		  FileImportConfig.Enable
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
		  LocalData.SharedInstance.LoadPresets()
		  
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  If IdentityFile.Exists Then
		    Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(IdentityFile.Convert, Xojo.IO.BinaryStream.LockModes.Read)
		    Dim Data As Xojo.Core.MemoryBlock = Stream.Read(Stream.Length)
		    Stream.Close
		    
		    Dim Contents As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Data)
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Contents)
		    Dim Identity As Beacon.Identity = Beacon.Identity.Import(Dict)
		    Self.mIdentity = Identity
		  Else
		    Dim Identity As New Beacon.Identity
		    Dim Dict As Xojo.Core.Dictionary = Identity.Export
		    
		    Dim Contents As Text = Xojo.Data.GenerateJSON(Dict)
		    Dim Data As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Contents)
		    
		    Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(IdentityFile.Convert, Xojo.IO.BinaryStream.LockModes.Write)
		    Stream.Write(Data)
		    Stream.Close
		    Self.mIdentity = Identity
		  End If
		  
		  Self.mFileLoader = New Xojo.Net.HTTPSocket
		  AddHandler Self.mFileLoader.PageReceived, WeakAddressOf Self.mFileLoader_PageReceived
		  AddHandler Self.mFileLoader.Error, WeakAddressOf Self.mFileLoader_Error
		  AddHandler Self.mFileLoader.AuthenticationRequired, WeakAddressOf Self.mFileLoader_AuthenticationRequired
		  
		  Self.mUpdateChecker = New UpdateChecker
		  AddHandler Self.mUpdateChecker.UpdateAvailable, WeakAddressOf Self.mUpdateChecker_UpdateAvailable
		  Self.mUpdateChecker.Check(True)
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  Dim Win As New DocWindow(Item)
		  Win.Show
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileImportConfig() As Boolean Handles FileImportConfig.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.IniFile
			
			Dim File As FolderItem = Dialog.ShowModal
			If File <> Nil Then
			Dim Win As New DocWindow
			Win.Show
			Win.Import(File)
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
		Function FileOpen() As Boolean Handles FileOpen.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile
			
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

	#tag Method, Flags = &h21
		Private Sub DownloadNextFile()
		  If Self.mFileLoading Or UBound(Self.mFileURLs) = -1 Then
		    Return
		  End If
		  
		  Self.mFileLoading = True
		  Self.mFileLoader.Disconnect
		  
		  Dim URL As Text = Self.mFileURLs(0)
		  Self.mFileURLs.Remove(0)
		  
		  Self.mFileLoader.Send("GET", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String) As Boolean
		  Dim Prefix As String = Beacon.URLScheme + "://"
		  Dim PrefixLength As Integer = Len(Prefix)
		  
		  If Left(URL, PrefixLength) <> Prefix Then
		    Return False
		  End If
		  
		  Dim FileURL As String = "https://" + Mid(URL, PrefixLength + 1)
		  Self.mFileURLs.Append(FileURL.ToText)
		  Self.DownloadNextFile()
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mFileLoader_AuthenticationRequired(Sender As Xojo.Net.HTTPSocket, Realm As Text, ByRef Name As Text, ByRef Password As Text) As Boolean
		  // Can't authenticate
		  
		  Self.mFileLoading = False
		  Self.DownloadNextFile
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mFileLoader_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  Self.mFileLoading = False
		  Self.DownloadNextFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mFileLoader_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  Self.mFileLoading = False
		  Self.DownloadNextFile
		  
		  Dim TextValue As Text
		  Try
		    TextValue = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Catch Err As RuntimeException
		    // Cannot be converted
		    Return
		  End Try
		  
		  Dim Document As Beacon.Document = Beacon.Document.Read(TextValue)
		  If Document = Nil Then
		    // Cannot be parsed correctly
		    Return
		  End If
		  
		  Dim Win As New DocWindow(Document)
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateChecker_UpdateAvailable(Sender As UpdateChecker, Version As String, Notes As String, URL As String, Signature As String)
		  #Pragma Unused Sender
		  
		  UpdateWindow.Present(Version, Notes, URL, Signature)
		End Sub
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
		Private mFileLoader As Xojo.Net.HTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileLoading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileURLs() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
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
