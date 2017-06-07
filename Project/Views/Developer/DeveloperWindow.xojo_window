#tag Window
Begin BeaconWindow DeveloperWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   450
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   450
   MinimizeButton  =   True
   MinWidth        =   1100
   Placement       =   2
   Resizeable      =   True
   Title           =   "Developer Tools"
   Visible         =   True
   Width           =   1100
   Begin TabHeader TabHeader
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Value           =   0
      Visible         =   True
      Width           =   1100
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   30
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1100
   End
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   419
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   31
      Value           =   3
      Visible         =   True
      Width           =   1100
      Begin DeveloperModsView ModsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   419
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   31
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1100
      End
      Begin DeveloperDocumentsView DocsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   419
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   31
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1100
      End
      Begin DeveloperIdentityView IdentityView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   419
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   31
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1100
      End
      Begin DeveloperAPIView APIView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   419
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Top             =   31
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   1100
      End
   End
   Begin APISocket Socket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.mInstance = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Moved()
		  Self.SavePosition("Developer Window Position")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.TabHeader.Append("Documents")
		  Self.TabHeader.Append("Mods")
		  Self.TabHeader.Append("Identity")
		  Self.TabHeader.Append("API Builder")
		  
		  Dim InitialWidth As Integer = Self.Width
		  Self.RecallPosition("Developer Window Position")
		  If Self.Width = InitialWidth Then
		    // Dumb workaround because contents are sizing 1 pixels too short.
		    // A resize causes them to find their correct positions.
		    Self.Width = InitialWidth + 1
		    Self.Width = InitialWidth
		  End If
		  
		  Dim Request As New APIRequest("user.php/" + App.Identity.Identifier, "GET", AddressOf APICallback_UserLookup)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.SavePosition("Developer Window Position")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_UserLookup(Success As Boolean, Message As Text, Details As Auto)
		  If Success Then
		    // Already exists
		    Return
		  End If
		  
		  // Create the user
		  
		  Dim Params As New Xojo.Core.Dictionary
		  Params.Value("user_id") = App.Identity.Identifier
		  Params.Value("public_key") = App.Identity.PublicKey
		  
		  Dim Body As Text = Xojo.Data.GenerateJSON(Params)
		  Dim Request As New APIRequest("user.php", "POST", Body, "application/json", AddressOf APICallback_UserSave)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_UserSave(Success As Boolean, Message As Text, Details As Auto)
		  If Not Success Then
		    Self.ShowAlert("User profile was not saved to the server. API access is limited.", Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedWindow(Create As Boolean = True) As DeveloperWindow
		  If mInstance = Nil And Create = True Then
		    mInstance = New DeveloperWindow
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAPIKey(Username As String, Password As String)
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Here is your API key"
		  Dialog.Explanation = "Username: " + Username + EndOfLine + "Password: " + Password
		  Call Dialog.ShowModal()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mInstance As DeveloperWindow
	#tag EndProperty


#tag EndWindowCode

#tag Events TabHeader
	#tag Event
		Sub Change()
		  Self.Panel.Value = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = if(TabHeader.Inverted, &c000000, &cBBBBBB)
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Panel
	#tag Event
		Sub Change()
		  Select Case Me.Value
		  Case 0
		    DocsView.SwitchedTo()
		  Case 1
		    ModsView.SwitchedTo()
		  Case 2
		    IdentityView.SwitchedTo()
		  Case 3
		    APIView.SwitchedTo()
		  End Select
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
