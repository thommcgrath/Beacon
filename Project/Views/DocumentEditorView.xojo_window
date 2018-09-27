#tag Window
Begin BeaconSubview DocumentEditorView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   528
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   858
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   487
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
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   858
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Select A Config To Begin"
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   487
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   41
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   858
      End
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   858
   End
   Begin BeaconPopupMenu ConfigMenu
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   ""
      Count           =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      LastIndex       =   0
      Left            =   9
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   9
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   215
   End
   Begin BeaconToolbar BeaconToolbar1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   233
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   625
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  FileSaveAs.Enable
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  If Self.mController.CanWrite And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeTransient Then
		    Self.mController.Save(App.Identity)
		  Else
		    Self.SaveAs()
		  End If
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  Self.mController = Controller
		  AddHandler Controller.WriteSuccess, WeakAddressOf mController_WriteSuccess
		  AddHandler Controller.WriteError, WeakAddressOf mController_WriteError
		  Self.Title = Controller.Name
		  
		  Self.Panels = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mController.Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteError(Sender As Beacon.DocumentController)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.DocumentController)
		  Self.ContentsChanged = Sender.Document.Modified
		  LocalData.SharedInstance.RememberDocument(Sender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Panel_ContentsChanged(Sender As ConfigEditor)
		  #Pragma Unused Sender
		  
		  Self.ContentsChanged = Self.Document.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyToDeploy() As Boolean
		  Return Self.Document <> Nil And Self.Document.IsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveAs()
		  Dim Dialog As New SaveAsDialog
		  Dialog.SuggestedFileName = Self.mController.Name + BeaconFileTypes.BeaconDocument.PrimaryExtension
		  Dialog.Filter = BeaconFileTypes.BeaconDocument
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.mController.SaveAs(Beacon.DocumentURL.TypeLocal + "://" + File.NativePath.ToText, App.Identity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartDeploy()
		  DeployDialog.Present(Self, Self.Document)
		  Self.ContentsChanged = Self.ContentsChanged Or Self.Document.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Beacon.DocumentURL
		  Return Self.mController.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As Text
		  Return Self.mController.URL.Hash
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CurrentPanel As ConfigEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.DocumentController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Panels As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ConfigMenu
	#tag Event
		Sub Open()
		  Me.AddRow("Maps")
		  Me.AddRow("Difficulty")
		  Me.AddRow("Loot Drops")
		  Me.AddRow("Loot Quality Scale")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Dim Caption As String = Me.Caption
		  If Caption = "" Then
		    Self.PagePanel1.Value = 0
		    Return
		  End If
		  
		  If Self.Panels.HasKey(Caption) Then
		    If Self.CurrentPanel <> Nil Then
		      Self.CurrentPanel.Visible = False
		      Self.CurrentPanel = Nil
		    End If
		    
		    Self.CurrentPanel = Self.Panels.Value(Caption)
		    Self.CurrentPanel.Visible = True
		    Self.PagePanel1.Value = 1
		    Return
		  End If
		  
		  Dim Panel As ConfigEditor
		  Select Case Caption
		  Case "Loot Drops"
		    Panel = New LootConfigEditor(Self.mController)
		  End Select
		  If Panel = Nil Then
		    Self.PagePanel1.Value = 0
		    Return
		  End If
		  
		  AddHandler Panel.ContentsChanged, WeakAddressOf Panel_ContentsChanged
		  Panel.EmbedWithinPanel(Self.PagePanel1, 1, 0, 0, PagePanel1.Width, PagePanel1.Height)
		  Self.CurrentPanel = Panel
		  Self.Panels.Value(Caption) = Panel
		  Panel.Visible = True
		  Self.PagePanel1.Value = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BeaconToolbar1
	#tag Event
		Sub Open()
		  Dim ImportButton As New BeaconToolbarItem("ImportButton", IconToolbarImport, "Import config files…")
		  Dim ExportButton As New BeaconToolbarItem("ExportButton", IconToolbarExport, Self.ReadyToDeploy, "Save new config files…")
		  Dim DeployButton As New BeaconToolbarItem("DeployButton", IconToolbarDeploy, Self.ReadyToDeploy, "Make config changes live.")
		  Dim PublishButton As New BeaconToolbarItem("PublishButton", IconToolbarPublish, "Upload this document to the cloud.")
		  
		  Me.LeftItems.Append(ImportButton)
		  Me.LeftItems.Append(ExportButton)
		  Me.LeftItems.Append(DeployButton)
		  Me.LeftItems.Append(PublishButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
