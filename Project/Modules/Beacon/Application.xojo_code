#tag Interface
Protected Interface Application
	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildNumber() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function BuildVersion() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenericLootSourceIcon() As Picture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleException(Error As RuntimeException)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String, AlreadyConfirmed As Boolean = False) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IdentityManager() As IdentityManager
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Err As RuntimeException, Location As String, MoreDetail As String = "")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LogAPIException(Err As RuntimeException, Location As String, URL As String, HTTPStatus As Integer, RawContent As MemoryBlock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogsFolder() As FolderItem
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReportException(Err As RuntimeException, Comments As String = "")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourcesFolder() As FolderItem
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserAgent() As String
		  
		End Function
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
End Interface
#tag EndInterface
