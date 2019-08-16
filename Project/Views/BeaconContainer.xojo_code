#tag Class
Protected Class BeaconContainer
Inherits ContainerControl
	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  
		  If Self.Window <> Nil And Self.Window IsA BeaconContainer Then
		    BeaconContainer(Self.Window).mChildren.Append(New WeakRef(Self))
		  End If
		  
		  #if XojoVersion >= 2018.01
		    Self.Composited = False
		    Self.Transparent = TargetMacOS
		  #else
		    Self.DoubleBuffer = TargetWin32
		    Self.Transparent = Not Self.DoubleBuffer
		    Self.EraseBackground = Not Self.DoubleBuffer
		  #endif
		  
		  Self.SwapButtons()
		  
		  RaiseEvent Resize(Self.mFirstResize)
		  Self.mFirstResize = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  RaiseEvent Resize(Self.mFirstResize)
		  Self.mFirstResize = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RaiseEvent Resize(Self.mFirstResize)
		  Self.mFirstResize = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub EmbedWithin(containingControl As RectControl, left As Integer = 0, top As Integer = 0, width As Integer = -1, height As Integer = -1)
		  Super.EmbedWithin(ContainingControl, Left, Top, Width, Height)
		  If Self.Window <> Nil And Self.Window IsA BeaconContainer Then
		    BeaconContainer(Self.Window).mChildren.Append(New WeakRef(Self))
		    Return
		  End If
		  Self.TriggerEmbeddingFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmbedWithin(containingWindow As Window, left As Integer = 0, top As Integer = 0, width As Integer = -1, height As Integer = -1)
		  Super.EmbedWithin(ContainingWindow, Left, Top, Width, Height)
		  If Self.Window <> Nil And Self.Window IsA BeaconContainer Then
		    BeaconContainer(Self.Window).mChildren.Append(New WeakRef(Self))
		    Return
		  End If
		  Self.TriggerEmbeddingFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmbedWithinPanel(containingPanel As PagePanel, page As Integer, left As Integer = 0, top As Integer = 0, width As Integer = -1, height As Integer = -1)
		  Super.EmbedWithinPanel(ContainingPanel, Page, Left, Top, Width, Height)
		  If Self.Window <> Nil And Self.Window IsA BeaconContainer Then
		    BeaconContainer(Self.Window).mChildren.Append(New WeakRef(Self))
		    Return
		  End If
		  Self.TriggerEmbeddingFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerEmbeddingFinished()
		  For I As Integer = Self.mChildren.LastRowIndex DownTo 0
		    Dim Ref As WeakRef = Self.mChildren(I)
		    If Ref = Nil Or Ref.Value = Nil Then
		      Self.mChildren.Remove(I)
		      Continue
		    End If
		    
		    BeaconContainer(Ref.Value).TriggerEmbeddingFinished()
		  Next
		  RaiseEvent EmbeddingFinished()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EmbeddingFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize(Initial As Boolean)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFirstResize As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=false
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=false
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=false
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackColor"
			Visible=false
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
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
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
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
			Name="LockLeft"
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
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
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
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
			EditorType="Picture"
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
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
