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
   Height          =   400
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
   MinWidth        =   600
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Import From Document"
   Visible         =   True
   Width           =   600
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
      Text            =   "Select Groups to Import"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "20,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   296
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
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
      Top             =   52
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
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
      Left            =   500
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
      Top             =   360
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
      Left            =   408
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
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
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
		Private Sub CheckEnabled()
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.CellCheckBoxValueAt(I, 0) Then
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

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, SourceDocuments() As Beacon.Document, DestinationDocument As Beacon.Document, Callback As MergeFinishedCallback = Nil)
		  Var Accounts As New Beacon.ExternalAccountManager
		  For Each Document As Beacon.Document In SourceDocuments
		    Accounts.Import(Document.Accounts)
		  Next
		  
		  Var UseMergeUI As Boolean
		  For Each Document As Beacon.Document In SourceDocuments
		    Var Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		    For Each Config As Beacon.ConfigGroup In Configs
		      If Config.SupportsMerging And Document.HasConfigGroup(Config.ConfigName) Then
		        UseMergeUI = True
		        Exit For Document
		      End If
		    Next
		  Next
		  
		  Var Win As New DocumentMergerWindow
		  Win.mDestination = DestinationDocument
		  Win.mExternalAccounts = Accounts
		  Win.mCallback = Callback
		  Win.mConfigCounts = New Dictionary
		  
		  If UseMergeUI Then
		    Win.List.ColumnCount = 3
		    Win.List.HasHeader = True
		    Win.List.HeaderAt(0) = " "
		    Win.List.HeaderAt(1) = "Group"
		    Win.List.HeaderAt(2) = "Merge Mode"
		  End If
		  
		  Var ExistingConfigs() As Beacon.ConfigGroup = DestinationDocument.ImplementedConfigs
		  For Each Config As Beacon.ConfigGroup In ExistingConfigs
		    Win.mConfigCounts.Value(Config.ConfigName) = Win.mConfigCounts.Lookup(Config.ConfigName, 0) + 1
		  Next
		  
		  Var Enabled As Boolean
		  Var UsePrefixes As Boolean = SourceDocuments.LastRowIndex > 0
		  Var UniqueMods As New Dictionary
		  For Each Document As Beacon.Document In SourceDocuments
		    Var Prefix As String = If(UsePrefixes, Document.Title + ": ", "")
		    Var Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		    For Each Config As Beacon.ConfigGroup In Configs
		      Win.mConfigCounts.Value(Config.ConfigName) = Win.mConfigCounts.Lookup(Config.ConfigName, 0) + 1
		      
		      Var CurrentConfig As Beacon.ConfigGroup = DestinationDocument.ConfigGroup(Config.ConfigName)
		      Var CellContent As String = Prefix + Language.LabelForConfig(Config)
		      If Not Config.WasPerfectImport Then
		        If Win.List.DefaultRowHeight <> 40 Then
		          Win.List.DefaultRowHeight = 40
		        End If
		        CellContent = CellContent + EndOfLine + "This imported config group is not perfect. Beacon will make a close approximation."
		      End If
		      Win.List.AddRow("", CellContent)
		      Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) = UsePrefixes = False And Config.DefaultImported And (CurrentConfig = Nil Or CurrentConfig.IsImplicit)
		      Win.List.RowTagAt(Win.List.LastAddedRowIndex) = Config
		      If UseMergeUI Then
		        Win.List.CellTagAt(Win.List.LastAddedRowIndex, 2) = 0
		        If Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) Then
		          Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = If(CurrentConfig = Nil, StrAdd, StrReplace)
		        Else
		          Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = StrDoNotImport
		        End If
		      End If
		      Enabled = Enabled Or Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0)
		    Next
		    For I As Integer = 0 To Document.ServerProfileCount - 1
		      If Document.ServerProfile(I).Name.Length = 0 Then
		        Continue For I
		      End If
		      
		      For X As Integer = 0 To DestinationDocument.ServerProfileCount - 1
		        If DestinationDocument.ServerProfile(X) = Document.ServerProfile(I) Then
		          DestinationDocument.ServerProfile(X).UpdateDetailsFrom(Document.ServerProfile(I))
		          Continue For I
		        End If
		      Next
		      Win.List.AddRow("", Document.ServerProfile(I).LinkPrefix + " Link: " + Document.ServerProfile(I).Name)
		      Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) = True
		      Win.List.RowTagAt(Win.List.LastAddedRowIndex) = Document.ServerProfile(I)
		      If UseMergeUI Then
		        Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = If(Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0), StrAdd, StrDoNotImport)
		      End If
		      Enabled = Enabled Or Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0)
		    Next
		    
		    Var EnabledMods() As String = Document.Mods
		    For Each ModID As String In EnabledMods
		      If UniqueMods.HasKey(ModID) Then
		        Continue
		      End If
		      UniqueMods.Value(ModID) = True
		      
		      Var ModInfo As Beacon.ModDetails = LocalData.SharedInstance.ModWithID(ModID)
		      If (ModInfo Is Nil) = False And DestinationDocument.ModEnabled(ModID) = False Then
		        Win.List.AddRow("", "Enable Mod: " + ModInfo.Name)
		        Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) = True
		        Win.List.RowTagAt(Win.List.LastAddedRowIndex) = ModInfo
		        If UseMergeUI Then
		          Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = StrAdd
		        End If
		        Enabled = True
		      End If
		    Next
		  Next
		  
		  Var CurrentMask As UInt64 = DestinationDocument.MapCompatibility
		  Var DesiredMask As UInt64
		  For Each Document As Beacon.Document In SourceDocuments
		    DesiredMask = DesiredMask Or Document.MapCompatibility
		    For I As Integer = 0 To Document.ServerProfileCount - 1
		      DesiredMask = DesiredMask Or Document.ServerProfile(I).Mask
		    Next
		  Next
		  For I As Integer = 0 To DestinationDocument.ServerProfileCount - 1
		    DesiredMask = DesiredMask Or DestinationDocument.ServerProfile(I).Mask
		  Next
		  Var MaskDiff As UInt64 = CurrentMask Xor DesiredMask
		  Var MaskToAdd As UInt64 = DesiredMask And MaskDiff
		  Var MaskToRemove As UInt64 = CurrentMask And MaskDiff
		  Var NewMaps() As Beacon.Map = Beacon.Maps.ForMask(MaskToAdd)
		  Var OldMaps() As Beacon.Map = Beacon.Maps.ForMask(MaskToRemove)
		  For Each Map As Beacon.Map In NewMaps
		    Win.List.AddRow("", "Add Map: " + Map.Name)
		    Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) = True
		    Win.List.RowTagAt(Win.List.LastAddedRowIndex) = "Map+" + Str(Map.Mask)
		    If UseMergeUI Then
		      Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = If(Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0), StrAdd, StrDoNotImport)
		    End If
		    Enabled = Enabled Or Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0)
		  Next
		  For Each Map As Beacon.Map In OldMaps
		    Win.List.AddRow("", "Remove Map: " + Map.Name)
		    Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0) = True
		    Win.List.RowTagAt(Win.List.LastAddedRowIndex) = "Map-" + Str(Map.Mask)
		    If UseMergeUI Then
		      Win.List.CellValueAt(Win.List.LastAddedRowIndex, 2) = If(Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0), StrAdd, StrDoNotImport)
		    End If
		    Enabled = Enabled Or Win.List.CellCheckBoxValueAt(Win.List.LastAddedRowIndex, 0)
		  Next
		  Win.ActionButton.Enabled = Enabled
		  
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldAddCustomConfig() As Boolean
		  If Self.mHasWarnedAboutCustomConfig Then
		    Return True
		  End If
		  
		  If Self.mDestination.HasConfigGroup(BeaconConfigs.CustomContent.ConfigName) Then
		    // Since the destination already has custom content, don't warn them again.
		    Self.mHasWarnedAboutCustomConfig = True
		    Return True
		  End If
		  
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("Are you sure you want to import Custom Config Content?", "If you intend to continue to configure the server outside of Beacon, it is recommended that you do not import the Custom Config Content.", "Import", "Cancel", "Learn More")
		  If Choice = BeaconUI.ConfirmResponses.Alternate Then
		    ShowURL(Beacon.WebURL("/help/using_custom_ini_content_with"))
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
		Private Sub TriggerCallback()
		  Self.mCallback.Invoke()
		  Self.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCallback As MergeFinishedCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigCounts As Dictionary
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


	#tag Constant, Name = MergeModeOtherPriority, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MergeModeSelfPriority, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StrAdd, Type = String, Dynamic = False, Default = \"Add", Scope = Private
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
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Column
		  
		  Var Tag As Variant = Me.RowTagAt(Row)
		  If Me.ColumnCount >= 3 Then
		    If Tag IsA Beacon.ConfigGroup Then
		      Var Group As Beacon.ConfigGroup = Tag
		      If Me.CellCheckBoxValueAt(Row, 0) Then
		        If Group IsA BeaconConfigs.CustomContent And Self.ShouldAddCustomConfig() = False Then
		          Me.CellCheckBoxValueAt(Row, 0) = False
		          Me.CellValueAt(Row, 2) = Self.StrDoNotImport
		          Me.CellTagAt(Row, 2) = -1
		          Return
		        End If
		        
		        Select Case Me.CellTagAt(Row, 2).IntegerValue
		        Case 0
		          If Self.mDestination.HasConfigGroup(Group.ConfigName) Then
		            Me.CellValueAt(Row, 2) = Self.StrReplace
		          Else
		            Me.CellValueAt(Row, 2) = Self.StrAdd
		          End If
		        Case Self.MergeModeSelfPriority
		          Me.CellValueAt(Row, 2) = Self.StrMergeSelf
		        Case Self.MergeModeOtherPriority
		          Me.CellValueAt(Row, 2) = Self.StrMergeOther
		        End Select
		      Else
		        Me.CellValueAt(Row, 2) = Self.StrDoNotImport
		      End If
		    Else
		      If Me.CellCheckBoxValueAt(Row, 0) Then
		        Me.CellValueAt(Row, 2) = Self.StrAdd
		      Else
		        Me.CellValueAt(Row, 2) = Self.StrDoNotImport
		      End If
		    End If
		  End If
		  
		  Self.CheckEnabled()
		End Sub
	#tag EndEvent
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  If Column <> 2 Then
		    Return False
		  End If
		  
		  Var Tag As Variant = Me.RowTagAt(Row)
		  If Not (Tag IsA Beacon.ConfigGroup) Then
		    Return False
		  End If
		  
		  Var Menu As New MenuItem
		  Var Mode As Integer = Me.CellTagAt(Row, Column)
		  Var IsImported As Boolean = Me.CellCheckBoxValueAt(Row, 0)
		  
		  Var DoNothingItem As New MenuItem(Self.StrDoNotImport, -1)
		  DoNothingItem.HasCheckMark = (IsImported = False)
		  Menu.AddMenu(DoNothingItem)
		  
		  If Self.mConfigCounts.Lookup(Beacon.ConfigGroup(Tag).ConfigName, 0) > 1 Then
		    Var ReplaceItem As New MenuItem(Self.StrReplace, 0)
		    ReplaceItem.HasCheckMark = (IsImported And Mode = 0)
		    Menu.AddMenu(ReplaceItem)
		    
		    If Beacon.ConfigGroup(Tag).SupportsMerging Then
		      Var MergeSelfItem As New MenuItem(Self.StrMergeSelf, Self.MergeModeSelfPriority)
		      MergeSelfItem.HasCheckMark = (IsImported And Mode = Self.MergeModeSelfPriority)
		      Menu.AddMenu(MergeSelfItem)
		      
		      Var MergeOtherItem As New MenuItem(Self.StrMergeOther, Self.MergeModeOtherPriority)
		      MergeOtherItem.HasCheckMark = (IsImported And Mode = Self.MergeModeOtherPriority)
		      Menu.AddMenu(MergeOtherItem)
		    End If
		  Else
		    Var AddItem As New MenuItem(Self.StrAdd, 0)
		    AddItem.HasCheckMark = (IsImported And Mode = 0)
		    Menu.AddMenu(AddItem)
		  End If
		  
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
		  
		  Var Choice As MenuItem = Menu.PopUp(OffsetX + X, OffsetY + Y)
		  If Choice = Nil Then
		    Return True
		  End If
		  
		  If Tag IsA BeaconConfigs.CustomContent And Choice.Tag.IntegerValue > -1 And Self.ShouldAddCustomConfig() = False Then
		    Return True
		  End If
		  
		  If Choice.Tag.IntegerValue > -1 Then
		    Me.CellTagAt(Row, Column) = Choice.Tag
		  End If
		  Me.CellValueAt(Row, Column) = Choice.Value
		  Me.CellCheckBoxValueAt(Row, 0) = Choice.Tag <> -1
		  
		  Self.CheckEnabled()
		End Function
	#tag EndEvent
	#tag Event
		Function CellTextPaint(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused Row
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  If Column <> 2 Then
		    Return False
		  End If
		  
		  Const IndicatorWidth = 8
		  Const IndicatorHeight = 4
		  
		  Var LineEnd As Integer = Ceil(HorizontalPosition + G.TextWidth(Line))
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
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var PreviousMods As New Beacon.StringList(Self.mDestination.Mods)
		  
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.CellCheckBoxValueAt(I, 0) Or Self.List.RowTagAt(I) = Nil Then
		      Continue
		    End If
		    
		    Var Tag As Variant = Self.List.RowTagAt(I)
		    Select Case Tag.Type
		    Case Variant.TypeObject
		      Select Case Tag
		      Case IsA Beacon.ConfigGroup
		        Var Config As Beacon.ConfigGroup = Tag
		        If Self.List.ColumnCount >= 3 And Self.List.CellTagAt(I, 2).IntegerValue > 0 And Config.SupportsMerging And Self.mDestination.HasConfigGroup(Config.ConfigName) Then
		          Var MergeMode As Integer = Self.List.CellTagAt(I, 2).IntegerValue
		          Var ExistingConfig As Beacon.ConfigGroup = Self.mDestination.ConfigGroup(Config.ConfigName, False)
		          Select Case MergeMode
		          Case Self.MergeModeSelfPriority
		            Call ExistingConfig.Merge(Config)
		          Case Self.MergeModeOtherPriority
		            If Config.Merge(ExistingConfig) Then
		              Self.mDestination.AddConfigGroup(Config)
		            End If
		          End Select
		        Else
		          Self.mDestination.AddConfigGroup(Config)
		        End If
		      Case IsA Beacon.ServerProfile
		        Var Profile As Beacon.ServerProfile = Tag
		        Self.mDestination.Add(Profile)
		        
		        If Profile.ExternalAccountUUID <> Nil Then
		          Var Account As Beacon.ExternalAccount = Self.mExternalAccounts.GetByUUID(Profile.ExternalAccountUUID)
		          If (Account Is Nil) = False Then
		            Self.mDestination.Accounts.Add(Account)
		          End If
		        End If
		      Case IsA Beacon.ModDetails
		        Self.mDestination.ModEnabled(Beacon.ModDetails(Tag).ModID) = True
		      End Select
		    Case Variant.TypeString
		      Var StringValue As String = Tag.StringValue
		      If StringValue.BeginsWith("Map") Then
		        Var Operator As String = StringValue.Middle(3, 1)
		        Var Mask As UInt64 = Val(StringValue.Middle(4))
		        If Operator = "+" Then
		          Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility Or Mask
		        Else
		          Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility And Not Mask
		        End If
		      End If
		    End Select
		  Next
		  
		  If Self.mDestination.Mods <> PreviousMods Then
		    Var Notification As New Beacon.UserNotification("The list of mods enabled for document """ + Self.mDestination.Title + """ has changed.")
		    Notification.SecondaryMessage = "You can change the enabled mods in the """ + Language.LabelForConfig(BeaconConfigs.Metadata.ConfigName) + """ config group."
		    LocalData.SharedInstance.SaveNotification(Notification)
		  End If
		  
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
