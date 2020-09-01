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


	#tag Method, Flags = &h0
		Sub AppendPage(Page As BeaconSubview)
		  If Self.IndexOf(Page) = -1 Then
		    Self.mPages.AddRow(Page)
		    If Self.CurrentPageIndex = -1 Then
		      Self.CurrentPageIndex = 0
		    End If
		  End If
		End Sub
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
		    If Callback <> Nil Then
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
		  Return Self.mPages(Self.mCurrentPageIndex)
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
		  Idx = Min(Idx, Self.mPages.LastRowIndex)
		  
		  If Self.mCurrentPageIndex = Idx Then
		    Return
		  End If
		  
		  Var OldIndex As Integer = Self.mCurrentPageIndex
		  
		  If OldIndex > -1 Then
		    // Tell the current page that it is being switched from
		    Self.mPages(OldIndex).SwitchedFrom()
		  End If
		  
		  Self.mCurrentPageIndex = Idx
		  
		  If Idx > -1 Then
		    Self.mPages(Idx).SwitchedTo(Nil)
		  End If
		  
		  RaiseEvent PageChanged(OldIndex, Idx)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Page As BeaconSubview) As Integer
		  For Idx As Integer = 0 To Self.mPages.LastRowIndex
		    If Self.mPages(Idx) = Page THen
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertPage(Idx As Integer, Page As BeaconSubview)
		  If Self.IndexOf(Page) = -1 Then
		    Self.mPages.AddRowAt(Idx, Page)
		    
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
		  Return Self.mPages.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModifiedPages() As BeaconSubview()
		  Var Pages() As BeaconSubview
		  For Each Page As BeaconSubview In Self.mPages
		    If Page.Changed Then
		      Pages.AddRow(Page)
		    End If
		  Next
		  Return Pages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Page(Idx As Integer) As BeaconSubview
		  If Idx <= Self.mPages.LastRowIndex And Idx >= 0 Then
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
		  If Idx < 0 Or Idx > Self.mPages.LastRowIndex Then
		    Return
		  End If
		  
		  Var FiredSwitchedFrom As Boolean
		  If Self.mCurrentPageIndex > Idx Then
		    // Decrement the current index, but don't trigger Switched events.
		    Self.mCurrentPageIndex = Self.mCurrentPageIndex - 1
		  ElseIf Self.mCurrentPageIndex = Self.mPages.LastRowIndex And Self.mCurrentPageIndex = Idx Then
		    // Removing the last page, so we need to switch pages
		    Self.CurrentPageIndex = Self.CurrentPageIndex - 1
		    FiredSwitchedFrom = True
		  End If
		  
		  If Not FiredSwitchedFrom Then
		    Self.mPages(Idx).SwitchedFrom()
		  End If
		  Self.mPages.RemoveRowAt(Idx)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowView(View As BeaconSubview)
		  Self.CurrentPage = View
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PageChanged(OldIndex As Integer, NewIndex As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReviewChanges(NumPages As Integer, ByRef ShouldClose As Boolean, ByRef ShouldFocus As Boolean)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentPageIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPages() As BeaconSubview
	#tag EndProperty


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
