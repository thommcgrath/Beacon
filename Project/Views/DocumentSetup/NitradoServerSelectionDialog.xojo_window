#tag Window
Begin Window NitradoServerSelectionDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   300
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   300
   MaximizeButton  =   False
   MaxWidth        =   500
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   92
   MinimizeButton  =   False
   MinWidth        =   500
   Placement       =   2
   Resizeable      =   False
   Title           =   "Select Servers"
   Visible         =   True
   Width           =   500
   Begin Beacon.NitradoDeploymentEngine Engine
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   300
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   1
      Visible         =   True
      Width           =   500
      Begin Label FindingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Finding Servers…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   174
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   460
      End
      Begin ProgressBar FindingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Top             =   206
         Value           =   0
         Visible         =   True
         Width           =   460
      End
      Begin Label DownloadingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Downloading Files…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   174
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   460
      End
      Begin ProgressBar DownloadingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         Top             =   206
         Value           =   0
         Visible         =   True
         Width           =   460
      End
      Begin Label MessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Select Servers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   460
      End
      Begin BeaconListbox List
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,200"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   196
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   " 	Name	Address"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   460
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton ActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "OK"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   400
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   260
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   308
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   260
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub LookupServers()
		  Self.mServerLookupsRemaining = 0
		  Redim Self.mNewServers(-1)
		  
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.CellCheck(I, 0) = False Then
		      Continue
		    End If
		    
		    Self.mServerLookupsRemaining = Self.mServerLookupsRemaining + 1
		    Self.Engine.LookupServer(Self.List.RowTag(I), Self.mToken)
		    Self.mNewServers.Append(Self.List.RowTag(I))
		  Next
		  
		  Self.Pages.Value = 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(AccessToken As Text, CurrentProfiles() As Beacon.NitradoServerProfile) As Beacon.NitradoServerProfile()
		  Dim Win As New NitradoServerSelectionDialog
		  Win.mToken = AccessToken
		  For Each Profile As Beacon.NitradoServerProfile In CurrentProfiles
		    Win.mIgnoredServices.Append(Profile.ServiceID)
		  Next
		  Win.Engine.ListServers(AccessToken)
		  Win.ShowModal()
		  
		  Dim Servers() As Beacon.NitradoServerProfile = Win.mNewServers
		  Win.Close
		  Return Servers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Dim ContentHeight As Integer = FindingLabel.Height + 12 + FindingProgress.Height
		  Dim AvailableHeight As Integer = Self.Height - 40
		  Dim ContentTop As Integer = 20 + ((AvailableHeight - ContentHeight) / 2)
		  
		  FindingLabel.Top = ContentTop
		  FindingProgress.Top = FindingLabel.Top + FindingLabel.Height + 12
		  
		  DownloadingLabel.Top = FindingLabel.Top
		  DownloadingProgress.Top = FindingProgress.Top
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIgnoredServices() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewServers() As Beacon.NitradoServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerLookupsRemaining As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToken As Text
	#tag EndProperty


#tag EndWindowCode

#tag Events Engine
	#tag Event
		Sub ServersFound(Servers() As Beacon.NitradoServerProfile)
		  If Servers.Ubound = -1 Then
		    Self.ShowAlert("No servers found", "Beacon was unable to find any servers linked to your account.")
		    Self.Hide
		    Return
		  End If
		  
		  Dim NewServers() As Beacon.NitradoServerProfile
		  For Each Profile As Beacon.NitradoServerProfile In Servers
		    If Self.mIgnoredServices.IndexOf(Profile.ServiceID) > -1 Then
		      Continue
		    End If
		    
		    NewServers.Append(Profile)
		  Next
		  
		  If NewServers.Ubound = -1 Then
		    Self.ShowAlert("All servers added", "Every server in your account is already linked to this document.")
		    Self.Hide
		    Return
		  End If
		  
		  For Each Profile As Beacon.NitradoServerProfile In NewServers
		    Self.List.AddRow("", Profile.Name, Profile.Address)
		    Self.List.RowTag(Self.List.LastIndex) = Profile
		  Next
		  
		  If Self.List.ListCount = 1 Then
		    Self.List.CellCheck(Self.List.LastIndex, 0) = True
		    Self.LookupServers()
		    Return
		  End If
		  
		  Self.Pages.Value = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub ServerDetails(Profile As Beacon.NitradoServerProfile, Map As Beacon.Map, DifficultyValue As Double)
		  If Map = Nil Then
		    If Self.Pages.Value = 2 Then
		      Self.ShowAlert("Unable to get files from server", "Beacon could not find the Game.ini for " + Profile.Name)
		      Self.Pages.Value = 1
		    End If
		    Return
		  End If
		  
		  Me.DownloadGameIni(Profile, Self.mToken)
		End Sub
	#tag EndEvent
	#tag Event
		Sub GameIniContent(Profile As Beacon.NitradoServerProfile, Content As Xojo.Core.MemoryBlock)
		  If Content = Nil Then
		    If Self.Pages.Value = 2 Then
		      Self.ShowAlert("Unable to get files from server", "Beacon could not find the Game.ini for " + Profile.Name)
		      Self.Pages.Value = 1
		    End If
		    Return
		  End If
		  
		  Self.mServerLookupsRemaining = Self.mServerLookupsRemaining - 1
		  
		  If Self.mServerLookupsRemaining = 0 Then
		    // Done!
		    
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub Change()
		  Dim DesiredHeight As Integer
		  Select Case Self.Pages.Value
		  Case 0, 2
		    DesiredHeight = 92
		  Case 1
		    DesiredHeight = 300
		  End Select
		  
		  If Self.Height <> DesiredHeight Then
		    Dim Task As New AnimationKit.MoveTask(Self)
		    Task.Height = DesiredHeight
		    Task.Curve = AnimationKit.Curve.CreateEaseOut
		    Task.DurationInSeconds = 0.15
		    Task.Run
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> 0 Then
		    Return
		  End If
		  
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.CellCheck(I, 0) Then
		      Self.ActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ActionButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.LookupServers()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Hide()
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
		Visible=true
		Group="Deprecated"
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
