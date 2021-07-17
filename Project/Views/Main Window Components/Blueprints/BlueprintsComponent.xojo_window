#tag Window
Begin BeaconPagedSubview BlueprintsComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   486
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
   Width           =   800
   Begin OmniBar Nav
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   800
   End
   Begin PagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   448
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   1
      Panels          =   ""
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   800
      Begin ModsListView ModsListView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackgroundColor=   False
         Height          =   448
         Index           =   -2147483648
         InitialParent   =   "Views"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   0
         MinimumWidth    =   0
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Mods"
         Visible         =   True
         Width           =   800
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function GetPagePanel() As PagePanel
		  Return Self.Views
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AppendPage(Self.ModsListView1)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReviewChanges(NumPages As Integer, ByRef ShouldClose As Boolean, ByRef ShouldFocus As Boolean)
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("You have " + NumPages.ToString + " mods with unpublished changes. Do you want to review these changes before quitting?", "If you don't review your mods, all your changes will be lost.", "Review Changes…", "Cancel", "Discard Changes")
		  Select Case Choice
		  Case BeaconUI.ConfirmResponses.Action
		    ShouldClose = False
		    ShouldFocus = True
		  Case BeaconUI.ConfirmResponses.Cancel
		    ShouldClose = False
		    ShouldFocus = False
		  Case BeaconUI.ConfirmResponses.Alternate
		    ShouldClose = True
		    ShouldFocus = False // Doesn't matter
		  End Select
		  
		  If ShouldClose Then
		    Var Pages() As BeaconSubview = Self.ModifiedPages
		    For Each Page As BeaconSubview In Pages
		      Page.DiscardChanges()
		    Next
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CloseView(View As BeaconSubview) As Boolean
		  If View.CanBeClosed = False Or View.ConfirmClose(WeakAddressOf ShowView) = False Then
		    Return False
		  End If
		  
		  Self.Nav.Remove(View.LinkedOmniBarItem)
		  Self.RemovePage(View)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EmbedView(View As BeaconSubview)
		  Self.AppendPage(View)
		  
		  Var NavButton As OmniBarItem = OmniBarItem.CreateTab(View.ViewID, View.ViewTitle)
		  NavButton.CanBeClosed = True
		  NavButton.IsFlexible = True
		  Self.Nav.Append(NavButton)
		  
		  View.LinkedOmniBarItem = NavButton
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Nav
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  For Idx As Integer = 0 To Self.LastPageIndex
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page.LinkedOmniBarItem = Item Then
		      Self.CurrentPage = Page
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Var Mods As OmniBarItem = OmniBarItem.CreateTab(Self.ModsListView1.ViewID, "Mods")
		  Mods.Toggled = True
		  
		  Me.Append(Mods, OmniBarItem.CreateSeparator)
		  
		  Self.ModsListView1.LinkedOmniBarItem = Mods
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCloseItem(Item As OmniBarItem)
		  For Idx As Integer = 0 To Self.LastPageIndex
		    If Self.Page(Idx).LinkedOmniBarItem = Item Then
		      Var View As BeaconSubview = Self.Page(Idx)
		      If View IsA ModEditorView Then
		        Call Self.CloseView(ModEditorView(View))
		      End If
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Views
	#tag Event
		Sub Change()
		  Var CurrentPage As BeaconSubview = Self.CurrentPage
		  Var CurrentItemName As String
		  If (CurrentPage Is Nil) = False And (CurrentPage.LinkedOmniBarItem Is Nil) = False Then
		    CurrentItemName = CurrentPage.LinkedOmniBarItem.Name
		  End If
		  For Idx As Integer = 0 To Self.Nav.LastIndex
		    Self.Nav.Item(Idx).Toggled = (Self.Nav.Item(Idx).Name = CurrentItemName)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsListView1
	#tag Event
		Sub ShowMod(ModInfo As BeaconAPI.WorkshopMod)
		  If ModInfo.Confirmed = False Then
		    Var Status As Integer =  RegisterModDialog.Present(Self, ModInfo)
		    If (Status And RegisterModDialog.FlagShouldRefresh) = RegisterModDialog.FlagShouldRefresh Then
		      Me.RefreshMods()
		    End If
		    If (Status And RegisterModDialog.FlagModIsConfirmed) = 0 Then
		      Return
		    End If
		  End If
		  
		  Var View As BeaconSubview
		  Var Idx As Integer = Self.Nav.IndexOf(ModInfo.ModID)
		  If Idx > -1 Then
		    View = Self.Page(Idx)
		  Else
		    Var Controller As BlueprintController
		    If ModInfo.ModID = Beacon.UserModID Then
		      Controller = New LocalBlueprintController
		    Else
		      Controller = New RemoteBlueprintController(ModInfo.ModID, ModInfo.Name)
		    End If
		    
		    View = New ModEditorView(Controller)
		    Self.EmbedView(View)
		  End If
		  Self.ShowView(View)
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
