#tag Window
Begin ContainerControl MapSelectionGrid
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   300
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   300
   Begin BeaconUI.MapCheckBox Boxes
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Untitled"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Scope           =   2
      State           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   6
      Transparent     =   False
      Underline       =   False
      Value           =   "False"
      Visible         =   True
      Width           =   140
   End
End
#tag EndWindow

#tag WindowCode
	#tag EventAPI2
		Sub Opening()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  Dim OfficialMaps(), OtherMaps() As Beacon.Map
		  Dim OfficialMasks(), OtherMasks() As UInt64
		  For Each Map As Beacon.Map In Maps
		    If Map.Official Then
		      OfficialMaps.AddRow(Map)
		      OfficialMasks.AddRow(Map.Mask)
		    Else
		      OtherMaps.AddRow(Map)
		      OtherMasks.AddRow(Map.Mask)
		    End If
		  Next
		  
		  OfficialMasks.SortWith(OfficialMaps)
		  OtherMasks.SortWith(OtherMaps)
		  
		  Dim OfficialLeft As Integer = Boxes(0).Left
		  Dim OfficialNextTop As Integer = Boxes(0).Top
		  Dim OtherLeft As Integer = Boxes(0).Left + Boxes(0).Width + 12
		  Dim OtherNextTop As Integer = Boxes(0).Top
		  
		  Boxes(0).Close
		  
		  For Each Map As Beacon.Map In OfficialMaps
		    Dim Box As New Boxes
		    Box.Mask = Map.Mask
		    Box.Caption = Map.Name
		    Box.Top = OfficialNextTop
		    Box.Left = OfficialLeft
		    OfficialNextTop = OfficialNextTop + Box.Height + 12
		    Self.mBoxes.AddRow(Box)
		  Next
		  For Each Map As Beacon.Map In OtherMaps
		    Dim Box As New Boxes
		    Box.Mask = Map.Mask
		    Box.Caption = Map.Name
		    Box.Top = OtherNextTop
		    Box.Left = OtherLeft
		    OtherNextTop = OtherNextTop + Box.Height + 12
		    Self.mBoxes.AddRow(Box)
		  Next
		  
		  Self.Height = (OfficialMaps.LastRowIndex + 1) * 32
		  Self.Width = 304
		  
		  RaiseEvent Opening
		  Self.mSettingUp = False
		End Sub
	#tag EndEventAPI2


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Combined As UInt64
			  For Each Box As BeaconUI.MapCheckBox In Self.mBoxes
			    If Box.Value Then
			      Combined = Combined Or Box.Mask
			    End If
			  Next
			  Return Combined
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.Mask = Value Then
			    Return
			  End If
			  
			  Self.mSettingUp = True
			  For Each Box As BeaconUI.MapCheckBox In Self.mBoxes
			    Box.Value = (Value And Box.Mask) = Box.Mask
			  Next
			  Self.mSettingUp = False
			  RaiseEvent Changed
			End Set
		#tag EndSetter
		Mask As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBoxes() As BeaconUI.MapCheckBox
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean = True
	#tag EndProperty


#tag EndWindowCode

#tag Events Boxes
	#tag EventAPI2
		Sub ValueChanged(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEventAPI2
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
		InitialValue=""
		Type="Integer"
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
	#tag ViewProperty
		Name="Mask"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="UInt64"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
