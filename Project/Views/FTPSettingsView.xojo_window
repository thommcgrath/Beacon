#tag DesktopWindow
Begin BeaconContainer FTPSettingsView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   326
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
   Width           =   600
   Begin UITweaks.ResizedLabel ModeLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mode:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin UITweaks.ResizedPopupMenu ModeMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "FTP\nFTP with TLS\nFTP with Implicit TLS\nSFTP"
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   142
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Host:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
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
      Italic          =   False
      Left            =   158
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
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   422
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
      Text            =   "Port:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
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
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "21"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   101
   End
   Begin UITweaks.ResizedLabel UserLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      Text            =   "Username:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   120
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin UITweaks.ResizedTextField UserField
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
      Italic          =   False
      Left            =   158
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
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   422
   End
   Begin DesktopCheckBox UsePublicKeyCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Use Public Key Authentication"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   154
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   422
   End
   Begin UITweaks.ResizedLabel PrivateKeyLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      Text            =   "Private Key File:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   186
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin UITweaks.ResizedTextField PrivateKeyField
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
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   186
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   320
   End
   Begin UITweaks.ResizedPushButton PrivateKeyChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   490
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   187
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel PassLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Password:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   252
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin UITweaks.ResizedTextField PassField
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
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   252
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   422
   End
   Begin DesktopCheckBox VerifyCertificateCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Verify Server Certificate"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   286
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      VisualState     =   0
      Width           =   422
   End
   Begin DesktopCheckBox InternalizeKeyCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Store Private Key in Project"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "If you choose to store your private key in the project, it will be available to any device where you are signed in. It will be encrypted with the rest of the private project data. If you choose not to store your private key in the project, every device which uses the project will need to have the key file in the same path."
      Top             =   220
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   422
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.SetupUI
		  Self.mOpening = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckHostForPort()
		  Var Checker As New Regex
		  Checker.SearchPattern = ":(\d{1,5})$"
		  Checker.ReplacementPattern = ""
		  
		  Var CheckedValue As String = Self.Host
		  
		  Var Matches As RegexMatch = Checker.Search(CheckedValue)
		  If Matches Is Nil Then
		    Self.Host = CheckedValue
		    Return
		  End If
		  
		  Self.Host = CheckedValue.Left(CheckedValue.Length - Matches.SubExpressionString(0).Length)
		  Self.Port = Integer.FromString(Matches.SubExpressionString(1), Locale.Current)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckReadyState()
		  Var WasReady As Boolean = Self.mReady
		  
		  Self.mReady = Self.Host.IsEmpty = False And Self.Port > 0 And Self.Username.IsEmpty = False
		  If Self.Mode = Beacon.FTPModeSSH Then
		    Self.mReady = Self.mReady And ((Self.UsePublicKeyAuth = True And Self.PrivateKeyField.Text.IsEmpty = False) Or (Self.UsePublicKeyAuth = False And Self.Password.IsEmpty = False))
		  Else
		    Self.mReady = Self.mReady And Self.Password.IsEmpty = False
		  End If
		  
		  If Self.mReady <> WasReady Then
		    RaiseEvent ReadyStateChanged()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOpening = True
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DesiredHeight() As Integer
		  Return Self.mDesiredHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DesiredHeight(Assigns Value As Integer)
		  If Self.mDesiredHeight = Value Then
		    Return
		  End If
		  
		  Self.mDesiredHeight = Value
		  RaiseEvent WantsHeightChange(Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImportFileZillaSpec(File As FolderItem) As Boolean
		  Var Doc As XMLDocument
		  Try
		    Doc = New XMLDocument(File)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  Return Self.ImportFileZillaSpec(Doc)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImportFileZillaSpec(Source As String) As Boolean
		  Var Doc As XMLDocument
		  Try
		    If Source.BeginsWith("<?xml") = False Then
		      Source = "<?xml version=""1.0"" encoding=""UTF-8""?>" + EndOfLine + Source
		    End If
		    Doc = New XMLDocument(Source)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  Return Self.ImportFileZillaSpec(Doc)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImportFileZillaSpec(Root As XMLNode) As Boolean
		  If Root Is Nil Then
		    Return False
		  End If
		  
		  Select Case Root.Name
		  Case "#document"
		    Return Self.ImportFileZillaSpec(Root.FirstChild)
		  Case "FileZilla3"
		    Var Nodes() As XMLNode = Root.FindNode("Servers")
		    If Nodes.Count = 0 Then
		      Return False
		    End If
		    Return Self.ImportFileZillaSpec(Nodes(0))
		  Case "Servers"
		    Var Nodes() As XMLNode = Root.FindNode("Server")
		    If Nodes.Count = 0 Then
		      Return False
		    End If
		    Return Self.ImportFileZillaSpec(Nodes(0))
		  Case "Server"
		    Var Bound As Integer = Root.ChildCount - 1
		    For Idx As Integer = 0 To Bound
		      Var Child As XMLNode = Root.Child(Idx)
		      Select Case Child.Name
		      Case "Host"
		        Self.Host = Child.FirstChild.Value
		      Case "Port"
		        Self.Port = Integer.FromString(Child.FirstChild.Value, Locale.Raw)
		      Case "User"
		        Self.Username = Child.FirstChild.Value
		      Case "Pass"
		        Select Case Child.GetAttribute("encoding")
		        Case "base64"
		          Self.Password = DecodeBase64(Child.FirstChild.Value, Encodings.UTF8)
		        Else
		          Self.Password = Child.FirstChild.Value
		        End Select
		      Case "Protocol"
		        Var Protocol As Integer = Integer.FromString(Child.FirstChild.Value, Locale.Raw)
		        Select Case Protocol
		        Case 0
		          Self.Mode = Beacon.FTPModeInsecure
		        Case 1
		          Self.Mode = Beacon.FTPModeSSH
		        Case 3
		          Self.Mode = Beacon.FTPModeImplicitTLS
		        Case 4
		          Self.Mode = Beacon.FTPModeExplicitTLS
		        End Select
		      End Select
		    Next
		    
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ready() As Boolean
		  Return Self.mReady
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Var RowIndex As Integer = Self.ModeMenu.SelectedRowIndex
		  Var UsePublicKeyAuth As Boolean = (RowIndex = Self.IndexSFTP) And Self.UsePublicKeyCheck.Value
		  
		  Self.UsePublicKeyCheck.Visible = (RowIndex = Self.IndexSFTP)
		  Self.PrivateKeyLabel.Visible = UsePublicKeyAuth
		  Self.PrivateKeyField.Visible = UsePublicKeyAuth
		  Self.PrivateKeyChooseButton.Visible = UsePublicKeyAuth
		  Self.InternalizeKeyCheck.Visible = UsePublicKeyAuth
		  Self.PassLabel.Text = If(UsePublicKeyAuth, "Key Password:", "Password:")
		  Self.VerifyCertificateCheck.Visible = (RowIndex = Self.IndexFTPTLS Or RowIndex = Self.IndexFTPS)
		  
		  BeaconUI.SizeToFit(Self.ModeLabel, Self.HostLabel, Self.PortLabel, Self.UserLabel, Self.PrivateKeyLabel, Self.PassLabel)
		  
		  Var FieldsLeft As Integer = Self.ModeLabel.Right + 12
		  Self.ModeMenu.Left = FieldsLeft
		  Self.HostField.Left = FieldsLeft
		  Self.HostField.Width = Self.Width - (20 + FieldsLeft)
		  Self.PortField.Left = FieldsLeft
		  Self.UserField.Left = FieldsLeft
		  Self.UserField.Width = Self.Width - (20 + FieldsLeft)
		  Self.UsePublicKeyCheck.Left = FieldsLeft
		  Self.PrivateKeyField.Left = FieldsLeft
		  Self.PrivateKeyField.Width = Self.PrivateKeyChooseButton.Left - (12 + FieldsLeft)
		  Self.InternalizeKeyCheck.Left = FieldsLeft
		  Self.PassField.Left = FieldsLeft
		  Self.PassField.Width = Self.Width - (20 + FieldsLeft)
		  Self.VerifyCertificateCheck.Left = FieldsLeft
		  
		  Var NextTop As Integer = Self.UserField.Bottom + 12
		  If Self.UsePublicKeyCheck.Visible Then
		    Self.UsePublicKeyCheck.Top = NextTop
		    NextTop = Self.UsePublicKeyCheck.Bottom + 12
		  End If
		  If Self.PrivateKeyField.Visible Then
		    Self.PrivateKeyLabel.Top = NextTop
		    Self.PrivateKeyField.Top = NextTop
		    Self.PrivateKeyChooseButton.Top = NextTop
		    NextTop = Self.PrivateKeyField.Bottom + 12
		  End If
		  If Self.InternalizeKeyCheck.Visible Then
		    Self.InternalizeKeyCheck.Top = NextTop
		    NextTop = Self.InternalizeKeyCheck.Bottom + 12
		  End If
		  
		  Self.PassLabel.Top = NextTop
		  Self.PassField.Top = NextTop
		  NextTop = Self.PassField.Bottom + 12
		  
		  If Self.VerifyCertificateCheck.Visible Then
		    Self.VerifyCertificateCheck.Top = NextTop
		    NextTop = Self.VerifyCertificateCheck.Bottom + 12
		  End If
		  
		  Self.DesiredHeight = NextTop + 8
		  
		  If RowIndex = Self.IndexSFTP Then
		    If Self.Port = 21 Or Self.Port = 990 Then
		      Self.Port = 22
		    End If
		  ElseIf RowIndex = Self.IndexFTPS Then
		    If Self.Port = 21 Or Self.Port = 22 Then
		      Self.Port = 990
		    End If
		  Else
		    If Self.Port = 22 Or Self.Port = 990 Then
		      Self.Port = 21
		    End If
		  End If
		  
		  Self.CheckReadyState()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadyStateChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WantsHeightChange(NewDesiredHeight As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.HostField.Text.Trim
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.HostField.Text = Value
			End Set
		#tag EndSetter
		Host As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.InternalizeKeyCheck.Value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.InternalizeKeyCheck.Value = Value
			End Set
		#tag EndSetter
		InternalizeKey As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDesiredHeight As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case Self.ModeMenu.SelectedRowIndex
			  Case Self.IndexFTP
			    Return Beacon.FTPModeInsecure
			  Case Self.IndexFTPTLS
			    Return Beacon.FTPModeExplicitTLS
			  Case Self.IndexSFTP
			    Return Beacon.FTPModeSSH
			  Case Self.IndexFTPS
			    Return Beacon.FTPModeImplicitTLS
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Select Case Value
			  Case Beacon.FTPModeImplicitTLS
			    Self.ModeMenu.SelectedRowIndex = Self.IndexFTPS
			  Case Beacon.FTPModeExplicitTLS
			    Self.ModeMenu.SelectedRowIndex = Self.IndexFTPTLS
			  Case Beacon.FTPModeSSH
			    Self.ModeMenu.SelectedRowIndex = Self.IndexSFTP
			  Else
			    Self.ModeMenu.SelectedRowIndex = Self.IndexFTP
			  End Select
			End Set
		#tag EndSetter
		Mode As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOpening As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKeyFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKeyFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReady As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PassField.Text
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.PassField.Text = Value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Integer.FromString(Self.PortField.Text.Trim, Locale.Current)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.PortField.Text = Value.ToString(Locale.Current, "0")
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPrivateKeyFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  If Value Is Nil Then
			    Self.mPrivateKeyFile = Nil
			    Self.PrivateKeyField.Text = ""
			    Return
			  End If
			  
			  If Self.PrivateKeyField.Text = Value.NativePath Then
			    Return
			  End If
			  
			  Self.mPrivateKeyFile = Value
			  Self.PrivateKeyField.Text = Value.NativePath
			End Set
		#tag EndSetter
		PrivateKeyFile As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.UsePublicKeyCheck.Value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.UsePublicKeyCheck.Value = Value
			End Set
		#tag EndSetter
		UsePublicKeyAuth As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.UserField.Text.Trim
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.UserField.Text = Value
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.VerifyCertificateCheck.Value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOpening Then
			    Return
			  End If
			  
			  Self.VerifyCertificateCheck.Value = Value
			End Set
		#tag EndSetter
		VerifyTLSCertificate As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = IndexFTP, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexFTPS, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexFTPTLS, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexSFTP, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModeMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.SetupUI()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HostField
	#tag Event
		Sub TextChanged()
		  Self.CheckReadyState()
		  Self.Modified = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  Self.CheckHostForPort()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PortField
	#tag Event
		Sub TextChanged()
		  Self.CheckReadyState()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserField
	#tag Event
		Sub TextChanged()
		  Self.CheckReadyState()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UsePublicKeyCheck
	#tag Event
		Sub ValueChanged()
		  Self.SetupUI()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PrivateKeyField
	#tag Event
		Sub TextChanged()
		  Self.CheckReadyState()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PrivateKeyChooseButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Any
		  
		  Var KeyFile As FolderItem = Dialog.ShowModal(Self)
		  If KeyFile Is Nil Then
		    Return
		  End If
		  
		  Self.PrivateKeyFile = KeyFile
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PassField
	#tag Event
		Sub TextChanged()
		  Self.CheckReadyState()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InternalizeKeyCheck
	#tag Event
		Sub ValueChanged()
		  Self.Modified = True
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
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Name="Mode"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Password"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Username"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Port"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Host"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UsePublicKeyAuth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="VerifyTLSCertificate"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InternalizeKey"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
