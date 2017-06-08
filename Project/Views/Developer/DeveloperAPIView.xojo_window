#tag Window
Begin DeveloperView DeveloperAPIView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   953
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Underline       =   False
      Visible         =   True
      Width           =   133
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   953
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   198
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   267
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
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Underline       =   False
      Visible         =   True
      Width           =   133
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   262
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
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   "Path:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
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
      TabIndex        =   2
      TabPanelIndex   =   0
      Text            =   "Method:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
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
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   "Body:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
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
      TabIndex        =   9
      TabPanelIndex   =   0
      Text            =   "Language:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
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
      TabIndex        =   12
      TabPanelIndex   =   0
      Text            =   "Code:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   262
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPushButton BuildButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Underline       =   False
      Visible         =   True
      Width           =   72
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   164
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
      TabIndex        =   6
      TabPanelIndex   =   0
      Text            =   "Content Type:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   164
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub APICallback_DoNothing(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Success
		  #Pragma Unused Message
		  #Pragma Unused Details
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildCURLCode(Request As BeaconAPI.Request) As Text
		  Dim Cmd As Text = "curl"
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
		    Cmd = Cmd + " --user " + Request.AuthUser + ":" + Request.AuthPassword
		  End If
		  Cmd = Cmd + " " + Request.URL
		  If Request.Method = "GET" And Request.Query <> "" Then
		    Cmd = Cmd + "?" + Request.Query
		  End If
		  Return Cmd
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildHTTPCode(Request As BeaconAPI.Request) As Text
		  Dim StringEOL As String = EndOfLine
		  Dim EOL As Text = StringEOL.ToText // Really hate that it takes 2 lines of code to do this
		  
		  Dim URL As Text = Request.URL
		  Dim SchemeEnd As Integer = URL.IndexOf("://")
		  URL = URL.Mid(SchemeEnd + 3)
		  
		  Dim HostEnd As Integer = URL.IndexOf("/")
		  Dim Host As Text = URL.Left(HostEnd)
		  Dim Path As Text = URL.Mid(HostEnd)
		  
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      Path = Path + "?" + Request.Query
		    End If
		  End If
		  
		  Dim Lines() As Text
		  Lines.Append(Request.Method + " " + Path + " HTTP/1.1")
		  Lines.Append("Host: " + Host)
		  
		  If Request.Authenticated Then
		    Lines.Append("Authorization: Basic " + EncodeBase64(Request.AuthUser + ":" + Request.AuthPassword, 0).ToText)
		  End If
		  
		  If Request.Method <> "GET" Then
		    If Request.ContentType <> "" Then
		      Lines.Append("Content-Type: " + Request.ContentType)
		    End If
		    Lines.Append("")
		    Lines.Append(Request.Query)
		  End If
		  
		  Return Text.Join(Lines, EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildPHPCode(Request As BeaconAPI.Request) As Text
		  Dim StringEOL As String = EndOfLine
		  Dim EOL As Text = StringEOL.ToText // Really hate that it takes 2 lines of code to do this
		  Dim Authenticated As Boolean = Request.Authenticated
		  
		  Dim Lines() As Text
		  
		  Dim URL As Text = Request.URL
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      URL = URL + "?" + Request.Query
		    End If
		  End If
		  Lines.Append("$url = '" + URL.ReplaceAll("'", "\'") + "';")
		  
		  If Authenticated Or Request.Method <> "GET" Then
		    Lines.Append("$method = '" + Request.Method.ReplaceAll("'", "\'").Uppercase + "';")
		  End If
		  
		  If Request.Method <> "GET" And Request.Query <> "" Then
		    Lines.Append("$body = '" + Request.Query.ReplaceAll("'", "\'") + "';")
		  End If
		  
		  If Authenticated Then
		    Lines.Append("")
		    If Request.Method = "GET" Then
		      Lines.Append("$auth = $method . chr(10) . $url;")
		    Else
		      If Request.Query <> "" Then
		        Lines.Append("$auth = $method . chr(10) . $url  . chr(10) . $body;")
		      Else
		        Lines.Append("$auth = $method . chr(10) . $url  . chr(10);")
		      End If
		    End If
		    Lines.Append("// Change Myself.beaconidentiy to point to your identity file!")
		    Lines.Append("$identity = json_decode(file_get_contents('Myself.beaconidentity'), true);")
		    Lines.Append("$username = $identity['Identifier'];")
		    Lines.Append("$private_key = $identity['Private'];")
		    Lines.Append("$private_key = trim(chunk_split(base64_encode(hex2bin($private_key)), 64, ""\n""));")
		    Lines.Append("$private_key = ""-----BEGIN RSA PRIVATE KEY-----\n$private_key\n-----END RSA PRIVATE KEY-----"";")
		    Lines.Append("openssl_sign($auth, $password, $private_key) or die('Unable to authenticate action');")
		  End If
		  
		  Lines.Append("")
		  Lines.Append("$http = curl_init();")
		  Lines.Append("curl_setopt($http, CURLOPT_URL, $url);")
		  Lines.Append("curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);")
		  If Request.Method <> "GET" Then
		    Lines.Append("curl_setopt($http, CURLOPT_CUSTOMREQUEST, $method);")
		    If Request.Query <> "" Then
		      Lines.Append("curl_setopt($http, CURLOPT_POSTFIELDS, $body);")
		    End If
		    If Request.ContentType <> "" Then
		      Lines.Append("curl_setopt($http, CURLOPT_HTTPHEADER, array('Content-Type: " + Request.ContentType.ReplaceAll("'", "\'") + "'));")
		    End If
		  End If
		  If Authenticated Then
		    Lines.Append("curl_setopt($http, CURLOPT_USERPWD, $username . ':' . bin2hex($password));")
		  End If
		  Lines.Append("$response = curl_exec($http);")
		  Lines.Append("$http_status = curl_getinfo($http, CURLINFO_HTTP_CODE);")
		  Lines.Append("curl_close($http);")
		  
		  Return Text.Join(Lines, EOL)
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events MethodMenu
	#tag Event
		Sub Change()
		  BodyField.Enabled = Me.ListIndex > 0
		  BodyLabel.Enabled = BodyField.Enabled
		  ContentTypeField.Enabled = BodyField.Enabled
		  ContentTypeLabel.Enabled = BodyField.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BuildButton
	#tag Event
		Sub Action()
		  Dim Path As Text = PathField.Text.ToText
		  Dim Method As Text = MethodMenu.Text.ToText
		  Dim Body As Text = BodyField.Text.ToText
		  Dim ContentType As Text = ContentTypeField.Text.ToText
		  
		  Dim Request As BeaconAPI.Request
		  Try
		    If BodyField.Enabled Then
		      Request = New BeaconAPI.Request(Path, Method, Body, ContentType, AddressOf APICallback_DoNothing)
		    Else
		      Request = New BeaconAPI.Request(Path, Method, AddressOf APICallback_DoNothing)
		    End If
		    If AuthenticatedCheck.Value Then
		      Request.Sign(App.Identity)
		    End If
		  Catch Err As UnsupportedOperationException
		    Self.ShowAlert("Cannot build the request", Err.Reason)
		    Return
		  End Try
		  
		  Select Case FormatMenu.ListIndex
		  Case 0
		    CodeField.Text = Self.BuildCURLCode(Request)
		  Case 1
		    CodeField.Text = Self.BuildPHPCode(Request)
		  Case 2
		    CodeField.Text = Self.BuildHTTPCode(Request)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
