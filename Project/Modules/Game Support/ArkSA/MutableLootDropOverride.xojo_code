#tag Class
Protected Class MutableLootDropOverride
Inherits ArkSA.LootDropOverride
Implements Beacon.BlueprintConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Add(Set As ArkSA.LootItemSet)
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
		Function ImmutableVersion() As ArkSA.LootDropOverride
		  Return New ArkSA.LootDropOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LootDropReference(Assigns Ref As ArkSA.BlueprintReference)
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
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Changed As Boolean
		  Var NewDropRef As ArkSA.BlueprintReference = ArkSA.FindMigratedBlueprint(Migrator, Self.mDropRef)
		  If (NewDropRef Is Nil) = False And NewDropRef.IsLootContainer Then
		    Self.mDropRef = NewDropRef
		    Self.Modified = True
		    Changed = True
		  End If
		  
		  // Tell item sets to migrate
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    Var Mutable As ArkSA.MutableLootItemSet = Self.mSets(Idx).MutableVersion
		    If Mutable.MigrateBlueprints(Migrator) Then
		      Self.mSets(Idx) = Mutable.ImmutableVersion
		      Self.Modified = True
		      Changed = True
		    End If
		  Next
		  
		  Return Changed
		End Function
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
		Function MutableVersion() As ArkSA.MutableLootDropOverride
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
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  For Idx As Integer = Self.mSets.LastIndex DownTo 0
		    Var Mutable As New ArkSA.MutableLootItemSet(Self.mSets(Idx))
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mSets.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  Var NumChanged As Integer
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    If Self.Msets(Idx).TemplateUUID.IsEmpty Then
		      Continue
		    End If
		    
		    Var Template As ArkSA.LootTemplate = ArkSA.DataSource.Pool.Get(False).GetLootTemplateByUUID(Self.mSets(Idx).TemplateUUID)
		    If Template Is Nil Then
		      Continue
		    End If
		    
		    Var Mutable As ArkSA.MutableLootItemSet = Self.mSets(Idx).MutableVersion
		    Var Container As ArkSA.Blueprint = Self.mDropRef.Resolve(ContentPacks)
		    If Container Is Nil Or (Container IsA ArkSA.LootContainer) = False Then
		      Continue
		    End If
		    If Template.RebuildLootItemSet(Mutable, Mask, ArkSA.LootContainer(Container), ContentPacks) = False Then
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
		Sub Remove(Set As ArkSA.LootItemSet)
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
		Sub SetAt(Idx As Integer, Assigns Set As ArkSA.LootItemSet)
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
