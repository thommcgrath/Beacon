#tag Class
Protected Class Document
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Add(LootSource As Beacon.LootSource)
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Return
		    End If
		  Next
		  Self.mLootSources.Append(LootSource)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconCount() As Integer
		  Return UBound(Self.mLootSources) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim Bytes As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		  Dim Id As New Xojo.Core.MutableMemoryBlock(Bytes)
		  Dim Value As UInt8
		  
		  Value = Id.UInt8Value(6)
		  Value = Value And CType(&b00001111, UInt8)
		  Value = Value Or CType(&b01000000, UInt8)
		  Id.UInt8Value(6) = Value
		  
		  Value = Id.UInt8Value(8)
		  Value = Value And CType(&b00111111, UInt8)
		  Value = Value Or CType(&b10000000, UInt8)
		  Id.UInt8Value(8) = Value
		  
		  Dim Chars() As Text
		  For I As Integer = 0 To Id.Size - 1
		    Chars.Append(Id.UInt8Value(I).ToHex(2))
		  Next
		  
		  Chars.Insert(10, "-")
		  Chars.Insert( 8, "-")
		  Chars.Insert( 6, "-")
		  Chars.Insert( 4, "-")
		  
		  Self.mIdentifier = Beacon.CreateUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    Source.ConsumeMissingEngrams(Engrams)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim LootSources() As Xojo.Core.Dictionary
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    LootSources.Append(LootSource.Export)
		  Next
		  
		  Dim Document As New Xojo.Core.Dictionary
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.mIdentifier
		  Document.Value("LootSources") = LootSources
		  Document.Value("Title") = Self.Title
		  Document.Value("Description") = Self.Description
		  Document.Value("Public") = Self.IsPublic
		  Document.Value("MapPreference") = Self.MapPreference
		  
		  Return Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasLootSource(LootSource As Beacon.LootSource) As Boolean
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As Text
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    If Not Source.IsValid Then
		      Return False
		    End If
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSource(Index As Integer) As Beacon.LootSource
		  Return Self.mLootSources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSources() As Beacon.LootSource()
		  Dim Results() As Beacon.LootSource
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    Results.Append(LootSource)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    If Source.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Source As Beacon.LootSource In Self.mLootSources
		      Source.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Document) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mIdentifier.Compare(Other.mIdentifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function Read(File As Global.FolderItem) As Beacon.Document
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Return Beacon.Document.Read(Contents.ToText)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Read(Contents As Text) As Beacon.Document
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim LootSources() As Auto
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  Dim Version As Integer
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // New style document
		    Dim Dict As Xojo.Core.Dictionary = Parsed
		    Try
		      If Dict.HasKey("LootSources") Then
		        LootSources = Dict.Value("LootSources")
		      Else
		        LootSources = Dict.Value("Beacons")
		      End If
		      Doc.mIdentifier = Dict.Value("Identifier")
		      Version = Dict.Lookup("Version", 0)
		      
		      If Dict.HasKey("Title") Then
		        Doc.mTitle = Dict.Value("Title")
		      End If
		      If Dict.HasKey("Description") Then
		        Doc.mDescription = Dict.Value("Description")
		      End If
		      If Dict.HasKey("Public") Then
		        Doc.mIsPublic = Dict.Value("Public")
		      End If
		      If Dict.HasKey("MapPreference") Then
		        Doc.MapPreference = Dict.Value("MapPreference")
		      End If
		    Catch Err As RuntimeException
		      // Likely a KeyNotFoundException or TypeMismatchException, either way, we can't handle it
		      Return Nil
		    End Try
		  ElseIf Info.FullName = "Auto()" Then
		    // Old style document
		    LootSources = Parsed
		  Else
		    // What on earth is this?
		    Return Nil
		  End If
		  
		  Dim Presets() As Beacon.Preset
		  If Version < 2 Then
		    // Will need this in a few lines
		    Presets = Beacon.Data.Presets
		  End If
		  For Each LootSource As Xojo.Core.Dictionary In LootSources
		    Dim Source As Beacon.LootSource = Beacon.LootSource.Import(LootSource)
		    If Source <> Nil Then
		      If Version < 2 Then
		        // Match item set names to presets
		        For Each Set As Beacon.ItemSet In Source
		          For Each Preset As Beacon.Preset In Presets
		            If Set.Label = Preset.Label Then
		              // Here's a hack to make assigning a preset possible: save current entries
		              Dim Entries() As Beacon.SetEntry
		              For Each Entry As Beacon.SetEntry In Set
		                Entries.Append(New Beacon.SetEntry(Entry))
		              Next
		              
		              // Reconfigure
		              Set.ReconfigureWithPreset(Preset, Source, Beacon.Maps.TheIsland)
		              
		              // Now "deconfigure" it
		              Redim Set(UBound(Entries))
		              For I As Integer = 0 To UBound(Entries)
		                Set(I) = Entries(I)
		              Next
		              Continue For Set
		            End If
		          Next
		        Next
		      End If
		      Doc.mLootSources.Append(Source)
		    End If
		  Next
		  
		  If Doc.MapPreference = 0 Then
		    // Let's try to figure out the map preference, it can only be island or scorched
		    Dim Island As Beacon.Map = Beacon.Maps.TheIsland
		    Dim Scorched As Beacon.Map = Beacon.Maps.ScorchedEarth
		    Dim IslandScore, ScorchedScore As UInteger
		    For Each Source As Beacon.LootSource In Doc.LootSources
		      If Source.ValidForMap(Island) Then
		        IslandScore = IslandScore + 1
		      End If
		      If Source.ValidForMap(Scorched) Then
		        ScorchedScore = ScorchedScore + 1
		      End If
		    Next
		    If ScorchedScore > IslandScore Then
		      Doc.MapPreference = Scorched.Mask
		    Else
		      Doc.MapPreference = Island.Mask
		    End If
		  End If
		  
		  Doc.mModified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function Read(File As Xojo.IO.FolderItem) As Beacon.Document
		  Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(File, Xojo.IO.BinaryStream.LockModes.Read)
		  Dim Data As Xojo.Core.MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Dim Contents As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Data)
		  
		  Return Beacon.Document.Read(Contents)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootSource As Beacon.LootSource)
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Self.mLootSources.Remove(I)
		      Self.mModified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, Text.CompareCaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mDescription = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		Description As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsPublic
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIsPublic = Value Then
			    Return
			  End If
			  
			  Self.mIsPublic = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		IsPublic As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		MapPreference As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPublic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTitle.Compare(Value, Text.CompareCaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mTitle = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		Title As Text
	#tag EndComputedProperty


	#tag Constant, Name = DocumentVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublic"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapPreference"
			Group="Behavior"
			Type="UInteger"
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
			Name="Title"
			Group="Behavior"
			Type="Text"
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
