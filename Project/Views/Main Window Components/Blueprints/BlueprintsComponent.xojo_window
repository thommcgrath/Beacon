#tag Window
Begin BeaconSubview BlueprintsComponent Implements AnimationKit.ValueAnimator
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
   Begin SourceList ModsList
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   486
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   -251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      SelectedRowIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
   Begin ModEditorView Editor
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
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MinimumHeight   =   300
      MinimumWidth    =   400
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   800
   End
   Begin FadedSeparator ModsListSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   486
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   -1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ModsList.Append(New SourceListItem(LocalData.UserModName, LocalData.UserModID))
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  If Self.ModsList.SelectedRowIndex = -1 Then
		    Self.ModsList.SelectedRowIndex = 0
		  End If
		  Self.RefreshMods()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AnimationStep(Identifier As String, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "ListWidth"
		    Self.ModsListSeparator.Left = Floor(Value)
		    Self.Editor.Left = Self.ModsListSeparator.Left + Self.ModsListSeparator.Width
		    Self.Editor.Width = Self.Width - Self.Editor.Left
		    Self.ModsList.Left = Self.ModsListSeparator.Left - Self.ModsList.Width
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListMods(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.ModsList = Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  If Not Response.Success Then
		    Return
		  End If
		  
		  Var SelectedModID As String
		  If Self.ModsList.SelectedRowIndex > -1 Then
		    SelectedModID = Self.ModsList.Item(Self.ModsList.SelectedRowIndex).Tag
		  End If
		  
		  Self.mUpdatingModsList = True
		  Self.ModsList.RemoveAllItems
		  
		  Var Arr() As Variant = Response.JSON
		  For Each Dict As Dictionary In Arr
		    Var UserMod As New BeaconAPI.WorkshopMod(Dict)
		    Self.ModsList.Append(New SourceListItem(UserMod.Name, UserMod.ModID))
		    If SelectedModID = UserMod.ModID Then
		      Self.ModsList.SelectedRowIndex = Self.ModsList.LastItemIndex
		    End If
		  Next
		  Self.ModsList.Sort
		  
		  Self.ModsList.Insert(0, New SourceListItem(LocalData.UserModName, LocalData.UserModID))
		  If SelectedModID = LocalData.UserModID Then
		    Self.ModsList.SelectedRowIndex = 0
		  End If
		  
		  Self.ModsListVisible = Self.ModsList.Count > 1
		  If Self.ModsList.SelectedRowIndex = -1 Then
		    Self.ModsList.SelectedRowIndex = 0
		  End If
		  Self.mUpdatingModsList = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mModsListAnimating = False
		  Self.mModsListVisible = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If (Self.mModsListAnimation Is Nil) = False And Self.mModsListAnimating Then
		    RemoveHandler Self.mModsListAnimation.Completed, WeakAddressOf mModsListAnimation_Completed
		    Self.mModsListAnimation.Cancel
		    Self.mModsListAnimation = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mModsListAnimation_Completed(Sender As AnimationKit.ValueTask)
		  #Pragma Unused Sender
		  
		  Self.mModsListAnimating = False
		  Self.mModsListAnimation = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshMods()
		  Var Request As New BeaconAPI.Request("mod", "GET", AddressOf APICallback_ListMods)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mModsListAnimating As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModsListAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModsListVisible As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mModsListVisible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mModsListVisible = Value Then
			    Return
			  End If
			  
			  If (Self.mModsListAnimation Is Nil) = False And Self.mModsListAnimating Then
			    RemoveHandler Self.mModsListAnimation.Completed, WeakAddressOf mModsListAnimation_Completed
			    Self.mModsListAnimation.Cancel
			    Self.mModsListAnimation = Nil
			  End If
			  
			  Var EndValue As Integer
			  If Value Then
			    EndValue = Self.ModsList.Width
			  Else
			    EndValue = Self.ModsListSeparator.Width * -1
			  End If
			  
			  Self.mModsListAnimation = New AnimationKit.ValueTask(Self, "ListWidth", Self.ModsListSeparator.Left, EndValue)
			  Self.mModsListAnimation.DurationInSeconds = 0.15
			  Self.mModsListAnimation.Curve = AnimationKit.Curve.CreateEaseOut
			  AddHandler Self.mModsListAnimation.Completed, WeakAddressOf mModsListAnimation_Completed
			  Self.mModsListAnimation.Run
			  
			  Self.mModsListVisible = Value
			  Self.mModsListAnimating = True
			End Set
		#tag EndSetter
		Private ModsListVisible As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mUpdatingModsList As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ModsList
	#tag Event
		Function ShouldChange(DesiredIndex As Integer) As Boolean
		  If DesiredIndex = -1 Or Self.mUpdatingModsList Then
		    Return True
		  End If
		  
		  Var Controller As BlueprintController
		  Var Tag As Variant = Me.Item(DesiredIndex).Tag
		  If Tag = LocalData.UserModID Then
		    Controller = New LocalBlueprintController
		  Else
		    Controller = New RemoteBlueprintController(Tag.StringValue)
		  End If
		  
		  Return Self.Editor.SetController(Controller)
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
