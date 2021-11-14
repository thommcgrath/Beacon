#tag Window
Begin ContainerControl DocumentFilterControl
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   True
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   62
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
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
   Width           =   758
   Begin DelayedSearchField FilterField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Search Projects"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   538
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   10
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   200
   End
   Begin UITweaks.ResizedPushButton MapPickerButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Maps"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton NewDocumentButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "New Project"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedPopupMenu OperatorMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Any Selected Map\nAll Selected Maps"
      Italic          =   False
      Left            =   239
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   150
   End
   Begin UITweaks.ResizedPopupMenu ModRestrictionMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Mods Allowed\nNo Mods"
      Italic          =   False
      Left            =   401
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   125
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.mMask = Beacon.Maps.UniversalMask
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub mMapSelectionController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Var NewMask As UInt64 = MapSelectionGrid(Sender.Container).Mask
		    If Self.mMask <> NewMask Then
		      Self.mMask = NewMask
		      RaiseEvent Changed()
		    End If
		  End If
		  
		  Self.mMapSelectionController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchText() As String
		  Return Self.FilterField.Text.MakeUTF8.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Var InitialSilence As Boolean = Self.mSilenceChangeEvents
		  Self.mSilenceChangeEvents = True
		  
		  Var ConsoleSafeIndex As Integer = If(Self.mConsoleSafe, 1, 0)
		  If Self.ModRestrictionMenu.SelectedRowIndex <> ConsoleSafeIndex Then
		    Self.ModRestrictionMenu.SelectedRowIndex = ConsoleSafeIndex
		  End If
		  
		  Var OperatorIndex As Integer = If(Self.mRequireAllMaps, 1, 0)
		  If Self.OperatorMenu.SelectedRowIndex <> OperatorIndex Then
		    Self.OperatorMenu.SelectedRowIndex = OperatorIndex
		  End If
		  
		  Self.mSilenceChangeEvents = InitialSilence
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewDocument()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConsoleSafe
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mConsoleSafe = Value Then
			    Return
			  End If
			  
			  Self.mConsoleSafe = Value
			  
			  If Thread.Current = Nil Then
			    Self.UpdateUI()
			  Else
			    Call CallLater.Schedule(1, AddressOf UpdateUI)
			  End If
			End Set
		#tag EndSetter
		ConsoleSafe As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMask
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMask = Value
			End Set
		#tag EndSetter
		Mask As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapSelectionController As PopoverController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireAllMaps As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSilenceChangeEvents As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mRequireAllMaps
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mRequireAllMaps = Value Then
			    Return
			  End If
			  
			  Self.mRequireAllMaps = Value
			  
			  If Thread.Current = Nil Then
			    Self.UpdateUI()
			  Else
			    Call CallLater.Schedule(1, AddressOf UpdateUI)
			  End If
			End Set
		#tag EndSetter
		RequireAllMaps As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.FilterField.DelayPeriod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.FilterField.DelayPeriod = Value
			End Set
		#tag EndSetter
		SearchDelayPeriod As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.MapPickerButton.Visible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.ShowFullControls Then
			    Return
			  End If
			  
			  Self.MapPickerButton.Visible = Value
			  Self.OperatorMenu.Visible = Value
			  Self.ModRestrictionMenu.Visible = Value
			End Set
		#tag EndSetter
		ShowFullControls As Boolean
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  If Self.mSilenceChangeEvents Then
		    Return
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapPickerButton
	#tag Event
		Sub Action()
		  If (Self.mMapSelectionController Is Nil) = False And Self.mMapSelectionController.Visible Then
		    Self.mMapSelectionController.Dismiss(False)
		    Self.mMapSelectionController = Nil
		    Return
		  End If
		  
		  Var Editor As New MapSelectionGrid
		  Var Controller As New PopoverController("Select Maps", Editor)
		  Editor.Mask = Self.mMask
		  Controller.Show(Me)
		  
		  AddHandler Controller.Finished, WeakAddressOf mMapSelectionController_Finished
		  Self.mMapSelectionController = Controller
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewDocumentButton
	#tag Event
		Sub Action()
		  RaiseEvent NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OperatorMenu
	#tag Event
		Sub Change()
		  If Self.mSilenceChangeEvents Then
		    Return
		  End If
		  
		  Var NewValue As Boolean = Me.SelectedRowIndex = 1
		  If Self.mRequireAllMaps <> NewValue Then
		    Self.mRequireAllMaps = NewValue
		    RaiseEvent Changed()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModRestrictionMenu
	#tag Event
		Sub Change()
		  If Self.mSilenceChangeEvents Then
		    Return
		  End If
		  
		  Var NewValue As Boolean = Me.SelectedRowIndex = 1
		  If Self.mConsoleSafe <> NewValue Then
		    Self.mConsoleSafe = NewValue
		    RaiseEvent Changed()
		  End If
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ShowFullControls"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Mask"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="UInt64"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ConsoleSafe"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="RequireAllMaps"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="SearchDelayPeriod"
		Visible=true
		Group="Behavior"
		InitialValue="250"
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
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
