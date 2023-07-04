#tag DesktopWindow
Begin ArkConfigEditor ArkAccountsEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   508
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
   Width           =   784
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   ""
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
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   1
      Height          =   467
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Provider	Status"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   784
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   784
   End
   Begin Timer RefreshWatchTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub SetupUI()
		  Var Selected() As String
		  For I As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(I) Then
		      Selected.Add(Self.List.RowTagAt(I).StringValue)
		    End If
		  Next
		  
		  Var TokenIds() As String = Self.Project.ProviderTokenIds
		  Var Profiles() As Beacon.ServerProfile = Self.Project.ServerProfiles
		  Self.List.RowCount = TokenIds.Count
		  
		  Var UsageCounts As New Dictionary
		  For Each Profile As Beacon.ServerProfile In Profiles
		    UsageCounts.Value(Profile.ProviderTokenId) = UsageCounts.Lookup(Profile.ProviderTokenId, 0) + 1
		  Next
		  
		  Var IsRefreshing As Boolean = Self.IsRefreshing
		  For RowIdx As Integer = 0 To TokenIds.LastIndex
		    Var TokenId As String = TokenIds(RowIdx)
		    Self.List.RowTagAt(RowIdx) = TokenId
		    
		    If Self.mTokens.HasKey(TokenId) Then
		      Var Token As BeaconAPI.ProviderToken = Self.mTokens.Value(TokenId)
		      Var UsedCount As Integer = UsageCounts.Lookup(Token.TokenId, 0)
		      
		      Self.List.CellTextAt(RowIdx, Self.ColumnLabel) = Token.Label(BeaconAPI.ProviderToken.DetailNormal)
		      Self.List.CellTextAt(RowIdx, Self.ColumnProvider) = Token.Provider
		      If Token.IsEncrypted Then
		        Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = "Error: Decryption key is incorrect"
		      ElseIf UsedCount = 0 Then
		        Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = "Unused"
		      Else
		        Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = "Used by " + Language.NounWithQuantity(UsedCount, "server", "servers")
		      End If
		    Else
		      Self.List.CellTextAt(RowIdx, Self.ColumnLabel) = TokenId
		      Self.List.CellTextAt(RowIdx, Self.ColumnProvider) = ""
		      Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = If(IsRefreshing, "Loading…", "Service not found")
		    End If
		  Next
		  
		  Self.List.Sort
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused UserData
		  #Pragma Unused FireSetupUI
		  
		  If Self.mNextRefresh Is Nil Or Self.mNextRefresh < DateTime.Now Then
		    Self.RefreshTokensList()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project)
		  Self.mTokens = New Dictionary
		  Super.Constructor(Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FetchToken(TokenId As String)
		  Var FetchThread As New Beacon.Thread
		  AddHandler FetchThread.Run, AddressOf Thread_FetchToken
		  AddHandler FetchThread.UserInterfaceUpdate, AddressOf Thread_UserInterfaceUpdate
		  FetchThread.UserData = TokenId
		  FetchThread.Start
		  Self.mThreads.Add(FetchThread)
		  Self.RefreshWatchTimer.RunMode = Timer.RunModes.Multiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FetchUserTokens(Silent As Boolean)
		  Var FetchThread As New Beacon.Thread
		  AddHandler FetchThread.Run, AddressOf Thread_FetchTokens
		  AddHandler FetchThread.UserInterfaceUpdate, AddressOf Thread_UserInterfaceUpdate
		  FetchThread.UserData = Silent
		  FetchThread.Start
		  Self.mThreads.Add(FetchThread)
		  Self.RefreshWatchTimer.RunMode = Timer.RunModes.Multiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameAccountsPsuedo
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRefreshing() As Boolean
		  For Idx As Integer = 0 To Self.mThreads.LastIndex
		    If Self.mThreads(Idx).ThreadState = Thread.ThreadStates.Running Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshTokensList()
		  Var TokenIds() As String = Self.Project.ProviderTokenIds
		  For Each TokenId As String In TokenIds
		    Self.FetchToken(TokenId)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_FetchToken(Sender As Beacon.Thread)
		  Var UpdateDict As New Dictionary("finished": true)
		  
		  Try
		    Var TokenId As String = Sender.UserData
		    Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(TokenId)
		    If (Token Is Nil) = False Then
		      UpdateDict.Value("token") = Token
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Fetching provider token.")
		  End Try
		  
		  Sender.AddUserInterfaceUpdate(UpdateDict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_FetchTokens(Sender As Beacon.Thread)
		  Var UpdateDict As New Dictionary("finished": true)
		  Try
		    UpdateDict.Value("silent") = Sender.UserData
		  Catch Err As RuntimeException
		  End Try
		  
		  Var User As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  If (User Is Nil) = False Then
		    Var Tokens() As BeaconAPI.ProviderToken = BeaconAPI.GetProviderTokens(User.UserId)
		    UpdateDict.Value("tokens") = Tokens
		  End If
		  
		  Sender.AddUserInterfaceUpdate(UpdateDict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasKey("tokens") Then
		        Var Tokens() As BeaconAPI.ProviderToken = Update.Value("tokens")
		        Var HadTokens As Boolean = Tokens.Count > 0
		        Var Silent As Boolean = Sender.UserData
		        For Idx As Integer = Tokens.LastIndex DownTo 0
		          If Self.Project.ProviderTokenKey(Tokens(Idx).TokenId).IsEmpty = False Then
		            // This token is alread linked to the project
		            Tokens.RemoveAt(Idx)
		          End If
		        Next
		        
		        If Tokens.Count = 0 Then
		          // No existing tokens to link
		          If Silent = False And HadTokens And Self.ShowConfirm("All your services are already added to this project.", "Would you link to connect a new service to your Beacon account?", "Connect", "Cancel") Then
		            System.GotoURL(Beacon.WebURL("/account/#oauth", True))
		          End If
		        Else
		          // Present link ui
		          Var NewLink As BeaconAPI.ProviderToken = ArkLinkAccountDialog.Present(Self, Tokens)
		          If (NewLink Is Nil) = False Then
		            If NewLink.IsEncrypted = False Then
		              Self.Project.ProviderTokenKey(NewLink.TokenId) = DecodeBase64(NewLink.EncryptionKey)
		              Self.mTokens.Value(NewLink.TokenId) = NewLink
		              Self.Modified = True
		              Self.SetupUI()
		            Else
		              Break
		            End If
		          End If
		        End If
		      End If
		      
		      If Update.HasKey("token") Then
		        Var Token As BeaconAPI.ProviderToken = Update.Value("token")
		        If Token.IsEncrypted Then
		          Var Key As String = Self.Project.ProviderTokenKey(Token.TokenId)
		          Call Token.Decrypt(Key)
		        End If
		        Self.mTokens.Value(Token.TokenId) = Token
		        Self.SetupUI()
		      End If
		      
		      If Update.Lookup("finished", False) = True Then
		        For Idx As Integer = Self.mThreads.LastIndex DownTo 0
		          If Self.mThreads(Idx) = Sender Then
		            Self.mThreads.RemoveAt(Idx)
		            Exit For Idx
		          End If
		        Next
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Handling token fetch response")
		    End Try
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mNextRefresh As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreads() As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokens As Dictionary
	#tag EndProperty


	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnProvider, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnStatus, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.LastRowIndex
		  Var TokenIds(), ServiceNames() As String
		  For I As Integer = 0 To Bound
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Var TokenId As String = Me.RowTagAt(I)
		    TokenIds.Add(TokenId)
		    If Self.mTokens.HasKey(TokenId) Then
		      ServiceNames.Add(BeaconAPI.ProviderToken(Self.mTokens.Value(TokenId)).Label(BeaconAPI.ProviderToken.DetailLow))
		    Else
		      ServiceNames.Add(Me.CellTextAt(I, Self.ColumnLabel))
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(ServiceNames, "service", "services") = False Then
		    Return
		  End If
		  
		  For Each TokenId As String In TokenIds
		    Self.Project.RemoveProviderTokenKey(TokenId)
		    Self.Modified = True
		    If Self.mTokens.HasKey(TokenId) THen
		      Self.mTokens.Remove(TokenId)
		    End If
		  Next
		  
		  Self.SetupUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("NewAccount", "Add Service", IconToolbarAdd, "Add a service to this project.", True))
		  Me.Append(OmniBarItem.CreateSpace)
		  Me.Append(OmniBarItem.CreateButton("Refresh", "Refresh", IconToolbarRefresh, "Refresh the services list.", True))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  If Item Is Nil Then
		    Return
		  End If
		  
		  Select Case Item.Name
		  Case "NewAccount"
		    Self.FetchUserTokens(False)
		  Case "Refresh"
		    Self.RefreshTokensList()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshWatchTimer
	#tag Event
		Sub Action()
		  If Self.IsRefreshing Then
		    If (Self.LinkedOmniBarItem Is Nil) = False And Self.LinkedOmniBarItem.HasProgressIndicator = False Then
		      Self.LinkedOmniBarItem.HasProgressIndicator = True
		      Self.LinkedOmniBarItem.Progress = OmniBarItem.ProgressIndeterminate
		    End If
		    
		    Var LinkButton As OmniBarItem = Self.ConfigToolbar.Item("NewAccount")
		    If (LinkButton Is Nil) = False And LinkButton.Enabled = True Then
		      LinkButton.Enabled = False
		    End If
		    
		    Var RefreshButton As OmniBarItem = Self.ConfigToolbar.Item("Refresh")
		    If (RefreshButton Is Nil) = False And RefreshButton.Enabled = True Then
		      RefreshButton.Enabled = False
		    End If
		    
		    Return
		  End If
		  
		  Me.RunMode = Timer.RunModes.Off
		  Self.mNextRefresh = DateTime.Now + New DateInterval(0, 0, 0, 1, 0, 0, 0)
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False And Self.LinkedOmniBarItem.HasProgressIndicator = True Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = False
		  End If
		  
		  Var LinkButton As OmniBarItem = Self.ConfigToolbar.Item("NewAccount")
		  If (LinkButton Is Nil) = False And LinkButton.Enabled = False Then
		    LinkButton.Enabled = True
		  End If
		  
		  Var RefreshButton As OmniBarItem = Self.ConfigToolbar.Item("Refresh")
		  If (RefreshButton Is Nil) = False And RefreshButton.Enabled = False Then
		    RefreshButton.Enabled = True
		  End If
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
#tag EndViewBehavior
