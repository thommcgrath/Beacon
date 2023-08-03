#tag Class
Protected Class BlueprintControllerPublishTask
Inherits Ark.BlueprintControllerTask
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function Blueprints() As Ark.Blueprint()
		  Var Clone() As Ark.Blueprint
		  Clone.ResizeTo(Self.mBlueprints.LastIndex)
		  For Idx As Integer = 0 To Self.mBlueprints.LastIndex
		    Clone(Idx) = Self.mBlueprints(Idx)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Mode As Integer)
		  Super.Constructor(Mode)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Mode As Integer, Blueprints() As Ark.Blueprint)
		  Super.Constructor(Mode)
		  Self.mDeleteMode = False
		  Self.mBlueprints = Blueprints
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Mode As Integer, BlueprintIds() As String)
		  Super.Constructor(Mode)
		  Self.mDeleteMode = True
		  Self.mDeleteIds = BlueprintIds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteIds() As String()
		  Var Clone() As String
		  Clone.ResizeTo(Self.mDeleteIds.LastIndex)
		  For Idx As Integer = 0 To Self.mDeleteIds.LastIndex
		    Clone(Idx) = Self.mDeleteIds(Idx)
		  Next
		  Return Clone
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDeleteMode
			End Get
		#tag EndGetter
		DeleteMode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBlueprints() As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeleteIds() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeleteMode As Boolean
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
		#tag ViewProperty
			Name="TaskId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ErrorMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Errored"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeleteMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
