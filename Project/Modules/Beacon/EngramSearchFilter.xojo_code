#tag Class
Protected Class EngramSearchFilter
	#tag Method, Flags = &h0
		Function Export() As Text
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Tags") = Self.Tags
		  Dict.Value("Mods") = Self.Mods
		  Return Xojo.Data.GenerateJSON(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Source As Text) As Beacon.EngramSearchFilter
		  Dim Dict As Xojo.Core.Dictionary
		  Try
		    Dict = Xojo.Data.ParseJSON(Source)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Tags() As Auto
		  If Dict.HasKey("Tags") Then
		    Try
		      Tags = Dict.Value("Tags")
		    Catch Err As TypeMismatchException
		      
		    End Try
		  End If
		  
		  Dim Mods() As Auto
		  If Dict.HasKey("Mods") Then
		    Try
		      Mods = Dict.Value("Mods")
		    Catch Err As TypeMismatchException
		      
		    End Try
		  End If
		  
		  Dim Filter As New Beacon.EngramSearchFilter
		  For Each Tag As Auto In Tags
		    Try
		      Filter.Tags.Append(Tag)
		    Catch Err As TypeMismatchException
		      
		    End Try
		  Next
		  For Each ModID As Auto In Mods
		    Try
		      Filter.Mods.Append(ModID)
		    Catch Err As TypeMismatchException
		      
		    End Try
		  Next
		  Return Filter
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Mods() As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Tags() As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tags()"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
