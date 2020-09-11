#tag Class
Protected Class ConfigEditor
Inherits BeaconSubview
	#tag Event
		Sub EnableMenuItems()
		  If Self.SupportsRestore() Then
		    Self.EnableEditorMenuItem("DocumentRestoreConfigToDefault")
		  End If
		  
		  RaiseEvent EnableMenuItems
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var PreCount As Integer = Items.Count
		  RaiseEvent GetEditorMenuItems(Items)
		  If Items.Count > PreCount Then
		    // Something was added, so we need another separator
		    Items.AddRow(New MenuItem(MenuItem.TextSeparator))
		  End If
		  
		  Var RestoreItem As New MenuItem("Restore """ + Self.ConfigLabel + """ to Default", "restore")
		  RestoreItem.Name = "DocumentRestoreConfigToDefault"
		  RestoreItem.AutoEnabled = False
		  RestoreItem.Enabled = Self.SupportsRestore()
		  Items.AddRow(RestoreItem)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.SetupUI()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentRestoreConfigToDefault() As Boolean Handles DocumentRestoreConfigToDefault.Action
			If Not Self.SupportsRestore Then
			Return True
			End If
			
			If Self.ShowConfirm("Are you sure you want to restore """ + Self.ConfigLabel + """ to default settings?", "Wherever possible, this will remove the config options from your file completely, restoring settings to Ark's default values. You cannot undo this action.", "Restore", "Cancel") Then
			RaiseEvent RestoreToDefault
			Self.SetupUI()
			Self.Changed = True
			End If
			
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigSetName() As String
		  Return Self.mConfigSetName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.SettingUp = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController, ConfigSetName As String)
		  Self.mController = Controller
		  Self.mConfigSetName = ConfigSetName
		  Self.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Controller() As Beacon.DocumentController
		  Return Self.mController
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mController.Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub EnableEditorMenuItem(Named As String)
		  Var Item As MenuItem = EditorMenu.Child(Named)
		  If Item <> Nil Then
		    Item.Enable
		  End If
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

	#tag Method, Flags = &h1
		Protected Sub Parse(Content As String, Source As String)
		  Var Data As New Beacon.DiscoveredData
		  Data.GameIniContent = Content
		  
		  Var Parser As New Beacon.ImportThread(Data, Self.Document)
		  AddHandler Parser.Finished, AddressOf Parser_Finished
		  AddHandler Parser.UpdateUI, AddressOf Parser_UpdateUI
		  
		  Var Win As New ImporterWindow
		  Win.Source = Source
		  Win.ShowWithin(Self.TrueWindow)
		  
		  If Self.mParserWindows = Nil Then
		    Self.mParserWindows = New Dictionary
		  End If
		  Self.mParserWindows.Value(Parser) = Win
		  
		  Parser.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_Finished(Sender As Beacon.ImportThread, Document As Beacon.Document)
		  RemoveHandler Sender.Finished, AddressOf Parser_Finished
		  RemoveHandler Sender.UpdateUI, AddressOf Parser_UpdateUI
		  
		  Var Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Close
		  Self.mParserWindows.Remove(Sender)
		  
		  If Document Is Nil Then
		    Return
		  End If
		  
		  Var Imported As Boolean
		  Try
		    Imported = RaiseEvent ParsingFinished(Document)
		  Catch Err As RuntimeException
		    ExceptionWindow.Report(Err)
		  End Try
		  If Imported Then
		    Self.SetupUI()
		    Return
		  End If
		  
		  Var Label As String = Self.ConfigLabel
		  If Document.HasConfigGroup(Label, Self.ConfigSetName) = False Then
		    Return
		  End If
		  
		  Var NewGroup As Beacon.ConfigGroup = Document.ConfigGroup(Label, Self.ConfigSetName)
		  
		  If Self.Document.HasConfigGroup(Label, Self.ConfigSetName) Then
		    Var OriginalGroup As Beacon.ConfigGroup = Self.Document.ConfigGroup(Label, Self.ConfigSetName)
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("How would you like to merge " + Language.LabelForConfig(Label) + " into your existing editor?", "In the case of overlapping content, which should take priority?", "New Content", "Cancel", "Existing Content")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Action
		      If NewGroup.Merge(OriginalGroup) Then
		        Self.Document.AddConfigGroup(NewGroup, Self.ConfigSetName)
		      End If
		    Case BeaconUI.ConfirmResponses.Cancel
		      Return
		    Case BeaconUI.ConfirmResponses.Alternate
		      If Not OriginalGroup.Merge(NewGroup) Then
		        Return
		      End If
		    End Select
		  Else
		    Self.Document.AddConfigGroup(NewGroup, Self.ConfigSetName)
		  End If
		  
		  Self.SetupUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_UpdateUI(Sender As Beacon.ImportThread)
		  Var Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Progress = Sender.Progress
		End Sub
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

	#tag Method, Flags = &h1
		Protected Sub SetupUI()
		  Var SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Var FocusControl As RectControl = Self.Focus
		  #if TargetMacOS
		    ClearFocus()
		  #else
		    Self.SetFocus()
		  #endif
		  RaiseEvent SetupUI
		  If FocusControl <> Nil Then
		    FocusControl.SetFocus()
		  End If
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestore() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetEditorMenuItems(Items() As MenuItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ParsingFinished(Document As Beacon.Document) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RestoreToDefault()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SetupUI()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowIssue(Issue As Beacon.Issue)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConfigSetName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.DocumentController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParserWindows As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SettingUp As Boolean
	#tag EndProperty


	#tag ViewBehavior
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
