#tag Window
Begin Window DocumentImportWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   3
   Resizable       =   "True"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Import"
   Visible         =   True
   Width           =   600
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  AddHandler mImportView.ProjectsImported, WeakAddressOf mImportView_ProjectsImported
		  AddHandler mImportView.ShouldDismiss, WeakAddressOf mImportView_ShouldDismiss
		  AddHandler mImportView.ShouldResize, WeakAddressOf mImportView_ShouldResize
		  
		  Self.mImportView.EmbedWithin(Self, 0, 0, Self.Width, Self.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mImportView.Reset
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ImportView As DocumentImportView, Callback As ImportFinishedDelegate)
		  Self.mImportCallback = Callback
		  Self.mImportView = ImportView
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ImportFinishedDelegate(Projects() As Beacon.Project)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub mImportView_ProjectsImported(Sender As DocumentImportView, Projects() As Beacon.Project)
		  #Pragma Unused Sender
		  
		  If Beacon.SafeToInvoke(Self.mImportCallback) Then
		    Self.mImportCallback.Invoke(Projects)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportView_ShouldDismiss(Sender As DocumentImportView)
		  #Pragma Unused Sender
		  
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportView_ShouldResize(Sender As DocumentImportView, Height As Integer)
		  #Pragma Unused Sender
		  
		  If Self.Height <> Height Then
		    Self.Height = Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(ImportView As DocumentImportView, ImportCallback As ImportFinishedDelegate, DestinationProject As Beacon.Project, OtherProjects() As Beacon.Project) As DocumentImportWindow
		  Var Win As New DocumentImportWindow(ImportView, ImportCallback)
		  ImportView.PullValuesFromProject(DestinationProject) // Give discovery views a chance to get stuff like oauth keys
		  ImportView.SetOtherProjects(OtherProjects)
		  Win.Show
		  Return Win
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(ImportView As DocumentImportView, ImportCallback As ImportFinishedDelegate, DestinationProject As Beacon.Project, File As FolderItem) As DocumentImportWindow
		  Var Win As New DocumentImportWindow(ImportView, ImportCallback)
		  ImportView.PullValuesFromProject(DestinationProject) // Give discovery views a chance to get stuff like oauth keys
		  ImportView.Import(File)
		  Win.Show
		  Return Win
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mImportCallback As ImportFinishedDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportView As DocumentImportView
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
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
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
