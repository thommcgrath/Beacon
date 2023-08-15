#tag DesktopWindow
Begin SDTDDiscoveryView SDTDLocalDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   392
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
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
   Width           =   720
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   352
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   528
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   352
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ChooseFileButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Select File"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   352
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin DesktopRectangle BorderRect
      AllowAutoDeactivate=   True
      BorderColor     =   &c000000
      BorderThickness =   1.0
      CornerSize      =   0.0
      Enabled         =   True
      FillColor       =   &cFFFFFF
      Height          =   235
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   105
      Transparent     =   False
      Visible         =   True
      Width           =   680
      Begin CodeEditor ConfigArea
         AutoDeactivate  =   True
         Enabled         =   True
         HasBorder       =   False
         Height          =   233
         HorizontalScrollPosition=   0
         Index           =   -2147483648
         InitialParent   =   "BorderRect"
         Left            =   21
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
         Top             =   106
         VerticalScrollPosition=   0
         Visible         =   True
         Width           =   678
      End
   End
   Begin Shelf Switcher
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      Index           =   -2147483648
      IsVertical      =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   720
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Paste the contents of your xml files here. Only one file is required, but Beacon can do its job with all three files."
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   73
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   680
   End
   Begin Timer TextChangeDelayTrigger
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ClipboardWatcher Watcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin FadedSeparator SwitcherSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   True
      Visible         =   True
      Width           =   720
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Const DesiredHeight = 450
		  
		  Self.ExplanationLabel.SizeToFit
		  Self.ActionButton.Top = DesiredHeight - (Self.ActionButton.Height + 20)
		  Self.CancelButton.Top = Self.ActionButton.Top
		  Self.ChooseFileButton.Top = Self.ActionButton.Top
		  Self.BorderRect.Top = Self.ExplanationLabel.Bottom + 12
		  Self.BorderRect.Height = Self.ActionButton.Top - (Self.BorderRect.Top + 12)
		  
		  Self.DesiredHeight = DesiredHeight
		  Self.ConfigArea.Text = ""
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.AcceptFileDrop(BeaconFileTypes.XmlFile)
		  Self.ConfigArea.AcceptFileDrop(BeaconFileTypes.XmlFile)
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddFile(File As FolderItem, Type As String = "")
		  If File Is Nil Or File.Exists = False Then
		    Return
		  End If
		  
		  Var Doc As XmlDocument
		  Try
		    Doc = New XmlDocument(File)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing xml file")
		    Return
		  End Try
		  
		  If Type.IsEmpty Then
		    Type = Self.DetectFileType(Doc)
		    If Type.IsEmpty Then
		      App.Log("Could not determine file type")
		      Return
		    End If
		  End If
		  
		  Var ExistingContent As String
		  Select Case Type
		  Case SDTD.ConfigFileServerAdminXml
		    ExistingContent = Self.mServerAdminXml
		  Case SDTD.ConfigFileServerConfigXml
		    ExistingContent = Self.mServerConfigXml
		  Case SDTD.ConfigFileWebPermissionsXml
		    ExistingContent = Self.mWebPermissionsXml
		  End Select
		  
		  If ExistingContent.IsEmpty = False Then
		    Var Explanation As String = "The selected file would replace your " + Type + " content."
		    If Self.ShowConfirm("Would you like to replace the existing content?", Explanation, "Replace", "Cancel") = False Then
		      Return
		    End If
		  End If
		  
		  Select Case Type
		  Case SDTD.ConfigFileServerAdminXml
		    Self.mServerAdminXml = Doc.Transform(Beacon.PrettyPrintXsl)
		    Self.mServerAdminXmlFile = File
		  Case SDTD.ConfigFileServerConfigXml
		    Self.mServerConfigXml = Doc.Transform(Beacon.PrettyPrintXsl)
		    Self.mServerConfigXmlFile = File
		  Case SDTD.ConfigFileWebPermissionsXml
		    Self.mWebPermissionsXml = Doc.Transform(Beacon.PrettyPrintXsl)
		    Self.mWebPermissionsXmlFile = File
		  End Select
		  
		  Self.RefreshContentArea(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectFileType(File As FolderItem) As String
		  Try
		    Var Doc As New XmlDocument(File)
		    Return Self.DetectFileType(Doc)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing xml from file")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectFileType(Source As String) As String
		  If Source.IsEmpty Or Source.BeginsWith("<?xml") = False Then
		    Return ""
		  End If
		  
		  Try
		    Return Self.DetectFileType(New XmlDocument(Source))
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing xml from string")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectFileType(Doc As XmlDocument) As String
		  If Doc Is Nil Then
		    Return ""
		  End If
		  
		  Select Case Doc.DocumentElement.Name
		  Case "ServerSettings"
		    Return SDTD.ConfigFileServerConfigXml
		  Case "adminTools"
		    Return SDTD.ConfigFileServerAdminXml
		  Case "webpermissions"
		    Return SDTD.ConfigFileWebPermissionsXml
		  End
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDrop(Obj As DragItem)
		  Do
		    If Obj.FolderItemAvailable Then
		      Self.AddFile(Obj.FolderItem)
		    End If
		  Loop Until Not Obj.NextItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea(ChangeIfEmpty As Boolean = False)
		  Var SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  Select Case Self.Switcher.SelectedIndex
		  Case Self.ServerAdminXmlIndex
		    If ChangeIfEmpty And Self.mServerAdminXml.IsEmpty And Self.mServerConfigXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.ServerConfigXmlIndex
		    ElseIf ChangeIfEmpty And Self.mServerAdminXml.IsEmpty And Self.mWebPermissionsXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.WebPermissionsXmlIndex
		    Else
		      Self.ConfigArea.Text = Self.mServerAdminXml
		    End If
		  Case Self.ServerConfigXmlIndex
		    If ChangeIfEmpty And Self.mServerConfigXml.IsEmpty And Self.mServerAdminXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.ServerAdminXmlIndex
		    ElseIf ChangeIfEmpty And Self.mServerConfigXml.IsEmpty And Self.mWebPermissionsXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.WebPermissionsXmlIndex
		    Else
		      Self.ConfigArea.Text = Self.mServerConfigXml
		    End If
		  Case Self.WebPermissionsXmlIndex
		    If ChangeIfEmpty And Self.mWebPermissionsXml.IsEmpty And Self.mServerConfigXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.ServerConfigXmlIndex
		    ElseIf ChangeIfEmpty And Self.mWebPermissionsXml.IsEmpty And Self.mServerAdminXml.IsEmpty = False Then
		      Self.Switcher.SelectedIndex = Self.ServerAdminXmlIndex
		    Else
		      Self.ConfigArea.Text = Self.mWebPermissionsXml
		    End If
		  Else
		    Self.ConfigArea.Text = ""
		  End Select
		  Self.mSettingUp = SettingUp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSwitcherForType(Type As String)
		  If Type = SDTD.ConfigFileServerAdminXml And Self.Switcher.SelectedIndex <> Self.ServerAdminXmlIndex Then
		    Self.Switcher.SelectedIndex = Self.ServerAdminXmlIndex
		  ElseIf Type = SDTD.ConfigFileServerConfigXml And Self.Switcher.SelectedIndex <> Self.ServerConfigXmlIndex Then
		    Self.Switcher.SelectedIndex = Self.ServerConfigXmlIndex
		  ElseIf Type = SDTD.ConfigFileWebPermissionsXml And Self.Switcher.SelectedIndex <> Self.WebPermissionsXmlIndex Then
		    Self.Switcher.SelectedIndex = Self.WebPermissionsXmlIndex
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mServerAdminXml As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerAdminXmlFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerConfigXml As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerConfigXmlFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWebPermissionsXml As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWebPermissionsXmlFile As FolderItem
	#tag EndProperty


	#tag Constant, Name = ServerAdminXmlIndex, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ServerConfigXmlIndex, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WebPermissionsXmlIndex, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As New SDTD.LocalServerProfile
		  If (Self.mServerAdminXmlFile Is Nil) = False Then
		    Profile.File(SDTD.ConfigFileServerAdminXml) = New BookmarkedFolderItem(Self.mServerAdminXmlFile)
		  End If
		  If (Self.mServerConfigXmlFile Is Nil) = False Then
		    Profile.File(SDTD.ConfigFileServerConfigXml) = New BookmarkedFolderItem(Self.mServerConfigXmlFile)
		  End If
		  If (Self.mWebPermissionsXmlFile Is Nil) = False Then
		    Profile.File(SDTD.ConfigFileWebPermissionsXml) = New BookmarkedFolderItem(Self.mWebPermissionsXmlFile)
		  End If
		  
		  Var Data As New SDTD.DiscoveredData
		  Data.Profile = Profile
		  If Self.mServerAdminXml.IsEmpty Then
		    Data.File(SDTD.ConfigFileServerAdminXml) = Self.mServerAdminXml
		  End If
		  If Self.mServerConfigXml.IsEmpty Then
		    Data.File(SDTD.ConfigFileServerConfigXml) = Self.mServerConfigXml
		  End If
		  If Self.mWebPermissionsXml.IsEmpty Then
		    Data.File(SDTD.ConfigFileWebPermissionsXml) = Self.mWebPermissionsXml
		  End If
		  
		  Self.ShouldFinish(Data)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseFileButton
	#tag Event
		Sub Pressed()
		  If Self.mServerAdminXml.IsEmpty = False And Self.mServerConfigXml.IsEmpty = False And Self.mWebPermissionsXml.IsEmpty = False And Self.ShowConfirm("All config files have been selected", "You can select another file if you need to, but all config files are already present.", "Add Another", "Cancel") = False Then
		    Return
		  End If
		  
		  Var Dialog As New OpenFileDialog
		  If Self.mServerConfigXml.IsEmpty Then
		    Dialog.SuggestedFileName = SDTD.ConfigFileServerConfigXml
		  ElseIf Self.mServerAdminXml.IsEmpty Then
		    Dialog.SuggestedFileName = SDTD.ConfigFileServerAdminXml
		  ElseIf Self.mWebPermissionsXml.IsEmpty Then
		    Dialog.SuggestedFileName = SDTD.ConfigFileWebPermissionsXml
		  End If
		  Dialog.Filter = BeaconFileTypes.XmlFile
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File <> Nil Then
		    Self.AddFile(File)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BorderRect
	#tag Event
		Sub Opening()
		  Me.BorderColor = SystemColors.SeparatorColor
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigArea
	#tag Event
		Sub TextChanged()
		  If Not Self.mSettingUp Then
		    Var TextValue As String = Me.Text.Trim(Chr(0), Chr(10), Chr(13), Chr(32))
		    Select Case Self.Switcher.SelectedIndex
		    Case Self.ServerAdminXmlIndex
		      Self.mServerAdminXml = TextValue
		      Self.mServerAdminXmlFile = Nil
		    Case Self.ServerConfigXmlIndex
		      Self.mServerConfigXml = TextValue
		      Self.mServerConfigXmlFile = Nil
		    Case Self.WebPermissionsXmlIndex
		      Self.mWebPermissionsXml = TextValue
		      Self.mWebPermissionsXmlFile = Nil
		    End Select
		  End If
		  
		  If Self.TextChangeDelayTrigger.RunMode = Timer.RunModes.Single Then
		    Self.TextChangeDelayTrigger.Reset
		  Else
		    Self.TextChangeDelayTrigger.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  Break
		  
		  #Pragma Unused Action
		  Self.HandleDrop(Obj)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SetupNeeded()
		  SDTD.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub URIDropped(text as String)
		  Try
		    Var File As FolderItem = New FolderItem(Text, FolderItem.PathModes.Native)
		    Self.AddFile(File)
		  Catch Err As RuntimeException
		  End Try
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconFileXmlFilled, SDTD.ConfigFileServerConfigXml, SDTD.ConfigFileServerConfigXml)
		  Me.Add(IconFileXml, SDTD.ConfigFileServerAdminXml, SDTD.ConfigFileServerAdminXml)
		  Me.Add(IconFileXml, SDTD.ConfigFileWebPermissionsXml, SDTD.ConfigFileWebPermissionsXml)
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.ServerConfigXmlIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Self.RefreshContentArea(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextChangeDelayTrigger
	#tag Event
		Sub Action()
		  Self.ActionButton.Enabled = (Self.mServerAdminXml.IsEmpty And Self.mServerConfigXml.IsEmpty And Self.mWebPermissionsXml.IsEmpty) = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Var Type As String = Self.DetectFileType(Content)
		  Self.SetSwitcherForType(Type)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
