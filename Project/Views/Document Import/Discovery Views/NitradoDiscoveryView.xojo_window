#tag Window
Begin DiscoveryView NitradoDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   400
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
   Width           =   600
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton FindingCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FindingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Finding Servers…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar FindingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Top             =   222
         Transparent     =   False
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin BeaconListbox List
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,200"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   296
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   " 	Name	Address"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label ListMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Select Servers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton ListCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ListActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin Beacon.OAuth2Client AuthClient
      Index           =   -2147483648
      LockedInPosition=   False
      Provider        =   ""
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer LookupStartTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 124
		  Self.LookupStartTimer.Mode = Timer.ModeSingle
		  Self.PagePanel1.Value = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetValuesFromDocument(Document As Beacon.Document)
		  Self.AuthClient.AuthData = Document.OAuthData("Nitrado")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AuthClient.Provider = Beacon.OAuth2Client.ProviderNitrado
		  Self.SwapButtons()
		  RaiseEvent Open
		  Self.CheckActionEnabled
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Dim ContentHeight As Integer = FindingLabel.Height + 12 + FindingProgress.Height
		  Dim AvailableHeight As Integer = Self.Height - (52 + FindingCancelButton.Height)
		  
		  Dim ContentTop As Integer = 20 + ((AvailableHeight - ContentHeight) / 2)
		  FindingLabel.Top = ContentTop
		  FindingProgress.Top = ContentTop + FindingLabel.Height + 12
		  
		  AvailableHeight = Self.Height - 40
		  ContentTop = 20 + ((AvailableHeight - ContentHeight) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Callback_ListServers(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  Select Case Status
		  Case 401
		    Self.ShowAlert("Nitrado API Error", "Authorization failed.")
		    Self.ShouldCancel()
		    Return
		  Case 429
		    Self.ShowAlert("Nitrado API Error", "The rate limit has been exceeded.")
		    Self.ShouldCancel()
		    Return
		  Case 503
		    Self.ShowAlert("Nitrado API Error", "Nitrado is currently offline for maintenance. Please try again later.")
		    Self.ShouldCancel()
		    Return
		  Case 200
		    // Good
		  Else
		    Self.ShowAlert("Nitrado API Error", "An unexpected error with the Nitrado API occurred. HTTP status " + Status.ToText + " was returned.")
		    Self.ShouldCancel()
		    Return
		  End Select
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      Self.ShowAlert("Nitrado API Error", "The request to list services was not successful.")
		      Self.ShouldCancel()
		      Return
		    End If
		    
		    Self.List.DeleteAllRows
		    
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim Services() As Auto = Data.Value("services")
		    For Each Service As Xojo.Core.Dictionary In Services
		      Dim Type As Text = Service.Value("type")
		      If Type <> "gameserver" Then
		        Continue
		      End If
		      
		      Dim Details As Xojo.Core.Dictionary = Service.Value("details")
		      Dim Game As Text = Details.Value("game")
		      If Not Game.BeginsWith("Ark: Survival Evolved") Then
		        Continue
		      End If
		      
		      Dim ServerName As Text = Details.Value("name")
		      If Service.Lookup("comment", Nil) <> Nil Then
		        ServerName = Service.Value("comment")
		      End If
		      
		      Dim Profile As New Beacon.NitradoServerProfile
		      Profile.Name = ServerName
		      Profile.Address = Details.Value("address")
		      Profile.ServiceID = Service.Value("id")
		      
		      Self.List.AddRow("", Profile.Name, Profile.Address)
		      Self.List.RowTag(Self.List.LastIndex) = Profile
		    Next
		    
		    Self.List.Sort
		    Self.DesiredHeight = 400
		    Self.PagePanel1.Value = 1
		  Catch Err As RuntimeException
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Err)
		    Self.ShowAlert("Nitrado API Error", "The Nitrado API responded in an unexpected manner. An unhandled " + Info.FullName + " was encountered.")
		    Self.ShouldCancel()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckActionEnabled()
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.CellCheck(I, 0) Then
		      Self.ListActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ListActionButton.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListServers()
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.AuthClient.AccessToken
		  
		  Dim URL As Text = "https://api.nitrado.net/services"
		  SimpleHTTP.Get(URL, AddressOf Callback_ListServers, Nil, Headers)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSelectedServers As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Structure, Name = MacVersionInfo, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		MajorVersion As Integer
		  MinorVersion As Integer
		BugVersion As Integer
	#tag EndStructure


#tag EndWindowCode

#tag Events FindingCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Self.List.ColumnType(0) = Listbox.TypeCheckbox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListActionButton
	#tag Event
		Sub Action()
		  Dim Engines() As Beacon.NitradoDiscoveryEngine
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Not Self.List.CellCheck(I, 0) Then
		      Continue
		    End If
		    
		    Dim Profile As Beacon.NitradoServerProfile = Self.List.RowTag(I)
		    Engines.Append(New Beacon.NitradoDiscoveryEngine(Profile, Self.AuthClient.AccessToken))
		  Next
		  Self.ShouldFinish(Engines, "Nitrado", Self.AuthClient.AuthData)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AuthClient
	#tag Event
		Sub Authenticated()
		  Self.ListServers()
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError()
		  Self.ShowAlert("Unable to communicate with Nitrado", "Sorry, the Nitrado API is not available at this time.")
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
	#tag Event
		Function ShowURL(URL As Text) As Beacon.WebView
		  #if TargetMacOS
		    Declare Function NSClassFromString Lib "Cocoa" (ClassName As CFStringRef) As Ptr
		    Declare Function GetProcessInfo Lib "Cocoa" Selector "processInfo" (Target As Ptr) As Ptr
		    Declare Function OperatingSystemVersion Lib "AppKit" Selector "operatingSystemVersion" (Target As Ptr) As MacVersionInfo
		    
		    Dim Info As Ptr = GetProcessInfo(NSClassFromString("NSProcessInfo"))
		    Dim Version As MacVersionInfo = OperatingSystemVersion(Info)
		    Dim ComboVersion As Integer = Val(Str(Version.MajorVersion, "000") + Str(Version.MinorVersion, "000") + Str(Version.BugVersion, "000"))
		    If ComboVersion < 10012000 Then
		      Return Nil
		    End If
		  #endif
		  
		  Return MiniBrowser.ShowURL(URL)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events LookupStartTimer
	#tag Event
		Sub Action()
		  Self.AuthClient.Authenticate()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
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
