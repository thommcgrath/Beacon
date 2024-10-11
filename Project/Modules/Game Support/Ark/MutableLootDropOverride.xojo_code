#tag Class
Protected Class MutableLootDropOverride
Inherits Ark.LootDropOverride
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Add(Set As Ark.LootItemSet)
		  // Making it public
		  Super.Add(Set)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddToDefaults(Assigns Value As Boolean)
		  If Self.mAddToDefaults = Value Then
		    Return
		  End If
		  
		  Self.mAddToDefaults = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootDropOverride
		  Return New Ark.LootDropOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LootDropReference(Assigns Ref As Ark.BlueprintReference)
		  If Self.mDropRef = Ref Then
		    Return
		  End If
		  
		  Self.mDropRef = Ref
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItemSets(Assigns Value As Integer)
		  If Self.mMaxItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMaxItemSets = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItemSets(Assigns Value As Integer)
		  If Self.mMinItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMinItemSets = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootDropOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventDuplicates(Assigns Value As Boolean)
		  If Self.mPreventDuplicates = Value Then
		    Return
		  End If
		  
		  Self.mPreventDuplicates = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  Var NumChanged As Integer
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    If Self.Msets(Idx).TemplateUUID.IsEmpty Then
		      Continue
		    End If
		    
		    Var Template As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(Self.mSets(Idx).TemplateUUID)
		    If Template Is Nil Then
		      Continue
		    End If
		    
		    Var Mutable As Ark.MutableLootItemSet = Self.mSets(Idx).MutableVersion
		    Var Container As Ark.Blueprint = Self.mDropRef.Resolve(ContentPacks)
		    If Container Is Nil Or (Container IsA Ark.LootContainer) = False Then
		      Continue
		    End If
		    If Template.RebuildLootItemSet(Mutable, Mask, Ark.LootContainer(Container), ContentPacks) = False Then
		      Continue
		    End If
		    
		    NumChanged = NumChanged + 1
		    Self.mSets(Idx) = Mutable.ImmutableVersion
		    Self.Modified = True
		  Next
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Set As Ark.LootItemSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAt(Idx As Integer, Assigns Set As Ark.LootItemSet)
		  If Set Is Nil Then
		    Return
		  End If
		  
		  Self.mSets(Idx) = Set.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
