#tag Class
Protected Class DiscoveredData
Inherits Beacon.DiscoveredData
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFiles = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Files As Dictionary)
		  Self.Constructor()
		  
		  If (Files Is Nil) = False Then
		    Self.mFiles = Files.Clone
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File(Path As String) As String
		  Return Self.mFiles.Lookup(Path, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub File(Path As String, Assigns Contents As String)
		  Self.mFiles.Value(Path) = Contents
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasFile(Path As String) As Boolean
		  Return Self.mFiles.HasKey(Path)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mFiles As Dictionary
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
