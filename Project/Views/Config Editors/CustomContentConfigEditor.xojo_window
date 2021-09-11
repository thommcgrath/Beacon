#tag Window
Begin ConfigEditor CustomContentConfigEditor Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   382
   HelpTag         =   ""
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   608
   Begin CodeArea ConfigArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   341
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   True
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "Source Code Pro"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   False
      Visible         =   True
      Width           =   608
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
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   608
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Document As Beacon.Document) As Boolean
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  Var SelfDocument As Beacon.Document = Self.Document
		  Var CreatedEditorNames() As String
		  Var Config As BeaconConfigs.CustomContent = Self.Config(False)
		  Var Organizer As New Beacon.ConfigOrganizer(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, Config.GameIniContent)
		  Organizer.Add(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, Config.GameUserSettingsIniContent)
		  
		  For Each CreatedConfig As Beacon.ConfigGroup In Document.ImplementedConfigs
		    Var ConfigName As String = CreatedConfig.ConfigName
		    If ConfigName = BeaconConfigs.NameCustomContent Then
		      Continue
		    End If
		    
		    If BeaconConfigs.ConfigPurchased(ConfigName, Identity.OmniFlags) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue
		    End If
		    
		    If SelfDocument.HasConfigGroup(ConfigName) Then
		      Var CurrentConfig As Beacon.ConfigGroup = SelfDocument.ConfigGroup(ConfigName, False)
		      If CurrentConfig <> Nil Then
		        If Not CurrentConfig.Merge(CreatedConfig) Then
		          Continue
		        End If
		      Else
		        SelfDocument.AddConfigGroup(CreatedConfig)
		      End If
		    Else
		      SelfDocument.AddConfigGroup(CreatedConfig)
		    End If
		    
		    Organizer.Remove(CreatedConfig.ManagedKeys)
		    
		    CreatedEditorNames.Add(Language.LabelForConfig(ConfigName))
		  Next
		  
		  If CreatedEditorNames.Count > 0 Then
		    Call Self.Config(True)
		    Config.GameIniContent() = Organizer
		    Config.GameUserSettingsIniContent() = Organizer
		  End If
		  
		  Self.SetupUI()
		  
		  If CreatedEditorNames.Count = 0 Then
		    Self.ShowAlert("No supported editor content found", "Beacon was unable to find any lines in either Game.ini or GameUserSettings.ini that it has a guided editor for.")
		  ElseIf CreatedEditorNames.Count = 1 Then
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the a guided editor for " + CreatedEditorNames(0) + ".")
		  Else
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the following guided editors: " + Language.EnglishOxfordList(CreatedEditorNames) + ".")
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTask(Task As BeaconConfigs.Task)
		  Select Case Task.UUID
		  Case "d29dc6f8-e834-4969-9cfe-b38e1c052156"
		    Self.LookForSupportedContent()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Select Case Self.ActiveButtonName
		  Case "GameUserSettingsIniButton"
		    Self.ConfigArea.Text = Self.Config(False).GameUserSettingsIniContent
		    Self.mGameUserSettingsIniState.ApplyTo(Self.ConfigArea)
		  Case "GameIniButton"
		    Self.ConfigArea.Text = Self.Config(False).GameIniContent
		    Self.mGameIniState.ApplyTo(Self.ConfigArea)
		  End Select
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditorLookforSupportedConfigLines() As Boolean Handles EditorLookforSupportedConfigLines.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Self.LookForSupportedContent()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.CustomContent
		  Static ConfigName As String = BeaconConfigs.NameCustomContent
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.CustomContent
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.CustomContent(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.CustomContent(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.CustomContent
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName) Then
		    Document.AddConfigGroup(Config)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(BeaconConfigs.NameCustomContent)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  Self.mGameUserSettingsIniState = New TextAreaState
		  Self.mGameIniState = New TextAreaState
		  
		  Super.Constructor(Controller)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LookForSupportedContent(Confirm As Boolean = True)
		  If Confirm Then
		    If Not Self.ShowConfirm("Do you want Beacon to search your Custom Config Content for lines that are supported by guided editors?", "Beacon will import your Custom Config Content and automatically setup guided editors for the lines it can support. Config lines will be merged according to Beacon's standard config merging guidelines.", "Continue", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Config As BeaconConfigs.CustomContent = Self.Config(False)
		  Self.Parse(Config.GameUserSettingsIniContent, Config.GameIniContent, "Custom Config Content")
		End Sub
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
		  Var Content As String = Self.ConfigArea.Text
		  Var Boundary As String = Content.DetectLineEnding
		  
		  Var Prefix As String = Content.Left(Self.ConfigArea.SelectionStart)
		  Var LineStartPos As Integer
		  Do
		    Var Pos As Integer = Prefix.IndexOf(LineStartPos, Boundary)
		    If Pos = -1 Then
		      Exit
		    Else
		      LineStartPos = Pos + Boundary.Length
		    End If
		  Loop
		  
		  Var LineEndPos As Integer = Content.IndexOf(LineStartPos, Boundary)
		  If LineEndPos = -1 Then
		    LineEndPos = Content.Length
		  End If
		  
		  Var Line As String = Content.Middle(LineStartPos, LineEndPos - LineStartPos).Trim
		  Return Line.BeginsWith("//")
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
		Private Sub ToggleComment()
		  Var StartPos As Integer = Self.ConfigArea.SelectionStart
		  Var EndPos As Integer = StartPos + Self.ConfigArea.SelectionLength
		  Var Content As String = Self.ConfigArea.Text
		  Var EOL As String = Content.DetectLineEnding
		  Var PreContent As String = Content.Left(StartPos)
		  Var PostContent As String = Content.Middle(EndPos)
		  Var SelContent As String = Content.Middle(StartPos, EndPos - StartPos)
		  
		  Var PreLines() As String = PreContent.Split(EOL)
		  Var SelLines() As String = SelContent.Split(EOL)
		  Var PostLines() As String = PostContent.Split(EOL)
		  If SelLines.Count > 0 And PreLines.Count > 0 Then
		    SelLines(0) = PreLines(PreLines.LastIndex) + SelLines(0)
		    PreLines.RemoveAt(PreLines.LastIndex)
		  ElseIf PreLines.Count > 0 Then
		    SelLines.Add(PreLines(PreLines.LastIndex))
		    PreLines.RemoveAt(PreLines.LastIndex)
		  End If
		  If SelLines.Count > 0 And PostLines.Count > 0 Then
		    SelLines(SelLines.LastIndex) = SelLines(SelLines.LastIndex) + PostLines(0)
		    PostLines.RemoveAt(0)
		  ElseIf PostLines.Count > 0 Then
		    SelLines.Add(PostLines(PostLines.LastIndex))
		    PostLines.RemoveAt(PostLines.LastIndex)
		  End If
		  
		  If SelLines.Count = 0 Then
		    Return
		  End If
		  
		  Var RemoveComments As Boolean
		  RemoveComments = SelLines(0).Trim.BeginsWith("//")
		  For Idx As Integer = 0 To SelLines.LastIndex
		    SelLines(Idx) = SelLines(Idx).Trim
		    
		    If RemoveComments Then
		      If SelLines(Idx).BeginsWith("//") Then
		        SelLines(Idx) = SelLines(Idx).Middle(2).Trim
		      End If
		    Else
		      If SelLines(Idx).BeginsWith("//") = False Then
		        SelLines(Idx) = "// " + SelLines(Idx)
		      End If
		    End If
		  Next
		  
		  If PreLines.Count > 0 Then
		    PreContent = PreLines.Join(EOL) + EOL
		  Else
		    PreContent = ""
		  End If
		  
		  If PostLines.Count > 0 Then
		    PostContent = EOL + PostLines.Join(EOL)
		  Else
		    PostContent = ""
		  End If
		  
		  SelContent = SelLines.Join(EOL)
		  
		  Self.ConfigArea.Text = PreContent + SelContent + PostContent
		  Self.ConfigArea.SelectionStart = PreContent.Length
		  Self.ConfigArea.SelectionLength = SelContent.Length
		  
		  Self.UpdateCommentButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleEncryption()
		  Var Tag As String = BeaconConfigs.CustomContent.EncryptedTag
		  Var TagLen As Integer = Tag.Length
		  Var Source As String = Self.ConfigArea.Text
		  
		  If Self.SelectionIsEncrypted Then
		    Var StartPos As Integer = Self.ConfigArea.SelectionStart
		    For I As Integer = StartPos DownTo TagLen
		      If Source.Middle((I - TagLen), TagLen) = Tag Then
		        StartPos = I
		        Exit For I
		      End If
		    Next
		    Var EndPos As Integer = Source.IndexOf(StartPos, Tag)
		    If EndPos = -1 Then
		      Source = Source + Tag
		      EndPos = Source.Length
		    End If
		    
		    Var ContentLen As Integer = EndPos - StartPos
		    Var Prefix As String = Source.Left(StartPos - TagLen)
		    Var Content As String = Source.Middle(StartPos, ContentLen)
		    Var Suffix As String = Source.Middle(EndPos + TagLen)
		    
		    Self.ConfigArea.Text = Prefix + Content + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length
		    Self.ConfigArea.SelectionLength = Content.Length
		  Else
		    Var Start As Integer = Self.ConfigArea.SelectionStart
		    Var Length As Integer = Self.ConfigArea.SelectionLength
		    Var Prefix As String = Source.Left(Start)
		    Var Content As String = Source.Middle(Start, Length)
		    Var Suffix As String = Source.Right(Source.Length - (Start + Length))
		    
		    Self.ConfigArea.Text = Prefix + Tag + Content + Tag + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length + TagLen
		    Self.ConfigArea.SelectionLength = Content.Length
		  End If
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
		  Var Tag As String = BeaconConfigs.CustomContent.EncryptedTag
		  Var TagLen As Integer = Tag.Length
		  Var Styles As StyledText = Self.ConfigArea.StyledText
		  If Styles <> Nil Then
		    Styles.TextColor(0, Source.Length) = SystemColors.LabelColor
		    Styles.Bold(0, Source.Length) = False
		    Styles.Italic(0, Source.Length) = False
		  End If
		  
		  Do
		    Pos = Source.IndexOf(Pos, Tag)
		    If Pos = -1 Then
		      Return
		    End If
		    
		    Var StartPos As Integer = Pos + TagLen
		    Var EndPos As Integer = Source.IndexOf(StartPos, Tag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		    End If
		    
		    Self.mEncryptedRanges.Add(New Beacon.Range(StartPos, EndPos))
		    
		    If Styles <> Nil Then
		      Styles.TextColor(StartPos - TagLen, TagLen) = SystemColors.TertiaryLabelColor
		      Styles.Italic(StartPos - TagLen, TagLen) = True
		      Styles.TextColor(StartPos, EndPos - StartPos) = SystemColors.SystemGreenColor
		      Styles.Bold(StartPos, EndPos - StartPos) = True
		      Styles.TextColor(EndPos, Min(TagLen, Source.Length - EndPos)) = SystemColors.TertiaryLabelColor
		      Styles.Italic(EndPos, Min(TagLen, Source.Length - EndPos)) = True
		    End If
		    
		    Pos = EndPos + TagLen
		  Loop
		  
		  Self.UpdateEncryptButton()
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var GameUserSettingsIniButton As OmniBarItem = Self.ConfigToolbar.Item("GameUserSettingsIniButton")
			  Var GameIniButton As OmniBarItem = Self.ConfigToolbar.Item("GameIniButton")
			  If (GameUserSettingsIniButton Is Nil) = False And GameUserSettingsIniButton.Toggled Then
			    Return GameUserSettingsIniButton.Name
			  ElseIf (GameIniButton Is Nil) = False And GameIniButton.Toggled Then
			    Return GameIniButton.Name
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var GameUserSettingsIniButton As OmniBarItem = Self.ConfigToolbar.Item("GameUserSettingsIniButton")
			  Var GameIniButton As OmniBarItem = Self.ConfigToolbar.Item("GameIniButton")
			  If (GameUserSettingsIniButton Is Nil) = False Then
			    GameUserSettingsIniButton.Toggled = (GameUserSettingsIniButton.Name = Value)
			  End If
			  If (GameIniButton Is Nil) = False Then
			    GameIniButton.Toggled = (GameIniButton.Name = Value)
			  End If
			End Set
		#tag EndSetter
		Private ActiveButtonName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedRanges() As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniState As TextAreaState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniState As TextAreaState
	#tag EndProperty


#tag EndWindowCode

#tag Events ConfigArea
	#tag Event
		Sub TextChange()
		  Self.UpdateTextColors()
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var SanitizedText As String = Self.SanitizeText(Me.Text)
		  If SanitizedText <> Me.Text Then
		    Var SelectionStart As Integer = Me.SelectionStart
		    Var SelectionLength As Integer = Me.SelectionLength
		    Me.Text = SanitizedText
		    Me.SelectionStart = SelectionStart
		    Me.SelectionLength = SelectionLength
		  End If
		  
		  Select Case Self.ActiveButtonName
		  Case "GameUserSettingsIniButton"
		    Self.Config(True).GameUserSettingsIniContent = SanitizedText
		    Self.Changed = True
		  Case "GameIniButton"
		    Self.Config(True).GameIniContent = SanitizedText
		    Self.Changed = True
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelChange()
		  Self.UpdateEncryptButton()
		  Self.UpdateCommentButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTab("GameUserSettingsIniButton", "GameUserSettings.ini"))
		  Me.Append(OmniBarItem.CreateTab("GameIniButton", "Game.ini"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EncryptButton", "Encrypt", IconToolbarLock, "Encrypt the selected text when saving", False))
		  Me.Append(OmniBarItem.CreateButton("CommentButton", "Comment", IconToolbarComment, "Comment the current line"))
		  
		  Me.Item("GameUserSettingsIniButton").Toggled = True
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
		  Case "GameUserSettingsIniButton", "GameIniButton"
		    If Item.Toggled Then
		      // Don't do anything
		      Return
		    End If
		    
		    Var SettingUp As Boolean = Self.SettingUp
		    Self.SettingUp = True
		    Select Case Item.Name
		    Case "GameUserSettingsIniButton"
		      Self.mGameIniState = New TextAreaState(Self.ConfigArea)
		      Self.ConfigArea.Text = Self.Config(False).GameUserSettingsIniContent
		      Self.mGameUserSettingsIniState.ApplyTo(Self.ConfigArea)
		    Case "GameIniButton"
		      Self.mGameUserSettingsIniState = New TextAreaState(Self.ConfigArea)
		      Self.ConfigArea.Text = Self.Config(False).GameIniContent
		      Self.mGameIniState.ApplyTo(Self.ConfigArea)
		    End Select
		    Me.Item("GameIniButton").Toggled = (Item.Name = "GameIniButton")
		    Me.Item("GameUserSettingsIniButton").Toggled = (Item.Name = "GameUserSettingsIniButton")
		    Self.SettingUp = SettingUp
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
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
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="TabStop"
		Visible=true
		Group="Position"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
