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
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   150
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   308
   End
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
      Height          =   321
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
      ScrollbarHorizontal=   False
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
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   608
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   608
   End
   Begin BeaconToolbar LeftButtons
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   10
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   150
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
		Sub EnableMenuItems()
		  If EditorMenu.Child("EditorLookforSupportedConfigLines") <> Nil Then
		    EditorMenu.Child("EditorLookforSupportedConfigLines").Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var ScanItem As New MenuItem("Setup Guided Editors")
		  ScanItem.Name = "EditorLookforSupportedConfigLines"
		  ScanItem.Enabled = True
		  Items.AddRow(ScanItem)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  Var Document As Beacon.Document = Self.Document
		  Var ConfigNames() As String = BeaconConfigs.AllConfigNames
		  Var CommandLineOptions As New Dictionary
		  Var CreatedEditorNames() As String
		  Var GenericProfile As New Beacon.GenericServerProfile(Document.Title, Beacon.Maps.All.Mask)
		  Var GameIniValues As New Dictionary
		  Var GameUserSettingsIniValues As New Dictionary
		  
		  Var ImportedConfigs() As Beacon.ConfigGroup
		  For Each ConfigName As String In ConfigNames
		    If ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		      Continue
		    End If
		    
		    If BeaconConfigs.ConfigPurchased(ConfigName, Identity.OmniVersion) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue
		    End If
		    
		    Var CreatedConfig As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(ConfigName, ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty)
		    If CreatedConfig = Nil Then
		      Continue
		    End If
		    
		    ImportedConfigs.AddRow(CreatedConfig)
		    
		    If Document.HasConfigGroup(ConfigName) Then
		      Var CurrentConfig As Beacon.ConfigGroup = Document.ConfigGroup(ConfigName, False)
		      If CurrentConfig <> Nil Then
		        If Not CurrentConfig.Merge(CreatedConfig) Then
		          Continue
		        End If
		      Else
		        Document.AddConfigGroup(CreatedConfig)
		      End If
		    Else
		      Document.AddConfigGroup(CreatedConfig)
		    End If
		    
		    Var GameIniArray() As Beacon.ConfigValue = CreatedConfig.GameIniValues(Document, Identity, GenericProfile)
		    Var GameUserSettingsIniArray() As Beacon.ConfigValue = CreatedConfig.GameUserSettingsIniValues(Document, Identity, GenericProfile)
		    Var NonGeneratedKeys() As Beacon.ConfigKey = CreatedConfig.NonGeneratedKeys(Identity)
		    For Each Key As Beacon.ConfigKey In NonGeneratedKeys
		      Select Case Key.File
		      Case "Game.ini"
		        GameIniArray.AddRow(New Beacon.ConfigValue(Key.Header, Key.Key, ""))
		      Case "GameUserSettings.ini"
		        GameUserSettingsIniArray.AddRow(New Beacon.ConfigValue(Key.Header, Key.Key, ""))
		      End Select
		    Next
		    
		    Beacon.ConfigValue.FillConfigDict(GameIniValues, GameIniArray)
		    Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniValues, GameUserSettingsIniArray)
		    
		    CreatedEditorNames.AddRow(Language.LabelForConfig(ConfigName))
		  Next
		  
		  If CreatedEditorNames.Count > 0 Then
		    Var Config As BeaconConfigs.CustomContent = Self.Config(True)
		    Config.GameIniContent(GameIniValues) = Config.GameIniContent
		    Config.GameUserSettingsIniContent(GameUserSettingsIniValues) = Config.GameUserSettingsIniContent
		  End If
		  
		  Self.SetupUI()
		  
		  If CreatedEditorNames.Count = 0 Then
		    Self.ShowAlert("No supported editor content found", "Beacon was unable to find any lines in either Game.ini or GameUserSettings.ini that it has a guided editor for.")
		  ElseIf CreatedEditorNames.Count = 1 Then
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the a guided editor for " + CreatedEditorNames(0) + ".")
		  Else
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the following guided editors: " + Language.EnglishOxfordList(CreatedEditorNames) + ".")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.CustomContent.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Select Case Self.Switcher.SelectedIndex
		  Case 1
		    Self.ConfigArea.Value = Self.Config(False).GameUserSettingsIniContent
		    Self.mGameUserSettingsIniState.ApplyTo(Self.ConfigArea)
		  Case 2
		    Self.ConfigArea.Value = Self.Config(False).GameIniContent
		    Self.mGameIniState.ApplyTo(Self.ConfigArea)
		  End Select
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditorLookforSupportedConfigLines() As Boolean Handles EditorLookforSupportedConfigLines.Action
			Self.LookForSupportedContent()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.CustomContent
		  Static ConfigName As String = BeaconConfigs.CustomContent.ConfigName
		  
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
		  Return Language.LabelForConfig(BeaconConfigs.CustomContent.ConfigName)
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
		  Var Combined As String = Config.GameUserSettingsIniContent + Encodings.ASCII.Chr(10) + Encodings.ASCII.Chr(10) + Config.GameIniContent
		  Self.Parse(Combined, "Custom Config Content")
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
		Private Function SelectionIsEncrypted() As Boolean
		  If Self.ConfigArea.SelectionStart >= Self.ConfigArea.Value.Length Then
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
		Private Sub ToggleEncryption()
		  Var Tag As String = BeaconConfigs.CustomContent.EncryptedTag
		  Var TagLen As Integer = Tag.Length
		  Var Source As String = Self.ConfigArea.Value
		  
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
		    
		    Self.ConfigArea.Value = Prefix + Content + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length
		    Self.ConfigArea.SelectionLength = Content.Length
		  Else
		    Var Start As Integer = Self.ConfigArea.SelectionStart
		    Var Length As Integer = Self.ConfigArea.SelectionLength
		    Var Prefix As String = Source.Left(Start)
		    Var Content As String = Source.Middle(Start, Length)
		    Var Suffix As String = Source.Right(Source.Length - (Start + Length))
		    
		    Self.ConfigArea.Value = Prefix + Tag + Content + Tag + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length + TagLen
		    Self.ConfigArea.SelectionLength = Content.Length
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEncryptButton()
		  If Self.LeftButtons.EncryptButton = Nil Then
		    Return
		  End If
		  
		  Var Button As BeaconToolbarItem = Self.LeftButtons.EncryptButton
		  If Self.SelectionIsEncrypted Then
		    Button.HelpTag = "Convert the encrypted value to plain text."
		    Button.Enabled = True
		    Button.Icon = IconToolbarUnlock
		  Else
		    Button.HelpTag = "Encrypt the selected text when saving."
		    Button.Enabled = Self.ConfigArea.SelectionLength > 0
		    Button.Icon = IconToolbarLock
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTextColors()
		  Self.mEncryptedRanges.ResizeTo(-1)
		  
		  Var Pos As Integer
		  Var Source As String = Self.ConfigArea.Value
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
		    
		    Self.mEncryptedRanges.AddRow(New Beacon.Range(StartPos, EndPos))
		    
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

