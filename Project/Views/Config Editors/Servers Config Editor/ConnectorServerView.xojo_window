#tag Window
Begin ServerViewContainer ConnectorServerView
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
   Height          =   600
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
   Width           =   600
   Begin Beacon.ConnectorClientSocket ClientSocket
      Address         =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Port            =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconToolbar ControlToolbar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Borders         =   0
      Caption         =   "Untitled"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   600
   End
   Begin FadedSeparator ControlsSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   True
      Visible         =   True
      Width           =   580
   End
   Begin UITweaks.ResizedTextField ServerNameField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedLabel ServerNameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Underline       =   False
      Value           =   "Server Name:"
      Visible         =   True
      Width           =   110
   End
   Begin UITweaks.ResizedLabel ServerStatusField
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Value           =   "Checking…"
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedLabel ServerStatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Value           =   "Server Status:"
      Visible         =   True
      Width           =   110
   End
   Begin UITweaks.ResizedTextField AddressField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedTextField PortField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedTextField KeyField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   226
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedLabel AddressLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      Value           =   "Address:"
      Visible         =   True
      Width           =   110
   End
   Begin UITweaks.ResizedLabel PortLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      Value           =   "Port:"
      Visible         =   True
      Width           =   110
   End
   Begin UITweaks.ResizedLabel KeyLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   226
      Transparent     =   False
      Underline       =   False
      Value           =   "Encryption Key:"
      Visible         =   True
      Width           =   110
   End
   Begin Timer RefreshTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   30000
      RunMode         =   "0"
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.ClientSocket.Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.ControlToolbar.Caption = Self.mProfile.Name
		  Self.ServerNameField.Value = Self.mProfile.Name
		  Self.AddressField.Value = Self.mProfile.Address
		  Self.PortField.Value = Self.mProfile.Port.ToString
		  Self.KeyField.Value = Self.mProfile.PreSharedKey
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ConnectorServerProfile)
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshServerStatus()
		  Self.RefreshTimer.RunMode = Timer.RunModes.Off
		  
		  If IsNumeric(Self.PortField.Value) = False Or Self.AddressField.Value.Trim = "" Or Self.KeyField.Value.Trim = "" Then
		    Self.Status = ServerStatus.UnableToCheck
		    Self.ClientSocket.Close
		    Return
		  End If
		  
		  Dim Port As Integer = CDbl(Self.PortField.Value)
		  Dim Address As String = Self.AddressField.Value.Trim
		  Dim Key As String = Self.KeyField.Value.Trim
		  
		  Self.Status = ServerStatus.Checking
		  
		  If Self.ClientSocket.IsConnected And Self.mLastTestedAddress = Address And Self.mLastTestedPort = Port And Self.mLastTestedKey.Compare(Key, ComparisonOptions.CaseSensitive) = 0 Then
		    Dim Message As New Dictionary
		    Message.Value("Command") = "Status"
		    Self.ClientSocket.Write(Message)
		    Return
		  End If
		  
		  Self.ClientSocket.Close
		  
		  Self.mLastTestedAddress = Address
		  Self.mLastTestedPort = Port
		  Self.mLastTestedKey = Key
		  
		  Self.ClientSocket.Address = Address
		  Self.ClientSocket.Port = Port
		  Self.ClientSocket.Connect(Key)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLastTestedAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastTestedKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastTestedPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ConnectorServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As ServerStatus
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mStatus
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.mStatus Then
			    Return
			  End If
			  
			  Self.mStatus = Value
			  Select Case Value
			  Case ServerStatus.Checking
			    Self.ServerStatusField.Value = "Checking…"
			    Self.ControlToolbar.PowerButton.Enabled = False
			    Self.ControlToolbar.PowerButton.Toggled = False
			  Case ServerStatus.Error
			    Self.ServerStatusField.Value = "Error, check server details"
			    Self.ControlToolbar.PowerButton.Enabled = False
			    Self.ControlToolbar.PowerButton.Toggled = False
			  Case ServerStatus.Started
			    Self.ServerStatusField.Value = "Started"
			    Self.ControlToolbar.PowerButton.Enabled = True
			    Self.ControlToolbar.PowerButton.Toggled = True
			  Case ServerStatus.Stopped
			    Self.ServerStatusField.Value = "Stopped"
			    Self.ControlToolbar.PowerButton.Enabled = True
			    Self.ControlToolbar.PowerButton.Toggled = False
			  Case ServerStatus.UnableToCheck
			    Self.ServerStatusField.Value = "Cannot check until server details are complete"
			    Self.ControlToolbar.PowerButton.Enabled = False
			    Self.ControlToolbar.PowerButton.Toggled = False
			  End Select
			End Set
		#tag EndSetter
		Private Status As ServerStatus
	#tag EndComputedProperty


	#tag Enum, Name = ServerStatus, Type = Integer, Flags = &h21
		Checking
		  Error
		  Started
		  Stopped
		UnableToCheck
	#tag EndEnum


#tag EndWindowCode

#tag Events ClientSocket
	#tag Event
		Sub Connected()
		  Self.Status = ServerStatus.Checking
		  
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Status"
		  Me.Write(Message)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MessageReceived(Message As Dictionary)
		  Dim Command As String = Message.Lookup("Command", "")
		  
		  Select Case Command
		  Case "Status"
		    Dim Started As Boolean = Message.Lookup("Status", "stopped") = "started"
		    Self.Status = If(Started, ServerStatus.Started, ServerStatus.Stopped)
		    Self.RefreshTimer.Reset
		    Self.RefreshTimer.RunMode = Timer.RunModes.Single
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(Err As RuntimeException)
		  #Pragma Unused Err
		  
		  Self.Status = ServerStatus.Error
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ControlToolbar
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("PowerButton", IconToolbarPower, False, "Start or stop the server."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "PowerButton"
		    If Self.Status = ServerStatus.Started And Self.ClientSocket.IsConnected Then
		      Dim StopMessage As String = StopMessageDialog.Present(Self)
		      If StopMessage = "" Then
		        Return
		      End If
		      
		      Dim Message As New Dictionary
		      Message.Value("Command") = "Stop"
		      Message.Value("Message") = StopMessage
		      Self.ClientSocket.Write(Message)
		      Self.RefreshServerStatus()
		    ElseIf Self.Status = ServerStatus.Stopped And Self.ClientSocket.IsConnected Then
		      Dim Message As New Dictionary
		      Message.Value("Command") = "Start"
		      Self.ClientSocket.Write(Message)
		      Self.RefreshServerStatus()
		    End If
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerNameField
	#tag Event
		Sub TextChange()
		  Self.mProfile.Name = Me.Value
		  Self.ControlToolbar.Caption = Me.Value
		  Self.Changed = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddressField
	#tag Event
		Sub TextChange()
		  Self.mProfile.Address = Me.Value.Trim
		  Self.Changed = Self.mProfile.Modified
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PortField
	#tag Event
		Sub TextChange()
		  If IsNumeric(Me.Value) Then
		    Self.mProfile.Port = CDbl(Me.Value)
		    Self.Changed = Self.mProfile.Modified
		  End If
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events KeyField
	#tag Event
		Sub TextChange()
		  Self.mProfile.PreSharedKey = Me.Value.Trim
		  Self.Changed = Self.mProfile.Modified
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
