#tag Class
Protected Class LibrarySubview
Inherits BeaconSubview
	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CleanupClosedViews()
		  If Self.mViews = Nil Then
		    Return
		  End If
		  
		  Var ViewsToRemove() As String
		  Var ViewsToAdd() As BeaconSubview
		  For Each Entry As DictionaryEntry In Self.mViews
		    Var ID As String = Entry.Key
		    Var View As BeaconSubview = Entry.Value
		    
		    If View = Nil Or View.Closed Then
		      ViewsToRemove.Add(ID)
		    ElseIf View.ViewID <> ID Then
		      ViewsToRemove.Add(ID)
		      ViewsToAdd.Add(View)
		    End If
		  Next
		  
		  For Each ID As String In ViewsToRemove
		    Self.mViews.Remove(ID)
		  Next
		  For Each View As BeaconSubview In ViewsToAdd
		    Self.mViews.Value(View.ViewID) = View
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloseLibrary()
		  RaiseEvent ShouldCloseLibrary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DiscardView(View As BeaconSubview) As Boolean
		  If View = Nil Or RaiseEvent ShouldDiscardView(View) Then
		    Self.CleanupClosedViews()
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasView(ViewID As String) As Boolean
		  If Self.mViews = Nil Then
		    Return False
		  End If
		  
		  Self.CleanupClosedViews()
		  Return Self.mViews.HasKey(ViewID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShowView(View As BeaconSubview)
		  If Self.mViews = Nil Then
		    Self.mViews = New Dictionary
		  End If
		  Self.mViews.Value(View.ViewID) = View
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function View(ViewID As String) As BeaconSubview
		  If Self.mViews = Nil Then
		    Return Nil
		  End If
		  
		  Self.CleanupClosedViews()
		  Return Self.mViews.Lookup(ViewID, Nil)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldCloseLibrary()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDiscardView(View As BeaconSubview) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldShowView(View As BeaconSubview)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mViews As Dictionary
	#tag EndProperty


	#tag ViewBehavior
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
			Name="EraseBackground"
			Visible=false
			Group="Behavior"
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
			Name="Progress"
			Visible=false
			Group="Behavior"
			InitialValue="ProgressNone"
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
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
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
	#tag EndViewBehavior
End Class
#tag EndClass
