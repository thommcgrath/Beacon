#tag Window
Begin DiscoveryView LocalDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   396
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
   Width           =   511
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   396
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   511
      Begin Label SetupMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Simple Config Import"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   471
      End
      Begin GroupBox GroupBox1
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   ""
         Enabled         =   True
         Height          =   91
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         Visible         =   True
         Width           =   471
         Begin Label Label1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   51
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "GroupBox1"
            Italic          =   False
            Left            =   40
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Multiline       =   True
            Scope           =   2
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Paste the contents of your Game.ini and/or GameUserSettings.ini files here. Only one file is required, but Beacon can do a better job with both files."
            TextAlign       =   0
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   72
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   431
         End
      End
      Begin UITweaks.ResizedPushButton ActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   411
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   356
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   319
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   356
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PushButton ChooseFileButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Select File"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   356
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin TextArea ConfigArea
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   189
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   155
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   471
      End
   End
   Begin Timer TextChangeTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   500
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 400
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem)
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Content As String = Stream.ReadAll(Encodings.UTF8).Trim
		  Stream.Close
		  
		  If Self.mCurrentConfigType <> ConfigFileType.Combo Then
		    Dim Other As FolderItem
		    Dim Type As ConfigFileType = Self.DetectConfigType(Content)
		    Select Case Type
		    Case ConfigFileType.GameIni
		      If Self.mCurrentConfigType <> ConfigFileType.GameUserSettingsIni Then
		        Other = File.Parent.Child("GameUserSettings.ini")
		      End If
		    Case ConfigFileType.GameUserSettingsIni
		      If Self.mCurrentConfigType <> ConfigFileType.GameIni Then
		        Other = File.Parent.Child("Game.ini")
		      End If
		    End Select
		    If Other <> Nil And Other.Exists Then
		      Stream = TextInputStream.Open(Other)
		      Content = Content + EndOfLine + EndOfLine + Stream.ReadAll(Encodings.UTF8).Trim
		      Stream.Close
		    End If
		  End If
		  
		  If Self.ConfigArea.Text = "" Then
		    Self.ConfigArea.Text = Content
		  Else
		    Self.ConfigArea.Text = Self.ConfigArea.Text.Trim + EndOfLine + EndOfLine + Content
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(File As FolderItem) As ConfigFileType
		  If File = Nil Then
		    Return ConfigFileType.Other
		  End If
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Return DetectConfigType(Content)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(Content As String) As ConfigFileType
		  Const GameIniHeader = "[/Script/ShooterGame.ShooterGameMode]"
		  Const GameUserSettingsIniHeader = "[/Script/ShooterGame.ShooterGameUserSettings]"
		  
		  Dim GameIniPos As Integer = Content.InStr(GameIniHeader)
		  Dim SettingsIniPos As Integer = Content.InStr(GameUserSettingsIniHeader)
		  
		  If GameIniPos > 0 And SettingsIniPos > 0 Then
		    Return ConfigFileType.Combo
		  ElseIf GameIniPos > 0 Then
		    Return ConfigFileType.GameIni
		  ElseIf SettingsIniPos > 0 Then
		    Return ConfigFileType.GameUserSettingsIni
		  Else
		    Return ConfigFileType.Other
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentConfigType As ConfigFileType
	#tag EndProperty


	#tag Enum, Name = ConfigFileType, Flags = &h21
		Other
		  GameIni
		  GameUserSettingsIni
		Combo
	#tag EndEnum


#tag EndWindowCode

#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseFileButton
	#tag Event
		Sub Action()
		  If Self.mCurrentConfigType = ConfigFileType.Combo And Self.ShowConfirm("Both files are already selected", "You can select another file if you really want to, but both Game.ini and GameUserSettings.ini files are already present.", "Add Another", "Cancel") = False Then
		    Return
		  End If
		  
		  Dim Dialog As New OpenDialog
		  
		  If Self.mCurrentConfigType = ConfigFileType.GameIni Then
		    Dialog.SuggestedFileName = "GameUserSettings.ini"
		  Else
		    Dialog.SuggestedFileName = "Game.ini"
		  End If
		  Dialog.Filter = BeaconFileTypes.IniFile
		  
		  Dim File As FolderItem = Dialog.ShowModal()
		  If File <> Nil Then
		    Self.AddFile(File)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigArea
	#tag Event
		Sub TextChange()
		  If Self.TextChangeTimer.Mode = Timer.ModeSingle Then
		    Self.TextChangeTimer.Reset
		    Self.TextChangeTimer.Period = 500
		  End If
		  Self.TextChangeTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextChangeTimer
	#tag Event
		Sub Action()
		  Self.mCurrentConfigType = Self.DetectConfigType(Self.ConfigArea.Text)
		  Self.ActionButton.Enabled = Self.mCurrentConfigType <> ConfigFileType.Other
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
