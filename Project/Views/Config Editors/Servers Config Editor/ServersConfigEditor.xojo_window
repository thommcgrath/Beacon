#tag Window
Begin ConfigEditor ServersConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   506
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   856
   Begin BeaconListbox ServerList
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   40
      DefaultSortColumn=   0
      DefaultSortDirection=   1
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   0
      Height          =   465
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   299
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   506
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   299
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
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
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  Var Container As ServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedFrom()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused FireSetupUI
		  
		  Var Container As ServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function CopyMOTDToAllServers() As Boolean Handles CopyMOTDToAllServers.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Var CurrentProfileID As String = Self.CurrentProfileID
			If CurrentProfileID.IsEmpty Then
			Return True
			End If
			Self.CurrentProfileID = ""
			
			Var SourceProfile As Beacon.ServerProfile
			Var Bound As Integer = Self.Document.ServerProfileCount - 1
			For Idx As Integer = 0 To Bound
			If Self.Document.ServerProfile(Idx).ProfileID = CurrentProfileID Then
			SourceProfile = Self.Document.ServerProfile(Idx)
			Exit
			End If
			Next
			
			If SourceProfile Is Nil Then
			Self.CurrentProfileID = CurrentProfileID
			Return True
			End If
			
			Var Message As Beacon.ArkML = SourceProfile.MessageOfTheDay
			Var Duration As Integer = SourceProfile.MessageDuration
			
			For Idx As Integer = 0 To Bound
			If Self.Document.ServerProfile(Idx).ProfileID <> CurrentProfileID Then
			Self.Document.ServerProfile(Idx).MessageOfTheDay = Message.Clone
			Self.Document.ServerProfile(Idx).MessageDuration = Duration
			Self.Changed = Self.Changed Or Self.Document.Modified
			End If
			Next
			
			Self.CurrentProfileID = CurrentProfileID
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return "Servers"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  Self.mViews = New Dictionary
		  Super.Constructor(Controller)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleViewMenu(ItemRect As Rect)
		  Var Base As New MenuItem
		  
		  Var ViewFullNames As New MenuItem("Use Full Server Names", Self.ListNamesFull)
		  Var ViewAbbreviatedNames As New MenuItem("Use Abbreviated Server Names", Self.ListNamesAbbreviated)
		  Var SortByName As New MenuItem("Sort By Name", Self.ListSortByName)
		  Var SortByAddress As New MenuItem("Sort By Address", Self.ListSortByAddress)
		  Var SortByColor As New MenuItem("Sort By Color", Self.ListSortByColor)
		  ViewFullNames.HasCheckMark = Preferences.ServersListNameStyle = Self.ListNamesFull
		  ViewAbbreviatedNames.HasCheckMark = Preferences.ServersListNameStyle = Self.ListNamesAbbreviated
		  SortByName.HasCheckMark = Preferences.ServersListSortedValue = Self.ListSortByName
		  SortByAddress.HasCheckMark = Preferences.ServersListSortedValue = Self.ListSortByAddress
		  SortByColor.HasCheckMark = Preferences.ServersListSortedValue = Self.ListSortByColor
		  Base.AddMenu(ViewFullNames)
		  Base.AddMenu(ViewAbbreviatedNames)
		  Base.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  Base.AddMenu(SortByName)
		  Base.AddMenu(SortByAddress)
		  Base.AddMenu(SortByColor)
		  
		  Var Position As Point = Self.GlobalPosition
		  Var Choice As MenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		  If Choice Is Nil Then
		    Return
		  End If
		  
		  Select Case Choice
		  Case ViewFullNames, ViewAbbreviatedNames
		    Preferences.ServersListNameStyle = Choice.Tag.StringValue
		    Self.UpdateList()
		  Case SortByName, SortByAddress, SortByColor
		    Preferences.ServersListSortedValue = Choice.Tag.StringValue
		    Self.UpdateList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProfileNames() As Dictionary
		  Var Bound As Integer = Self.Document.ServerProfileCount - 1
		  Var Names() As String
		  Var Profiles() As Beacon.ServerProfile
		  Names.ResizeTo(Bound)
		  Profiles.ResizeTo(Bound)
		  For Idx As Integer = 0 To Bound
		    Var Profile As Beacon.ServerProfile = Self.Document.ServerProfile(Idx)
		    Names(Idx) = Profile.Name
		    Profiles(Idx) = Profile
		  Next Idx
		  If Preferences.ServersListNameStyle = Self.ListNamesAbbreviated Then
		    Names = Language.FilterServerNames(Names)
		  End If
		  
		  Var Lookup As New Dictionary
		  For Idx As Integer = 0 To Bound
		    Lookup.Value(Profiles(Idx).ProfileID) = If(Names(Idx).IsEmpty = False, Names(Idx), Profiles(Idx).Name)
		  Next Idx
		  Return Lookup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList()
		  // Updates the list, maintaining the current selection
		  
		  Var Profiles() As Beacon.ServerProfile
		  For Idx As Integer = 0 To Self.ServerList.LastRowIndex
		    If Self.ServerList.Selected(Idx) = False Then
		      Continue
		    End If
		    
		    Profiles.Add(Self.ServerList.RowTagAt(Idx))
		  Next
		  Self.UpdateList(Profiles, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList(SelectProfiles() As Beacon.ServerProfile, WithChangeEvent As Boolean)
		  Self.ServerList.SelectionChangeBlocked = True
		  Self.ServerList.RowCount = Self.Document.ServerProfileCount
		  
		  Var SelectIDs() As String
		  For Each Profile As Beacon.ServerProfile In SelectProfiles
		    If Profile Is Nil Then
		      Continue
		    End If
		    SelectIDs.Add(Profile.ProfileID)
		  Next
		  
		  Var SortBy As String = Preferences.ServersListSortedValue
		  Var AddressMatcher As New Regex
		  AddressMatcher.SearchPattern = "^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3}):(\d{1,5})$"
		  
		  Var Names As Dictionary = Self.ProfileNames()
		  For Idx As Integer = 0 To Self.ServerList.LastRowIndex
		    Var Profile As Beacon.ServerProfile = Self.Document.ServerProfile(Idx)
		    Var SortName As String = Names.Value(Profile.ProfileID)
		    Var Name As String = SortName + EndOfLine + Profile.ProfileID.Left(8) + "  " + Profile.SecondaryName
		    Var Selected As Boolean = SelectIDs.IndexOf(Profile.ProfileID) > -1
		    
		    Select Case SortBy
		    Case Self.ListSortByAddress
		      SortName = If(Profile.SecondaryName.IsEmpty = False, Profile.SecondaryName, SortName)
		      Var Matches As RegexMatch = AddressMatcher.Search(SortName)
		      If (Matches Is Nil) = False Then
		        Var First As Integer = Matches.SubExpressionString(1).ToInteger
		        Var Second As Integer = Matches.SubExpressionString(2).ToInteger
		        Var Third As Integer = Matches.SubExpressionString(3).ToInteger
		        Var Fourth As Integer = Matches.SubExpressionString(4).ToInteger
		        Var Port As Integer = Matches.SubExpressionString(5).ToInteger
		        SortName = First.ToString(Locale.Raw, "000") + "." + Second.ToString(Locale.Raw, "000") + "." + Third.ToString(Locale.Raw, "000") + "." + Fourth.ToString(Locale.Raw, "000") + ":" + Port.ToString(Locale.Raw, "00000")
		      End If
		    Case Self.ListSortByColor
		      SortName = "color" + CType(Profile.ProfileColor, Integer).ToString(Locale.Raw, "00") + ":" + SortName
		    End Select
		    
		    If Self.ServerList.CellValueAt(Idx, 0) <> Name Then
		      Self.ServerList.CellValueAt(Idx, 0) = Name
		    End If
		    If Self.ServerList.CellTagAt(Idx, 0) <> SortName Then
		      Self.ServerList.CellTagAt(Idx, 0) = SortName
		    End If
		    If Self.ServerList.RowTagAt(Idx) <> Profile Then
		      Self.ServerList.RowTagAt(Idx) = Profile
		    End If
		    If Self.ServerList.Selected(Idx) <> Selected Then
		      Self.ServerList.Selected(Idx) = Selected
		    End If
		  Next
		  Self.ServerList.Sort
		  Self.ServerList.SelectionChangeBlocked(WithChangeEvent) = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList(SelectProfile As Beacon.ServerProfile, WithChangeEvent As Boolean)
		  // Updates the list, selecting the requested profile
		  
		  Var Profiles(0) As Beacon.ServerProfile
		  Profiles(0) = SelectProfile
		  Self.UpdateList(Profiles, WithChangeEvent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_ContentsChanged(Sender As ServerViewContainer)
		  Self.Changed = Sender.Changed
		  Self.UpdateList()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldDeployProfiles(SelectedProfiles() As Beacon.ServerProfile)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentProfileID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentProfileID = Value Then
			    Return
			  End If
			  
			  If Self.mCurrentProfileID <> "" Then
			    Var View As ServerViewContainer = Self.mViews.Value(Self.mCurrentProfileID)
			    View.Visible = False
			    View.SwitchedFrom()
			    Self.mCurrentProfileID = ""
			  End If
			  
			  If Not Self.mViews.HasKey(Value) Then
			    Return
			  End If
			  
			  Var View As ServerViewContainer = Self.mViews.Value(Value)
			  View.SwitchedTo()
			  View.Visible = True
			  Self.mCurrentProfileID = Value
			End Set
		#tag EndSetter
		CurrentProfileID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViews.HasKey(Self.mCurrentProfileID) Then
			    Return ServerViewContainer(Self.mViews.Value(Self.mCurrentProfileID))
			  End If
			End Get
		#tag EndGetter
		CurrentView As ServerViewContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Dictionary
	#tag EndProperty


	#tag Constant, Name = ListNamesAbbreviated, Type = String, Dynamic = False, Default = \"abbreviated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListNamesFull, Type = String, Dynamic = False, Default = \"full", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListSortByAddress, Type = String, Dynamic = False, Default = \"address", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListSortByColor, Type = String, Dynamic = False, Default = \"color", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListSortByName, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub Change()
		  Select Case Me.SelectedRowCount
		  Case 0
		    Self.CurrentProfileID = ""
		    Return
		  Case 1
		    Var Profile As Beacon.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    Var ProfileID As String = Profile.ProfileID
		    If Not Self.mViews.HasKey(ProfileID) Then
		      // Create the view
		      Var View As ServerViewContainer
		      Select Case Profile
		      Case IsA Beacon.NitradoServerProfile
		        View = New NitradoServerView(Self.Document, Beacon.NitradoServerProfile(Profile))
		      Case IsA Beacon.FTPServerProfile
		        View = New FTPServerView(Self.Document, Beacon.FTPServerProfile(Profile))
		      Case IsA Beacon.ConnectorServerProfile
		        View = New ConnectorServerView(Beacon.ConnectorServerProfile(Profile))
		      Case IsA Beacon.LocalServerProfile
		        View = New LocalServerView(Self.Document, Beacon.LocalServerProfile(Profile))
		      Case IsA Beacon.GSAServerProfile
		        View = New GSAServerView(Self.Document, Beacon.GSAServerProfile(Profile))
		      Else
		        Self.CurrentProfileID = ""
		        Return
		      End Select
		      
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    Self.CurrentProfileID = ProfileID
		  Else
		    Var Profiles() As Beacon.ServerProfile
		    Var Parts() As String
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Not Me.Selected(Idx) Then
		        Continue
		      End If
		      
		      Profiles.Add(Me.RowTagAt(Idx))
		      Parts.Add(Profiles(Profiles.LastIndex).ProfileID)
		    Next
		    
		    Var ProfileID As String = Parts.Join(",")
		    If Not Self.mViews.HasKey(ProfileID) Then
		      Var View As New MultiServerView(Self.Document, Profiles)
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    
		    Self.CurrentProfileID = ProfileID
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var SelCount As Integer = Me.SelectedRowCount
		  If SelCount = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Var Subject As String = If(SelCount = 1, "server", "servers")
		    Var DemonstrativeAdjective As String = If(SelCount = 1, "this", "these " + SelCount.ToString)
		    If Not Self.ShowConfirm("Are you sure you want to delete " + DemonstrativeAdjective + " " + Subject + "?", "The " + Subject + " can be added again later using the ""Import"" feature next to the ""Config Type"" menu.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Me.LastRowIndex DownTo 0
		    If Me.Selected(I) Then
		      Var Profile As Beacon.ServerProfile = Me.RowTagAt(I)
		      If Self.mViews.HasKey(Profile.ProfileID) Then
		        If Self.CurrentProfileID = Profile.ProfileID Then
		          Self.CurrentProfileID = ""
		        End If
		        
		        Var Panel As ServerViewContainer = Self.mViews.Value(Profile.ProfileID)
		        Panel.Close
		        Self.mViews.Remove(Profile.ProfileID)
		      End If
		      Self.Document.Remove(Profile)
		      Self.Changed = True
		      Me.RemoveRowAt(I)
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var CopyProfileMenuItem As New MenuItem("Copy Profile ID")
		  CopyProfileMenuItem.Enabled = False
		  Base.AddMenu(CopyProfileMenuItem)
		  
		  Var DeployItem As MenuItem
		  If Me.SelectedRowCount > 1 Then
		    DeployItem = New MenuItem("Deploy These Servers…")
		  Else
		    DeployItem = New MenuItem("Deploy This Server…")
		  End If
		  Var DeployProfiles() As Beacon.ServerProfile
		  Var NitradoProfiles() As Beacon.NitradoServerProfile
		  Var LocalProfiles() As Beacon.LocalServerProfile
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Idx) = False Then
		      Continue
		    End If
		    Var Profile As Beacon.ServerProfile = Me.RowTagAt(Idx)
		    If Profile.DeployCapable Then
		      DeployProfiles.Add(Profile)
		    End If
		    If Profile IsA Beacon.NitradoServerProfile Then
		      NitradoProfiles.Add(Beacon.NitradoServerProfile(Profile))
		    End If
		    If Profile IsA Beacon.LocalServerProfile Then
		      LocalProfiles.Add(Beacon.LocalServerProfile(Profile))
		    End If
		  Next Idx
		  DeployItem.Enabled = DeployProfiles.Count > 0
		  DeployItem.Tag = DeployProfiles
		  Base.AddMenu(DeployItem)
		  
		  Var BackupsItem As New MenuItem("Show Config Backups")
		  Base.AddMenu(BackupsItem)
		  
		  If NitradoProfiles.Count > 0 Then
		    Base.AddMenu(New MenuItem("Open Nitrado Dashboard", NitradoProfiles))
		  End If
		  
		  If LocalProfiles.Count > 0 Then
		    #if Not TargetMacOS
		      // Sandbox prevents this from working on macOS
		      Base.AddMenu(New MenuItem("Show Config Files", LocalProfiles))
		    #endif
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var Profile As Beacon.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    CopyProfileMenuItem.Tag = Profile.ProfileID.Left(8)
		    CopyProfileMenuItem.Enabled = True
		    
		    BackupsItem.Tag = App.BackupsFolder.Child(Profile.BackupFolderName)
		  Else
		    BackupsItem.Tag = App.BackupsFolder
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  Select Case HitItem.Text
		  Case "Show Config Backups"
		    Var Folder As FolderItem = HitItem.Tag
		    If Folder = Nil Then
		      Return True
		    End If
		    If Not Folder.Exists Then
		      Folder.CreateFolder
		    End If
		    Folder.Open
		  Case "Copy Profile ID"
		    Var ProfileID As String = HitItem.Tag
		    Var Board As New Clipboard
		    Board.Text = ProfileID
		  Case "Deploy These Servers…", "Deploy This Server…"
		    Var SelectedProfiles() As Beacon.ServerProfile = HitItem.Tag
		    RaiseEvent ShouldDeployProfiles(SelectedProfiles)
		  Case "Open Nitrado Dashboard"
		    Var NitradoProfiles() As Beacon.NitradoServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To NitradoProfiles.LastIndex
		      System.GotoURL(Beacon.WebURL("/redirect?destination=nitradodash&serviceid=" + NitradoProfiles(Idx).ServiceID.ToString(Locale.Raw, "0")))
		    Next Idx
		  Case "Show Config Files"
		    Var LocalProfiles() As Beacon.LocalServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To LocalProfiles.LastIndex
		      Var File As FolderItem = LocalProfiles(Idx).GameIniFile
		      If File Is Nil Or File.Exists = False Then
		        File = LocalProfiles(Idx).GameUserSettingsIniFile
		      End If
		      If (File Is Nil) = False And File.Exists Then
		        File.Parent.Open
		      End If
		    Next Idx
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Var Sort1 As String = Me.CellTagAt(Row1, Column)
		  Var Sort2 As String = Me.CellTagAt(Row2, Column)
		  Result = Sort1.Compare(Sort2, ComparisonOptions.CaseInsensitive)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused Column
		  #Pragma Unused BackgroundColor
		  
		  If Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var Profile As Beacon.ServerProfile = Me.RowTagAt(Row)
		  If Profile.ProfileColor = Beacon.ServerProfile.Colors.None Then
		    Return
		  End If
		  
		  Select Case Profile.ProfileColor
		  Case Beacon.ServerProfile.Colors.Blue
		    G.DrawingColor = SystemColors.SystemBlueColor
		  Case Beacon.ServerProfile.Colors.Brown
		    G.DrawingColor = SystemColors.SystemBrownColor
		  Case Beacon.ServerProfile.Colors.Green
		    G.DrawingColor = SystemColors.SystemGreenColor
		  Case Beacon.ServerProfile.Colors.Grey
		    G.DrawingColor = SystemColors.SystemGrayColor
		  Case Beacon.ServerProfile.Colors.Indigo
		    G.DrawingColor = SystemColors.SystemIndigoColor
		  Case Beacon.ServerProfile.Colors.Orange
		    G.DrawingColor = SystemColors.SystemOrangeColor
		  Case Beacon.ServerProfile.Colors.Pink
		    G.DrawingColor = SystemColors.SystemPinkColor
		  Case Beacon.ServerProfile.Colors.Purple
		    G.DrawingColor = SystemColors.SystemPurpleColor
		  Case Beacon.ServerProfile.Colors.Red
		    G.DrawingColor = SystemColors.SystemRedColor
		  Case Beacon.ServerProfile.Colors.Teal
		    G.DrawingColor = SystemColors.SystemTealColor
		  Case Beacon.ServerProfile.Colors.Yellow
		    G.DrawingColor = SystemColors.SystemYellowColor
		  End Select
		  G.FillRectangle(G.Width - 3, 0, 3, G.Height)
		  
		  If Me.Selected(Row) And IsHighlighted Then
		    G.DrawingColor = TextColor
		    G.DrawLine(G.Width - 4, 0, G.Width - 4, G.Height)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator("ConfigTitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddServerButton", "New Server", IconToolbarAdd, "Add a new simple server."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("ViewOptionsButton", "View Options", IconToolbarView, "Change server list view options."))
		  
		  Me.Item("ConfigTitle").Priority = 5
		  Me.Item("ConfigTitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddServerButton"
		    Var Profile As New Beacon.LocalServerProfile
		    Profile.Name = "An Ark Server"
		    
		    Self.Document.AddServerProfile(Profile)
		    Self.UpdateList(Profile, True)
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="Visible"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
	#tag ViewProperty
		Name="CurrentProfileID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
