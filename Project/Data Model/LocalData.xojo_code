#tag Class
Protected Class LocalData
	#tag Method, Flags = &h1
		Protected Function BuiltinPresetsFolder() As FolderItem
		  Return App.ResourcesFolder.Child("Presets")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CustomPresetsFolder() As FolderItem
		  Dim SupportFolder As FolderItem = App.ApplicationSupport
		  Dim PresetsFolder As FolderItem = SupportFolder.Child("Presets")
		  If PresetsFolder.Exists Then
		    If Not PresetsFolder.Directory Then
		      PresetsFolder.Delete
		      PresetsFolder.CreateAsFolder
		    End If
		  Else
		    PresetsFolder.CreateAsFolder
		  End If
		  Return PresetsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FileForCustomPreset(Preset As Beacon.Preset) As FolderItem
		  Return Self.CustomPresetsFolder.Child(Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Return File.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Dim Folders(1) As FolderItem
		  Folders(0) = Self.BuiltinPresetsFolder
		  Folders(1) = Self.CustomPresetsFolder
		  
		  Dim Extension As String = BeaconFileTypes.BeaconPreset.PrimaryExtension
		  Dim ExtensionLength As Integer = Len(Extension)
		  
		  Redim Self.mPresets(-1)
		  Dim Names() As String
		  
		  For Each Folder As FolderItem In Folders
		    For I As Integer = 1 To Folder.Count
		      Dim File As FolderItem = Folder.Item(I)
		      If Right(File.Name, ExtensionLength) <> Extension Then
		        Continue For I
		      End If
		      
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		      If Preset <> Nil Then
		        Dim Idx As Integer = Names.IndexOf(Preset.Label)
		        If Idx > -1 Then
		          Self.mPresets(Idx) = Preset
		        Else
		          Self.mPresets.Append(Preset)
		          Names.Append(Preset.Label)
		        End If
		      End If
		    Next
		  Next
		  
		  Names.SortWith(Self.mPresets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Append(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePreset(Preset As Beacon.Preset)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  If File.Exists Then
		    File.Delete
		    Self.LoadPresets
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Preset.ToFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance() As LocalData
		  If mSharedInstance = Nil Then
		    mSharedInstance = New LocalData
		  End If
		  Return mSharedInstance
		End Function
	#tag EndMethod


	#tag Note, Name = Plans
		
		ArkData class will be merged into this one.
	#tag EndNote


	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSharedInstance As LocalData
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
