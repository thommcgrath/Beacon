#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag Event
		Sub AddSaveData(PlainData As Dictionary, EncryptedData As Dictionary)
		  PlainData.Value("AllowUCS") = Self.AllowUCS2
		  PlainData.Value("IsConsole") = Self.ConsoleSafe
		  PlainData.Value("Map") = Self.MapMask
		  PlainData.Value("ModSelections") = Self.mContentPacks
		End Sub
	#tag EndEvent

	#tag Event
		Function ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
		  Self.AllowUCS2 = PlainData.Lookup("AllowUCS", Self.AllowUCS2).BooleanValue
		  Self.ConsoleSafe = PlainData.Lookup("IsConsole", Self.ConsoleSafe).BooleanValue
		  
		  If PlainData.HasKey("Map") Then
		    Self.MapMask = PlainData.Value("Map")
		  ElseIf PlainData.HasKey("MapPreference") Then
		    Self.MapMask = PlainData.Value("MapPreference")
		  End If
		  
		  If PlainData.HasKey("ModSelections") Then
		    // Newest mod, keys are uuids and values are boolean
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		    Var Selections As Dictionary = PlainData.Value("ModSelections")
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    For Each Pack As Ark.ContentPack In AllPacks
		      If Selections.HasKey(Pack.UUID) = False Then
		        Selections.Value(Pack.UUID) = Pack.DefaultEnabled And (Pack.ConsoleSafe Or ConsoleMode = False)
		      End If
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("Mods") Then
		    // In this mode, an empty list meant "all on" and populated list mean "only enable these."
		    
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		    Var SelectedMods As Beacon.StringList = Beacon.StringList.FromVariant(PlainData.Value("Mods"))
		    Var SelectedModCount As Integer = CType(SelectedMods.Count, Integer)
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    Var Selections As New Dictionary
		    For Each Pack As Ark.ContentPack In AllPacks
		      Selections.Value(Pack.UUID) = (Pack.ConsoleSafe Or ConsoleMode = False) And (SelectedModCount = 0 Or SelectedMods.IndexOf(Pack.UUID) > -1)
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("ConsoleModsOnly") Then
		    Var ConsoleModsOnly As Boolean = PlainData.Value("ConsoleModsOnly")
		    If ConsoleModsOnly Then
		      Var Selections As New Dictionary
		      Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		      For Each Pack As Ark.ContentPack In AllPacks
		        Selections.Value(Pack.UUID) = Pack.DefaultEnabled And Pack.ConsoleSafe
		      Next
		      
		      Self.ConsoleSafe = True
		      Self.mContentPacks = Selections
		    End If
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AllowUCS2() As Boolean
		  Return Self.mAllowUCS2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllowUCS2(Assigns Value As Boolean)
		  If Self.mAllowUCS2 <> Value Then
		    Self.mAllowUCS2 = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafe() As Boolean
		  Return Self.mConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsoleSafe(Assigns Value As Boolean)
		  If Self.mConsoleSafe <> Value Then
		    Self.mConsoleSafe = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mContentPacks = New Dictionary
		  Self.mMapMask = 1
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(Pack As Ark.ContentPack) As Boolean
		  Return Self.ContentPackEnabled(Pack.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(Pack As Ark.ContentPack, Assigns Value As Boolean)
		  Self.ContentPackEnabled(Pack.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(UUID As String) As Boolean
		  Return Self.mContentPacks.Lookup(UUID, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(UUID As String, Assigns Value As Boolean)
		  If v4UUID.IsValid(UUID) = False Then
		    Return
		  End If
		  
		  If Self.mContentPacks.HasKey(UUID) = False Or Self.mContentPacks.Value(UUID).BooleanValue <> Value Then
		    Self.mContentPacks.Value(UUID) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPacks() As Beacon.StringList
		  Var List As New Beacon.StringList
		  For Each Entry As DictionaryEntry In Self.mContentPacks
		    If Entry.Value.BooleanValue = True Then
		      List.Append(Entry.Key.StringValue)
		    End If
		  Next
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MapMask() As UInt64
		  Return Self.mMapMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MapMask(Assigns Value As UInt64)
		  If Self.mMapMask <> Value Then
		    Self.mMapMask = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Ark.Map()
		  Return Ark.Maps.ForMask(Self.mMapMask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Maps(Assigns MapList() As Ark.Map)
		  Var Value As UInt64 = 0
		  For Each Map As Ark.Map In MapList
		    Value = Value Or Map.Mask
		  Next Map
		  Self.MapMask = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMap(Map As Ark.Map) As Boolean
		  Return (Self.MapMask And Map.Mask) = Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SupportsMap(Map As Ark.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.MapMask = Self.MapMask Or Map.Mask
		  Else
		    Self.MapMask = Self.MapMask And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAllowUCS2 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMapMask As UInt64
	#tag EndProperty


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
