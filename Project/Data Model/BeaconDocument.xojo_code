#tag Class
Protected Class BeaconDocument
	#tag Method, Flags = &h0
		Sub Add(Beacon As Ark.Beacon)
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Return
		    End If
		  Next
		  Self.mBeacons.Append(Beacon)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconCount() As Integer
		  Return UBound(Self.mBeacons) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Beacons() As Ark.Beacon()
		  Dim Results() As Ark.Beacon
		  For Each Beacon As Ark.Beacon In Self.mBeacons
		    Results.Append(Beacon)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Beacons() As Ark.Beacon)
		  Self.Constructor()
		  
		  Redim Self.mBeacons(UBound(Beacons))
		  For I As Integer = 0 To UBound(Beacons)
		    Self.mBeacons(I) = New Ark.Beacon(Beacons(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Export(Beacon As Ark.Beacon) As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Set As Ark.ItemSet In Beacon
		    Children.Append(BeaconDocument.Export(Set))
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("Items") = Children
		  Keys.Value("Label") = Beacon.Label
		  Keys.Value("MaxItemSets") = Beacon.MaxItemSets
		  Keys.Value("MinItemSets") = Beacon.MinItemSets
		  Keys.Value("NumItemSetsPower") = Beacon.NumItemSetsPower
		  Keys.Value("SetsRandomWithoutReplacement") = Beacon.SetsRandomWithoutReplacement
		  Keys.Value("Type") = Beacon.Type
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Export(Item As Ark.ItemClass) As Xojo.Core.Dictionary
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("Class") = Item.ClassString
		  Keys.Value("Weight") = Item.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Export(Set As Ark.ItemSet) As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Entry As Ark.SetEntry In Set
		    Children.Append(BeaconDocument.Export(Entry))
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("Items") = Children
		  Keys.Value("ItemsRandomWithoutReplacement") = Set.ItemsRandomWithoutReplacement
		  Keys.Value("Label") = Set.Label
		  Keys.Value("MaxNumItems") = Set.MaxNumItems
		  Keys.Value("MinNumItems") = Set.MinNumItems
		  Keys.Value("NumItemsPower") = Set.NumItemsPower
		  Keys.Value("Weight") = Set.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Export(Entry As Ark.SetEntry) As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Item As Ark.ItemClass In Entry
		    Children.Append(BeaconDocument.Export(Item))
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("ChanceToBeBlueprint") = Entry.ChanceToBeBlueprint
		  Keys.Value("ForceBlueprint") = Entry.ForceBlueprint
		  Keys.Value("Items") = Children
		  Keys.Value("MaxQuality") = Entry.MaxQuality
		  Keys.Value("MaxQuantity") = Entry.MaxQuantity
		  Keys.Value("MinQuality") = Entry.MinQuality
		  Keys.Value("MinQuantity") = Entry.MinQuantity
		  Keys.Value("Weight") = Entry.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBeacon(Beacon As Ark.Beacon) As Boolean
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsBeacon(Keys As Xojo.Core.Dictionary) As Ark.Beacon
		  Dim Beacon As New Ark.Beacon
		  Beacon.Label = Keys.Lookup("Label", Beacon.Label)
		  Beacon.MaxItemSets = Keys.Lookup("MaxItemSets", Beacon.MaxItemSets)
		  Beacon.MinItemSets = Keys.Lookup("MinItemSets", Beacon.MinItemSets)
		  Beacon.NumItemSetsPower = Keys.Lookup("NumItemSetsPower", Beacon.NumItemSetsPower)
		  Beacon.SetsRandomWithoutReplacement = Keys.Lookup("SetsRandomWithoutReplacement", Beacon.SetsRandomWithoutReplacement)
		  Beacon.Type = Keys.Lookup("Type", Beacon.Type)
		  
		  If Keys.HasKey("Items") Then
		    Dim Children() As Auto = Keys.Value("Items")
		    For Each Child As Xojo.Core.Dictionary In Children
		      Beacon.Append(BeaconDocument.ImportAsItemSet(Child))
		    Next
		  End If
		  
		  Return Beacon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsEntry(Keys As Xojo.Core.Dictionary) As Ark.SetEntry
		  Dim Entry As New Ark.SetEntry
		  Entry.ChanceToBeBlueprint = Keys.Lookup("ChanceToBeBlueprint", Entry.ChanceToBeBlueprint)
		  Entry.MaxQuality = Keys.Lookup("MaxQuality", Entry.MaxQuality)
		  Entry.MaxQuantity = Keys.Lookup("MaxQuantity", Entry.MaxQuantity)
		  Entry.MinQuality = Keys.Lookup("MinQuality", Entry.MinQuality)
		  Entry.MinQuantity = Keys.Lookup("MinQuantity", Entry.MinQuantity)
		  Entry.Weight = Keys.Lookup("Weight", Entry.Weight)
		  
		  If Keys.HasKey("Items") Then
		    Dim Children() As Auto = Keys.Value("Items")
		    For Each Child As Xojo.Core.Dictionary In Children
		      Entry.Append(BeaconDocument.ImportAsItemClass(Child))
		    Next
		  End If
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsItemClass(Keys As Xojo.Core.Dictionary) As Ark.ItemClass
		  Return New Ark.ItemClass(Keys.Value("Class"), Keys.Value("Weight"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsItemSet(Keys As Xojo.Core.Dictionary) As Ark.ItemSet
		  Dim Set As New Ark.ItemSet
		  Set.ItemsRandomWithoutReplacement = Keys.Lookup("ItemsRandomWithoutReplacement", Set.ItemsRandomWithoutReplacement)
		  Set.Label = Keys.Lookup("Label", Set.Label)
		  Set.MaxNumItems = Keys.Lookup("MaxNumItems", Set.MaxNumItems)
		  Set.MinNumItems = Keys.Lookup("MinNumItems", Set.MinNumItems)
		  Set.NumItemsPower = Keys.Lookup("NumItemsPower", Set.NumItemsPower)
		  Set.Weight = Keys.Lookup("Weight", Set.Weight)
		  
		  If Keys.HasKey("Items") Then
		    Dim Children() As Auto = Keys.Value("Items")
		    For Each Child As Xojo.Core.Dictionary In Children
		      Set.Append(BeaconDocument.ImportAsEntry(Child))
		    Next
		  End If
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Read(File As Xojo.IO.FolderItem) As BeaconDocument
		  Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		  Dim Contents As Text = Stream.ReadAll
		  Stream.Close
		  
		  Dim Doc As New BeaconDocument
		  Dim Beacons() As Auto
		  Try
		    Beacons = Xojo.Data.ParseJSON(Contents)
		  Catch IJE As Xojo.Data.InvalidJSONException
		  Catch TME As TypeMismatchException
		  End Try
		  For Each Beacon As Xojo.Core.Dictionary In Beacons
		    Doc.mBeacons.Append(BeaconDocument.ImportAsBeacon(Beacon))
		  Next
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Beacon As Ark.Beacon)
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Self.mBeacons.Remove(I)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(File As Xojo.IO.FolderItem)
		  Dim Beacons() As Xojo.Core.Dictionary
		  For Each Beacon As Ark.Beacon In Self.mBeacons
		    Beacons.Append(Self.Export(Beacon))
		  Next
		  
		  Dim Contents As Text = Xojo.Data.GenerateJSON(Beacons)
		  Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(File, Xojo.Core.TextEncoding.UTF8)
		  Stream.Write(Contents)
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBeacons() As Ark.Beacon
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
