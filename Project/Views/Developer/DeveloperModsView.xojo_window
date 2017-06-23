#tag Window
Begin BeaconSubview DeveloperModsView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   1100
   Begin ListHeader Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DisplayAsMenu   =   False
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   31
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SegmentIndex    =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TintColor       =   &cF7F7F700
      Title           =   "Mods"
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   235
   End
   Begin BeaconAPI.Socket Socket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconListbox ModList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   363
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   31
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   235
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   419
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   235
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   394
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   235
   End
   Begin DeveloperModView ModView
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   419
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   236
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   864
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Shown(UserData As Auto = Nil)
		  If Self.mReady Then
		    Self.RefreshMods()
		  End If
		  
		  // Purely because the header is drawing in the "clear" state instead of the active state
		  Xojo.Core.Timer.CallLater(100, AddressOf RefreshHeader)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteMod(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Details
		  
		  If Success Then
		    Self.RefreshMods
		    Return
		  End If
		  
		  Self.ShowAlert("Unable to delete mod", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListMods(Success As Boolean, Message As Text, Details As Auto)
		  If Not Success Then
		    MsgBox("Unable to load mods: " + Message)
		    Return
		  End If
		  
		  Dim SelectedMod As BeaconAPI.WorkshopMod
		  If ModList.ListIndex > -1 Then
		    SelectedMod = Self.SelectedMod()
		  End If
		  
		  ModList.DeleteAllRows()
		  
		  Dim Arr() As Auto = Details
		  For Each Dict As Xojo.Core.Dictionary In Arr
		    Dim UserMod As New BeaconAPI.WorkshopMod(Dict)
		    
		    ModList.AddRow(UserMod.Name)
		    ModList.RowTag(ModList.LastIndex) = UserMod
		    
		    If Not UserMod.Confirmed Then
		      ModList.CellItalic(ModList.LastIndex, 0) = True
		    End If
		    
		    If UserMod = SelectedMod Then
		      ModList.ListIndex = ModList.LastIndex
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshHeader()
		  Header.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshMods()
		  Dim Request As New BeaconAPI.Request("mod.php", "GET", AddressOf APICallback_ListMods)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedMod() As BeaconAPI.WorkshopMod
		  If ModList.ListIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return ModList.RowTag(ModList.ListIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetReady()
		  If Not Self.mReady Then
		    Self.mReady = True
		    Self.Footer.Button("AddButton").Enabled = True
		    Self.RefreshMods()
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mReady As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ModList
	#tag Event
		Sub Change()
		  Footer.Button("RemoveButton").Enabled = Me.ListIndex > -1
		  Footer.Button("SettingsButton").Enabled = Me.ListIndex > -1
		  ModView.CurrentMod = Self.SelectedMod()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cBBBBBB
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Footer
	#tag Event
		Sub Action(Button As FooterBarButton)
		  If Not Self.mReady Then
		    Return
		  End If
		  
		  Select Case Button.Name
		  Case "AddButton"
		    If DeveloperAddModDialog.Present(Self) Then
		      Self.RefreshMods
		    End If
		  Case "RemoveButton"
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Are you sure you want to remove your mod?"
		    Dialog.Explanation = "This cannot be undone. All associated engrams will also be removed."
		    Dialog.ActionButton.Caption = "Delete"
		    Dialog.CancelButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    If Choice = Dialog.ActionButton Then
		      Dim Request As New BeaconAPI.Request(Self.SelectedMod.ResourceURL, "DELETE", AddressOf APICallback_DeleteMod)
		      Request.Sign(App.Identity)
		      Self.Socket.Start(Request)
		    End If
		  Case "SettingsButton"
		    Dim WorkshopMod As BeaconAPI.WorkshopMod = Self.SelectedMod()
		    If WorkshopMod <> Nil Then
		      DeveloperModSettingsDialog.Present(Self, WorkshopMod)
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Dim AddButton As New FooterBarButton("AddButton", IconAdd)
		  AddButton.Enabled = Self.mReady
		  Me.Append(AddButton)
		  
		  Dim SettingsButton As New FooterBarButton("SettingsButton", IconSettings)
		  SettingsButton.Enabled = False
		  Me.Append(SettingsButton)
		  
		  Dim RemoveButton As New FooterBarButton("RemoveButton", IconRemove)
		  RemoveButton.Enabled = False
		  Me.Append(RemoveButton)
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
