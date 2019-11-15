#tag Window
Begin BeaconSubview APIBuilderView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   460
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   1100
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "API Builder"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   "False"
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   ""
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1100
   End
   Begin CheckBox AuthenticatedCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Authenticated"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   127
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   239
      Transparent     =   False
      Underline       =   False
      Value           =   "False"
      Visible         =   True
      Width           =   267
   End
   Begin TextArea BodyField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   66
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   127
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel BodyLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Body:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   127
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPushButton BuildButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Build"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   272
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   271
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
   End
   Begin TextArea CodeField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   137
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   303
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel CodeLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Code:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   303
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedTextField ContentTypeField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   205
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   267
   End
   Begin UITweaks.ResizedLabel ContentTypeLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Content Type:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   205
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPopupMenu FormatMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "cURL\nPHP\nHTTP"
      Italic          =   False
      Left            =   127
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   271
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   133
   End
   Begin UITweaks.ResizedLabel LanguageLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      Text            =   "Language:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   271
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedLabel MethodLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Method:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   95
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPopupMenu MethodMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "GET\nPOST\nDELETE"
      Italic          =   False
      Left            =   127
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   95
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   133
   End
   Begin UITweaks.ResizedTextField PathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel PathLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Path:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin FadedSeparator HeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   1
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
      ScrollSpeed     =   20
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1100
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ToolbarCaption = "API Builder"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DoNothing(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  #Pragma Unused Response
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildCURLCode(Request As BeaconAPI.Request) As String
		  Dim Cmd As String = "curl"
		  If Request.Method <> "GET" Then
		    Cmd = Cmd + " --request '" + Request.Method + "'"
		    If Request.Query <> "" Then
		      Cmd = Cmd + " --data '" + Request.Query + "'"
		    End If
		    If Request.ContentType <> "" Then
		      Cmd = Cmd + " --header 'Content-Type: " + Request.ContentType + "'"
		    End If
		  End If
		  If Request.Authenticated Then
		    Cmd = Cmd + " --header 'Authorization: " + Request.AuthHeader + "'"
		  End If
		  Cmd = Cmd + " " + Request.URL
		  If Request.Method = "GET" And Request.Query <> "" Then
		    Cmd = Cmd + "?" + Request.Query
		  End If
		  Return Cmd
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildHTTPCode(Request As BeaconAPI.Request) As String
		  Dim StringEOL As String = EndOfLine
		  Dim EOL As String = StringEOL // Really hate that it takes 2 lines of code to do this
		  
		  Dim URL As String = Request.URL
		  Dim SchemeEnd As Integer = URL.IndexOf("://")
		  URL = URL.Middle(SchemeEnd + 3)
		  
		  Dim HostEnd As Integer = URL.IndexOf("/")
		  Dim Host As String = URL.Left(HostEnd)
		  Dim Path As String = URL.Middle(HostEnd)
		  
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      Path = Path + "?" + Request.Query
		    End If
		  End If
		  
		  Dim Lines() As String
		  Lines.AddRow(Request.Method + " " + Path + " HTTP/1.1")
		  Lines.AddRow("Host: " + Host)
		  
		  If Request.Authenticated Then
		    Lines.AddRow("Authorization: " + Request.AuthHeader)
		  End If
		  
		  If Request.Method <> "GET" Then
		    If Request.ContentType <> "" Then
		      Lines.AddRow("Content-Type: " + Request.ContentType)
		    End If
		    Lines.AddRow("")
		    Lines.AddRow(Request.Query)
		  End If
		  
		  Return Lines.Join(EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildPHPCode(Request As BeaconAPI.Request) As String
		  Dim StringEOL As String = EndOfLine
		  Dim EOL As String = StringEOL // Really hate that it takes 2 lines of code to do this
		  Dim Authenticated As Boolean = Request.Authenticated
		  
		  Dim Lines() As String
		  
		  Dim URL As String = Request.URL
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      URL = URL + "?" + Request.Query
		    End If
		  End If
		  Lines.AddRow("$url = '" + URL.ReplaceAll("'", "\'") + "';")
		  
		  If Authenticated Or Request.Method <> "GET" Then
		    Lines.AddRow("$method = '" + Request.Method.ReplaceAll("'", "\'").Uppercase + "';")
		  End If
		  
		  If Request.Method <> "GET" And Request.Query <> "" Then
		    Lines.AddRow("$body = '" + Request.Query.ReplaceAll("'", "\'") + "';")
		  End If
		  
		  If Authenticated Then
		    Lines.AddRow("")
		    If Request.Method = "GET" Then
		      Lines.AddRow("$auth = $method . Encodings.UTF8.Chr(10) . $url;")
		    Else
		      If Request.Query <> "" Then
		        Lines.AddRow("$auth = $method . Encodings.UTF8.Chr(10) . $url  . Encodings.UTF8.Chr(10) . $body;")
		      Else
		        Lines.AddRow("$auth = $method . Encodings.UTF8.Chr(10) . $url  . Encodings.UTF8.Chr(10);")
		      End If
		    End If
		    Lines.AddRow("// Change Myself.beaconidentiy to point to your identity file!")
		    Lines.AddRow("$identity = json_decode(file_get_contents('Myself.beaconidentity'), true);")
		    Lines.AddRow("$username = $identity['Identifier'];")
		    Lines.AddRow("$private_key = $identity['Private'];")
		    Lines.AddRow("$private_key = trim(chunk_split(base64_encode(hex2bin($private_key)), 64, ""\n""));")
		    Lines.AddRow("$private_key = ""-----BEGIN RSA PRIVATE KEY-----\n$private_key\n-----END RSA PRIVATE KEY-----"";")
		    Lines.AddRow("openssl_sign($auth, $password, $private_key) or die('Unable to authenticate action');")
		  End If
		  
		  Lines.AddRow("")
		  Lines.AddRow("$http = curl_init();")
		  Lines.AddRow("curl_setopt($http, CURLOPT_URL, $url);")
		  Lines.AddRow("curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);")
		  If Request.Method <> "GET" Then
		    Lines.AddRow("curl_setopt($http, CURLOPT_CUSTOMREQUEST, $method);")
		    If Request.Query <> "" Then
		      Lines.AddRow("curl_setopt($http, CURLOPT_POSTFIELDS, $body);")
		    End If
		    If Request.ContentType <> "" Then
		      Lines.AddRow("curl_setopt($http, CURLOPT_HTTPHEADER, array('Content-Type: " + Request.ContentType.ReplaceAll("'", "\'") + "'));")
		    End If
		  End If
		  If Authenticated Then
		    Lines.AddRow("curl_setopt($http, CURLOPT_USERPWD, $username . ':' . bin2hex($password));")
		  End If
		  Lines.AddRow("$response = curl_exec($http);")
		  Lines.AddRow("$http_status = curl_getinfo($http, CURLINFO_HTTP_CODE);")
		  Lines.AddRow("curl_close($http);")
		  
		  Return Lines.Join(EOL)
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events BuildButton
	#tag Event
		Sub Action()
		  Dim Path As String = PathField.Value
		  Dim Method As String = MethodMenu.SelectedRowValue
		  Dim Body As String = BodyField.Value
		  Dim ContentType As String = ContentTypeField.Value
		  
		  Dim Request As BeaconAPI.Request
		  Try
		    If BodyField.Enabled Then
		      Request = New BeaconAPI.Request(Path, Method, Body, ContentType, AddressOf APICallback_DoNothing)
		    Else
		      Request = New BeaconAPI.Request(Path, Method, AddressOf APICallback_DoNothing)
		    End If
		    If AuthenticatedCheck.Value Then
		      Request.Authenticate(Preferences.OnlineToken)
		    End If
		  Catch Err As UnsupportedOperationException
		    Self.ShowAlert("Cannot build the request", Err.Reason)
		    Return
		  End Try
		  
		  Select Case FormatMenu.SelectedRowIndex
		  Case 0
		    CodeField.Value = Self.BuildCURLCode(Request)
		  Case 1
		    CodeField.Value = Self.BuildPHPCode(Request)
		  Case 2
		    CodeField.Value = Self.BuildHTTPCode(Request)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MethodMenu
	#tag Event
		Sub Change()
		  BodyField.Enabled = Me.SelectedRowIndex > 0
		  BodyLabel.Enabled = BodyField.Enabled
		  ContentTypeField.Enabled = BodyField.Enabled
		  ContentTypeLabel.Enabled = BodyField.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
