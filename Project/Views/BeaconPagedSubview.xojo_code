#tag Class
Protected Class BeaconPagedSubview
Inherits BeaconSubview
	#tag Event
		Sub EnableMenuItems()
		  RaiseEvent EnableMenuItems()
		  
		  If (Self.CurrentPage Is Nil) = False Then
		    Self.CurrentPage.EnableMenuItems()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var Page As BeaconSubview = Self.CurrentPage
		  If (Page Is Nil) = False Then
		    Page.GetEditorMenuItems(Items)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  If Self.mCurrentPageIndex > -1 Then
		    Self.mPages(Self.mCurrentPageIndex).SwitchedFrom()
		  End If
		  
		  RaiseEvent Hidden()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  
		  If Self.mCurrentPageIndex > -1 Then
		    Self.mPages(Self.mCurrentPageIndex).SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendPage(Page As BeaconSubview)
		  If Self.IndexOf(Page) > -1 Then
		    // Already added
		    Return
		  End If
		  
		  Self.mPages.Add(Page)
		  If Self.CurrentPageIndex = -1 Then
		    Self.CurrentPageIndex = 0
		  End If
		  
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False Then
		    If Panel.PanelCount < Self.mPages.Count Then
		      // Embed it
		      Panel.AddPanel
		      Var PageIndex As Integer = Panel.LastAddedPanelIndex
		      Page.EmbedWithinPanel(Panel, PageIndex, 0, 0, Panel.Width, Panel.Height)
		    End If
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
		Function ConfirmClose(Callback As BeaconSubview.BringToFrontDelegate) As Boolean
		  Const AllowClose = True
		  Const BlockClose = False
		  
		  Var ModifiedViews() As BeaconSubview = Self.ModifiedPages()
		  Var NumChanges As Integer = ModifiedViews.Count
		  
		  Select Case NumChanges
		  Case 0
		    Return AllowClose
		  Case 1
		    If Beacon.SafeToInvoke(Callback) Then
		      Callback.Invoke(Self)
		    End If
		    Return ModifiedViews(0).ConfirmClose(AddressOf ShowView)
		  Else
		    Var ShouldClose As Boolean = True
		    Var ShouldFocus As Boolean
		    RaiseEvent ReviewChanges(NumChanges, ShouldClose, ShouldFocus)
		    If ShouldClose Then
		      Return AllowClose
		    Else
		      If ShouldFocus Then
		        If Callback <> Nil Then
		          Callback.Invoke(Self)
		        End If
		      End If
		      Return BlockClose
		    End If
		  End Select
		  
		  Return AllowClose
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentPage() As BeaconSubview
		  If Self.mCurrentPageIndex >= Self.mPages.FirstIndex And Self.mCurrentPageIndex <= Self.mPages.LastIndex Then
		    Return Self.mPages(Self.mCurrentPageIndex)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentPage(Assigns Page As BeaconSubview)
		  Var Idx As Integer = Self.IndexOf(Page)
		  If Idx > -1 Then
		    Self.CurrentPageIndex = Idx
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentPageIndex() As Integer
		  Return Self.mCurrentPageIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentPageIndex(Assigns Idx As Integer)
		  Idx = Min(Idx, Self.mPages.LastIndex)
		  
		  If Self.mCurrentPageIndex = Idx Then
		    Return
		  End If
		  
		  Var OldIndex As Integer = Self.mCurrentPageIndex
		  
		  If Self.IsFrontmost And OldIndex > -1 Then
		    // Tell the current page that it is being switched from
		    Self.mPages(OldIndex).SwitchedFrom()
		  End If
		  
		  Self.mCurrentPageIndex = Idx
		  
		  If Idx > -1 Then
		    Var NewPage As BeaconSubview = Self.mPages(Idx)
		    Var HistoryIdx As Integer = Self.mPageHistory.IndexOf(NewPage.ViewID)
		    If HistoryIdx > -1 Then
		      Self.mPageHistory.RemoveAt(HistoryIdx)
		    End If
		    If Self.mPageHistory.Count > 0 Then
		      Self.mPageHistory.AddAt(0, NewPage.ViewID)
		    Else
		      Self.mPageHistory.Add(NewPage.ViewID)
		    End If
		    
		    If Self.IsFrontmost Then
		      NewPage.SwitchedTo(Nil)
		    End If
		  End If
		  
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False Then
		    Panel.SelectedPanelIndex = Idx
		  End If
		End Sub
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
		Attributes( Deprecated )  Sub InsertPage(Idx As Integer, Page As BeaconSubview)
		  If Self.IndexOf(Page) = -1 Then
		    Self.mPages.AddAt(Idx, Page)
		    
		    If Self.CurrentPageIndex = -1 Then
		      Self.CurrentPageIndex = 0
		    ElseIf Self.mCurrentPageIndex >= Idx Then
		      Self.mCurrentPageIndex = Self.mCurrentPageIndex + 1
		    End If
		  End If
		End Sub
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
		  Var Idx As Integer = Self.IndexOf(Page)
		  If Idx > -1 Then
		    Self.RemovePage(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePage(Idx As Integer)
		  If Idx < 0 Or Idx > Self.mPages.LastIndex Then
		    Return
		  End If
		  
		  Var Page As BeaconSubview = Self.mPages(Idx)
		  Var HistoryIdx As Integer = Self.mPageHistory.IndexOf(Page.ViewID)
		  If HistoryIdx > -1 Then
		    Self.mPageHistory.RemoveAt(HistoryIdx)
		  End If
		  
		  Var FiredSwitchedFrom As Boolean
		  If Self.mCurrentPageIndex > Idx Then
		    // Decrement the current index, but don't trigger Switched events.
		    Self.mCurrentPageIndex = Self.mCurrentPageIndex - 1
		  ElseIf Self.mCurrentPageIndex = Idx Then
		    // Removing the current page, so we need to switch to something else
		    Var NewPageID As String
		    If Self.mPageHistory.Count > 0 Then
		      NewPageID = Self.mPageHistory(0)
		    Else
		      NewPageID = Self.mPages(0).ViewID
		    End If
		    Var NewPageIdx As Integer = Self.IndexOf(NewPageID)
		    
		    Self.CurrentPageIndex = NewPageIdx
		    FiredSwitchedFrom = True
		  End If
		  
		  If Not FiredSwitchedFrom Then
		    Self.mPages(Idx).SwitchedFrom()
		  End If
		  Var Panel As PagePanel = Self.ViewsPanel
		  If (Panel Is Nil) = False Then
		    Panel.RemovePanelAt(Idx)
		    Panel.SelectedPanelIndex = Self.mCurrentPageIndex
		  End If
		  Self.mPages.RemoveAt(Idx)
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
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentPageIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPageHistory() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPages() As BeaconSubview
	#tag EndProperty


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