#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Var SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Select Case Me.SelectedIndex
		  Case 1
		    Self.mGameIniState = New TextAreaState(Self.ConfigArea)
		    Self.ConfigArea.Value = Self.Config(False).GameUserSettingsIniContent
		    Self.mGameUserSettingsIniState.ApplyTo(Self.ConfigArea)
		  Case 2
		    Self.mGameUserSettingsIniState = New TextAreaState(Self.ConfigArea)
		    Self.ConfigArea.Value = Self.Config(False).GameIniContent
		    Self.mGameIniState.ApplyTo(Self.ConfigArea)
		  End Select
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigArea
	#tag Event
		Sub TextChange()
		  Self.UpdateTextColors()
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var SanitizedText As String = Self.SanitizeText(Me.Value)
		  If SanitizedText <> Me.Value Then
		    Var SelectionStart As Integer = Me.SelectionStart
		    Var SelectionLength As Integer = Me.SelectionLength
		    Me.Value = SanitizedText
		    Me.SelectionStart = SelectionStart
		    Me.SelectionLength = SelectionLength
		  End If
		  
		  Select Case Self.Switcher.SelectedIndex
		  Case 1
		    Self.Config(True).GameUserSettingsIniContent = SanitizedText
		    Self.Changed = True
		  Case 2
		    Self.Config(True).GameIniContent = SanitizedText
		    Self.Changed = True
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelChange()
		  Self.UpdateEncryptButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LeftButtons
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "EncryptButton"
		    Self.ToggleEncryption
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("EncryptButton", IconToolbarLock, "Encrypt the selected text when saving."))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
