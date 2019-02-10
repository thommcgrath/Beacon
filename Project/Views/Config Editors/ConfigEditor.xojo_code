#tag Class
Protected Class ConfigEditor
Inherits BeaconSubview
	#tag Event
		Sub EnableMenuItems()
		  DocumentRestoreConfigToDefault.Enable
		  DocumentRestoreConfigToDefault.Text = "Restore """ + Self.ConfigLabel + """ to Default"
		  
		  RaiseEvent EnableMenuItems
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.SettingUp = True
		  RaiseEvent SetupUI
		  Self.SettingUp = False
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentRestoreConfigToDefault() As Boolean Handles DocumentRestoreConfigToDefault.Action
			If Self.ShowConfirm("Are you sure you want to restore """ + Self.ConfigLabel + """ to default settings?", "Wherever possible, this will remove the config options from your file completely, restoring settings to Ark's default values. You cannot undo this action.", "Restore", "Cancel") Then
			RaiseEvent RestoreToDefault
			Self.SettingUp = True
			RaiseEvent SetupUI
			Self.SettingUp = False
			Self.ContentsChanged = True
			End If
			
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ConfigLabel() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.SettingUp = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  Self.mController = Controller
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

	#tag Method, Flags = &h0
		Sub GoToIssue(Issue As Beacon.Issue)
		  RaiseEvent ShowIssue(Issue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFinished()
		  Dim Value As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  RaiseEvent SetupUI
		  Self.SettingUp = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Parse(Content As Text, Source As Text)
		  Dim Parser As New Beacon.ImportThread
		  AddHandler Parser.Finished, WeakAddressOf Parser_Finished
		  AddHandler Parser.UpdateUI, WeakAddressOf Parser_UpdateUI
		  
		  Dim Win As New ImporterWindow
		  Win.Source = Source
		  Win.ShowWithin(Self.TrueWindow)
		  
		  If Self.mParserWindows = Nil Then
		    Self.mParserWindows = New Xojo.Core.Dictionary
		  End If
		  Self.mParserWindows.Value(Parser) = Win
		  
		  Parser.GameIniContent = Content
		  Parser.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_Finished(Sender As Beacon.ImportThread, ParsedData As Xojo.Core.Dictionary)
		  Dim Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Close
		  Self.mParserWindows.Remove(Sender)
		  
		  RaiseEvent ParsingFinished(ParsedData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parser_UpdateUI(Sender As Beacon.ImportThread)
		  Dim Win As ImporterWindow = Self.mParserWindows.Value(Sender)
		  Win.Progress = Sender.Progress
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ParsingFinished(ParsedData As Xojo.Core.Dictionary)
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
		Private mController As Beacon.DocumentController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParserWindows As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SettingUp As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Progress"
			Group="Behavior"
			InitialValue="ProgressNone"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=true
			Group="Behavior"
			InitialValue="400"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=true
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToolbarCaption"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
