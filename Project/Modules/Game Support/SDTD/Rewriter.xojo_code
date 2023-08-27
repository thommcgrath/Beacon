#tag Class
Protected Class Rewriter
Inherits Global.Thread
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.mOutputFiles = New Dictionary
		  Self.AddUserInterfaceUpdate(New Dictionary("Event": "Started"))
		  
		  Var Project As SDTD.Project = Self.mProject
		  Var Identity As Beacon.Identity = Self.mIdentity
		  Var Profile As SDTD.ServerProfile = Self.mProfile
		  
		  If Self.mOrganizer Is Nil Or Self.mRebuildOrganizer Then
		    If (Self.mOutputFlags And Self.FlagForceTrollMode) = Self.FlagForceTrollMode Then
		      Self.mOrganizer = Project.CreateTrollConfigOrganizer(Profile)
		    Else
		      Self.mOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    End If
		    Self.mRebuildOrganizer = False
		  End If
		  
		  Var Error As RuntimeException
		  
		  For Each Entry As DictionaryEntry In Self.mInputFiles
		    Var Filename As String = Entry.Key
		    Var InputContent As String = Entry.Value
		    Var OutputContent As String = Rewrite(Self.mSource, Filename, InputContent, Self.mOrganizer, Project.ProjectId, (Self.mOutputFlags And Self.FlagNuke) = Self.FlagNuke, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.AddUserInterfaceUpdate(New Dictionary("Event": "Finished"))
		      Return
		    End If
		    Self.mOutputFiles.Value(Filename) = OutputContent
		  Next
		  
		  Self.mFinished = True
		  Self.mError = Error
		  Self.AddUserInterfaceUpdate(New Dictionary("Event": "Finished"))
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var EventName As String = Update.Lookup("Event", "").StringValue
		    Select Case EventName
		    Case "Finished"
		      RaiseEvent Finished
		    Case "Started"
		      RaiseEvent Started
		    End Select
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  If Self.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.Stop
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mInputFiles = New Dictionary
		  Self.mOutputFiles = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return (Self.mError Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Filenames() As String()
		  Var Arr() As String
		  For Each Entry As DictionaryEntry In Self.mInputFiles
		    Arr.Add(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InputFile(Filename As String) As String
		  Return Self.mInputFiles.Lookup(Filename, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InputFile(Filename As String, Assigns Content As String)
		  Self.mInputFiles.Value(Filename) = Content
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OutputFile(Filename As String) As String
		  Return Self.mOutputFiles.Lookup(Filename, Self.InputFile(Filename)).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OutputFlags() As Integer
		  Return Self.mOutputFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetFiles()
		  Self.mInputFiles = New Dictionary
		  Self.mOutputFiles = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewrite(Flags As Integer)
		  Self.mOutputFlags = Flags And (Self.FlagForceTrollMode Or Self.FlagNuke)
		  Super.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As SDTD.Rewriter.Sources, InputFiles As Dictionary, Organizer As SDTD.ConfigOrganizer, ProjectId As String, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As SDTD.Rewriter.Sources, InputFiles As Dictionary, Project As SDTD.Project, Identity As Beacon.Identity, Profile As SDTD.ServerProfile, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  Try
		    Var Organizer As SDTD.ConfigOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    Return Rewrite(Source, InputFiles, Organizer, Project.ProjectId, Nuke, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As SDTD.Rewriter.Sources, Filename As String, InputContent As String, Organizer As SDTD.ConfigOrganizer, ProjectId As String, Nuke As Boolean, ByRef Err As RuntimeException) As String
		  Return InputContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Start()
		  Super.Start()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIdentity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIdentity <> Value Then
			    Self.mIdentity = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Identity As Beacon.Identity
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInputFiles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrganizer As SDTD.ConfigOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFiles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As SDTD.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRebuildOrganizer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As SDTD.Rewriter.Sources
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProfile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Don't just use <> here, it does not compare correctly with Nitrado
			  
			  If Value Is Nil Then
			    If Self.mProfile Is Nil Then
			      Return
			    End If
			    
			    Self.mProfile = Nil
			    Self.mRebuildOrganizer = True
			    Return
			  End If
			  
			  If (Self.mProfile Is Nil) = False And Self.mProfile.Hash = Value.Hash Then
			    Return
			  End If
			  
			  Self.mProfile = Value
			  Self.mRebuildOrganizer = True
			End Set
		#tag EndSetter
		Profile As SDTD.ServerProfile
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProject
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProject <> Value Then
			    Self.mProject = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Project As SDTD.Project
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSource
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSource = Value
			End Set
		#tag EndSetter
		Source As SDTD.Rewriter.Sources
	#tag EndComputedProperty


	#tag Constant, Name = FlagForceTrollMode, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagNuke, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Sources, Flags = &h0
		Original
		  Deploy
		  SmartCopy
		SmartSave
	#tag EndEnum


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
		#tag ViewProperty
			Name="Source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="SDTD.Rewriter.Sources"
			EditorType="Enum"
			#tag EnumValues
				"0 - Original"
				"1 - Deploy"
				"2 - SmartCopy"
				"3 - SmartSave"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
