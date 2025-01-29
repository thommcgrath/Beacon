#tag DesktopWindow
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
   Begin DesktopLabel MessageLabel
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Import Results"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   740
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
      ColumnWidths    =   "26,*,175,250"
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
      Height          =   380
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
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   1
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
      Width           =   740
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   680
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
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
      Left            =   588
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
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
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
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
		  If FoundInDocuments.IndexOf(Self.mDestination.ProjectId + ":" + ConfigItem.DestinationConfigSet.ConfigSetId) > -1 Then
		    AlreadyInDestination = True
		  End If
		  If FoundInDocuments.IndexOf(ConfigItem.SourceKey) > -1 Then
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
		  Var AlreadyInDestination As Boolean = FoundInDocuments.IndexOf(Self.mDestination.ProjectId + ":" + ConfigItem.DestinationConfigSet.ConfigSetId) > -1
		  
		  If FoundInDocuments.IndexOf(ConfigItem.SourceKey) > -1 Then
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
		Shared Sub Present(Parent As DesktopWindow, SourceProjects() As Beacon.Project, DestinationProject As Beacon.Project, Callback As MergeFinishedCallback = Nil)
		  Var UseServerNames As Boolean = SourceProjects.Count > 1
		  If UseServerNames Then
		    Var ServerNames() As String
		    For Each SourceProject As Beacon.Project In SourceProjects
		      ServerNames.Add(SourceProject.Title)
		    Next
		    ServerNames = Language.FilterServerNames(ServerNames)
		    For Idx As Integer = 0 To Min(SourceProjects.LastIndex, ServerNames.LastIndex)
		      SourceProjects(Idx).Title = ServerNames(Idx)
		    Next
		  End If
		  
		  Var ShowConfigSetNames As Boolean
		  For Each SourceProject As Beacon.Project In SourceProjects
		    Var SetNames() As String = SourceProject.ConfigSetNames
		    If SetNames.Count > 1 Then
		      ShowConfigSetNames = True
		      Exit For SourceProject
		    End If
		  Next SourceProject
		  
		  Var ActiveConfigSet As Beacon.ConfigSet = DestinationProject.ActiveConfigSet
		  Var MergeItems() As Beacon.DocumentMergeItem
		  Var DesiredArkMask As UInt64
		  Var UniqueContentPacks As New Dictionary
		  Var AddedSinglePlayerItem As Boolean
		  For Each SourceProject As Beacon.Project In SourceProjects
		    // Config Groups
		    Var Sets() As Beacon.ConfigSet = SourceProject.ConfigSets
		    For Each Set As Beacon.ConfigSet In Sets
		      For Each Config As Beacon.ConfigGroup In SourceProject.ImplementedConfigs(Set)
		        Var MergeItem As New Beacon.DocumentMergeConfigGroupItem(Config, SourceProject, Set)
		        If ShowConfigSetNames Then
		          MergeItem.Label = Set.Name + ": " + MergeItem.Label
		        End If
		        If UseServerNames Then
		          MergeItem.Label = MergeItem.Label + EndOfLine + "From " + SourceProject.Title
		        End If
		        MergeItem.DestinationConfigSet = ActiveConfigSet
		        MergeItems.Add(MergeItem)
		      Next
		    Next
		    
		    Select Case SourceProject
		    Case IsA Ark.Project
		      Var ArkProject As Ark.Project = Ark.Project(SourceProject)
		      DesiredArkMask = DesiredArkMask Or ArkProject.MapMask
		    Case IsA ArkSA.Project
		      Var ArkProject As ArkSA.Project = ArkSA.Project(SourceProject)
		      DesiredArkMask = DesiredArkMask Or ArkProject.MapMask
		      
		      // Single player
		      If AddedSinglePlayerItem = False Then
		        Var SourceIsSingle As Boolean = SourceProject.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		        Var DestinationIsSingle As Boolean = DestinationProject.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		        
		        If SourceIsSingle = True And DestinationIsSingle = False Then
		          MergeItems.Add(New Beacon.DocumentMergeFlagItem("Enable Single Player Project", ArkSA.Project.FlagSinglePlayer, 0))
		          AddedSinglePlayerItem = True
		        ElseIf SourceIsSingle = False And DestinationIsSingle = True Then
		          MergeItems.Add(New Beacon.DocumentMergeFlagItem("Disable Single Player Project", 0, ArkSA.Project.FlagSinglePlayer))
		          AddedSinglePlayerItem = True
		        End If
		      End If
		    End Select
		    
		    // Content Packs
		    Var EnabledContentPacks() As String = SourceProject.ContentPacks
		    For Each ContentPackId As String In EnabledContentPacks
		      If UniqueContentPacks.HasKey(ContentPackId) = False Then
		        UniqueContentPacks.Value(ContentPackId) = True
		      End If
		    Next
		    
		    // Profiles
		    Var ProfileBound As Integer = SourceProject.ServerProfileCount - 1
		    For ProfileIndex As Integer = 0 To ProfileBound
		      Var Profile As Beacon.ServerProfile = SourceProject.ServerProfile(ProfileIndex)
		      If Profile.Name.IsEmpty Then
		        Continue For ProfileIndex
		      End If
		      
		      // Make sure this profile isn't already in the destination, and update the profile if it is.
		      Var DestinationProfileBound As Integer = DestinationProject.ServerProfileCount - 1
		      For DestinationProfileIndex As Integer = 0 To DestinationProfileBound
		        Var DestinationProfile As Beacon.ServerProfile = DestinationProject.ServerProfile(DestinationProfileIndex)
		        If DestinationProfile = Profile Then
		          Continue For ProfileIndex
		        End If
		      Next
		      
		      If Profile IsA Ark.ServerProfile Then
		        DesiredArkMask = DesiredArkMask Or Ark.ServerProfile(Profile).Mask
		      ElseIf Profile IsA ArkSA.ServerProfile Then
		        DesiredArkMask = DesiredArkMask Or ArkSA.ServerProfile(Profile).Mask
		      End If
		      
		      MergeItems.Add(New Beacon.DocumentMergeProfileItem(Profile))
		    Next
		  Next
		  
		  Select Case DestinationProject
		  Case IsA Ark.Project
		    Var ArkProject As Ark.Project = Ark.Project(DestinationProject)
		    
		    // Process map changes
		    Var CurrentMask As UInt64 = ArkProject.MapMask
		    Var DestinationProfileBound As Integer = DestinationProject.ServerProfileCount - 1
		    For DestinationProfileIndex As Integer = 0 To DestinationProfileBound
		      Var DestinationProfile As Beacon.ServerProfile = DestinationProject.ServerProfile(DestinationProfileIndex)
		      If DestinationProfile IsA Ark.ServerProfile Then
		        DesiredArkMask = DesiredArkMask Or Ark.ServerProfile(DestinationProfile).Mask
		      End If
		    Next
		    Var MaskDiff As UInt64 = CurrentMask Xor DesiredArkMask
		    Var MaskToAdd As UInt64 = DesiredArkMask And MaskDiff
		    Var MaskToRemove As UInt64 = CurrentMask And MaskDiff
		    Var NewMaps() As Ark.Map = Ark.Maps.ForMask(MaskToAdd)
		    Var OldMaps() As Ark.Map = Ark.Maps.ForMask(MaskToRemove)
		    For Each Map As Ark.Map In NewMaps
		      MergeItems.Add(New Ark.DocumentMergeMapItem(Map, True))
		    Next
		    For Each Map As Ark.Map In OldMaps
		      MergeItems.Add(New Ark.DocumentMergeMapItem(Map, False))
		    Next
		    
		    // Process mod additions
		    For Each Entry As DictionaryEntry In UniqueContentPacks
		      Var PackId As String = Entry.Key
		      Var Pack As Beacon.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPackWithId(PackId)
		      If (Pack Is Nil) = False And ArkProject.ContentPackEnabled(PackId) = False Then
		        MergeItems.Add(New Beacon.DocumentMergeContentPackItem(Pack))
		      End If
		    Next
		  Case IsA ArkSA.Project
		    Var ArkProject As ArkSA.Project = ArkSA.Project(DestinationProject)
		    
		    // Process map changes
		    Var CurrentMask As UInt64 = ArkProject.MapMask
		    Var DestinationProfileBound As Integer = DestinationProject.ServerProfileCount - 1
		    For DestinationProfileIndex As Integer = 0 To DestinationProfileBound
		      Var DestinationProfile As Beacon.ServerProfile = DestinationProject.ServerProfile(DestinationProfileIndex)
		      If DestinationProfile IsA ArkSA.ServerProfile Then
		        DesiredArkMask = DesiredArkMask Or ArkSA.ServerProfile(DestinationProfile).Mask
		      End If
		    Next
		    Var MaskDiff As UInt64 = CurrentMask Xor DesiredArkMask
		    Var MaskToAdd As UInt64 = DesiredArkMask And MaskDiff
		    Var MaskToRemove As UInt64 = CurrentMask And MaskDiff
		    Var NewMaps() As ArkSA.Map = ArkSA.Maps.ForMask(MaskToAdd)
		    Var OldMaps() As ArkSA.Map = ArkSA.Maps.ForMask(MaskToRemove)
		    For Each Map As ArkSA.Map In NewMaps
		      MergeItems.Add(New ArkSA.DocumentMergeMapItem(Map, True))
		    Next
		    For Each Map As ArkSA.Map In OldMaps
		      MergeItems.Add(New ArkSA.DocumentMergeMapItem(Map, False))
		    Next
		    
		    // Process mod additions
		    For Each Entry As DictionaryEntry In UniqueContentPacks
		      Var PackId As String = Entry.Key
		      Var Pack As Beacon.ContentPack = ArkSA.DataSource.Pool.Get(False).GetContentPackWithId(PackId)
		      If (Pack Is Nil) = False And ArkProject.ContentPackEnabled(PackId) = False Then
		        MergeItems.Add(New Beacon.DocumentMergeContentPackItem(Pack))
		      End If
		    Next
		  End Select
		  
		  // Setup the window
		  Var Win As New DocumentMergerWindow
		  Win.mDestination = DestinationProject
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
		  Win.ShowModal(Parent)
		End Sub
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
		    If ConfigItem.OrganizationKey <> TargetKey Or ConfigItem.SourceKey = TargetConfigItem.SourceKey Then
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
		  Var ConfigSets() As Beacon.ConfigSet = Self.mDestination.ConfigSets
		  For Each ConfigSet As Beacon.ConfigSet In ConfigSets
		    For Each Group As Beacon.ConfigGroup In Self.mDestination.ImplementedConfigs(ConfigSet)
		      ConfigMap.Value(ConfigSet.ConfigSetId + ":" + Group.InternalName) = Array(Self.mDestination.ProjectId + ":" + ConfigSet.ConfigSetId)
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
		    Map.Add(ConfigItem.SourceKey)
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
		        MergeItem.Mode = If(ConfigItem.Group.IsDefaultImported And Map.Count = 1, Beacon.DocumentMergeItem.ModeReplace, Beacon.DocumentMergeItem.ModeSkip)
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
		      If ConfigItem.Group.SupportsConfigSets Then
		        Self.List.CellTextAt(RowIndex, Self.ColumnConfigSet) = ConfigItem.DestinationConfigSet.Name
		      Else
		        Self.List.CellTextAt(RowIndex, Self.ColumnConfigSet) = ""
		      End If
		      
		      Var Map() As String
		      If ConfigMap.HasKey(Key) Then
		        Map = ConfigMap.Value(Key)
		      End If
		      ShowAsReplace = Map.IndexOf(Self.mDestination.ProjectId + ":" + ConfigItem.DestinationConfigSet.ConfigSetId) > -1
		    Else
		      Self.List.CellTextAt(RowIndex, Self.ColumnConfigSet) = ""
		    End If
		    
		    Self.List.CellTextAt(RowIndex, Self.ColumnConfigName) = MergeItem.Label
		    
		    Var CanBeImported As Boolean
		    Call Self.ModesForItem(MergeItem, CanBeImported)
		    If CanBeImported Then
		      Self.List.CellTypeAt(RowIndex, Self.ColumnCheckboxes) = DesktopListbox.CellTypes.CheckBox
		      Self.List.CellCheckBoxValueAt(RowIndex, Self.ColumnCheckboxes) = MergeItem.IsImported
		    Else
		      Self.List.CellTypeAt(RowIndex, Self.ColumnCheckboxes) = DesktopListbox.CellTypes.Normal
		      Self.List.CellCheckBoxValueAt(RowIndex, Self.ColumnCheckboxes) = False
		      MergeItem.Mode = Beacon.DocumentMergeItem.ModeSkip
		    End If
		    
		    Select Case MergeItem.Mode
		    Case Beacon.DocumentMergeItem.ModeSkip
		      Self.List.CellTextAt(RowIndex, Self.ColumnMergeMode) = Self.StrDoNotImport
		    Case Beacon.DocumentMergeItem.ModeReplace
		      Self.List.CellTextAt(RowIndex, Self.ColumnMergeMode) = If(ShowAsReplace, Self.StrReplace, Self.StrAdd)
		    Case Beacon.DocumentMergeItem.ModeMergeImportPriority
		      Self.List.CellTextAt(RowIndex, Self.ColumnMergeMode) = Self.StrMergeOther
		    Case Beacon.DocumentMergeItem.ModeMergeProjectPriority
		      Self.List.CellTextAt(RowIndex, Self.ColumnMergeMode) = Self.StrMergeSelf
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
		Private mDestination As Beacon.Project
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
		Sub Opening()
		  Me.ColumnTypeAt(Self.ColumnCheckboxes) = DesktopListbox.CellTypes.CheckBox
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
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnCheckboxes, Self.ColumnConfigName
		    Return False
		  End Select
		  
		  Var Base As New DesktopMenuItem
		  Var MergeItem As Beacon.DocumentMergeItem = Me.RowTagAt(Row)
		  
		  Select Case Column
		  Case Self.ColumnMergeMode
		    Var Modes() As String = Self.ModesForItem(MergeItem)
		    For Each Mode As String In Modes
		      Select Case Mode
		      Case Self.StrAdd
		        Var AddItem As New DesktopMenuItem(Self.StrAdd, Beacon.DocumentMergeItem.ModeReplace)
		        AddItem.HasCheckMark = MergeItem.IsImported
		        Base.AddMenu(AddItem)
		      Case Self.StrAlreadySelected
		        Var RejectedMenu As New DesktopMenuItem(Self.StrAlreadySelected)
		        RejectedMenu.Enabled = False
		        Base.AddMenu(RejectedMenu)
		      Case Self.StrDoNotImport
		        Var DoNothingItem As New DesktopMenuItem(Self.StrDoNotImport, Beacon.DocumentMergeItem.ModeSkip)
		        DoNothingItem.HasCheckMark = Not MergeItem.IsImported
		        Base.AddMenu(DoNothingItem)
		      Case Self.StrMergeOther
		        Var MergeOtherItem As New DesktopMenuItem(Self.StrMergeOther, Beacon.DocumentMergeItem.ModeMergeImportPriority)
		        MergeOtherItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeMergeImportPriority)
		        Base.AddMenu(MergeOtherItem)
		      Case Self.StrMergeSelf
		        Var MergeSelfItem As New DesktopMenuItem(Self.StrMergeSelf, Beacon.DocumentMergeItem.ModeMergeProjectPriority)
		        MergeSelfItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeMergeProjectPriority)
		        Base.AddMenu(MergeSelfItem)
		      Case Self.StrReplace
		        Var ReplaceItem As New DesktopMenuItem(Self.StrReplace, Beacon.DocumentMergeItem.ModeReplace)
		        ReplaceItem.HasCheckMark = (MergeItem.Mode = Beacon.DocumentMergeItem.ModeReplace)
		        Base.AddMenu(ReplaceItem)
		      End Select
		    Next
		  Case Self.ColumnConfigSet
		    If (MergeItem IsA Beacon.DocumentMergeConfigGroupItem) = False Then
		      Return True
		    End If
		    
		    Var ConfigSets() As Beacon.ConfigSet = Self.mDestination.ConfigSets
		    For Each ConfigSet As Beacon.ConfigSet In ConfigSets
		      Var Item As New DesktopMenuItem(ConfigSet.Name, ConfigSet)
		      Item.HasCheckMark = (Beacon.DocumentMergeConfigGroupItem(MergeItem).DestinationConfigSet = ConfigSet)
		      Base.AddMenu(Item)
		    Next
		  End Select
		  
		  
		  Var WindowPos As Point = Me.GlobalPosition
		  Var OffsetX, OffsetY As Integer
		  OffsetX = WindowPos.X
		  OffsetY = WindowPos.Y
		  For I As Integer = 0 To Column - 1
		    OffsetX = OffsetX + Me.ColumnAttributesAt(I).WidthActual
		  Next
		  OffsetX = OffsetX - Me.ScrollPositionX
		  If Me.HasHeader Then
		    OffsetY = OffsetY + Me.HeaderHeight
		  End If
		  OffsetY = OffsetY + ((Row - Me.ScrollPosition) * Me.DefaultRowHeight)
		  
		  Var Choice As DesktopMenuItem = Base.PopUp(OffsetX + X, OffsetY + Y)
		  If Choice = Nil Then
		    Return True
		  End If
		  
		  Select Case Column
		  Case Self.ColumnMergeMode
		    MergeItem.Mode = Choice.Tag.IntegerValue
		  Case Self.ColumnConfigSet
		    Beacon.DocumentMergeConfigGroupItem(MergeItem).DestinationConfigSet = Beacon.ConfigSet(Choice.Tag.ObjectValue)
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
		  ElseIf SupportedModes.IndexOf(Me.CellTextAt(Row, Self.ColumnMergeMode)) = -1 Then
		    MergeItem.Mode = Self.BestModeForItem(MergeItem)
		    Self.UpdateList()
		  End If
		  
		  Self.CheckEnabled()
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function PaintCellText(G As Graphics, Row As Integer, Column As Integer, Line As String, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
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
		    
		    G.FillPath(Path)
		    
		    Return False // Yes, this is correct, we are adding to the text instead of replacing it
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var OriginalConfigSet As Beacon.ConfigSet = Self.mDestination.ActiveConfigSet
		  
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    Try
		      Var MergeItem As Beacon.DocumentMergeItem = Self.List.RowTagAt(RowIdx)
		      If MergeItem.IsImported = False Then
		        Continue
		      End If
		      
		      Select Case MergeItem
		      Case IsA Beacon.DocumentMergeConfigGroupItem
		        If (Self.mDestination Is Nil) = False Then
		          Var ConfigItem As Beacon.DocumentMergeConfigGroupItem = Beacon.DocumentMergeConfigGroupItem(MergeItem)
		          Self.mDestination.ActiveConfigSet = ConfigItem.DestinationConfigSet
		          Var ExistingConfig As Beacon.ConfigGroup = Self.mDestination.ConfigGroup(ConfigItem.Group.InternalName, False)
		          Select Case ConfigItem.Mode
		          Case Beacon.DocumentMergeItem.ModeReplace
		            Self.mDestination.AddConfigGroup(ConfigItem.Group)
		          Case Beacon.DocumentMergeItem.ModeMergeImportPriority
		            Select Case ConfigItem.Group
		            Case IsA Ark.ConfigGroup
		              Var Merged As Ark.ConfigGroup = Ark.Configs.Merge(False, Ark.ConfigGroup(ExistingConfig), Ark.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            Case IsA SDTD.ConfigGroup
		              Var Merged As SDTD.ConfigGroup = SDTD.Configs.Merge(False, SDTD.ConfigGroup(ExistingConfig), SDTD.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            Case IsA ArkSA.ConfigGroup
		              Var Merged As ArkSA.ConfigGroup = ArkSA.Configs.Merge(False, ArkSA.ConfigGroup(ExistingConfig), ArkSA.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            End Select
		          Case Beacon.DocumentMergeItem.ModeMergeProjectPriority
		            Select Case ConfigItem.Group
		            Case IsA Ark.ConfigGroup
		              Var Merged As Ark.ConfigGroup = Ark.Configs.Merge(True, Ark.ConfigGroup(ExistingConfig), Ark.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            Case IsA SDTD.ConfigGroup
		              Var Merged As SDTD.ConfigGroup = SDTD.Configs.Merge(True, SDTD.ConfigGroup(ExistingConfig), SDTD.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            Case IsA ArkSA.ConfigGroup
		              Var Merged As ArkSA.ConfigGroup = ArkSA.Configs.Merge(True, ArkSA.ConfigGroup(ExistingConfig), ArkSA.ConfigGroup(ConfigItem.Group))
		              Self.mDestination.AddConfigGroup(Merged)
		            End Select
		          End Select
		        End If
		      Case IsA Ark.DocumentMergeMapItem
		        If Self.mDestination IsA Ark.Project Then
		          Var ArkDestination As Ark.Project = Ark.Project(Self.mDestination)
		          Var MapItem As Ark.DocumentMergeMapItem = Ark.DocumentMergeMapItem(MergeItem)
		          If MapItem.AddMode Then
		            ArkDestination.MapMask = ArkDestination.MapMask Or MapItem.Map.Mask
		          Else
		            ArkDestination.MapMask = ArkDestination.MapMask And Not MapItem.Map.Mask
		          End If
		        End If
		      Case IsA ArkSA.DocumentMergeMapItem
		        If Self.mDestination IsA ArkSA.Project Then
		          Var ArkDestination As ArkSA.Project = ArkSA.Project(Self.mDestination)
		          Var MapItem As ArkSA.DocumentMergeMapItem = ArkSA.DocumentMergeMapItem(MergeItem)
		          If MapItem.AddMode Then
		            ArkDestination.MapMask = ArkDestination.MapMask Or MapItem.Map.Mask
		          Else
		            ArkDestination.MapMask = ArkDestination.MapMask And Not MapItem.Map.Mask
		          End If
		        End If
		      Case IsA Beacon.DocumentMergeContentPackItem
		        Var PackItem As Beacon.DocumentMergeContentPackItem = Beacon.DocumentMergeContentPackItem(MergeItem)
		        Self.mDestination.ContentPackEnabled(PackItem.Pack.ContentPackId) = True
		      Case IsA Beacon.DocumentMergeProfileItem
		        Var ProfileItem As Beacon.DocumentMergeProfileItem = Beacon.DocumentMergeProfileItem(MergeItem)
		        Self.mDestination.AddServerProfile(ProfileItem.Profile)
		        If (ProfileItem.TokenId.IsEmpty) = False Then
		          Self.mDestination.ProviderTokenKey(ProfileItem.TokenId) = ProfileItem.TokenKey
		        End If
		      Case IsA Beacon.DocumentMergeFlagItem
		        Self.mDestination.IsFlagged(Beacon.DocumentMergeFlagItem(MergeItem).FlagsToSet) = True
		        Self.mDestination.IsFlagged(Beacon.DocumentMergeFlagItem(MergeItem).FlagsToRemove) = False
		      End Select
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName)
		    End Try
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
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ManageConfigSetsButton
	#tag Event
		Sub Pressed()
		  Call ConfigSetManagerWindow.Present(Self, Self.mDestination)
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
			"9 - Modeless Dialog"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
