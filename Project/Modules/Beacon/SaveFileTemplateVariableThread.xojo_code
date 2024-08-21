#tag Class
Protected Class SaveFileTemplateVariableThread
Inherits Thread
	#tag Event
		Sub Run()
		  Self.Retain
		  
		  Var Database As Beacon.CommonData = Beacon.CommonData.Pool.Get(True)
		  For Each TemplateVariable As Beacon.FileTemplateVariable In Self.mVariables
		    Database.SaveFileTemplateVariable(TemplateVariable, False, True)
		  Next
		  Self.AddUserInterfaceUpdate(New Dictionary("State": "Finished"))
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    If Dict.Lookup("State", "").StringValue = "Finished" Then
		      RaiseEvent SaveComplete()
		      Self.Release
		    End If
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Variables() As Beacon.FileTemplateVariable)
		  Self.mVariables = Variables
		  Self.DebugIdentifier = "Beacon.SaveFileTemplateVariableThread"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray Variables() As Beacon.FileTemplateVariable)
		  Self.Constructor(Variables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ready() As Boolean
		  Return Self.ThreadState = Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(Variables() As Beacon.FileTemplateVariable)
		  Self.mVariables = Variables
		  Self.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(ParamArray Variables() As Beacon.FileTemplateVariable)
		  Self.Save(Variables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variables() As Beacon.FileTemplateVariable()
		  Return Self.mVariables
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mVariables() As Beacon.FileTemplateVariable
	#tag EndProperty


	#tag ViewBehavior
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
			InitialValue=""
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
