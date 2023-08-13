#tag DesktopWindow
Begin DesktopContainer DocumentImportSourcePicker
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   252
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   508
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Select Import Source"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   468
   End
   Begin DesktopRadioButton SourceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Nitrado"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   468
   End
   Begin DesktopRadioButton SourceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "GameServerApp.com"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   1
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   468
   End
   Begin DesktopRadioButton SourceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Single Player, Local Files, or Copy + Paste"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   2
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   468
   End
   Begin DesktopRadioButton SourceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Server With FTP Access"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   3
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   148
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   468
   End
   Begin DesktopRadioButton SourceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Other Beacon Project"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   4
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   180
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   468
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   316
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   212
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Continue"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   408
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   212
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ActionButtonEnabled() As Boolean
		  Return Self.mActionButtonCanEnable
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActionButtonEnabled(Assigns Value As Boolean)
		  Self.mActionButtonCanEnable = Value
		  Self.ActionButton.Enabled = Value And Self.SelectedSource > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexForSource(Source As Integer) As Integer
		  Select Case Source
		  Case Self.SourceFTP
		    Return Self.RadioFTP
		  Case Self.SourceGSA
		    Return Self.RadioGSA
		  Case Self.SourceLocal
		    Return Self.RadioLocal
		  Case Self.SourceNitrado
		    Return Self.RadioNitrado
		  Case Self.SourceOtherProject
		    Return Self.RadioOtherProject
		  Else
		    Return -1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedSource() As Integer
		  For Idx As Integer = Self.FirstRadioIndex To Self.LastRadioIndex
		    If Self.SourceRadio(Idx).Value And Self.SourceRadio(Idx).Enabled Then
		      Return Self.SourceForIndex(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedSource(Assigns Value As Integer)
		  Var DesiredIndex As Integer = Self.IndexForSource(Value)
		  For Idx As Integer = Self.FirstRadioIndex To Self.LastRadioIndex
		    Self.SourceRadio(Idx).Value = Self.SourceRadio(Idx).Enabled And Idx = DesiredIndex
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Self.SourceRadio(Self.RadioFTP).Visible = (Self.mAllowedSources And Self.SourceFTP) > 0
		  Self.SourceRadio(Self.RadioGSA).Visible = (Self.mAllowedSources And Self.SourceGSA) > 0
		  Self.SourceRadio(Self.RadioLocal).Visible = (Self.mAllowedSources And Self.SourceLocal) > 0
		  Self.SourceRadio(Self.RadioNitrado).Visible = (Self.mAllowedSources And Self.SourceNitrado) > 0
		  Self.SourceRadio(Self.RadioOtherProject).Visible = (Self.mAllowedSources And Self.SourceOtherProject) > 0
		  
		  Self.SourceRadio(Self.RadioFTP).Enabled = (Self.mEnabledSources And Self.SourceFTP) > 0
		  Self.SourceRadio(Self.RadioGSA).Enabled = (Self.mEnabledSources And Self.SourceGSA) > 0
		  Self.SourceRadio(Self.RadioLocal).Enabled = (Self.mEnabledSources And Self.SourceLocal) > 0
		  Self.SourceRadio(Self.RadioNitrado).Enabled = (Self.mEnabledSources And Self.SourceNitrado) > 0
		  Self.SourceRadio(Self.RadioOtherProject).Enabled = (Self.mEnabledSources And Self.SourceOtherProject) > 0
		  
		  Self.ActionButton.Enabled = Self.mActionButtonCanEnable And Self.SelectedSource > 0
		  Self.SourceRadio(Self.RadioOtherProject).Caption = "Other " + Language.GameName(Self.mGameId) + " Project" + If(Self.SourceRadio(Self.RadioOtherProject).Enabled, "", " (No Other Projects Open)")
		  
		  Var NextTop As Integer = Self.MessageLabel.Bottom + 12
		  For Idx As Integer = Self.FirstRadioIndex To Self.LastRadioIndex
		    If Self.SourceRadio(Idx).Visible = False Then
		      Continue
		    End If
		    
		    Self.SourceRadio(Idx).Top = NextTop
		    NextTop = Self.SourceRadio(Idx).Bottom + 12
		  Next
		  
		  Self.ActionButton.Top = NextTop
		  Self.CancelButton.Top = NextTop
		  
		  Var TargetHeight As Integer = Self.ActionButton.Bottom + 20
		  If Self.Height <> TargetHeight Then
		    RaiseEvent ShouldResize(TargetHeight)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SourceForIndex(Index As Integer) As Integer
		  Select Case Index
		  Case Self.RadioFTP
		    Return Self.SourceFTP
		  Case Self.RadioGSA
		    Return Self.SourceGSA
		  Case Self.RadioLocal
		    Return Self.SourceLocal
		  Case Self.RadioNitrado
		    Return Self.SourceNitrado
		  Case Self.RadioOtherProject
		    Return Self.SourceOtherProject
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Cancelled()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(NewHeight As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SourceChosen(Source As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAllowedSources
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAllowedSources = Value Then
			    Return
			  End If
			  
			  Self.mAllowedSources = Value
			  Self.SetupUI
			End Set
		#tag EndSetter
		AllowedSources As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabledSources
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabledSources = Value Then
			    Return
			  End If
			  
			  Self.mEnabledSources = Value
			  Self.SetupUI
			End Set
		#tag EndSetter
		EnabledSources As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameId
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameId = Value Then
			    Return
			  End If
			  
			  Self.mGameId = Value
			  Self.SetupUI
			End Set
		#tag EndSetter
		GameId As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActionButtonCanEnable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowedSources As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabledSources As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameId As String
	#tag EndProperty


	#tag Constant, Name = FirstRadioIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LastRadioIndex, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioFTP, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioGSA, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioLocal, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioNitrado, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioOtherProject, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SourceFTP, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SourceGSA, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SourceLocal, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SourceNitrado, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SourceOtherProject, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events SourceRadio
	#tag Event
		Sub ValueChanged(index as Integer)
		  // DesktopRadioButton.ValueChanged only fires when the value becomes true, either programmatically or by the user
		  
		  Self.ActionButton.Enabled = Self.mActionButtonCanEnable And Self.SelectedSource > 0
		  Self.ActionButton.Default = Self.ActionButton.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  RaiseEvent Cancelled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Source As Integer = Self.SelectedSource
		  RaiseEvent SourceChosen(Source)
		  Self.ActionButtonEnabled = False
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
		Name="AllowedSources"
		Visible=true
		Group="Behavior"
		InitialValue="31"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EnabledSources"
		Visible=true
		Group="Behavior"
		InitialValue="31"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="GameId"
		Visible=true
		Group="Behavior"
		InitialValue="#Ark.Identifier"
		Type="String"
		EditorType="MultiLineEditor"
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
#tag EndViewBehavior
