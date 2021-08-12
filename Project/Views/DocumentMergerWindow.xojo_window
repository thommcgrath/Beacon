#tag Window
Begin BeaconDialog DocumentMergerWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   500
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   780
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Import Results"
   Visible         =   True
   Width           =   780
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Import Results"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   740
   End
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   False
      ColumnWidths    =   "26,*,175,250"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   "#BeaconListbox.StandardRowHeight"
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   380
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Editor	Config Set	Merge"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   60
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      VisibleRowCount =   0
      Width           =   740
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   680
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   588
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ManageConfigSetsButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Manage Config Sets"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   160
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BestModeForItem(MergeItem As Beacon.DocumentMergeItem) As Integer
		  If (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		    Return Beacon.DocumentMergeItem.ModeReplace
		  End If
		  
		  Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		  Var Siblings() As Beacon.DocumentMergeConfigGroupItem = Self.SiblingItems(ConfigItem)
		  Var SiblingIsInReplaceMode, SiblingIsInHighPriorityMode As Boolean
		  For Each SiblingItem As Beacon.DocumentMergeConfigGroupItem In Siblings
		    If SiblingItem.Mode = Beacon.DocumentMergeItem.ModeReplace Then
		      SiblingIsInReplaceMode = True
		    ElseIf SiblingItem.Mode = Beacon.DocumentMergeItem.ModeMergeImportPriority Then
		      SiblingIsInHighPriorityMode = True
		    End If
		  Next
		  If ConfigItem.SupportsMerging = False Then
		    If SiblingIsInReplaceMode Then
		      Return Beacon.DocumentMergeItem.ModeSkip
		    Else
		      Return Beacon.DocumentMergeItem.ModeReplace
		    End If
		  End If
		  
		  Var Key As String = ConfigItem.OrganizationKey
		  Var FoundInDocuments() As String
		  If Self.mConfigMap.HasKey(Key) Then
		    FoundInDocuments = Self.mConfigMap.Value(Key)
		  End If
		  Var Count As Integer = FoundInDocuments.Count
		  Var AlreadyInDestination As Boolean
		  If FoundInDocuments.IndexOf(Self.mDestination.DocumentID) > -1 Then
		    AlreadyInDestination = True
		  End If
		  If FoundInDocuments.IndexOf(ConfigItem.SourceDocument.DocumentID) > -1 Then
		    Count = Count - 1
		  End If
		  If AlreadyInDestination And Count = 1 Then
		    Return Beacon.DocumentMergeItem.ModeMergeImportPriority
		  ElseIf Count > 0 Then
		    If SiblingIsInHighPriorityMode Then
		      Return Beacon.DocumentMergeItem.ModeMergeProjectPriority
		    Else
		      Return Beacon.DocumentMergeItem.ModeMergeImportPriority
		    End If
		  ElseIf SiblingIsInReplaceMode Then
		    Return Beacon.DocumentMergeItem.ModeSkip
		  Else
		    Return Beacon.DocumentMergeItem.ModeReplace
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckEnabled()
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.CellCheckBoxValueAt(I, Self.ColumnCheckboxes) Then
		      Self.ActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ActionButton.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mCallbackKey)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub MergeFinishedCallback()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function ModesForItem(MergeItem As Beacon.DocumentMergeItem) As String()
		  Var CanBeImported As Boolean
		  Return Self.ModesForItem(MergeItem, CanBeImported)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ModesForItem(MergeItem As Beacon.DocumentMergeItem, ByRef CanBeImported As Boolean) As String()
		  If (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		    CanBeImported = True
		    Return Array(Self.StrDoNotImport, Self.StrAdd)
		  End If
		  
		  Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		  Var Options(0) As String
		  Options(0) = Self.StrDoNotImport
		  
		  Var Key As String = ConfigItem.OrganizationKey
		  Var FoundInDocuments() As String
		  If Self.mConfigMap.HasKey(Key) Then
		    FoundInDocuments = Self.mConfigMap.Value(Key)
		  End If
		  
		  Var Count As Integer = FoundInDocuments.Count
		  Var AlreadyInDestination As Boolean = FoundInDocuments.IndexOf(Self.mDestination.DocumentID) > -1
		  
		  If FoundInDocuments.IndexOf(ConfigItem.SourceDocument.DocumentID) > -1 Then
		    Count = Count - 1
		  End If
		  
		  If Count <= 0 Then
		    Options.Add(Self.StrAdd)
		    CanBeImported = True
		  ElseIf Count = 1 And AlreadyInDestination Then
		    Options.Add(Self.StrReplace)
		    If ConfigItem.SupportsMerging Then
		      Options.Add(Self.StrMergeSelf)
		      Options.Add(Self.StrMergeOther)
		    End If
		    CanBeImported = True
		  Else
		    If ConfigItem.SupportsMerging Then
		      Var AllowReplace As Boolean = True
		      Var Siblings() As Beacon.DocumentMergeConfigGroupItem = Self.SiblingItems(ConfigItem)
		      For Each SiblingItem As Beacon.DocumentMergeConfigGroupItem In Siblings
		        If SiblingItem.Mode = Beacon.DocumentMergeItem.ModeReplace Then
		          AllowReplace = False
		          Exit For SiblingItem
		        End If
		      Next
		      If AllowReplace Then
		        Options.Add(Self.StrReplace)
		      End If
		      
		      Options.Add(Self.StrMergeSelf)
		      Options.Add(Self.StrMergeOther)
		      CanBeImported = True
		    Else
		      Options.Add(Self.StrAlreadySelected)
		      CanBeImported = False
		    End If
		  End If
		  
		  Return Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, SourceDocuments() As Beacon.Document, DestinationDocument As Beacon.Document, Callback As MergeFinishedCallback = Nil)
		  Var Accounts As New Beacon.ExternalAccountManager
		  For Each Document As Beacon.Document In SourceDocuments
		    Accounts.Import(Document.Accounts)
		  Next
		  
		  Var UseServerNames As Boolean = SourceDocuments.Count > 1
		  If UseServerNames Then
		    Var ServerNames() As String
		    For Each SourceDocument As Beacon.Document In SourceDocuments
		      ServerNames.Add(SourceDocument.Title)
		    Next
		    ServerNames = Language.FilterServerNames(ServerNames)
		    For DocumentIndex As Integer = 0 To Min(SourceDocuments.LastIndex, ServerNames.LastIndex)
		      SourceDocuments(DocumentIndex).Title = ServerNames(DocumentIndex)
		    Next
		  End If
		  
		  Var ActiveConfigSet As String = DestinationDocument.ActiveConfigSet
		  Var MergeItems() As Beacon.DocumentMergeItem
		  Var DesiredMask As UInt64
		  Var UniqueMods As New Dictionary
		  For Each SourceDocument As Beacon.Document In SourceDocuments
		    // Config Groups
		    Var Configs() As Beacon.ConfigGroup = SourceDocument.ImplementedConfigs
		    For Each Config As Beacon.ConfigGroup In Configs
		      If Config IsA BeaconConfigs.Metadata Then
		        Continue
		      End If
		      
		      Var MergeItem As New Beacon.DocumentMergeConfigGroupItem(Config, SourceDocument)
		      If UseServerNames Then
		        MergeItem.Label = MergeItem.Label + EndOfLine + "From " + SourceDocument.Title
		      End If
		      MergeItem.DestinationConfigSet = ActiveConfigSet
		      MergeItems.Add(MergeItem)
		    Next
		    
		    // Profiles
		    Var ProfileBound As Integer = SourceDocument.ServerProfileCount - 1
		    For ProfileIndex As Integer = 0 To ProfileBound
		      Var Profile As Beacon.ServerProfile = SourceDocument.ServerProfile(ProfileIndex)
		      If Profile.Name.IsEmpty Then
		        Continue For ProfileIndex
		      End If
		      
		      // Make sure this profile isn't already in the destination, and update the profile if it is.
		      Var DestinationProfileBound As Integer = DestinationDocument.ServerProfileCount - 1
		      For DestinationProfileIndex As Integer = 0 To DestinationProfileBound
		        Var DestinationProfile As Beacon.ServerProfile = DestinationDocument.ServerProfile(DestinationProfileIndex)
		        If DestinationProfile = Profile Then
		          DestinationProfile.UpdateDetailsFrom(Profile)
		          Continue For ProfileIndex
		        End If
		      Next
		      
		      DesiredMask = DesiredMask Or Profile.Mask
		      MergeItems.Add(New Beacon.DocumentMergeProfileItem(Profile))
		    Next
		    
		    // Maps, will be handled after the loop
		    DesiredMask = DesiredMask Or SourceDocument.MapCompatibility
		    
		    // Mods
		    Var EnabledMods() As String = SourceDocument.Mods
		    For Each ModUUID As String In EnabledMods
		      If UniqueMods.HasKey(ModUUID) = False Then
		        UniqueMods.Value(ModUUID) = True
		      End If
		    Next
		  Next
		  
		  // Process map changes
		  Var CurrentMask As UInt64 = DestinationDocument.MapCompatibility
		  Var DestinationProfileBound As Integer = DestinationDocument.ServerProfileCount - 1
		  For DestinationProfileIndex As Integer = 0 To DestinationProfileBound
		    Var DestinationProfile As Beacon.ServerProfile = DestinationDocument.ServerProfile(DestinationProfileIndex)
		    DesiredMask = DesiredMask Or DestinationProfile.Mask
		  Next
		  Var MaskDiff As UInt64 = CurrentMask Xor DesiredMask
		  Var MaskToAdd As UInt64 = DesiredMask And MaskDiff
		  Var MaskToRemove As UInt64 = CurrentMask And MaskDiff
		  Var NewMaps() As Beacon.Map = Beacon.Maps.ForMask(MaskToAdd)
		  Var OldMaps() As Beacon.Map = Beacon.Maps.ForMask(MaskToRemove)
		  For Each Map As Beacon.Map In NewMaps
		    MergeItems.Add(New Beacon.DocumentMergeMapItem(Map, True))
		  Next
		  For Each Map As Beacon.Map In OldMaps
		    MergeItems.Add(New Beacon.DocumentMergeMapItem(Map, False))
		  Next
		  
		  // Process mod additions
		  For Each Entry As DictionaryEntry In UniqueMods
		    Var ModUUID As String = Entry.Key
		    Var ModInfo As Beacon.ModDetails = Beacon.Data.GetModWithID(ModUUID)
		    If (ModInfo Is Nil) = False And DestinationDocument.ModEnabled(ModUUID) = False Then
		      MergeItems.Add(New Beacon.DocumentMergeModItem(ModInfo))
		    End If
		  Next
		  
		  // Setup the window
		  Var Win As New DocumentMergerWindow
		  Win.mDestination = DestinationDocument
		  Win.mExternalAccounts = Accounts
		  Win.mCallback = Callback
		  Win.mConfigMap = New Dictionary
		  If UseServerNames Then
		    Win.List.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  End If
		  
		  For Each Item As Beacon.DocumentMergeItem In MergeItems
		    Win.List.AddRow("")
		    Var RowIdx as Integer = Win.List.LastAddedRowIndex
		    Win.List.RowTagAt(RowIdx) = Item
		  Next
		  Win.UpdateList(True)
		  Win.CheckEnabled()
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldAddCustomConfig() As Boolean
		  // Let's try not having this warning any more
		  Return True
		  
		  If Self.mHasWarnedAboutCustomConfig Then
		    Return True
		  End If
		  
		  If Self.mDestination.HasConfigGroup(BeaconConfigs.NameCustomContent) Then
		    // Since the destination already has custom content, don't warn them again.
		    Self.mHasWarnedAboutCustomConfig = True
		    Return True
		  End If
		  
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("Are you sure you want to import Custom Config Content?", "If you intend to continue to configure the server outside of Beacon, it is recommended that you do not import the Custom Config Content.", "Import", "Cancel", "Learn More")
		  If Choice = BeaconUI.ConfirmResponses.Alternate Then
		    System.GotoURL(Beacon.WebURL("/help/using_custom_ini_content_with"))
		  End If
		  If Choice = BeaconUI.ConfirmResponses.Action Then
		    Self.mHasWarnedAboutCustomConfig = True
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SiblingItems(TargetConfigItem As Beacon.DocumentMergeConfigGroupItem) As Beacon.DocumentMergeConfigGroupItem()
		  Var Results() As Beacon.DocumentMergeConfigGroupItem
		  If TargetConfigItem Is Nil Then
		    Return Results
		  End If
		  Var TargetKey As String = TargetConfigItem.OrganizationKey
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIdx)
		    If (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		      Continue
		    End If
		    
		    Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		    If ConfigItem.OrganizationKey <> TargetKey Or ConfigItem.SourceDocument.DocumentID = TargetConfigItem.SourceDocument.DocumentID Then
		      Continue
		    End If
		    
		    Results.Add(ConfigItem)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerCallback()
		  If Beacon.SafeToInvoke(Self.mCallback) Then
		    Self.mCallback.Invoke()
		  End If
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SetDefaultState As Boolean = False)
		  Self.mSettingUp = True
		  
		  Var ConfigMap As New Dictionary
		  Var ConfigSets() As String = Self.mDestination.ConfigSetNames
		  For Each ConfigSet As String In ConfigSets
		    Var Groups() As Beacon.ConfigGroup = Self.mDestination.ImplementedConfigs(ConfigSet)
		    For Each Group As Beacon.ConfigGroup In Groups
		      ConfigMap.Value(ConfigSet + ":" + Group.ConfigName) = Array(Self.mDestination.DocumentID)
		    Next
		  Next
		  For RowIndex As Integer = 0 To Self.List.LastRowIndex
		    Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIndex)
		    If (SetDefaultState = False And MergeItem.IsImported = False) Or (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		      Continue
		    End If
		    
		    Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		    Var Key As String = ConfigItem.OrganizationKey
		    Var Map() As String
		    If ConfigMap.HasKey(Key) Then
		      Map = ConfigMap.Value(Key)
		    End If
		    Map.Add(ConfigItem.SourceDocument.DocumentID)
		    ConfigMap.Value(Key) = Map
		  Next
		  
		  // Loop through and enable any item that should be enabled by default
		  If SetDefaultState Then
		    For RowIndex As Integer = 0 To Self.List.LastRowIndex
		      Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIndex)
		      If MergeItem IsA Beacon.DocumentMergeConfigGroupItem Then
		        Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		        Var Key As String = ConfigItem.OrganizationKey
		        Var Map() As String
		        If ConfigMap.HasKey(Key) Then
		          Map = ConfigMap.Value(Key)
		        End If
		        MergeItem.Mode = If(ConfigItem.Group.DefaultImported And Map.Count = 1, Beacon.DocumentMergeItem.ModeReplace, Beacon.DocumentMergeItem.ModeSkip)
		      Else
		        MergeItem.Mode = Beacon.DocumentMergeItem.ModeReplace
		      End If
		    Next
		    
		    // Stop here and start over now that the default modes are set
		    Self.UpdateList(False)
		    Return
		  End If
		  
		  // Make sure this is set *before* using ModesForItem
		  Self.mConfigMap = ConfigMap
		  
		  // Now update the actual list contents
		  For RowIndex As Integer = 0 To Self.List.LastRowIndex
		    Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIndex)
		    
		    Var ShowAsReplace As Boolean
		    If MergeItem IsA Beacon.DocumentMergeConfigGroupItem Then
		      Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		      Var Key As String = ConfigItem.OrganizationKey
		      If BeaconConfigs.SupportsConfigSets(ConfigItem.Group.ConfigName) Then
		        Self.List.CellValueAt(RowIndex, Self.ColumnConfigSet) = ConfigItem.DestinationConfigSet
		      Else
		        Self.List.CellValueAt(RowIndex, Self.ColumnConfigSet) = ""
		      End If
		      
		      Var Map() As String
		      If ConfigMap.HasKey(Key) Then
		        Map = ConfigMap.Value(Key)
		      End If
		      ShowAsReplace = Map.IndexOf(Self.mDestination.DocumentID) > -1
		    Else
		      Self.List.CellValueAt(RowIndex, Self.ColumnConfigSet) = ""
		    End If
		    
		    Self.List.CellValueAt(RowIndex, Self.ColumnConfigName) = MergeItem.Label
		    
		    Var CanBeImported As Boolean
		    Call Self.ModesForItem(MergeItem, CanBeImported)
		    If CanBeImported Then
		      Self.List.CellTypeAt(RowIndex, Self.ColumnCheckboxes) = Listbox.CellTypes.CheckBox
		      Self.List.CellCheckBoxValueAt(RowIndex, Self.ColumnCheckboxes) = MergeItem.IsImported
		    Else
		      Self.List.CellTypeAt(RowIndex, Self.ColumnCheckboxes) = Listbox.CellTypes.Normal
		      Self.List.CellCheckBoxValueAt(RowIndex, Self.ColumnCheckboxes) = False
		      MergeItem.Mode = Beacon.DocumentMergeItem.ModeSkip
		    End If
		    
		    Select Case MergeItem.Mode
		    Case Beacon.DocumentMergeItem.ModeSkip
		      Self.List.CellValueAt(RowIndex, Self.ColumnMergeMode) = Self.StrDoNotImport
		    Case Beacon.DocumentMergeItem.ModeReplace
		      Self.List.CellValueAt(RowIndex, Self.ColumnMergeMode) = If(ShowAsReplace, Self.StrReplace, Self.StrAdd)
		    Case Beacon.DocumentMergeItem.ModeMergeImportPriority
		      Self.List.CellValueAt(RowIndex, Self.ColumnMergeMode) = Self.StrMergeOther
		    Case Beacon.DocumentMergeItem.ModeMergeProjectPriority
		      Self.List.CellValueAt(RowIndex, Self.ColumnMergeMode) = Self.StrMergeSelf
		    End Select
		  Next
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCallback As MergeFinishedCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigMap As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExternalAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasWarnedAboutCustomConfig As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnCheckboxes, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnConfigName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnConfigSet, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMergeMode, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrAdd, Type = String, Dynamic = False, Default = \"Add", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrAlreadySelected, Type = String, Dynamic = False, Default = \"A conflicting item is already selected", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrDoNotImport, Type = String, Dynamic = False, Default = \"Do not import", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrMergeOther, Type = String, Dynamic = False, Default = \"Merge\x2C new config takes priority", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrMergeSelf, Type = String, Dynamic = False, Default = \"Merge\x2C current config takes priority", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrReplace, Type = String, Dynamic = False, Default = \"Replace", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(Self.ColumnCheckboxes) = Listbox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mSettingUp = True Or Column <> Self.ColumnCheckboxes Then
		    Return
		  End If
		  
		  Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Self.ColumnCheckboxes)
		  Var MergeItem As Beacon.DocumentMergeItem = Me.RowTagAt(Row)
		  Var NewMode As Integer
		  If Checked Then
		    NewMode = Self.BestModeForItem(MergeItem)
		  Else
		    NewMode = Beacon.DocumentMergeItem.ModeSkip
		  End If
		  MergeItem.Mode = NewMode
		  Self.UpdateList()
		  Self.CheckEnabled()
		End Sub
	#tag EndEvent
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnCheckboxes, Self.ColumnConfigName
		    Return False
		  End Select
		  
		  Var Base As New MenuItem
		  Var MergeItem As Beacon.DocumentMergeItem = Me.RowTagAt(Row)
		  
		  Select Case Column
		  Case Self.ColumnMergeMode
		    Var Modes() As String = Self.ModesForItem(MergeItem)
		    For Each Mode As String In Modes
		      Select Case Mode
		      Case Self.StrAdd
		        Var AddItem As New MenuItem(Self.StrAdd, Beacon.DocumentMergeItem.ModeReplace)
		        AddItem.HasCheckMark = MergeItem.IsImported
		        Base.AddMenu(AddItem)
		      Case Self.StrAlreadySelected
		        Var RejectedMenu As New MenuItem(Self.StrAlreadySelected)
		        RejectedMenu.Enabled = False
		        Base.AddMenu(RejectedMenu)
		      Case Self.StrDoNotImport
		        Var DoNothingItem As New MenuItem(Self.StrDoNotImport, Beacon.DocumentMergeItem.ModeSkip)
		        DoNothingItem.HasCheckMark = Not MergeItem.IsImported
		        Base.AddMenu(DoNothingItem)
		      Case Self.StrMergeOther
		        Var MergeOtherItem As New MenuItem(Self.StrMergeOther, Beacon.DocumentMergeItem.ModeMergeImportPriority)
		        MergeOtherItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeMergeImportPriority)
		        Base.AddMenu(MergeOtherItem)
		      Case Self.StrMergeSelf
		        Var MergeSelfItem As New MenuItem(Self.StrMergeSelf, Beacon.DocumentMergeItem.ModeMergeProjectPriority)
		        MergeSelfItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeMergeProjectPriority)
		        Base.AddMenu(MergeSelfItem)
		      Case Self.StrReplace
		        Var ReplaceItem As New MenuItem(Self.StrReplace, Beacon.DocumentMergeItem.ModeReplace)
		        ReplaceItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeReplace)
		        Base.AddMenu(ReplaceItem)
		      End Select
		    Next
		  Case Self.ColumnConfigSet
		    If (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		      Return True
		    End If
		    
		    Var ConfigSets() As String = Self.mDestination.ConfigSetNames
		    For Each ConfigSet As String In ConfigSets
		      Var Item As New MenuItem(ConfigSet, ConfigSet)
		      Item.HasCheckMark = (Beacon.DocumentMergeConfigGroupItem(MergeItem).DestinationConfigSet = ConfigSet)
		      Base.AddMenu(Item)
		    Next
		  End Select
		  
		  
		  Var WindowPos As Point = Self.GlobalPosition
		  Var OffsetX, OffsetY As Integer
		  OffsetX = WindowPos.X + Me.Left
		  OffsetY = WindowPos.Y + Me.Top
		  For I As Integer = 0 To Column - 1
		    OffsetX = OffsetX + Me.ColumnAt(I).WidthActual
		  Next
		  OffsetX = OffsetX - Me.ScrollPositionX
		  If Me.HasHeader Then
		    OffsetY = OffsetY + Me.HeaderHeight
		  End If
		  OffsetY = OffsetY + ((Row - Me.ScrollPosition) * Me.DefaultRowHeight)
		  
		  Var Choice As MenuItem = Base.PopUp(OffsetX + X, OffsetY + Y)
		  If Choice = Nil Then
		    Return True
		  End If
		  
		  Select Case Column
		  Case Self.ColumnMergeMode
		    MergeItem.Mode = Choice.Tag.IntegerValue
		  Case Self.ColumnConfigSet
		    Beacon.DocumentMergeConfigGroupItem(MergeItem).DestinationConfigSet = Choice.Tag.StringValue
		    Var NewMode As Integer = Self.BestModeForItem(MergeItem)
		    If MergeItem.Mode <> NewMode Then
		      MergeItem.Mode = NewMode
		    End If
		  End Select
		  
		  Self.UpdateList()
		  
		  Var CanBeImported As Boolean
		  Var SupportedModes() As String = Self.ModesForItem(MergeItem, CanBeImported)
		  If CanBeImported = False Then
		    MergeItem.Mode = Beacon.DocumentMergeItem.ModeSkip
		    Self.UpdateList()
		  ElseIf SupportedModes.IndexOf(Me.CellValueAt(Row, Self.ColumnMergeMode)) = -1 Then
		    MergeItem.Mode = Self.BestModeForItem(MergeItem)
		    Self.UpdateList()
		  End If
		  
		  Self.CheckEnabled()
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function CellTextPaint(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused Row
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  If Column = Self.ColumnMergeMode Or Column = Self.ColumnConfigSet Then
		    Const IndicatorWidth = 8
		    Const IndicatorHeight = 4
		    
		    Var LineEnd As Integer = Ceiling(HorizontalPosition + G.TextWidth(Line))
		    Var IndicatorLeft As Integer = LineEnd + 4
		    Var IndicatorTop As Integer = Round((Me.DefaultRowHeight - IndicatorHeight) / 2)
		    
		    Var Path As New GraphicsPath
		    Path.MoveToPoint(IndicatorLeft, IndicatorTop)
		    Path.AddLineToPoint(IndicatorLeft + IndicatorWidth, IndicatorTop)
		    Path.AddLineToPoint(IndicatorLeft + (IndicatorWidth / 2), IndicatorTop + IndicatorHeight)
		    Path.AddLineToPoint(IndicatorLeft, IndicatorTop)
		    
		    G.DrawingColor = TextColor
		    G.FillPath(Path)
		    
		    Return False // Yes, this is correct, we are adding to the text instead of replacing it
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var OriginalConfigSet As String = Self.mDestination.ActiveConfigSet
		  
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIdx)
		    If MergeItem.IsImported = False Then
		      Continue
		    End If
		    
		    Select Case MergeItem
		    Case IsA Beacon.DocumentMergeConfigGroupItem
		      Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		      Self.mDestination.ActiveConfigSet = ConfigItem.DestinationConfigSet
		      Var ExistingConfig As Beacon.ConfigGroup = Self.mDestination.ConfigGroup(ConfigItem.Group.ConfigName, False)
		      Select Case ConfigItem.Mode
		      Case Beacon.DocumentMergeItem.ModeReplace
		        Self.mDestination.AddConfigGroup(ConfigItem.Group)
		      Case Beacon.DocumentMergeItem.ModeMergeImportPriority
		        Call ExistingConfig.Merge(ConfigItem.Group)
		      Case Beacon.DocumentMergeItem.ModeMergeProjectPriority
		        If ConfigItem.Group.Merge(ExistingConfig) Then
		          Self.mDestination.AddConfigGroup(ConfigItem.Group)
		        End If
		      End Select
		    Case IsA Beacon.DocumentMergeMapItem
		      Var MapItem As Beacon.DocumentMergeMapItem = Beacon.DocumentMergeMapItem(MergeItem)
		      If MapItem.AddMode Then
		        Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility Or MapItem.Map.Mask
		      Else
		        Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility And Not MapItem.Map.Mask
		      End If
		    Case IsA Beacon.DocumentMergeModItem
		      Var ModItem As Beacon.DocumentMergeModItem = Beacon.DocumentMergeModItem(MergeItem)
		      Self.mDestination.ModEnabled(ModItem.ModInfo.ModID) = True
		    Case IsA Beacon.DocumentMergeProfileItem
		      Var ProfileItem As Beacon.DocumentMergeProfileItem = Beacon.DocumentMergeProfileItem(MergeItem)
		      Self.mDestination.AddServerProfile(ProfileItem.Profile)
		      
		      If ProfileItem.Profile.ExternalAccountUUID <> Nil Then
		        Var Account As Beacon.ExternalAccount = Self.mExternalAccounts.GetByUUID(ProfileItem.Profile.ExternalAccountUUID)
		        If (Account Is Nil) = False Then
		          Self.mDestination.Accounts.Add(Account)
		        End If
		      End If
		    End Select
		  Next
		  
		  Self.mDestination.ActiveConfigSet = OriginalConfigSet
		  
		  If Self.mCallback <> Nil Then
		    Self.mCallbackKey = CallLater.Schedule(100, WeakAddressOf TriggerCallback)
		    Self.Hide
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ManageConfigSetsButton
	#tag Event
		Sub Action()
		  If ConfigSetManagerWindow.Present(Self, Self.mDestination) Then
		    Break
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
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
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
