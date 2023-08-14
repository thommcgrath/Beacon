#tag DesktopWindow
Begin DocumentImportView SDTDImportView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   480
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
   Width           =   720
   Begin DesktopPagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   480
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   720
      Begin DocumentImportSourcePicker SourcePicker
         AllowAutoDeactivate=   True
         AllowedSources  =   31
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         EnabledSources  =   31
         GameId          =   "#SDTD.Identifier"
         HasBackgroundColor=   False
         Height          =   252
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin SDTDLocalDiscoveryView LocalView
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   392
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub ImportFile(File As FolderItem)
		  Self.QuickCancel = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  
		  Self.SwapButtons
		  Self.Reset
		End Sub
	#tag EndEvent

	#tag Event
		Sub PullValuesFromProject(Project As Beacon.Project)
		  If (Project IsA SDTD.Project) = False Then
		    Return
		  End If
		  
		  Var SDTDProject As SDTD.Project = SDTD.Project(Project)
		  Self.mDestinationProject = SDTDProject
		  Self.LocalView.PullValuesFromProject(SDTDProject)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Reset()
		  // For I As Integer = 0 To Self.mImporters.LastIndex
		  // If Self.mImporters(I) <> Nil And Not Self.mImporters(I).Finished Then
		  // Self.mImporters(I).Cancel
		  // End If
		  // Next
		  // 
		  // Self.mImporters.ResizeTo(-1)
		  
		  If (Self.Views Is Nil) = False Then
		    If Self.Views.SelectedPanelIndex <> Self.PagePicker Then
		      Self.Views.SelectedPanelIndex = Self.PagePicker
		    Else
		      Self.SetPageHeight(Self.SourcePicker.Height)
		      Self.SourcePicker.ActionButtonEnabled = True
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetOtherProjects(Projects() As Beacon.Project)
		  Var DestinationProjectId As String
		  If (Self.mDestinationProject Is Nil) = False Then
		    DestinationProjectId = Self.mDestinationProject.ProjectId
		  End If
		  
		  Var SDTDProjects() As SDTD.Project
		  For Idx As Integer = 0 To Projects.LastIndex
		    If Projects(Idx) IsA SDTD.Project And Projects(Idx).ProjectId <> DestinationProjectId Then
		      SDTDProjects.Add(SDTD.Project(Projects(Idx)))
		    End If
		  Next
		  
		  Self.mOtherProjects = SDTDProjects
		  
		  If SDTDProjects.Count > 0 Then
		    Self.SourcePicker.EnabledSources = Self.SourcePicker.EnabledSources Or Self.SourcePicker.SourceOtherProject
		  Else
		    Self.SourcePicker.EnabledSources = Self.SourcePicker.EnabledSources And Not Self.SourcePicker.SourceOtherProject
		  End If
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDestinationProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOtherProjects() As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h0
		QuickCancel As Boolean
	#tag EndProperty


	#tag Constant, Name = PageLocal, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePicker, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PagePicker
		    Self.SetPageHeight(Self.SourcePicker.Height)
		    Self.SourcePicker.ActionButtonEnabled = True
		  Case Self.PageLocal
		    Self.LocalView.Begin
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourcePicker
	#tag Event
		Sub Cancelled()
		  Self.Dismiss
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SourceChosen(Source As Integer)
		  Select Case Source
		  Case Me.SourceFTP
		  Case Me.SourceGSA
		  Case Me.SourceLocal
		    Self.Views.SelectedPanelIndex = Self.PageLocal
		  Case Me.SourceNitrado
		  Case Me.SourceOtherProject
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LocalView
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = Self.PagePicker
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
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
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="QuickCancel"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
