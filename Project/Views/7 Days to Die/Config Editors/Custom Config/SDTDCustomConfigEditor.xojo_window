#tag DesktopWindow
Begin SDTDConfigEditor SDTDCustomConfigEditor Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   500
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   800
   Begin CodeEditor ConfigArea
      AutoDeactivate  =   True
      Enabled         =   True
      HasBorder       =   False
      Height          =   459
      HorizontalScrollPosition=   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectionLength =   0
      ShowInfoBar     =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      VerticalScrollPosition=   0
      Visible         =   True
      Width           =   800
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   800
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Select Case Self.ActiveButtonName
		  Case "ServerConfigButton"
		    Self.ConfigArea.Text = Self.Config(False).XmlContent(SDTD.ConfigFileServerConfigXml)
		    Self.mServerConfigXmlState.ApplyTo(Self.ConfigArea)
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As SDTD.Configs.CustomConfig
		  Return SDTD.Configs.CustomConfig(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As SDTD.Project)
		  Self.mServerConfigXmlState = New TextAreaState
		  Super.Constructor(Project)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentFile() As String
		  Select Case Self.ActiveButtonName
		  Case "ServerConfigButton"
		    Return "serverconfig.xml"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return SDTD.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.UpdateTextColors()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectionIsCommented() As Boolean
		  Var Pos As Integer = Self.ConfigArea.SelectionStart
		  If Pos = Self.ConfigArea.Length Then
		    If Pos = 0 Then
		      // No content
		      Return False
		    End If
		    
		    // Using the style information won't help
		    Var Source As String = Self.ConfigArea.Text
		    
		    // Make sure there is a potential comment at all
		    If Source.Contains("<!--") = False Then
		      Return False
		    End If
		    
		    // Look backwards until <!-- or --> is found
		    Var CharCount As Integer = Source.Length
		    Var Bound As Integer = CharCount - 1
		    For Idx As Integer = Bound DownTo 0
		      Var RemainingChars As Integer = CharCount - Idx
		      Var Tail As String = Source.Middle(Idx, Min(RemainingChars, 4))
		      If Tail.BeginsWith("<!--") Then
		        Return True
		      ElseIf Tail.BeginsWith("-->") Then
		        Return False
		      End If
		    Next
		    
		    // How did we get here?
		    Return False
		  End If
		  
		  Var Style As ScintillaStyleMBS = Self.ConfigArea.StyleAt(Pos)
		  If Style Is Nil Then
		    Return False
		  End If
		  
		  Return Style.Name = "SCE_H_COMMENT"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectionIsEncrypted() As Boolean
		  If Self.ConfigArea.SelectionStart >= Self.ConfigArea.Text.Length Then
		    Return False
		  End If
		  
		  Var StartPos As Integer = Self.ConfigArea.SelectionStart
		  Var EndPos As Integer = StartPos + Max(Self.ConfigArea.SelectionLength, 1)
		  For Each Range As Beacon.Range In Self.mEncryptedRanges
		    If StartPos >= Range.Min And EndPos <= Range.Max Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAutocomplete()
		  Var CurrentLine As String = Self.ConfigArea.CurrentLine.Trim
		  Var Position As Integer = Self.ConfigArea.PositionInLine
		  If Position = 0 Or Position <> CurrentLine.Length Or CurrentLine.IndexOf("=") > -1 Then
		    // Only show autocomplete if we are at the end of the line, and the line
		    // does not contain an equal sign
		    Self.ConfigArea.AutoCompleteCancel
		    Return
		  End If
		  
		  // Next, the word list should be based on the entire typed line
		  Var Matches() As String
		  Var MaxWidth As Integer
		  For Each Possible As String In Self.mAutocompleteWords
		    If Possible.BeginsWith(CurrentLine) Then
		      Matches.Add(Possible)
		      MaxWidth = Max(MaxWidth, Possible.Length)
		    End If
		  Next Possible
		  
		  If Matches.Count = 0 Then
		    Self.ConfigArea.AutoCompleteCancel
		    Return
		  End If
		  
		  Self.ConfigArea.AutoCompleteIgnoreCase = True
		  Self.ConfigArea.AutoCompleteMaxHeight = 9
		  Self.ConfigArea.AutoCompleteMaxWidth = 0
		  Self.ConfigArea.AutoCompleteSeparator = 32
		  Self.ConfigArea.AutoCompleteSetFillUps("=")
		  Self.ConfigArea.AutoCompleteShow(CurrentLine.Length, String.FromArray(Matches, " "))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleComment()
		  Var StartTag As String = "<!--"
		  Var EndTag As String = "-->"
		  Var StartTagLen As Integer = StartTag.Length
		  Var EndTagLen As Integer = EndTag.Length
		  Var Source As String = Self.ConfigArea.Text
		  
		  If Self.SelectionIsCommented Then
		    Var StartPos As Integer = Self.ConfigArea.SelectionStart
		    For I As Integer = StartPos DownTo StartTagLen
		      If Source.Middle((I - StartTagLen), StartTagLen) = StartTag Then
		        StartPos = I
		        Exit For I
		      End If
		    Next
		    Var EndPos As Integer = Source.IndexOf(StartPos, EndTag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		      Source = Source + EndTag
		    End If
		    
		    Var ContentLen As Integer = EndPos - StartPos
		    Var Prefix As String = Source.Left(StartPos - StartTagLen)
		    Var Content As String = Source.Middle(StartPos, ContentLen).Trim
		    Var Suffix As String = Source.Middle(EndPos + EndTagLen)
		    
		    Self.ConfigArea.Text = Prefix + Content + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length
		    Self.ConfigArea.SelectionLength = Content.Length
		  Else
		    Var Start As Integer = Self.ConfigArea.SelectionStart
		    Var Length As Integer = Self.ConfigArea.SelectionLength
		    Var Prefix As String = Source.Left(Start)
		    Var Content As String = Source.Middle(Start, Length)
		    Var Suffix As String = Source.Right(Source.Length - (Start + Length))
		    
		    Self.ConfigArea.Text = Prefix + StartTag + " " + Content + " " + EndTag + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length + StartTagLen + 1
		    Self.ConfigArea.SelectionLength = Content.Length
		  End If
		  
		  Self.UpdateCommentButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleEncryption()
		  Var StartTag As String = "<" + SDTD.Configs.CustomConfig.EncryptedTag + ">"
		  Var EndTag As String = "</" + SDTD.Configs.CustomConfig.EncryptedTag + ">"
		  Var StartTagLen As Integer = StartTag.Length
		  Var EndTagLen As Integer = EndTag.Length
		  Var Source As String = Self.ConfigArea.Text
		  
		  If Self.SelectionIsEncrypted Then
		    Var StartPos As Integer = Self.ConfigArea.SelectionStart
		    For I As Integer = StartPos DownTo StartTagLen
		      If Source.Middle((I - StartTagLen), StartTagLen) = StartTag Then
		        StartPos = I
		        Exit For I
		      End If
		    Next
		    Var EndPos As Integer = Source.IndexOf(StartPos, EndTag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		      Source = Source + EndTag
		    End If
		    
		    Var ContentLen As Integer = EndPos - StartPos
		    Var Prefix As String = Source.Left(StartPos - StartTagLen)
		    Var Content As String = Source.Middle(StartPos, ContentLen)
		    Var Suffix As String = Source.Middle(EndPos + EndTagLen)
		    
		    Self.ConfigArea.Text = Prefix + Content + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length
		    Self.ConfigArea.SelectionLength = Content.Length
		  Else
		    Var Start As Integer = Self.ConfigArea.SelectionStart
		    Var Length As Integer = Self.ConfigArea.SelectionLength
		    Var Prefix As String = Source.Left(Start)
		    Var Content As String = Source.Middle(Start, Length)
		    Var Suffix As String = Source.Right(Source.Length - (Start + Length))
		    
		    Self.ConfigArea.Text = Prefix + StartTag + Content + EndTag + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length + StartTagLen
		    Self.ConfigArea.SelectionLength = Content.Length
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateAutoComplete()
		  Var CurrentFile As String = Self.CurrentFile
		  Var Options() As SDTD.ConfigOption = SDTD.DataSource.Pool.Get(False).GetConfigOptions(CurrentFile, "", Self.Project.GameVersion, Self.Project.ContentPacks)
		  Self.mAutocompleteWords.ResizeTo(Options.LastIndex)
		  For Idx As Integer = Options.FirstIndex To Options.LastIndex
		    Self.mAutocompleteWords(Idx) = Options(Idx).Key
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommentButton()
		  Var CommentButton As OmniBarItem = Self.ConfigToolbar.Item("CommentButton")
		  If CommentButton Is Nil Then
		    Return
		  End If
		  
		  If Self.SelectionIsCommented Then
		    CommentButton.HelpTag = "Uncomment the current line"
		    CommentButton.Caption = "Uncomment"
		    CommentButton.Icon = IconToolbarUncomment
		  Else
		    CommentButton.HelpTag = "Comment the current line"
		    CommentButton.Caption = "Comment"
		    CommentButton.Icon = IconToolbarComment
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEncryptButton()
		  Var EncryptButton As OmniBarItem = Self.ConfigToolbar.Item("EncryptButton")
		  If EncryptButton Is Nil Then
		    Return
		  End If
		  
		  If Self.SelectionIsEncrypted Then
		    EncryptButton.HelpTag = "Convert the encrypted value to plain text"
		    EncryptButton.Caption = "Decrypt"
		    EncryptButton.Enabled = True
		    EncryptButton.Icon = IconToolbarUnlock
		  Else
		    EncryptButton.HelpTag = "Encrypt the selected text when saving"
		    EncryptButton.Caption = "Encrypt"
		    EncryptButton.Enabled = Self.ConfigArea.SelectionLength > 0
		    EncryptButton.Icon = IconToolbarLock
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTextColors()
		  Self.mEncryptedRanges.ResizeTo(-1)
		  
		  Var Pos As Integer
		  Var Source As String = Self.ConfigArea.Text
		  Var StartTag As String = "<" + SDTD.Configs.CustomConfig.EncryptedTag + ">"
		  Var EndTag As String = "</" + SDTD.Configs.CustomConfig.EncryptedTag + ">"
		  Var StartTagLen As Integer = StartTag.Length
		  Var EndTagLen As Integer = EndTag.Length
		  
		  Do
		    If Pos > Source.Length Then
		      Exit
		    End If
		    
		    Pos = Source.IndexOf(Pos, StartTag)
		    If Pos = -1 Then
		      Exit
		    End If
		    
		    Var StartPos As Integer = Pos + StartTagLen
		    Var EndPos As Integer = Source.IndexOf(StartPos, EndTag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		    End If
		    
		    Self.mEncryptedRanges.Add(New Beacon.Range(StartPos, EndPos))
		    
		    Pos = EndPos + EndTagLen
		  Loop
		  
		  Self.UpdateEncryptButton()
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var ServerConfigButton As OmniBarItem = Self.ConfigToolbar.Item("ServerConfigButton")
			  If (ServerConfigButton Is Nil) = False And ServerConfigButton.Toggled Then
			    Return ServerConfigButton.Name
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var ServerConfigButton As OmniBarItem = Self.ConfigToolbar.Item("ServerConfigButton")
			  If (ServerConfigButton Is Nil) = False Then
			    ServerConfigButton.Toggled = (ServerConfigButton.Name = Value)
			  End If
			End Set
		#tag EndSetter
		Private ActiveButtonName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAutocompleteWords() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedRanges() As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerConfigXmlState As TextAreaState
	#tag EndProperty


#tag EndWindowCode

#tag Events ConfigArea
	#tag Event
		Sub TextChanged()
		  Self.UpdateTextColors()
		  Self.UpdateAutoComplete()
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var SanitizedText As String = Beacon.SanitizeText(Me.Text)
		  If SanitizedText <> Me.Text Then
		    Var SelectionStart As Integer = Me.SelectionStart
		    Var SelectionLength As Integer = Me.SelectionLength
		    Me.Text = SanitizedText
		    Me.SelectionStart = SelectionStart
		    Me.SelectionLength = SelectionLength
		  End If
		  
		  Select Case Self.ActiveButtonName
		  Case "ServerConfigButton"
		    Self.Config(True).XmlContent(SDTD.ConfigFileServerConfigXml) = SanitizedText
		    Self.Modified = True
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateEncryptButton()
		  Self.UpdateCommentButton()
		  Self.UpdateAutoComplete()
		End Sub
	#tag EndEvent
	#tag Event
		Sub CharacterAdded(Character as Integer, CharacterSource as Integer)
		  #Pragma Unused Character
		  #Pragma Unused CharacterSource
		  
		  If Me.SelectionEnd = Me.SelectionStart And Me.SelectionStart > 0 And Me.AutoCompleteActive = False Then
		    Self.ShowAutocomplete()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SetupNeeded()
		  SDTD.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DWellEnd(Position as Integer, X as Integer, Y as Integer)
		  #Pragma Unused Position
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Me.CallTipCancel
		End Sub
	#tag EndEvent
	#tag Event
		Sub DWellStart(Position as Integer, X as Integer, Y as Integer)
		  #Pragma Unused Position
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Position = -1 Then
		    Me.CallTipCancel
		    Return
		  End If
		  Var LineNum As Integer = Me.LineFromPosition(Position)
		  Var PositionInLine As Integer = Position - Me.LineStart(LineNum)
		  Var Line As String = Me.Line(LineNum).Trim
		  
		  Var EqualsPosition As Integer = Line.IndexOf("=")
		  If EqualsPosition = -1 Then
		    EqualsPosition = Line.Length
		  End If
		  
		  If PositionInLine > EqualsPosition Then 
		    Me.CallTipCancel
		    Return
		  End If
		  
		  Var Keys() As SDTD.ConfigOption = SDTD.DataSource.Pool.Get(False).GetConfigOptions(Self.CurrentFile, Line.Left(EqualsPosition), Self.Project.GameVersion)
		  If Keys Is Nil Or Keys.Count = 0 Then
		    Me.CallTipCancel
		    Return
		  End If
		  
		  Me.CallTipShow(Me.LineStart(LineNum), Keys(0).Description)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.MouseDwellTime = 1500
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateTab("ServerConfigButton", "ServerConfig.xml"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EncryptButton", "Encrypt", IconToolbarLock, "Encrypt the selected text when saving", False))
		  Me.Append(OmniBarItem.CreateButton("CommentButton", "Comment", IconToolbarComment, "Comment the current line"))
		  
		  Me.Item("ServerConfigButton").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "EncryptButton"
		    Self.ToggleEncryption()
		  Case "CommentButton"
		    Self.ToggleComment()
		  Case "ServerConfigButton"
		    If Item.Toggled Then
		      // Don't do anything
		      Return
		    End If
		    
		    Var SettingUp As Boolean = Self.SettingUp
		    Self.SettingUp = True
		    Select Case Item.Name
		    Case "ServerConfigButton"
		      Self.mServerConfigXmlState = New TextAreaState(Self.ConfigArea)
		      Self.ConfigArea.Text = Self.Config(False).XmlContent(SDTD.ConfigFileServerConfigXml)
		      Self.mServerConfigXmlState.ApplyTo(Self.ConfigArea)
		    End Select
		    Me.Item("ServerConfigButton").Toggled = (Item.Name = "ServerConfigButton")
		    Self.SettingUp = SettingUp
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
