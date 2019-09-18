#tag Class
Protected Class Stat
	#tag Method, Flags = &h0
		Sub Constructor(Key As String, Index As Integer, IsPercentage As Boolean, PlayerBase As Double, PlayerBaseCapped As Boolean, PlayerPerLevelAmount As Double, PlayerPerLevelEditable As Boolean, WildDefault As Double, TamedDefault As Double, TamedAddDefault As Double, TamedAffinityDefault As Double)
		  Self.mKey = Key
		  Self.mIndex = Index
		  Self.mIsPercentage = IsPercentage
		  Self.mPlayerBase = PlayerBase
		  Self.mPlayerBaseCapped = PlayerBaseCapped
		  Self.mPlayerPerLevelAmount = PlayerPerLevelAmount
		  Self.mPlayerPerLevelEditable = PlayerPerLevelEditable
		  Self.mWildDefault = WildDefault
		  Self.mTamedDefault = TamedDefault
		  Self.mTamedAddDefault = TamedAddDefault
		  Self.mTamedAffinityDefault = TamedAffinityDefault
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Index() As Integer
		  Return Self.mIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPercentage() As Boolean
		  Return Self.mIsPercentage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerBase() As Double
		  Return Self.mPlayerBase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerBaseCapped() As Boolean
		  Return Self.mPlayerBaseCapped
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerPerLevelAmount() As Double
		  Return Self.mPlayerPerLevelAmount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerPerLevelEditable() As Boolean
		  Return Self.mPlayerPerLevelEditable
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAddDefault() As Double
		  Return Self.mTamedAddDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAffinityDefault() As Double
		  Return Self.mTamedAffinityDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedDefault() As Double
		  Return Self.mTamedDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WildDefault() As Double
		  Return Self.mWildDefault
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPercentage As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerBase As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerBaseCapped As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerPerLevelAmount As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerPerLevelEditable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTamedAddDefault As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTamedAffinityDefault As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTamedDefault As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWildDefault As Double
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
