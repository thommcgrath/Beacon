#tag Class
Protected Class LocalServerProfile
Inherits SDTD.ServerProfile
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Var SaveInfo As Dictionary = Dict.Value("Paths")
		  Self.mFiles = New Dictionary
		  For Each Entry As DictionaryEntry In SaveInfo
		    Var Path As String = Entry.Key
		    Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(Entry.Value.StringValue, False)
		    Self.mFiles.Value(Path) = File
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateDetailsFrom(Profile As SDTD.ServerProfile)
		  If Not Profile IsA SDTD.LocalServerProfile Then
		    Return
		  End If
		  
		  Self.mFiles = New Dictionary
		  Var LocalProfile As SDTD.LocalServerProfile = SDTD.LocalServerProfile(Profile)
		  For Each Entry As DictionaryEntry In LocalProfile.mFiles
		    Self.File(Entry.Key.StringValue) = BookmarkedFolderItem(Entry.Value.ObjectValue)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Var SaveInfo As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mFiles
		    SaveInfo.Value(Entry.Key) = BookmarkedFolderItem(Entry.Value).SaveInfo(False)
		  Next
		  
		  Dict.Value("Paths") = SaveInfo
		  Dict.Value("Provider") = "Local"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFiles = New Dictionary
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File(Path As String) As BookmarkedFolderItem
		  Return Self.mFiles.Lookup(Path, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub File(Path As String, Assigns File As BookmarkedFolderItem)
		  If Self.File(Path) = File Then
		    Return
		  End If
		  
		  Self.mFiles.Value(Path) = File
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFiles As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ExternalAccountId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Modified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsConsole"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackupFolderName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AdminNotes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProfileColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Beacon.ServerProfile.Colors"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Blue"
				"2 - Brown"
				"3 - Grey"
				"4 - Green"
				"5 - Indigo"
				"6 - Orange"
				"7 - Pink"
				"8 - Purple"
				"9 - Red"
				"10 - Teal"
				"11 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Nickname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProviderTokenId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
