#tag Class
Protected Class ModFilterSettings
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Constructor(CType(ModsListView.ViewModes.Local, Integer) Or CType(ModsListView.ViewModes.LocalReadOnly, Integer) Or CType(ModsListView.ViewModes.Remote, Integer), Beacon.Games)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Types As Integer, Games() As Beacon.Game)
		  Var GameIds() As String
		  GameIds.ResizeTo(Games.LastIndex)
		  For Idx As Integer = 0 To Games.LastIndex
		    GameIds(Idx) = Games(Idx).Identifier
		  Next
		  Self.Constructor(Types, GameIds)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Types As Integer, GameIds() As String)
		  Self.mTypes = Types And (CType(ModsListView.ViewModes.Local, Integer) Or CType(ModsListView.ViewModes.LocalReadOnly, Integer) Or CType(ModsListView.ViewModes.Remote, Integer))
		  Self.mGameIds.ResizeTo(GameIds.LastIndex)
		  For Idx As Integer = 0 To GameIds.LastIndex
		    Self.mGameIds(Idx) = GameIds(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled(Game As Beacon.Game) As Boolean
		  Return Self.mGameIds.IndexOf(Game.Identifier) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled(Type As Integer) As Boolean
		  Return (Self.mTypes And Type) = Type
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled(GameId As String) As Boolean
		  Return Self.mGameIds.IndexOf(GameId) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As JSONItem) As ModFilterSettings
		  If Source Is Nil Then
		    Return New ModFilterSettings
		  End If
		  
		  Var Types As Integer = Source.Value("types").IntegerValue
		  
		  Var GameIds() As String
		  Var SourceGameIds As JSONItem = Source.Child("gameIds")
		  If SourceGameIds.IsArray Then
		    For Idx As Integer = 0 To SourceGameIds.LastRowIndex
		      GameIds.Add(SourceGameIds.ValueAt(Idx))
		    Next
		  Else
		    Var Games() As Beacon.Game = Beacon.Games
		    For Each Game As Beacon.Game In Games
		      If SourceGameIds.Lookup(Game.Identifier, True).BooleanValue Then
		        GameIds.Add(Game.Identifier)
		      End If
		    Next
		  End If
		  
		  Return New ModFilterSettings(Types, GameIds)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIds() As String()
		  Var GameIds() As String
		  GameIds.ResizeTo(Self.mGameIds.LastIndex)
		  For Idx As Integer = 0 To Self.mGameIds.LastIndex
		    GameIds(Idx) = Self.mGameIds(Idx)
		  Next
		  Return GameIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsFiltered() As Boolean
		  Return Self.mTypes <> (CType(ModsListView.ViewModes.Local, Integer) Or CType(ModsListView.ViewModes.LocalReadOnly, Integer) Or CType(ModsListView.ViewModes.Remote, Integer)) Or Self.mGameIds.Count <> Beacon.Games.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As JSONItem
		  Var SavedGameIds As New JSONItem
		  Var Games() As Beacon.Game = Beacon.Games
		  For Each Game As Beacon.Game In Games
		    SavedGameIds.Value(Game.Identifier) = False
		  Next
		  For Each GameId As String In Self.mGameIds
		    SavedGameIds.Value(GameId) = True
		  Next
		  
		  Var Data As New JSONItem
		  Data.Value("types") = Self.mTypes
		  Data.Child("gameIds") = SavedGameIds
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Types() As Integer
		  Return Self.mTypes
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mGameIds() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypes As Integer
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
