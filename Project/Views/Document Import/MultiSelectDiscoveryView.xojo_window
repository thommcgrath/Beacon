#tag DesktopWindow
Begin DiscoveryView MultiSelectDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   480
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
   Width           =   720
   Begin Thread TokenLookupThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin DesktopButton TokensRefreshButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Refresh"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   7
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -48
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel ListMessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Select Servers"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   680
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   4
      ColumnWidths    =   "26,*,170,170"
      DefaultRowHeight=   "#BeaconListbox.StandardRowHeight"
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   360
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Name	Address	Platform"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   680
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopProgressWheel TokensRefreshSpinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   442
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel TokensRefreshLabel
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
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Authorizing…"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   440
      Transparent     =   False
      Underline       =   False
      Visible         =   False
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   528
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   440
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Next"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   440
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 480
		  Self.RefreshTokens()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Busy() As Boolean
		  Return Self.mPendingListActions > 0 Or Self.mFetchingTokens = True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mThreads = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Discovered(Profiles() As Beacon.ServerProfile)
		  Self.mPendingListActions = Self.mPendingListActions - 1
		  
		  For Each Profile As Beacon.ServerProfile In Profiles
		    Var PlatformText As String = "Unknown"
		    Select Case Profile.Platform
		    Case Beacon.PlatformPC
		      PlatformText = "Steam & Epic"
		    Case Beacon.PlatformPlayStation
		      PlatformText = "PlayStation"
		    Case Beacon.PlatformSwitch
		      PlatformText = "Switch"
		    Case Beacon.PlatformXbox
		      PlatformText = "Xbox & Windows Store"
		    End Select
		    
		    Self.List.AddRow("", Profile.Name, Profile.SecondaryName, PlatformText)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Profile
		  Next
		  
		  If Self.Busy = False And Self.List.RowCount = 0 Then
		    Self.ShowAlert("No eligible servers were found", "Beacon could not find any " + Language.GameName(Self.GameId()) + " servers on any of the connected " + Self.ProviderName + " accounts.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  Var AllSamePlatform As Boolean = True
		  Var PlatformText As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If PlatformText.IsEmpty Then
		      PlatformText = Self.List.CellTextAt(Idx, 3)
		      Continue
		    End If
		    
		    If PlatformText <> Self.List.CellTextAt(Idx, 3) Then
		      AllSamePlatform = False
		      Exit For Idx
		    End If
		  Next
		  
		  If AllSamePlatform Then
		    Self.List.ColumnAttributesAt(3).WidthExpression = "0"
		  Else
		    Self.List.SizeColumnToFit(3)
		  End If
		  Self.List.SizeColumnToFit(2)
		  
		  Self.List.SortingColumn = 1
		  Self.List.Sort
		  Self.UpdateUI()
		  
		  If Self.Busy = False And Self.TrueWindow IsA BeaconWindow Then
		    BeaconWindow(Self.TrueWindow).BringToFront()
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Error(Err As RuntimeException)
		  Self.mPendingListActions = Self.mPendingListActions - 1
		  Self.ShowAlert("Unable to retrieve server list from " + Self.ProviderName, "The error message provided was:" + EndOfLine + EndOfLine + Err.Message + EndOfLine + EndOfLine + "This error may be temporary, so try again in a few minutes. If the problem persists, make sure your antivirus or malware protection is not blocking Beacon from contacting " + Self.ProviderName + "'s servers.")
		  Self.ShouldCancel()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListServers(Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig
		  Select Case Token.Provider
		  Case Nitrado.Identifier
		    Config = New Nitrado.HostConfig
		    Nitrado.HostConfig(Config).TokenId = Token.TokenId
		  Case GameServerApp.Identifier
		    Config = New GameServerApp.HostConfig
		    GameServerApp.HostConfig(Config).TokenId = Token.TokenId
		  End Select
		  
		  Var Thread As New Beacon.Thread
		  Thread.UserData = Config
		  AddHandler Thread.Run, WeakAddressOf Thread_Run
		  Self.mThreads.Value(Token.TokenId) = Thread
		  Thread.Start
		  Self.mPendingListActions = Self.mPendingListActions + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshTokens()
		  Self.List.RemoveAllRows()
		  Self.mFetchingTokens = False
		  Self.mPendingListActions = 0
		  Self.mCancelled = False
		  
		  Self.TokenLookupThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldCancel()
		  Self.mCancelled = True
		  Super.ShouldCancel()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Run(Sender As Beacon.Thread)
		  Try
		    Var Config As Beacon.HostConfig = Sender.UserData
		    Var Profiles() As Beacon.ServerProfile = Self.Provider.ListServers(Nil, Config, Self.GameId())
		    Var Dict As New Dictionary
		    Dict.Value("Event") = "Finished"
		    Dict.Value("Profiles") = Profiles
		    Sender.AddUserInterfaceUpdate(Dict)
		  Catch Err As RuntimeException
		    Var Dict As New Dictionary
		    Dict.Value("Event") = "Error"
		    Dict.Value("Error") = Err
		    Sender.AddUserInterfaceUpdate(Dict)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasKey("Event") Then
		        Select Case Update.Value("Event")
		        Case "Finished"
		          Var Profiles() As Beacon.ServerProfile = Update.Value("Profiles")
		          Self.Discovered(Profiles)
		        Case "Error"
		          Var DiscoveryError As RuntimeException = Update.Value("Error")
		          Self.Error(DiscoveryError)
		        End Select
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Processing discovery thread interface update")
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Var Refreshing As Boolean = Self.Busy
		  If Self.TokensRefreshLabel.Visible <> Refreshing Then
		    Self.TokensRefreshLabel.Visible = Refreshing
		  End If
		  If Self.TokensRefreshSpinner.Visible <> Refreshing Then
		    Self.TokensRefreshSpinner.Visible = Refreshing
		  End If
		  If Self.TokensRefreshButton.Visible = Refreshing Then
		    Self.TokensRefreshButton.Visible = Not Refreshing
		  End If
		  
		  Var ActionEnabled As Boolean
		  If Refreshing Then
		    Var RefreshLabel As String
		    If Self.mFetchingTokens Then
		      RefreshLabel = "Retrieving " + Self.ProviderName + " tokens…"
		    Else
		      RefreshLabel = "Listing servers on " + Language.NounWithQuantity(Self.mPendingListActions, Self.ProviderName + " account", Self.ProviderName + " accounts") + "…"
		    End If
		    
		    If Self.TokensRefreshLabel.Text <> RefreshLabel Then
		      Self.TokensRefreshLabel.Text = RefreshLabel
		    End If
		  Else
		    For I As Integer = 0 To Self.List.RowCount - 1
		      If Self.List.CellCheckBoxValueAt(I, 0) Then
		        ActionEnabled = True
		        Exit For I
		      End If
		    Next
		  End If
		  
		  If Self.ActionButton.Enabled <> ActionEnabled Then
		    Self.ActionButton.Enabled = ActionEnabled
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAddressColumnWidth As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFetchingTokens As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingListActions As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatformColumnWidth As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedServers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreads As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokens() As BeaconAPI.ProviderToken
	#tag EndProperty


#tag EndWindowCode

#tag Events TokenLookupThread
	#tag Event
		Sub Run()
		  If Self.Busy Then
		    Return
		  End If
		  Self.mFetchingTokens = True
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		  
		  Var UserId As String = App.IdentityManager.CurrentUserId
		  Var Tokens() As BeaconAPI.ProviderToken = BeaconAPI.GetProviderTokens(UserId)
		  Var Cache As New Dictionary
		  Var Provider As Beacon.HostingProvider = Self.Provider()
		  For Idx As Integer = Tokens.LastIndex DownTo 0
		    If Self.mCancelled Then
		      Return
		    End If
		    Cache.Value(Tokens(Idx).TokenId) = Tokens(Idx)
		    
		    If Provider.MatchProviderToken(Tokens(Idx)) Then
		      Self.ListServers(Tokens(Idx))
		      Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		    Else
		      Tokens.RemoveAt(Idx)
		    End If
		  Next
		  
		  Var TokenIds() As String = Self.Project.ProviderTokenIds
		  For Each TokenId As String In TokenIds
		    If Self.mCancelled Then
		      Return
		    End If
		    If Cache.HasKey(TokenId) Then
		      Continue
		    End If
		    
		    Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(TokenId)
		    If (Token Is Nil) = False And Provider.MatchProviderToken(Token) And Token.Decrypt(Self.Project.ProviderTokenKey(TokenId)) Then
		      Tokens.Add(Token)
		      Cache.Value(Token.TokenId) = Token
		      Self.ListServers(Token)
		      Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		    End If
		  Next
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mTokens = Tokens
		  Self.mFetchingTokens = False
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true, "Finished": true))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("UpdateUI", False).BooleanValue = True Then
		      Self.UpdateUI()
		    End If
		    If Update.Lookup("Finished", false).BooleanValue = True And Self.mTokens.Count = 0 Then
		      If Self.ShowConfirm("No " + Self.ProviderName + " services are available. Would you like to connect a " + Self.ProviderName + " account to your Beacon account?", "Your web browser will be opened so you can connect your accounts.", "Connect", "Cancel") Then
		        System.GotoURL(Beacon.WebURL("/account/#services", True))
		      End If
		      Self.ShouldCancel()
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TokensRefreshButton
	#tag Event
		Sub Pressed()
		  Self.RefreshTokens()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Top = Self.TokensRefreshLabel.Top
		  Me.Left = Self.TokensRefreshSpinner.Left
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Profiles() As Beacon.ServerProfile
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Profiles.Add(Self.List.RowTagAt(I))
		  Next
		  Self.ShouldFinish(Profiles)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
