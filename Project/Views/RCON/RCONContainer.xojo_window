#tag DesktopWindow
Begin BeaconSubview RCONContainer
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   450
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
   Width           =   718
   Begin Beacon.RCONSocket Sock
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   450
      Index           =   -2147483648
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
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   718
      Begin DesktopTextArea OutputArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   376
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   678
      End
      Begin DesktopTextField CommandField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   408
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   678
      End
      Begin UITweaks.ResizedPushButton ConnectButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Connect"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   360
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   122
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField HostField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   308
      End
      Begin UITweaks.ResizedTextField PasswordField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   308
      End
      Begin UITweaks.ResizedTextField PortField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel HostLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Host:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedLabel PortLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Port:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedLabel PasswordLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Password:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopProgressBar ConnectingIndicator
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumValue    =   100
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   400
      End
      Begin UITweaks.ResizedPushButton ConnectingCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   340
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel ConnectingStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Connecting"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   400
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  BeaconUI.SizeToFit(Self.HostLabel, Self.PortLabel, Self.PasswordLabel)
		  Self.UpdateTitle()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  Var MinContentWidth As Integer = Self.Width - 40
		  Var MaxContentWidth As Integer = 600
		  Var ContentWidth As Integer = Min(MinContentWidth, MaxContentWidth)
		  Var ContentLeft As Integer = BeaconUI.ProportionallyPosition(20, Self.Width, ContentWidth, 2.0)
		  Var ContentHeight As Integer = Self.ConnectButton.Bottom - Self.HostField.Top
		  Var ContentTop As Integer = BeaconUI.ProportionallyPosition(20, Self.Height, ContentHeight, 2.5)
		  
		  Self.HostLabel.Left = ContentLeft
		  Self.HostLabel.Top = ContentTop
		  Self.HostField.Left = Self.HostLabel.Right + 12
		  Self.HostField.Top = Self.HostLabel.Top
		  Self.HostField.Width = ContentWidth - (Self.HostLabel.Width + 12)
		  
		  Self.PortLabel.Left = ContentLeft
		  Self.PortLabel.Top = Self.HostLabel.Bottom + 12
		  Self.PortField.Left = Self.PortLabel.Right + 12
		  Self.PortField.Top = Self.PortLabel.Top
		  
		  Self.PasswordLabel.Left = ContentLeft
		  Self.PasswordLabel.Top = Self.PortLabel.Bottom + 12
		  Self.PasswordField.Left = Self.PasswordLabel.Right + 12
		  Self.PasswordField.Top = Self.PasswordLabel.Top
		  Self.PasswordField.Width = ContentWidth - (Self.PasswordLabel.Width + 12)
		  
		  Self.ConnectButton.Top = Self.PasswordLabel.Bottom + 12
		  Self.ConnectButton.Left = ContentLeft + (ContentWidth - Self.ConnectButton.Width)
		  
		  Var ConnectingHeight As Integer = Self.ConnectingCancelButton.Bottom - Self.ConnectingStatusLabel.Top
		  Var ConnectingTop As Integer = Round((Self.Height - ConnectingHeight) / 2.5)
		  
		  Self.ConnectingStatusLabel.Top = ConnectingTop
		  Self.ConnectingStatusLabel.Width = ContentWidth
		  
		  Self.ConnectingIndicator.Top = Self.ConnectingStatusLabel.Bottom + 12
		  Self.ConnectingIndicator.Left = ContentLeft
		  Self.ConnectingIndicator.Width = ContentWidth
		  
		  Self.ConnectingCancelButton.Left = ContentLeft + (ContentWidth - Self.ConnectingCancelButton.Width)
		  Self.ConnectingCancelButton.Top = Self.ConnectingIndicator.Bottom + 12
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageDetails
		    If Self.HostField.Text.IsEmpty Then
		      Self.HostField.SetFocus
		    ElseIf Self.PortField.Text.IsEmpty Then
		      Self.PortField.SetFocus
		    ElseIf Self.PasswordField.Text.IsEmpty Then
		      Self.PasswordField.SetFocus
		    Else
		      Self.ConnectButton.SetFocus
		    End If
		  Case Self.PageConnecting
		    Self.ConnectingCancelButton.SetFocus
		  Case Self.PageCommands
		    Self.CommandField.SetFocus
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Connect()
		  Var Port As Integer
		  Try
		    Port = Integer.FromString(Self.PortField.Text.Trim, Locale.Current)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Invalid port", "The port should be only numbers.")
		    Return
		  End Try
		  
		  If Port < 1 Or Port > 65535 Then
		    Self.ShowAlert("Invalid port", "The port should be a number greater than 0 and less than 65536.")
		    Return
		  End If
		  
		  Var Host As String = Self.HostField.Text.Trim
		  If Host.IsEmpty Then
		    Self.ShowAlert("Invalid host", "The host should be an ip address or domain name, and definitely not empty.")
		    Return
		  End If
		  
		  If Self.Sock.IsConnected Then
		    Self.Sock.Disconnect
		  End If
		  
		  Self.ConnectingStatusLabel.Text = "Connecting to " + Host + "…"
		  Self.Sock.Connect(Host, Port, Self.PasswordField.Text)
		  Self.Pages.SelectedPanelIndex = Self.PageConnecting
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ViewId = Beacon.UUID.v4
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Host() As String
		  Return Self.Sock.Host
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Return Self.Sock.IsConnected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Port() As Integer
		  Return Self.Sock.Port
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Profile As Beacon.ServerProfile, Connect As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Host As String, Port As Integer, Password As String, Connect As Boolean)
		  Self.HostField.Text = Host
		  Self.PortField.Text = Port.ToString(Locale.Current, "0")
		  Self.PasswordField.Text = Password
		  If Connect Then
		    Self.Connect()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTitle()
		  Var Host As String = Self.HostField.Text.Trim
		  If Host.IsEmpty Then
		    Self.ViewTitle = "New Connection"
		    Return
		  End If
		  
		  Var Port As Integer
		  #Pragma BreakOnExceptions Off
		  Try
		    Port = Integer.FromString(Self.PortField.Text.Trim, Locale.Current)
		  Catch Err As RuntimeException
		  End Try
		  #Pragma BreakOnExceptions Default
		  If Port < 1 Or Port > 65535 Then
		    Self.ViewTitle = Host
		    Return
		  End If
		  
		  Self.ViewTitle = Host + ":" + Port.ToString(Locale.Current, "0")
		End Sub
	#tag EndMethod


	#tag Constant, Name = PageCommands, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageConnecting, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDetails, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Sock
	#tag Event
		Sub ReplyReceived(Message As Beacon.RCONMessage)
		  Self.OutputArea.Text = Self.OutputArea.Text + EndOfLine + "<- " + Message.Response.Trim
		End Sub
	#tag EndEvent
	#tag Event
		Sub Authenticated()
		  Self.OutputArea.Text = "Connected"
		  Self.Pages.SelectedPanelIndex = Self.PageCommands
		End Sub
	#tag EndEvent
	#tag Event
		Sub Disconnected()
		  Self.Pages.SelectedPanelIndex = Self.PageDetails
		  Self.OutputArea.Text = ""
		End Sub
	#tag EndEvent
	#tag Event
		Sub MessageReceived(Message As Beacon.RCONMessage)
		  Self.OutputArea.Text = Self.OutputArea.Text + EndOfLine + "<- " + Message.Body.Trim
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationFailed()
		  Self.Pages.SelectedPanelIndex = Self.PageDetails
		  
		  Self.ShowAlert("Authentication failed", "The RCON server connected, but rejected the password.")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Connected()
		  Self.ConnectingStatusLabel.Text = "Connected and sent password. Waiting for reply…"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CommandField
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(10) Or Key = Chr(13) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub KeyUp(key As String)
		  If Key = Chr(10) Or Key = Chr(13) Then
		    Self.OutputArea.Text = Self.OutputArea.Text + EndOfLine + "-> " + Me.Text
		    Call Self.Sock.Send(Me.Text)
		    Me.Text = ""
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectButton
	#tag Event
		Sub Pressed()
		  Self.Connect()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HostField
	#tag Event
		Sub TextChanged()
		  Self.UpdateTitle()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PortField
	#tag Event
		Sub TextChanged()
		  Self.UpdateTitle()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectingCancelButton
	#tag Event
		Sub Pressed()
		  Self.Sock.Disconnect
		  Self.Pages.SelectedPanelIndex = Self.PageDetails
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
#tag EndViewBehavior
