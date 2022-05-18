#tag Class
Protected Class BeaconPagedSubview
Inherits BeaconSubview
Implements ObservationKit.Observer
	#tag Event
		Sub EnableMenuItems()
		  RaiseEvent EnableMenuItems()
		  
		  If (Self.CurrentPage Is Nil) = False Then
		    Self.CurrentPage.EnableMenuItems()
		  Else
		    App.Log("CurrentPage is Nil")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  Var CurrentPage As BeaconSubview = Self.CurrentPage
		  If (CurrentPage Is Nil) = False Then
		    CurrentPage.SwitchedFrom()
		  End If
		  
		  RaiseEvent Hidden()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  
		  Var CurrentPage As BeaconSubview = Self.CurrentPage
		  If (CurrentPage Is Nil) = False Then
		    CurrentPage.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendPage(Page As BeaconSubview)
		  If Self.IndexOf(Page) > -1 Then
		    // Already added
		    Return
		  End If
		  
		  AddHandler Page.WantsClose, AddressOf View_WantsClose
		  AddHandler Page.WantsFrontmost, AddressOf View_WantsFrontmost
		  
		  Self.mPages.Add(Page)
		  
		  Page.AddObserver(Self, "ViewID")
		  
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False And Panel.PanelCount < Self.mPages.Count Then
		    // Embed it
		    Panel.AddPanel
		    Var PageIndex As Integer = Panel.LastAddedPanelIndex
		    Page.EmbedWithinPanel(Panel, PageIndex, 0, 0, Panel.Width, Panel.Height)
		  End If
		  
		  If Self.CurrentPageID = "" Then
		    Self.CurrentPageID = Page.ViewID
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  If Super.Busy Then
		    Return True
		  End If
		  
		  For Each Page As BeaconSubview In Self.mPages
		    If Page.Busy Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmClose() As Boolean
		  Const AllowClose = True
		  Const BlockClose = False
		  
		  Var ModifiedViews() As BeaconSubview = Self.ModifiedPages()
		  Var NumChanges As Integer = ModifiedViews.Count
		  
		  Select Case NumChanges
		  Case 0
		    Return AllowClose
		  Case 1
		    Self.RequestFrontmost()
		    Return ModifiedViews(0).ConfirmClose()
		  Else
		    Var ShouldClose As Boolean = True
		    Var ShouldFocus As Boolean
		    RaiseEvent ReviewChanges(NumChanges, ShouldClose, ShouldFocus)
		    If ShouldClose Then
		      Return AllowClose
		    Else
		      If ShouldFocus Then
		        Self.RequestFrontmost()
		      End If
		      Return BlockClose
		    End If
		  End Select
		  
		  Return AllowClose
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentPage() As BeaconSubview
		  For Each Page As BeaconSubview In Self.mPages
		    If Page.ViewID = Self.mCurrentPageID Then
		      Return Page
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentPage(Assigns Page As BeaconSubview)
		  If (Page Is Nil) = False Then
		    Self.CurrentPageID = Page.ViewID
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentPageID() As String
		  Return Self.mCurrentPageID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentPageID(Assigns PageID As String)
		  Var OldPageID As String = Self.mCurrentPageID
		  Var OldPageIdx As Integer = Self.IndexOf(OldPageID)
		  If Self.IsFrontmost And OldPageIdx > -1 Then
		    Self.mPages(OldPageIdx).SwitchedFrom()
		  End If
		  
		  Self.mCurrentPageID = PageID
		  
		  Var NewPageIdx As Integer = Self.IndexOf(PageID)
		  If NewPageIdx = -1 Then
		    Break
		    Return
		  End If
		  
		  Var HistoryIdx As Integer = Self.mPageHistory.IndexOf(PageID)
		  If HistoryIdx > -1 Then
		    Self.mPageHistory.RemoveAt(HistoryIdx)
		  End If
		  If Self.mPageHistory.Count > 0 Then
		    Self.mPageHistory.AddAt(0, PageID)
		  Else
		    Self.mPageHistory.Add(PageID)
		  End If
		  
		  Var NewPage As BeaconSubview = Self.mPages(NewPageIdx)
		  If Self.IsFrontmost Then
		    NewPage.SwitchedTo(Nil)
		  End If
		  
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False Then
		    Panel.SelectedPanelIndex = NewPageIdx
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FrontmostPage(Offset As Integer = 0) As BeaconSubview
		  If Offset < Self.mPageHistory.FirstIndex Or Offset > Self.mPageHistory.LastIndex Then
		    Return Nil
		  End If
		  
		  Var ViewID As String = Self.mPageHistory(Offset)
		  For Each Page As BeaconSubview In Self.mPages
		    If Page.ViewID = ViewID Then
		      Return Page
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasModifications() As Boolean
		  If Super.HasModifications Then
		    Return True
		  End If
		  
		  For Each Page As BeaconSubview In Self.mPages
		    Return Page.HasModifications
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Page As BeaconSubview) As Integer
		  If Page Is Nil Then
		    Return -1
		  End If
		  
		  Return Self.IndexOf(Page.ViewID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(ViewID As String) As Integer
		  For Idx As Integer = 0 To Self.mPages.LastIndex
		    If Self.mPages(Idx).ViewID = ViewID THen
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastPageIndex() As Integer
		  Return Self.mPages.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModifiedPages() As BeaconSubview()
		  Var Pages() As BeaconSubview
		  For Each Page As BeaconSubview In Self.mPages
		    If Page.Changed Then
		      Pages.Add(Page)
		    End If
		  Next
		  Return Pages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  
		  Select Case Key
		  Case "ViewID"
		    If Self.mCurrentPageID = OldValue Then
		      Self.mCurrentPageID = NewValue
		    End If
		    
		    Var HistoryIdx As Integer = Self.mPageHistory.IndexOf(OldValue)
		    If HistoryIdx > -1 Then
		      Self.mPageHistory(HistoryIdx) = NewValue
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Page(Idx As Integer) As BeaconSubview
		  If Idx <= Self.mPages.LastIndex And Idx >= 0 Then
		    Return Self.mPages(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PageCount() As Integer
		  Return Self.mPages.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePage(Page As BeaconSubview)
		  If (Page Is Nil) = False Then
		    Self.RemovePage(Page.ViewID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePage(Idx As Integer)
		  If Idx < 0 Or Idx > Self.mPages.LastIndex Then
		    Return
		  End If
		  
		  Var PageID As String = Self.mPages(Idx).ViewID
		  Self.RemovePage(PageID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePage(PageID As String)
		  Var HistoryIdx As Integer = Self.mPageHistory.IndexOf(PageID)
		  If HistoryIdx > -1 Then
		    Self.mPageHistory.RemoveAt(HistoryIdx)
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(PageID)
		  If Idx = -1 Then
		    Return
		  End If
		  Self.mPages(Idx).RemoveObserver(Self, "ViewID")
		  RemoveHandler Self.mPages(Idx).WantsClose, AddressOf View_WantsClose
		  RemoveHandler Self.mPages(Idx).WantsFrontmost, AddressOf View_WantsFrontmost
		  Self.mPages.RemoveAt(Idx)
		  
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False Then
		    Panel.RemovePanelAt(Idx)
		  End If
		  
		  If Self.mCurrentPageID = PageID Then
		    // Find a new page
		    Var NewPageID As String
		    If Self.mPageHistory.Count > 0 Then
		      NewPageID = Self.mPageHistory(0)
		    Else
		      NewPageID = Self.mPages(0).ViewID
		    End If
		    
		    Self.CurrentPageID = NewPageID
		  ElseIf (Panel Is Nil) = False Then
		    Var NewCurrentIndex As Integer = Self.IndexOf(Self.CurrentPage)
		    Panel.SelectedPanelIndex = NewCurrentIndex
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowView(View As BeaconSubview)
		  Self.CurrentPage = View
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ViewsPanel() As PagePanel
		  Return RaiseEvent GetPagePanel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_WantsClose(Sender As BeaconSubview)
		  RaiseEvent ShouldCloseView(Sender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_WantsFrontmost(Sender As BeaconSubview)
		  Self.RequestFrontmost()
		  Self.ShowView(Sender)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetPagePanel() As PagePanel
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Hidden()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReviewChanges(NumPages As Integer, ByRef ShouldClose As Boolean, ByRef ShouldFocus As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCloseView(View As BeaconSubview)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentPageID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPageHistory() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPages() As BeaconSubview
	#tag EndProperty


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
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="500"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
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
			Name="LockLeft"
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
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
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
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
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
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
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
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
