#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub Run()
		  Var Files As New Dictionary
		  Var Filenames() As String = Self.mData.Filenames
		  #Pragma BreakOnExceptions Off
		  For Each Filename As String In Filenames
		    Self.Status = "Parsing " + Filename + "…"
		    Try
		      Var Doc As New XmlDocument(Self.mData.File(Filename))
		      Files.Value(Filename) = Doc
		    Catch Err As RuntimeException
		    End Try
		  Next
		  #Pragma BreakOnExceptions Default
		  
		  Self.Status = "Building Beacon project…"
		  Try
		    Self.mCreatedProject = Self.BuildProject(Files)
		  Catch Err As RuntimeException
		  End Try
		  Self.Status = "Finished"
		  Self.mFinished = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BuildProject(Files As Dictionary) As SDTD.Project
		  Var Profile As SDTD.ServerProfile
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False Then
		    Profile = Self.mData.Profile
		  End If
		  
		  Var Project As New SDTD.Project
		  
		  If (Self.mDestinationProject Is Nil) = False Then
		    Var DestinationPacks As Beacon.StringList = Self.mDestinationProject.ContentPacks
		    For Each ContentPackId As String In DestinationPacks
		      Project.ContentPackEnabled(ContentPackId) = True
		    Next
		  End If
		  
		  Var ConfigNames() As String = SDTD.Configs.AllNames()
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  Var Configs() As SDTD.ConfigGroup
		  For Each ConfigName As String In ConfigNames
		    If ConfigName = SDTD.Configs.NameCustomConfig Then
		      // Custom content is special
		      Continue For ConfigName
		    End If
		    
		    If SDTD.Configs.ConfigUnlocked(ConfigName, Identity) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue For ConfigName
		    End If
		    
		    Self.Status = "Building Beacon project… (" + Language.LabelForConfig(ConfigName) + ")"
		    Var Group As SDTD.ConfigGroup
		    Try
		      Group = SDTD.Configs.CreateInstance(ConfigName, Files, Project)
		    Catch Err As RuntimeException
		    End Try
		    If (Group Is Nil) = False Then
		      Project.AddConfigGroup(Group)
		      Configs.Add(Group)
		    End If
		  Next
		  
		  // Now split the content into values and remove the ones controlled by the imported groups
		  Self.Status = "Building Beacon project… (" + Language.LabelForConfig(SDTD.Configs.NameCustomConfig) + ")"
		  #Pragma Warning "Does not parse custom config"
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Data As SDTD.DiscoveredData, DestinationProject As SDTD.Project)
		  Self.mUpdateTimer = New Timer
		  Self.mUpdateTimer.RunMode = Timer.RunModes.Off
		  Self.mUpdateTimer.Period = 0
		  #if TargetDesktop
		    AddHandler Self.mUpdateTimer.Action, WeakAddressOf Self.mUpdateTimer_Action
		  #else
		    AddHandler Self.mUpdateTimer.Run, WeakAddressOf Self.mUpdateTimer_Action
		  #endif
		  
		  Self.mData = Data
		  Self.mDestinationProject = DestinationProject
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Invalidate()
		  If Self.mFinished Then
		    Return
		  End If
		  
		  If Self.mUpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.mUpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI
		  
		  If Self.mFinished Then
		    RaiseEvent Finished(Self.mCreatedProject)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False And Self.mData.Profile.Name.IsEmpty = False Then
		    Return Self.mData.Profile.Name
		  Else
		    Return "Untitled Importer"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As SDTD.Project
		  Return Self.mCreatedProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  Return Self.mStatusMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Status(Assigns Value As String)
		  If Self.mStatusMessage.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) <> 0 Then
		    Self.mStatusMessage = Value
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Project As SDTD.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatedProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mData As SDTD.DiscoveredData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Timer
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=false
			Group="Behavior"
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
	#tag EndViewBehavior
End Class
#tag EndClass
