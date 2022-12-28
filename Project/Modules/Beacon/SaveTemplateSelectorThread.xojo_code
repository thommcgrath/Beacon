#tag Class
Protected Class SaveTemplateSelectorThread
Inherits Thread
	#tag Event
		Sub Run()
		  Self.Retain
		  
		  Var Database As Beacon.CommonData = Beacon.CommonData.SharedInstance(Beacon.CommonData.CommonFlagsWritable)
		  For Each TemplateSelector As Beacon.TemplateSelector In Self.mSelectors
		    Database.SaveTemplateSelector(TemplateSelector)
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
		Sub Constructor(Selectors() As Beacon.TemplateSelector)
		  Self.mSelectors = Selectors
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray Selectors() As Beacon.TemplateSelector)
		  Self.Constructor(Selectors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ready() As Boolean
		  Return Self.ThreadState = Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(Selectors() As Beacon.TemplateSelector)
		  Self.mSelectors = Selectors
		  Self.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(ParamArray Selectors() As Beacon.TemplateSelector)
		  Self.Save(Selectors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Selectors() As Beacon.TemplateSelector()
		  Return Self.mSelectors
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSelectors() As Beacon.TemplateSelector
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
