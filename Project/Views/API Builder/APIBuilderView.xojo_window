#tag DesktopWindow
Begin BeaconSubview APIBuilderView
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   460
   HelpTag         =   ""
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
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   1100
   Begin DesktopCheckBox AuthenticatedCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Authenticated"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   198
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   267
   End
   Begin DesktopTextArea BodyField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   66
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel BodyLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   False
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Body:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPushButton BuildButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Build"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   272
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
   End
   Begin DesktopTextArea CodeField
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
      Height          =   178
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
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
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   262
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel CodeLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Code:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   262
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedTextField ContentTypeField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   127
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
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   164
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   267
   End
   Begin UITweaks.ResizedLabel ContentTypeLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   False
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Content Type:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   164
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPopupMenu FormatMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "cURL\nPHP\nHTTP"
      Italic          =   False
      Left            =   127
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   133
   End
   Begin UITweaks.ResizedLabel LanguageLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Language:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   230
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedLabel MethodLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Method:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
   Begin UITweaks.ResizedPopupMenu MethodMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "GET\nPOST\nDELETE"
      Italic          =   False
      Left            =   127
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   133
   End
   Begin UITweaks.ResizedTextField PathField
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
      Left            =   127
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   953
   End
   Begin UITweaks.ResizedLabel PathLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Path:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   95
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.ViewTitle = "API Builder"
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
		  Var Cmd As String = "curl"
		  If Request.Method <> "GET" Then
		    Cmd = Cmd + " --request '" + Request.Method + "'"
		    If Request.Query <> "" Then
		      Cmd = Cmd + " --data '" + Request.Query + "'"
		    End If
		    If Request.ContentType <> "" Then
		      Cmd = Cmd + " --header 'Content-Type: " + Request.ContentType + "'"
		    End If
		  End If
		  Var Headers() As String
		  For Each Header As String In Headers
		    Cmd = Cmd + " --header '" + Header.ReplaceAll("'", "\'") + ": " + Request.RequestHeader(Header).ReplaceAll("'", "\'") + "'"
		  Next
		  Cmd = Cmd + " " + Request.URL
		  If Request.Method = "GET" And Request.Query <> "" Then
		    Cmd = Cmd + "?" + Request.Query
		  End If
		  Return Cmd
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildHTTPCode(Request As BeaconAPI.Request) As String
		  Var StringEOL As String = EndOfLine
		  Var EOL As String = StringEOL // Really hate that it takes 2 lines of code to do this
		  
		  Var URL As String = Request.URL
		  Var SchemeEnd As Integer = URL.IndexOf("://")
		  URL = URL.Middle(SchemeEnd + 3)
		  
		  Var HostEnd As Integer = URL.IndexOf("/")
		  Var Host As String = URL.Left(HostEnd)
		  Var Path As String = URL.Middle(HostEnd)
		  
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      Path = Path + "?" + Request.Query
		    End If
		  End If
		  
		  Var Lines() As String
		  Lines.Add(Request.Method + " " + Path + " HTTP/1.1")
		  Lines.Add("Host: " + Host)
		  
		  Var Headers() As String
		  For Each Header As String In Headers
		    Lines.Add(Header + ": " + Request.RequestHeader(Header))
		  Next
		  
		  If Request.Method <> "GET" Then
		    If Request.ContentType <> "" Then
		      Lines.Add("Content-Type: " + Request.ContentType)
		    End If
		    Lines.Add("")
		    Lines.Add(Request.Query)
		  End If
		  
		  Return Lines.Join(EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildPHPCode(Request As BeaconAPI.Request) As String
		  #Pragma Warning "Needs updating"
		  
		  Var EOL As String = EndOfLine
		  Var Authenticated As Boolean = Request.RequiresAuthentication
		  
		  Var Lines() As String
		  
		  Var URL As String = Request.URL
		  If Request.Method = "GET" Then
		    If Request.Query <> "" Then
		      URL = URL + "?" + Request.Query
		    End If
		  End If
		  Lines.Add("$url = '" + URL.ReplaceAll("'", "\'") + "';")
		  
		  If Authenticated Or Request.Method <> "GET" Then
		    Lines.Add("$method = '" + Request.Method.ReplaceAll("'", "\'").Uppercase + "';")
		  End If
		  
		  If Request.Method <> "GET" And Request.Query <> "" Then
		    Lines.Add("$body = '" + Request.Query.ReplaceAll("'", "\'") + "';")
		  End If
		  
		  If Authenticated Then
		    Lines.Add("")
		    If Request.Method = "GET" Then
		      Lines.Add("$auth = $method . Encodings.UTF8.Chr(10) . $url;")
		    Else
		      If Request.Query <> "" Then
		        Lines.Add("$auth = $method . Encodings.UTF8.Chr(10) . $url  . Encodings.UTF8.Chr(10) . $body;")
		      Else
		        Lines.Add("$auth = $method . Encodings.UTF8.Chr(10) . $url  . Encodings.UTF8.Chr(10);")
		      End If
		    End If
		    Lines.Add("// Change Myself.beaconidentiy to point to your identity file!")
		    Lines.Add("$identity = json_decode(file_get_contents('Myself.beaconidentity'), true);")
		    Lines.Add("$username = $identity['Identifier'];")
		    Lines.Add("$private_key = $identity['Private'];")
		    Lines.Add("$private_key = trim(chunk_split(base64_encode(hex2bin($private_key)), 64, ""\n""));")
		    Lines.Add("$private_key = ""-----BEGIN RSA PRIVATE KEY-----\n$private_key\n-----END RSA PRIVATE KEY-----"";")
		    Lines.Add("openssl_sign($auth, $password, $private_key) or die('Unable to authenticate action');")
		  End If
		  
		  Lines.Add("")
		  Lines.Add("$http = curl_init();")
		  Lines.Add("curl_setopt($http, CURLOPT_URL, $url);")
		  Lines.Add("curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);")
		  If Request.Method <> "GET" Then
		    Lines.Add("curl_setopt($http, CURLOPT_CUSTOMREQUEST, $method);")
		    If Request.Query <> "" Then
		      Lines.Add("curl_setopt($http, CURLOPT_POSTFIELDS, $body);")
		    End If
		    If Request.ContentType <> "" Then
		      Lines.Add("curl_setopt($http, CURLOPT_HTTPHEADER, array('Content-Type: " + Request.ContentType.ReplaceAll("'", "\'") + "'));")
		    End If
		  End If
		  If Authenticated Then
		    Lines.Add("curl_setopt($http, CURLOPT_USERPWD, $username . ':' . bin2hex($password));")
		  End If
		  Lines.Add("$response = curl_exec($http);")
		  Lines.Add("$http_status = curl_getinfo($http, CURLINFO_HTTP_CODE);")
		  Lines.Add("curl_close($http);")
		  
		  Return Lines.Join(EOL)
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events BuildButton
	#tag Event
		Sub Pressed()
		  Var Path As String = PathField.Text
		  Var Method As String = MethodMenu.SelectedRowValue
		  Var Body As String = BodyField.Text
		  Var ContentType As String = ContentTypeField.Text
		  
		  Var Request As BeaconAPI.Request
		  Try
		    If BodyField.Enabled Then
		      Request = New BeaconAPI.Request(Path, Method, Body, ContentType, AddressOf APICallback_DoNothing)
		    Else
		      Request = New BeaconAPI.Request(Path, Method, AddressOf APICallback_DoNothing)
		    End If
		    Request.RequiresAuthentication = AuthenticatedCheck.Value
		  Catch Err As RuntimeException
		    Self.ShowAlert("Cannot build the request", Err.Message)
		    Return
		  End Try
		  
		  Select Case FormatMenu.SelectedRowIndex
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
#tag Events MethodMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  BodyField.Enabled = Me.SelectedRowIndex > 0
		  BodyLabel.Enabled = BodyField.Enabled
		  ContentTypeField.Enabled = BodyField.Enabled
		  ContentTypeLabel.Enabled = BodyField.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
