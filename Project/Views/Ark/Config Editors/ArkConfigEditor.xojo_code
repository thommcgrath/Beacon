#tag Class
Protected Class ArkConfigEditor
Inherits BeaconSubview
	#tag Event
		Sub Open()
		  RaiseEvent Open
		  // Do not call SetupUI here, it's redundant. Shown will handle that.
		  Self.SettingUp = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  Var FireSetupUI As Boolean = True
		  RaiseEvent Shown(UserData, FireSetupUI)
		  If FireSetupUI Then
		    Self.SetupUI()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Ark.ConfigGroup
		  Var Config As Ark.ConfigGroup
		  Var InternalName As String = Self.InternalName
		  
		  If (Self.mConfigRef Is Nil) = False And (Self.mConfigRef.Value Is Nil) = False Then
		    Config = Ark.ConfigGroup(Self.mConfigRef.Value)
		  ElseIf Self.mProject.HasConfigGroup(InternalName) Then
		    Config = Self.mProject.ConfigGroup(InternalName, False)
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = Ark.Configs.CreateInstance(InternalName)
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Self.mProject.HasConfigGroup(InternalName) = False Then
		    Self.mProject.AddConfigGroup(Config)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(Self.InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.SettingUp = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project)
		  Self.mProject = Project
		  Self.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GoToIssue(Issue As Beacon.Issue)
		  RaiseEvent ShowIssue(Issue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFinished()
		  Self.SetupUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InvalidateConfigRef()
		  Self.mConfigRef = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Parse(GameUserSettingsIniContent As String, GameIniContent As String, Source As String)
		  Var Data As New Ark.DiscoveredData
		  Data.GameUserSettingsIniContent = GameUserSettingsIniContent
		  Data.GameIniContent = GameIniContent
		  
		  Var Parser As New Ark.ImportThread(Data, Self.mProject)
		  AddHandler Parser.Finished, AddressOf Parser_Finished
		  AddHandler Parser.UpdateUI, AddressOf Parser_UpdateUI
		  
		  Var Win As New ImporterWindow
		  Win.Source = Source
		  Win.ShowDelayed(Self.TrueWindow)
		  
		  If Self.mParserWindows = Nil Then
		    Self.mParserWindows = New Dictionary
		  End If
		  Self.mParserWindows.Value(Parser) = Win
		  
		  Parser.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseDouble(Input As String, ByRef Value As Double) As Boolean
		  If IsNumeric(Input) Then
		    Value = CDbl(Input)
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_Finished(Sender As Ark.ImportThread, Project As Ark.Project)
		  RemoveHandler Sender.Finished, AddressOf Parser_Finished
		  RemoveHandler Sender.UpdateUI, AddressOf Parser_UpdateUI
		  
		  Var Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Close
		  Self.mParserWindows.Remove(Sender)
		  
		  If Project Is Nil Then
		    Return
		  End If
		  
		  Var Imported As Boolean
		  Try
		    Imported = RaiseEvent ParsingFinished(Project)
		  Catch Err As RuntimeException
		    ExceptionWindow.Report(Err)
		  End Try
		  If Imported Then
		    Self.SetupUI()
		    Return
		  End If
		  
		  Var InternalName As String = Self.InternalName
		  If Project.HasConfigGroup(InternalName) = False Then
		    Return
		  End If
		  
		  Var NewGroup As Ark.ConfigGroup = Project.ConfigGroup(InternalName)
		  
		  If Self.Project.HasConfigGroup(InternalName) And Self.Project.ConfigGroup(InternalName).SupportsMerging Then
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("How would you like to merge " + Self.ConfigLabel() + " into your existing editor?", "In the case of overlapping content, which should take priority?", "New Content", "Cancel", "Existing Content")
		    If Choice = BeaconUI.ConfirmResponses.Cancel Then
		      Return
		    End If
		    
		    Var OriginalGroup As Ark.ConfigGroup = Self.Project.ConfigGroup(InternalName)
		    Var Editors(1) As Ark.ConfigGroup
		    Editors(0) = OriginalGroup
		    Editors(1) = NewGroup
		    Var ZeroHasPriority As Boolean = Choice = BeaconUI.ConfirmResponses.Alternate
		    Var Merged As Ark.ConfigGroup = Ark.Configs.Merge(Editors, ZeroHasPriority)
		    
		    Self.Project.AddConfigGroup(Merged)
		  Else
		    Self.Project.AddConfigGroup(NewGroup)
		  End If
		  
		  Self.SetupUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_UpdateUI(Sender As Ark.ImportThread)
		  Var Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Progress = Sender.Progress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Ark.Project
		  Return Self.mProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunTool(ToolUUID As String) As Boolean
		  Var Tools() As Ark.ProjectTool = Ark.Configs.AllTools
		  For Each Tool As Ark.ProjectTool In Tools
		    If Tool.UUID = ToolUUID Then
		      RaiseEvent RunTool(Tool)
		      Return True
		    End If
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SanitizeText(Source As String, ASCIIOnly As Boolean = True) As String
		  Var Sanitizer As New RegEx
		  If ASCIIOnly Then
		    Sanitizer.SearchPattern = "[^\x0A\x0D\x20-\x7E]+"
		  Else
		    Sanitizer.SearchPattern = "[\x00-\x08\x0B-\x0C\x0E-\x1F\x7F]+"
		  End If
		  Sanitizer.ReplacementPattern = ""
		  If ASCIIOnly Then
		    Return Sanitizer.Replace(Source.SanitizeIni).ConvertEncoding(Encodings.ASCII)
		  Else
		    Return Sanitizer.Replace(Source.SanitizeIni)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupUI()
		  Var SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Var FocusControl As RectControl = Self.Focus
		  Self.SetFocus()
		  RaiseEvent SetupUI
		  If FocusControl <> Nil Then
		    FocusControl.SetFocus()
		  End If
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ParsingFinished(Project As Ark.Project) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RunTool(Tool As Ark.ProjectTool)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SetupUI()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowIssue(Issue As Beacon.Issue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParserWindows As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SettingUp As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFrontmost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewTitle"
			Visible=true
			Group="Behavior"
			InitialValue="Untitled"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Progress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=true
			Group="Behavior"
			InitialValue="400"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=true
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
