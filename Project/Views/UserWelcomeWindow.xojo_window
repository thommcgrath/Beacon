#tag Window
Begin Window UserWelcomeWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   True
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   ""
   Visible         =   True
   Width           =   400
   Begin BeaconWebView ContentView
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   600
      HelpTag         =   ""
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Renderer        =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Visible         =   True
      Width           =   400
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  If App.Identity = Nil Then
		    Quit
		  Else
		    App.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.mBaseURL = Beacon.WebURL("inapp/")
		  Dim File As String = "welcome.php"
		  If Self.mLoginOnly Then
		    File = File + "?login_only=true"
		  Else
		    Preferences.OnlineEnabled = False
		  End If
		  Self.ContentView.LoadURL(Self.mBaseURL + File)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_CreateSession(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  #Pragma Unused Message
		  
		  If Success Then
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Details
		      Dim Token As Text = Dict.Value("session_id")
		      Preferences.OnlineToken = Token
		      Preferences.OnlineEnabled = True
		      Self.Close()
		    Catch Err As RuntimeException
		      If Self.ShowConfirm("Something went wrong while saving your authentication token.", "Would you like to try again?", "Try Again", "Cancel") Then
		        Self.ObtainToken()
		      Else
		        Self.Close()
		      End If
		    End Try
		  Else
		    If Self.ShowConfirm("Beacon was unable to authenticate with the cloud.", "Would you like to try again?", "Try Again", "Cancel") Then
		      Self.ObtainToken()
		    Else
		      Self.Close()
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_GetCurrentUser(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  If Success Then
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Identity As Beacon.Identity = Beacon.Identity.FromUserDictionary(Dict, Self.mUserPassword.ToText)
		    If Identity <> Nil Then
		      Preferences.OnlineToken = Self.mUserToken.ToText
		      Preferences.OnlineEnabled = True
		      
		      If App.Identity <> Nil And App.Identity.Identifier <> Identity.Identifier And Identity.LoginKey <> "" Then
		        // merge old identity
		        Dim OldIdentity As Beacon.Identity = App.Identity
		        App.Identity = Identity
		        
		        Dim SignedValue As Text = Beacon.CreateUUID
		        Dim Signature As Text = Beacon.EncodeHex(OldIdentity.Sign(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(SignedValue)))
		        
		        Dim MergeKeys As New Xojo.Core.Dictionary
		        MergeKeys.Value("user_id") = OldIdentity.Identifier
		        MergeKeys.Value("login_key") = Identity.LoginKey
		        MergeKeys.Value("signed_value") = SignedValue
		        MergeKeys.Value("signature") = Signature
		        
		        Dim Request As New BeaconAPI.Request("user.php", "POST", Xojo.Data.GenerateJSON(MergeKeys), "application/json", AddressOf APICallback_MergeUser)
		        Request.Authenticate(Preferences.OnlineToken)
		        BeaconAPI.Send(Request)
		      Else
		        App.Identity = Identity
		        Self.Close
		      End If
		      Return
		    End If
		  End If
		  
		  Self.ShowAlert("Beacon was unable to download your user details.", Message)
		  App.Identity = New Beacon.Identity
		  Self.Close()
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_MergeUser(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  #Pragma Unused Success
		  #Pragma Unused Message
		  #Pragma Unused Details
		  
		  Self.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_UserSave(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  Try
		    If Success = False And Details IsA Xojo.Core.Dictionary Then
		      Dim Dict As Xojo.Core.Dictionary = Details
		      Dim PublicKey As Text = Dict.Value("public_key")
		      Dim UserID As Text = Dict.Value("user_id")
		      
		      If App.Identity.Identifier = UserID And App.Identity.PublicKey = PublicKey Then
		        Success = True
		      End If
		    End If
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  If Success Then
		    Self.ObtainToken()
		  Else
		    Self.ShowAlert("Beacon was unable to create a user with the cloud. For now, online features are disabled.", Message)
		    Self.Close()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(LoginOnly As Boolean = False)
		  Self.mLoginOnly = LoginOnly
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleAnonymous()
		  If App.Identity = Nil Then
		    App.Identity = New Beacon.Identity
		  End If
		  
		  Dim Params As New Xojo.Core.Dictionary
		  Params.Value("user_id") = App.Identity.Identifier
		  Params.Value("public_key") = App.Identity.PublicKey
		  
		  Dim Body As Text = Xojo.Data.GenerateJSON(Params)
		  Dim Request As New BeaconAPI.Request("user.php", "POST", Body, "application/json", AddressOf APICallback_UserSave)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDisableOnline()
		  If App.Identity = Nil Then
		    App.Identity = New Beacon.Identity
		  End If
		  Self.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ObtainToken()
		  Dim Request As New BeaconAPI.Request("session.php", "POST", "", "text/plain", AddressOf APICallback_CreateSession)
		  Request.Sign(App.Identity)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginOnly As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserToken As String
	#tag EndProperty


#tag EndWindowCode

#tag Events ContentView
	#tag Event
		Function CancelLoad(URL as String) As Boolean
		  If URL.Left(Self.mBaseURL.Len) = Self.mBaseURL Then
		    Return False
		  End If
		  If Not Beacon.IsBeaconURL(URL) Then
		    ShowURL(URL)
		    Return True
		  End If
		  
		  Dim Pos As Integer = URL.InStr("?")
		  Dim Path, Query As String
		  If Pos > 0 Then
		    Path = URL.Left(Pos - 1)
		    Query = URL.Mid(Pos + 1)
		  Else
		    Path = URL
		  End If
		  
		  Pos = Query.InStr("#")
		  If Pos > 0 Then
		    Query = Query.Left(Pos - 1)
		  End If
		  
		  Dim Params As New Dictionary
		  Dim Parts() As String = Split(Query, "&")
		  For Each Part As String In Parts
		    Pos = Part.InStr("=")
		    Dim Key As String = DecodeURLComponent(Part.Left(Pos - 1)).DefineEncoding(Encodings.UTF8)
		    Dim Value As String = DecodeURLComponent(Part.Mid(Pos + 1)).DefineEncoding(Encodings.UTF8)
		    Params.Value(Key) = Value
		  Next
		  
		  Select Case Path
		  Case "set_user_privacy"
		    Dim Action As String = Params.Lookup("action", "full") // err on the side of privacy
		    Select Case Action
		    Case "anonymous"
		      Self.HandleAnonymous()
		    Case "full"
		      Self.HandleDisableOnline()
		    Case "none"
		    Else
		    End Select
		  Case "set_user_token"
		    Self.mUserToken = Params.Lookup("token", "")
		    Self.mUserPassword = Params.Lookup("password", "")
		    
		    Dim Request As New BeaconAPI.Request("user.php", "GET", "", "text/plain", AddressOf APICallback_GetCurrentUser)
		    Request.Authenticate(Self.mUserToken.ToText)
		    BeaconAPI.Send(Request)
		  Case "dismiss_me"
		    Self.Close()
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Error(errorNumber as Integer, errorMessage as String)
		  App.Log("UserWelcomeWindow.ContentView.Error " + Str(ErrorNumber) + ": " + ErrorMessage)
		  If App.Identity = Nil Then
		    App.Identity = New Beacon.Identity
		  End If
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
