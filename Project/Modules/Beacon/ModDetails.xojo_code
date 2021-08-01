#tag Class
Protected Class ModDetails
	#tag Method, Flags = &h0
		Sub Constructor(ModID As String, Name As String, ConsoleSafe As Boolean, DefaultEnabled As Boolean, WorkshopID As UInt32, IsUserMod As Boolean)
		  Self.mModID = ModID
		  Self.mName = Name
		  Self.mConsoleSafe = ConsoleSafe
		  Self.mDefaultEnabled = DefaultEnabled
		  Self.mWorkshopID = WorkshopID
		  Self.mIsUserMod = IsUserMod
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConsoleSafe
			End Get
		#tag EndGetter
		ConsoleSafe As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDefaultEnabled
			End Get
		#tag EndGetter
		DefaultEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsUserMod
			End Get
		#tag EndGetter
		IsUserMod As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsUserMod As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mModID
			End Get
		#tag EndGetter
		ModID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mWorkshopID As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mWorkshopID
			End Get
		#tag EndGetter
		WorkshopID As UInt32
	#tag EndComputedProperty


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
			Name="ConsoleSafe"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ModID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WorkshopID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt32"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsUserMod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
