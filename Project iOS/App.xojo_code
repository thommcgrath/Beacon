#tag Class
Protected Class App
Inherits IOSApplication
	#tag CompatibilityFlags = TargetIOS
	#tag Event
		Sub Open()
		  LocalData.Start()
		  Self.LoadIdentity()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ApplicationSupport() As Xojo.IO.FolderItem
		  Return Xojo.IO.SpecialFolder.Documents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As Xojo.IO.FolderItem)
		  If Folder.Exists Then
		    If Not Folder.IsFolder Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Identity(Assigns Value As Beacon.Identity)
		  Self.mIdentity = Value
		  
		  Dim IdentityFile As Xojo.IO.FolderItem = Self.ApplicationSupport.Child("Default" + Self.IdentityExtension)
		  Dim Writer As New Beacon.JSONWriter(Value.Export, IdentityFile)
		  Writer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadIdentity()
		  Dim IdentityFile As Xojo.IO.FolderItem = Self.ApplicationSupport.Child("Default" + Self.IdentityExtension)
		  If IdentityFile.Exists Then
		    Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(IdentityFile, Xojo.Core.TextEncoding.UTF8)
		    Dim Contents As Text = Stream.ReadAll()
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Contents)
		    Dim Identity As Beacon.Identity = Beacon.Identity.Import(Dict)
		    Self.mIdentity = Identity
		  End If
		  If Self.mIdentity = Nil Then
		    Self.Log("Creating new identity")
		    Dim Identity As New Beacon.Identity
		    Dim Dict As Xojo.Core.Dictionary = Identity.Export
		    
		    Dim Contents As Text = Xojo.Data.GenerateJSON(Dict)
		    
		    Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(IdentityFile, Xojo.Core.TextEncoding.UTF8)
		    Stream.Write(Contents)
		    Stream.Close
		    Self.mIdentity = Identity
		  End If
		  Self.Log("Identity is " + Self.mIdentity.Identifier)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As Text)
		  #Pragma Unused Message
		  
		  #if false
		    Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		    Dim LogFile As FolderItem = Self.ApplicationSupport.Child("Events.log")
		    Dim Stream As TextOutputStream = TextOutputStream.Append(LogFile)
		    Stream.WriteLine(Now.ToText + Str(Now.Nanosecond / 1000000000, ".0000000000") + " " + Now.TimeZone.Abbreviation + Chr(9) + Message)
		    Stream.Close
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty


	#tag Constant, Name = BuildNumber, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DocumentExtension, Type = Text, Dynamic = False, Default = \".beacon", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IdentityExtension, Type = Text, Dynamic = False, Default = \".beaconidentity", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PresetExtension, Type = Text, Dynamic = False, Default = \".beaconpreset", Scope = Public
	#tag EndConstant


End Class
#tag EndClass
