#tag Window
Begin BeaconPagedSubview PresetsComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   300
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
   Width           =   300
   Begin OmniBar Nav
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   38
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   300
   End
   Begin PagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   262
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   1
      Panels          =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   300
      Begin ListPresetsComponent PresetsList
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackgroundColor=   False
         Height          =   262
         InitialParent   =   "Views"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   0
         MinimumWidth    =   0
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Untitled"
         Visible         =   True
         Width           =   300
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function GetPagePanel() As PagePanel
		  Return Self.Views
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AppendPage(Self.PresetsList)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ClosePreset(Preset As Beacon.Preset) As Boolean
		  Var Bound As Integer = Self.PageCount - 1
		  For Idx As Integer = 0 To Bound
		    Var View As BeaconSubview = Self.Page(Idx)
		    If (View IsA PresetEditorView) = False Then
		      Continue
		    End If
		    
		    // Will only match database presets, not file presets. That's ok.
		    Var EditorView As PresetEditorView = PresetEditorView(View)
		    If EditorView.ViewID <> Preset.PresetID Then
		      Continue
		    End If
		    
		    Return Self.CloseView(EditorView)
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CloseView(View As PresetEditorView) As Boolean
		  If View.CanBeClosed = False Or View.ConfirmClose(WeakAddressOf ShowView) = False Then
		    Return False
		  End If
		  
		  Self.Nav.Remove(View.LinkedOmniBarItem)
		  Self.RemovePage(View)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatePreset(ItemSet As Beacon.ItemSet) As Beacon.Preset
		  Var Preset As Beacon.MutablePreset
		  If ItemSet.SourcePresetID <> "" Then
		    Var SourcePreset As Beacon.Preset = LocalData.SharedInstance.GetPreset(ItemSet.SourcePresetID)
		    If SourcePreset <> Nil Then
		      Preset = New Beacon.MutablePreset(SourcePreset)
		    End If
		  End If
		  If Preset = Nil Then
		    Preset = New Beacon.MutablePreset()
		  End If
		  
		  Preset.Label = ItemSet.Label
		  Preset.MinItems = ItemSet.MinNumItems
		  Preset.MaxItems = ItemSet.MaxNumItems
		  
		  Preset.ResizeTo(-1)
		  For Each Entry As Beacon.SetEntry In ItemSet
		    Preset.Append(New Beacon.PresetEntry(Entry))
		  Next
		  
		  Self.OpenPreset(Preset, True)
		  Return Preset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EmbedView(View As PresetEditorView)
		  Self.AppendPage(View)
		  
		  Var NavButton As OmniBarItem = OmniBarItem.CreateTab(View.ViewID, View.ViewTitle)
		  NavButton.CanBeClosed = True
		  Self.Nav.Append(NavButton)
		  
		  View.LinkedOmniBarItem = NavButton
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewPreset()
		  Self.OpenPreset(New Beacon.MutablePreset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenPreset(Preset As Beacon.Preset, DefaultModified As Boolean = False)
		  If Preset = Nil Then
		    Return
		  End If
		  
		  Var ViewIdx As Integer = Self.Nav.IndexOf(Preset.PresetID)
		  Var View As BeaconSubview
		  If ViewIdx > -1 Then
		    View = Self.Page(ViewIdx)
		  End If
		  If View Is Nil Then
		    View = New PresetEditorView(Preset)
		    Self.EmbedView(PresetEditorView(View))
		  End If
		  Self.ShowView(View)
		  If DefaultModified Then
		    View.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenPreset(File As FolderItem, Import As Boolean, DefaultModified As Boolean = False)
		  Var Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		  If Preset = Nil Then
		    Self.ShowAlert("Unable to open preset file", "The file may be damaged or a newer format.")
		    Return
		  End If
		  
		  If Import Then
		    LocalData.SharedInstance.SavePreset(Preset)
		    Self.OpenPreset(Preset, DefaultModified)
		    Return
		  End If
		  
		  Var ViewHash As String = EncodeHex(Crypto.MD5(File.NativePath))
		  Var ViewIdx As Integer = Self.Nav.IndexOf(ViewHash)
		  Var View As BeaconSubview
		  If ViewIdx > -1 Then
		    View = Self.Page(ViewIdx)
		  End If
		  If View Is Nil Then
		    View = New PresetEditorView(Preset, File)
		    Self.EmbedView(PresetEditorView(View))
		  End If
		  Self.ShowView(View)
		  If DefaultModified Then
		    View.Changed = True
		  End If
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Nav
	#tag Event
		Sub Open()
		  Var ListItem As OmniBarItem = OmniBarItem.CreateTab("PresetList", "Presets")
		  ListItem.Toggled = True
		  Self.PresetsList.LinkedOmniBarItem = ListItem
		  
		  Me.Append(ListItem)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  For Idx As Integer = 0 To Self.LastPageIndex
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page.LinkedOmniBarItem = Item Then
		      Self.CurrentPage = Page
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCloseItem(Item As OmniBarItem)
		  For Idx As Integer = 0 To Self.LastPageIndex
		    If Self.Page(Idx).LinkedOmniBarItem = Item Then
		      Var View As BeaconSubview = Self.Page(Idx)
		      If View IsA PresetEditorView Then
		        Call Self.CloseView(PresetEditorView(View))
		      End If
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Views
	#tag Event
		Sub Change()
		  Var CurrentPage As BeaconSubview = Self.CurrentPage
		  Var CurrentItemName As String
		  If (CurrentPage Is Nil) = False And (CurrentPage.LinkedOmniBarItem Is Nil) = False Then
		    CurrentItemName = CurrentPage.LinkedOmniBarItem.Name
		  End If
		  For Idx As Integer = 0 To Self.Nav.LastIndex
		    Self.Nav.Item(Idx).Toggled = (Self.Nav.Item(Idx).Name = CurrentItemName)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PresetsList
	#tag Event
		Sub OpenPreset(Preset As Beacon.Preset)
		  Self.OpenPreset(Preset, False)
		End Sub
	#tag EndEvent
	#tag Event
		Function ClosePreset(Preset As Beacon.Preset) As Boolean
		  Return Self.ClosePreset(Preset)
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
