#tag DesktopWindow
Begin DocumentsComponentView RecentDocumentsComponent Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "True"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   374
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
   Width           =   788
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   4
      ColumnWidths    =   "46,*,200,*"
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Open"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   311
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Name	Game	Path"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   63
      Transparent     =   False
      TypeaheadColumn =   1
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   788
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   True
      Visible         =   True
      Width           =   788
   End
   Begin DocumentFilterControl FilterBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      Composited      =   False
      ConsoleSafe     =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   62
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      RequireAllMaps  =   False
      Scope           =   2
      SearchDelayPeriod=   250
      ShowFullControls=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   788
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, Preferences.Notification_RecentsChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, Preferences.Notification_RecentsChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.UpdateList()
		  Self.List.SetFocus
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case Preferences.Notification_RecentsChanged
		    Self.UpdateList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateList()
		  Var Recents() As Beacon.ProjectURL = Preferences.RecentDocuments
		  
		  Var SelectedURLs() As String
		  For I As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(I) Then
		      Var URL As Beacon.ProjectURL = Self.List.RowTagAt(I)
		      SelectedURLs.Add(URL)
		    End If
		  Next
		  
		  Var Filter As String = Self.FilterBar.SearchText
		  If Filter.IsEmpty Then
		    Self.List.RowCount = Recents.Count
		    
		    For Idx As Integer = 0 To Recents.LastIndex
		      Var URL As Beacon.ProjectURL = Recents(Idx)
		      Self.List.CellTextAt(Idx, Self.ColumnName) = URL.Name
		      Self.List.CellTextAt(Idx, Self.ColumnGame) = Language.GameName(URL.GameID)
		      Self.List.CellTextAt(Idx, Self.ColumnPath) = URL.HumanPath
		      Self.List.CellTooltipAt(Idx, Self.ColumnPath) = Self.List.CellTextAt(Idx, Self.ColumnPath)
		      Self.List.RowTagAt(Idx) = URL
		      Self.List.RowSelectedAt(Idx) = SelectedURLs.IndexOf(URL) > -1
		    Next
		  Else
		    Self.List.RowCount = 0
		    For Each URL As Beacon.ProjectURL In Recents
		      If URL.Name.IndexOf(Filter) = -1 Then
		        Continue
		      End If
		      
		      Self.List.AddRow("")
		      Var Idx As Integer = Self.List.LastAddedRowIndex
		      Self.List.CellTextAt(Idx, Self.ColumnName) = URL.Name
		      Self.List.CellTextAt(Idx, Self.ColumnGame) = Language.GameName(URL.GameID)
		      Self.List.CellTextAt(Idx, Self.ColumnPath) = URL.HumanPath
		      Self.List.CellTooltipAt(Idx, Self.ColumnPath) = Self.List.CellTextAt(Idx, Self.ColumnPath)
		      Self.List.RowTagAt(Idx) = URL
		      Self.List.RowSelectedAt(Idx) = SelectedURLs.IndexOf(URL) > -1
		    Next
		  End If
		  
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnGame, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIcon, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnPath, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub PaintCellBackground(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  
		  If Column <> Self.ColumnIcon Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var URL As Beacon.ProjectURL = Me.RowTagAt(Row)
		  If URL = Nil Then
		    Return
		  End If
		  
		  Var IconColor As Color = TextColor.AtOpacity(0.5)
		  Var Icon As Picture
		  Select Case URL.Scheme
		  Case Beacon.ProjectURL.TypeCloud
		    Icon = BeaconUI.IconWithColor(IconCloudDocument, IconColor)
		  Case Beacon.ProjectURL.TypeWeb
		    Icon = BeaconUI.IconWithColor(IconCommunityDocument, IconColor)
		  End Select
		  
		  If Icon = Nil Then
		    Return
		  End If
		  
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, (G.Height - Icon.Height) / 2)
		End Sub
	#tag EndEvent
	#tag Event
		Function PaintCellText(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Line
		  #Pragma Unused TextColor
		  #Pragma Unused HorizontalPosition
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  Return Column = Self.ColumnIcon
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  // Not deleting something, just removing from the list
		  Var Recents() As Beacon.ProjectURL = Preferences.RecentDocuments
		  Var Changed As Boolean
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.RowSelectedAt(I) Then
		      Continue For I
		    End If
		    
		    Var SelectedURL As Beacon.ProjectURL = Me.RowTagAt(I)
		    For X As Integer = Recents.LastIndex DownTo 0
		      If Recents(X) = SelectedURL Then
		        Changed = True
		        Recents.RemoveAt(X)
		        Exit For X
		      End If
		    Next
		    
		    Me.RemoveRowAt(I)
		  Next
		  If Changed Then
		    Preferences.RecentDocuments = Recents
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Row) = False Then
		      Continue
		    End If
		    
		    Var URL As Beacon.ProjectURL = Me.RowTagAt(Row)
		    Self.OpenProject(URL)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case 0
		    Var Row1URL As Beacon.ProjectURL = Me.RowTagAt(Row1)
		    Var Row2URL As Beacon.ProjectURL = Me.RowTagAt(Row2)
		    
		    Result = Row1URL.Name.Compare(Row2URL.Name, ComparisonOptions.CaseSensitive)
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FilterBar
	#tag Event
		Sub NewProject()
		  Self.NewProject()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Changed()
		  Self.UpdateList()
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
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
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
#tag EndViewBehavior
