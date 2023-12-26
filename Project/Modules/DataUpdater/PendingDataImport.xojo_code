#tag Class
Protected Class PendingDataImport
	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem, Flags As Integer)
		  // Don't catch exceptions here, the caller should do that.
		  Var Contents As String = File.Read
		  Self.Constructor(Contents, Flags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As String, Flags As Integer)
		  Self.mContent = Source
		  Self.mFlags = Flags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Content() As String
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flags() As Integer
		  Return Self.mFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupressExport() As Boolean
		  Return (Self.mFlags And Self.FlagSuppressExport) > 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty


	#tag Constant, Name = FlagSuppressExport, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="mFlags"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
