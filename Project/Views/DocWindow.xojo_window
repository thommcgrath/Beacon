#tag Window
Begin Window DocWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   580
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   817604607
   MenuBarVisible  =   True
   MinHeight       =   580
   MinimizeButton  =   True
   MinWidth        =   1000
   Placement       =   0
   Resizeable      =   True
   Title           =   "Beacon"
   Visible         =   True
   Width           =   1000
   Begin Listbox BeaconList
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
      Height          =   555
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
      SelectionType   =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   190
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   580
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   190
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
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin BeaconEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   False
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   580
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   191
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
      Width           =   809
   End
   Begin GraphicButton AddBeaconButton
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   24
      HelpTag         =   "Add a beacon. Click to show the  ""Add Beacon"" dialog, hold to show a menu of possible beacons."
      IconDisabled    =   0
      IconNormal      =   0
      IconPressed     =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   30
   End
   Begin GraphicButton RemoveBeaconButton
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   False
      EraseBackground =   True
      Height          =   24
      HelpTag         =   "Remove the selected beacon."
      IconDisabled    =   0
      IconNormal      =   0
      IconPressed     =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   31
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   30
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   24
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   62
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   128
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   24
      HelpTag         =   ""
      Index           =   1
      InitialParent   =   ""
      Left            =   30
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   24
      HelpTag         =   ""
      Index           =   2
      InitialParent   =   ""
      Left            =   61
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   1
      HelpTag         =   ""
      Index           =   3
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   555
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   190
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #Pragma Unused appQuitting
		  
		  If Not Self.ContentsChanged Then
		    Return False
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Message = "Do you want to save changes to """ + Self.Title + """ before closing?"
		  Dialog.Explanation = "If you don't save, your changes will be lost."
		  Dialog.ActionButton.Caption = "Save"
		  Dialog.AlternateActionButton.Caption = "Don't Save"
		  Dialog.CancelButton.Visible = True
		  Dialog.AlternateActionButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  Select Case Choice
		  Case Dialog.ActionButton
		    If Self.Save() Then
		      Return False
		    Else
		      Return True
		    End If
		  Case Dialog.CancelButton
		    Return True
		  Case Dialog.AlternateActionButton
		    Return False
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSave.Enable
		  FileSaveAs.Enable
		  FileClose.Enable
		  DocumentAddBeacon.Enable
		  If BeaconList.ListIndex > -1 Then
		    DocumentDuplicateBeacon.Enable
		    DocumentRemoveBeacon.Enable
		    Editor.EnableMenuItems
		  End If
		  If Self.Doc.BeaconCount > 0 Then
		    FileExportConfig.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Dim Beacons() As Ark.Beacon = Self.Doc.Beacons
		  For Each Beacon As Ark.Beacon In Beacons
		    BeaconList.AddRow(Beacon.Label)
		    BeaconList.RowTag(BeaconList.LastIndex) = Beacon
		  Next
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentAddBeacon() As Boolean Handles DocumentAddBeacon.Action
			Self.ShowAddBeacon()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentDuplicateBeacon() As Boolean Handles DocumentDuplicateBeacon.Action
			Dim Beacon As Ark.Beacon = BeaconAddSheet.Present(Self, Self.Doc)
			If Beacon <> Nil Then
			Dim Type As Text = Beacon.Type
			Dim Label As Text = Beacon.Label
			Dim Source As Ark.Beacon = BeaconList.RowTag(BeaconList.ListIndex)
			Beacon.Constructor(Source)
			Beacon.Type = Type
			Beacon.Label = Label
			
			BeaconList.AddRow(Beacon.Label)
			BeaconList.RowTag(BeaconList.LastIndex) = Beacon
			BeaconList.ListIndex = BeaconList.LastIndex
			
			Self.Doc.Add(Beacon)
			Self.ContentsChanged = True
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRemoveBeacon() As Boolean Handles DocumentRemoveBeacon.Action
			Self.RemoveSelectedBeacon()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileExportConfig() As Boolean Handles FileExportConfig.Action
			Dim Dialog As New SaveAsDialog
			Dialog.SuggestedFileName = "Game.ini"
			Dialog.Filter = BeaconFileTypes.IniFile
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self)
			If File <> Nil Then
			Dim Lines() As String
			Lines.Append("[/script/shootergame.shootergamemode]")
			
			Dim Beacons() As Ark.Beacon = Self.Doc.Beacons
			For Each Beacon As Ark.Beacon In Beacons
			Lines.Append("ConfigOverrideSupplyCrateItems=" + Beacon.TextValue)
			Next
			
			Dim Stream As TextOutputStream = TextOutputStream.Create(File)
			Stream.Write(Join(Lines, EndOfLine))
			Stream.Close
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			Call Self.Save()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddBeacon(Beacon As Ark.Beacon)
		  BeaconList.AddRow(Beacon.Label)
		  BeaconList.RowTag(BeaconList.LastIndex) = Beacon
		  BeaconList.ListIndex = BeaconList.LastIndex
		  Self.Doc.Add(Beacon)
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Doc = New BeaconDocument
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Doc As BeaconDocument)
		  Self.Doc = Doc
		  Super.Constructor
		  Self.ContentsChanged = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem)
		  Self.File = New Xojo.IO.FolderItem(File.NativePath.ToText)
		  Self.Doc = BeaconDocument.Read(Self.File)
		  Self.Title = File.Name
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedBeacon()
		  If BeaconList.ListIndex = -1 Then
		    Return
		  End If
		  Dim CurrentBeacon As Ark.Beacon = BeaconList.RowTag(BeaconList.ListIndex)
		  Self.Doc.Remove(CurrentBeacon)
		  Self.ContentsChanged = True
		  BeaconList.RemoveRow(BeaconList.ListIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As Boolean
		  If Self.File <> Nil Then
		    Self.SaveAs(Self.File)
		    Return True
		  Else
		    Return Self.SaveAs()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveAs() As Boolean
		  Dim Dialog As New SaveAsDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self)
		  If File <> Nil Then
		    Self.SaveAs(File)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As FolderItem)
		  Self.SaveAs(New Xojo.IO.FolderItem(File.NativePath.ToText))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As Xojo.IO.FolderItem)
		  Self.File = File
		  Self.Doc.Write(File)
		  Self.Title = File.Name
		  Self.ContentsChanged = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddBeacon()
		  Dim Beacon As Ark.Beacon = BeaconAddSheet.Present(Self, Self.Doc)
		  If Beacon <> Nil Then
		    Self.AddBeacon(Beacon)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Doc As BeaconDocument
	#tag EndProperty

	#tag Property, Flags = &h21
		Private File As Xojo.IO.FolderItem
	#tag EndProperty


#tag EndWindowCode

#tag Events BeaconList
	#tag Event
		Sub Change()
		  RemoveBeaconButton.Enabled = Me.ListIndex > -1
		  
		  If Me.ListIndex = -1 Then
		    Editor.Enabled = False
		    Editor.Beacon = Nil
		  Else
		    Editor.Beacon = Me.RowTag(Me.ListIndex)
		    Editor.Enabled = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cCCCCCC
		  G.FillRect(0, 0, G.Width, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  Self.ContentsChanged = True
		  If BeaconList.ListIndex > -1 Then
		    BeaconList.Cell(BeaconList.ListIndex, 0) = Ark.Beacon(BeaconList.RowTag(BeaconList.ListIndex)).Label
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddBeaconButton
	#tag Event
		Sub Open()
		  Me.IconNormal = IconAddWithMenuNormal
		  Me.IconPressed = IconAddWithMenuPressed
		  Me.IconDisabled = IconAddWithMenuDisabled
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.ShowAddBeacon()
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseHold(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim Base As New MenuItem
		  Dim Beacons() As Ark.Beacon = App.DataSource.SearchForBeacons("")
		  For I As Integer = UBound(Beacons) DownTo 0
		    If Self.Doc.HasBeacon(Beacons(I)) Then
		      Beacons.Remove(I)
		    End If
		  Next
		  
		  For Each Beacon As Ark.Beacon In Beacons
		    Base.Append(New MenuItem(Beacon.Label, Beacon))
		  Next
		  
		  If UBound(Beacons) > -1 Then
		    Base.Append(New MenuItem(MenuItem.TextSeparator))
		  End If
		  
		  Base.Append(New MenuItem("New custom beacon…"))
		  
		  Dim Position As Xojo.Core.Point = Self.GlobalPosition
		  Dim Choice As MenuItem = Base.PopUp(Position.X + Me.Left, Position.Y + Me.Top + Me.Height)
		  If Choice = Nil Then
		    Return True
		  End If
		  
		  Dim SelectedBeacon As Ark.Beacon
		  If Choice.Tag = Nil Then
		    SelectedBeacon = CustomBeaconSheet.Present(Self)
		  Else
		    SelectedBeacon = Choice.Tag
		  End If
		  
		  If SelectedBeacon <> Nil Then
		    Self.AddBeacon(SelectedBeacon)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events RemoveBeaconButton
	#tag Event
		Sub Open()
		  Me.IconNormal = IconRemoveNormal
		  Me.IconPressed = IconRemovePressed
		  Me.IconDisabled = IconRemoveDisabled
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.RemoveSelectedBeacon()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
