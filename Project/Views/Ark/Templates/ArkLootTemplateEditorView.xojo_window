#tag DesktopWindow
Begin TemplateEditorView ArkLootTemplateEditorView
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
   Height          =   556
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
   Width           =   740
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   515
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
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   740
      Begin DesktopLabel LockExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Checking the box next to a quantity, quality, or blueprint chance will allow the values to be adjusted by modifiers."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   516
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   700
      End
      Begin DesktopUpDownArrows MaxItemsStepper
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   163
         Transparent     =   False
         Visible         =   True
         Width           =   13
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopUpDownArrows MinItemsStepper
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   23
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   129
         Transparent     =   False
         Visible         =   True
         Width           =   13
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedTextField MaxItemsField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   163
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MaxItemsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Max Items:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   163
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField MinItemsField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   129
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MinItemsLabels
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Min Items:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   129
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel GroupingLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Grouping:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   95
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel NameLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Name:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField GroupingField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   95
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   588
      End
      Begin UITweaks.ResizedTextField NameField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   588
      End
      Begin UITweaks.ResizedPushButton AddModifierButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add Modifier"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   114
      End
      Begin UITweaks.ResizedPushButton EditModifierButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   154
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DeleteModifierButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   246
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox ContentsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   6
         ColumnWidths    =   "30,*,100,120,100,100"
         DefaultRowHeight=   22
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
         HeadingIndex    =   "#ColumnDescription"
         Height          =   401
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   " 	Engram	Quantity	Quality	Blueprint %	Weight"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   103
         Transparent     =   True
         TypeaheadColumn =   1
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox ModifiersList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   6
         ColumnWidths    =   "30%,14%,14%,14%,14%,14%"
         DefaultRowHeight=   22
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
         Height          =   435
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Group	Min Quality Change	Max Quality Change	Quantity Multiplier	Blueprint % Multiplier	Weight Multiplier"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   101
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconSegmentedControl MapSelector
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowMultipleSelection=   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   ""
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   True
         Visible         =   True
         Width           =   700
      End
   End
   Begin OmniBar TemplateToolbar
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   740
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  If Self.Modified Then
		    FileSave.Enabled = True
		    If Self.mSaveFile <> Nil Then
		      FileSaveAs.Enabled = True
		    End If
		  End If
		  If Self.mSaveFile = Nil Then
		    FileExport.Enabled = True
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.MapSelector.LockChangeEvent
		  Self.MapSelector.RemoveAll
		  Var AllMaps() As Ark.Map = Ark.Maps.All
		  For Each Map As Ark.Map In AllMaps
		    Self.MapSelector.Add(Map.Name)
		  Next
		  Self.MapSelector.UnlockChangeEvent
		  Self.UpdateUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma unused Initial
		  
		  Self.MapSelector.Left = Self.ContentsList.Left + ((Self.ContentsList.Width - Self.MapSelector.Width) / 2)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShouldSave(CloseWhenFinished As Boolean)
		  Self.mCloseAfterSave = CloseWhenFinished
		  Self.Save()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconPreset
		  Dialog.SuggestedFileName = Self.mTemplate.Label + Beacon.FileExtensionTemplate
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If (File Is Nil) = False Then
		    Var Writer As New Beacon.JSONWriter(Self.mTemplate.SaveData, File)
		    Writer.Start
		  End If
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Call Self.Save()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconPreset
		  Dialog.SuggestedFileName = Self.mTemplate.Label + Beacon.FileExtensionTemplate
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If (File Is Nil) = False Then
		    Self.mSaveFile = File
		    Call Self.Save()
		  End If
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddEntriesToList(Entries() As Ark.LootTemplateEntry)
		  Var Maps() As Ark.Map = Self.FilteredMaps()
		  For Each Entry As Ark.LootTemplateEntry In Entries
		    Self.ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, Self.ContentsList.LastAddedRowIndex, Maps)
		  Next
		  Self.ContentsList.Sort
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Ark.LootTemplate, SourceFile As FolderItem = Nil)
		  Self.mTemplate = New Ark.MutableLootTemplate(Template)
		  Self.ViewID = Template.UUID
		  Self.mSaveFile = SourceFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelectedEntries(Warn As Boolean)
		  If Self.ContentsList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If Warn And Not Self.ShowConfirm(if(Self.ContentsList.SelectedRowCount = 1, "Are you sure you want to delete this entry?", "Are you sure you want to delete these " + Self.ContentsList.SelectedRowCount.ToString(Locale.Raw, "0") + " entries?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Not Self.ContentsList.RowSelectedAt(I) Then
		      Continue
		    End If
		    Var Entry As Ark.LootTemplateEntry = Self.ContentsList.RowTagAt(I)
		    Var Idx As Integer = Self.mTemplate.IndexOf(Entry)
		    If Idx > -1 Then
		      Self.mTemplate.RemoveAt(Idx)  
		      Self.Modified = True
		    End If
		    Self.ContentsList.RemoveRowAt(I)
		  Next
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries()
		  Var Entries() As Ark.LootItemSetEntry
		  For I As Integer = 0 To ContentsList.RowCount - 1
		    If Not ContentsList.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Entry As Ark.MutableLootTemplateEntry = ContentsList.RowTagAt(I)
		    Entries.Add(Entry)
		  Next
		  
		  If Entries.Count = 0 Then
		    Return
		  End If
		  
		  Var NewEntries() As Ark.LootItemSetEntry = ArkLootEntryEditor.Present(Self.TrueWindow, Entries)
		  If NewEntries Is Nil Or NewEntries.Count <> Entries.Count Then
		    Return
		  End If
		  
		  Var Maps() As Ark.Map = Self.FilteredMaps()
		  For Each NewEntry As Ark.LootItemSetEntry In NewEntries
		    Var OriginalEntry As Ark.LootTemplateEntry
		    Var OriginalIndex As Integer = -1
		    For Idx As Integer = 0 To Self.mTemplate.LastIndex
		      If Self.mTemplate(Idx).UUID = NewEntry.UUID Then
		        OriginalEntry = Self.mTemplate(Idx)
		        OriginalIndex = Idx
		        Exit For Idx
		      End If
		    Next
		    If OriginalIndex = -1 Then
		      System.DebugLog("Unable to find original entry " + NewEntry.UUID)
		      Break
		      Return
		    End If
		    
		    Var Item As New Ark.MutableLootTemplateEntry(NewEntry)
		    Item.Availability = OriginalEntry.Availability
		    Item.RespectQualityOffsets = OriginalEntry.RespectQualityOffsets
		    Item.RespectQuantityMultipliers = OriginalEntry.RespectQuantityMultipliers
		    Self.mTemplate(OriginalIndex) = Item
		    
		    For Idx As Integer = 0 To ContentsList.RowCount - 1
		      If Ark.LootTemplateEntry(ContentsList.RowTagAt(Idx)).UUID = OriginalEntry.UUID Then
		        Self.PutEntryInRow(Item, Idx, Maps)
		        Exit For Idx
		      End If
		    Next
		  Next
		  
		  ContentsList.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredMaps() As Ark.Map()
		  Var Maps() As Ark.Map
		  Var AllMaps() As Ark.Map = Ark.Maps.All
		  For Idx As Integer = 0 To Self.MapSelector.SegmentCount - 1
		    Var Cell As BeaconSegment = Self.MapSelector.Segment(Idx)
		    If Not Cell.Selected Then
		      Continue
		    End If
		    
		    Maps.Add(AllMaps(Idx))
		  Next
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinHeight() As UInteger
		  Return 455
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinWidth() As UInteger
		  Return 740
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PutEntryInRow(Entry As Ark.LootTemplateEntry, Index As Integer, Maps() As Ark.Map, SelectIt As Boolean = False)
		  If Index = -1 Then
		    Self.ContentsList.AddRow("")
		    Index = Self.ContentsList.LastAddedRowIndex
		  End If
		  
		  Var MapsValid, MapsInvalid As Integer
		  For Each Map As Ark.Map In Maps
		    If Entry.ValidForMap(Map) Then
		      MapsValid = MapsValid + 1
		    Else
		      MapsInvalid = MapsInvalid + 1
		    End If
		  Next
		  
		  If MapsValid = 0 Then
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = DesktopCheckbox.VisualStates.Unchecked
		  ElseIf MapsInvalid = 0 Then
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = DesktopCheckbox.VisualStates.Checked
		  Else
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = DesktopCheckbox.VisualStates.Indeterminate
		  End If
		  
		  Self.ContentsList.RowTagAt(Index) = Entry.MutableVersion
		  Self.ContentsList.CellTextAt(Index, Self.ColumnDescription) = Entry.Label
		  Self.ContentsList.CellTextAt(Index, Self.ColumnQuantity) = If(Entry.MinQuantity = Entry.MaxQuantity, Entry.MinQuantity.ToString(Locale.Current, "0"), Entry.MinQuantity.ToString(Locale.Current, "0") + "-" + Entry.MaxQuantity.ToString(Locale.Current, "0"))
		  Self.ContentsList.CellTextAt(Index, Self.ColumnQuality) = If(Entry.MinQuality = Entry.MaxQuality, Entry.MinQuality.Label, Entry.MinQuality.Label(False) + "-" + Entry.MaxQuality.Label(False))
		  Self.ContentsList.CellTextAt(Index, Self.ColumnBlueprint) = If(Entry.CanBeBlueprint, Entry.ChanceToBeBlueprint.ToString(Locale.Current, "0%"), "N/A")
		  Self.ContentsList.CellTextAt(Index, Self.ColumnWeight) = Entry.RawWeight.ToString(Locale.Current, "0,")
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnQuantity) = Entry.RespectQuantityMultipliers
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnQuality) = Entry.RespectQualityOffsets
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnBlueprint) = Entry.RespectBlueprintChanceMultipliers
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnWeight) = Entry.RespectWeightMultipliers
		  
		  If SelectIt Then
		    Self.ContentsList.RowSelectedAt(Index) = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Save()
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.Caption = Self.mTemplate.Label
		  End If
		  
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		  
		  If Self.mSaveFile Is Nil Then
		    Var SaveThread As New Beacon.SaveTemplateThread(Self.mTemplate)
		    AddHandler SaveThread.SaveComplete, AddressOf SaveThread_SaveComplete
		    SaveThread.Start
		  Else
		    Var Writer As New Beacon.JSONWriter(Self.mTemplate.SaveData, Self.mSaveFile)
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveThread_SaveComplete(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Self.ViewID = Self.mTemplate.UUID
		  
		  Self.Modified = False
		  NotificationKit.Post("Template Saved", Self.mTemplate)
		  
		  Self.Progress = BeaconSubview.ProgressNone
		  
		  If Self.mCloseAfterSave Then
		    Self.RequestClose()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEntries() As Ark.MutableLootTemplateEntry()
		  Var Entries() As Ark.MutableLootTemplateEntry
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Self.ContentsList.RowSelectedAt(I) Then
		      Entries.Add(Self.ContentsList.RowTagAt(I))
		    End If
		  Next
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddDialog()
		  Var Entries() As Ark.LootItemSetEntry = ArkLootEntryEditor.Present(Self.TrueWindow)
		  If Entries = Nil Or Entries.LastIndex = -1 Then
		    Return
		  End If
		  Self.ContentsList.SelectedRowIndex = -1
		  Var Maps() As Ark.Map = Self.FilteredMaps
		  For Each Entry As Ark.LootItemSetEntry In Entries
		    Var Item As New Ark.LootTemplateEntry(Entry)
		    Self.PutEntryInRow(Item, -1, Maps, True)
		    Self.mTemplate.Add(Item)
		    Self.Modified = True
		  Next
		  Self.ContentsList.Sort
		  Self.Pages.SelectedPanelIndex = Self.PageContents
		  Self.ContentsList.EnsureSelectionIsVisible
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowModifierEditor(Edit As Boolean)
		  Var EditID As String
		  If Edit And Self.ModifiersList.SelectedRowCount = 1 Then
		    EditID = Self.ModifiersList.RowTagAt(Self.ModifiersList.SelectedRowIndex)
		  End If
		  If ArkLootTemplateModifierEditor.Present(Self, Self.mTemplate, EditID) Then
		    Self.UpdateUI
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinAndMaxFields()
		  Var Focus As DesktopUIControl = Self.Window.Focus
		  
		  If Focus <> Self.MinItemsField Then
		    Self.MinItemsField.Text = Self.mTemplate.MinEntriesSelected.ToString(Locale.Current, "0")
		  End If
		  If Focus <> Self.MaxItemsField Then
		    Self.MaxItemsField.Text = Self.mTemplate.MaxEntriesSelected.ToString(Locale.Current, "0")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If (Self.mSaveFile Is Nil) = False Then
		    Self.Title = Self.mSaveFile.DisplayName
		  Else
		    Self.Title = Self.mTemplate.Label
		  End If
		  Self.ViewTitle = Self.Title
		  Self.mUpdating = True
		  Self.Modified = False
		  
		  Var Mask As UInt64 = Preferences.LastPresetMapFilter
		  Var AllMaps() As Ark.Map = Ark.Maps.All
		  For Idx As Integer = 0 To AllMaps.LastIndex
		    Self.MapSelector.Segment(Idx).Selected = (Mask And AllMaps(Idx).Mask) = AllMaps(Idx).Mask
		  Next
		  
		  Var Maps() As Ark.Map = Self.FilteredMaps()
		  Var SelectedEntries() As String
		  For I As Integer = 0 To Self.ContentsList.RowCount - 1
		    If Self.ContentsList.RowSelectedAt(I) Then
		      Var Entry As Ark.MutableLootTemplateEntry = Self.ContentsList.RowTagAt(I)
		      SelectedEntries.Add(Entry.UUID)
		    End If
		  Next
		  Self.ContentsList.RemoveAllRows()
		  For Each Entry As Ark.LootTemplateEntry In Self.mTemplate
		    Self.PutEntryInRow(Entry, -1, Maps, SelectedEntries.IndexOf(Entry.UUID) > -1)
		  Next
		  Self.ContentsList.Sort
		  
		  Self.NameField.Text = Self.mTemplate.Label
		  Self.GroupingField.Text = Self.mTemplate.Grouping
		  Self.UpdateMinAndMaxFields
		  
		  Var AppliedModifiers() As String = Self.mTemplate.ActiveSelectorIDs
		  Var Selectors() As Beacon.TemplateSelector = Beacon.CommonData.Pool.Get(False).GetTemplateSelectors("", Ark.Identifier)
		  Self.ModifiersList.RemoveAllRows()
		  For Each TemplateSelector As Beacon.TemplateSelector In Selectors
		    If AppliedModifiers.IndexOf(TemplateSelector.UUID) = -1 Then
		      Continue
		    End If
		    
		    Var QuantityMultiplier As Double = Self.mTemplate.QuantityMultiplier(TemplateSelector)
		    Var MinQualityModifier As Integer = Self.mTemplate.MinQualityOffset(TemplateSelector)
		    Var MaxQualityModifier As Integer = Self.mTemplate.MaxQualityOffset(TemplateSelector)
		    Var BlueprintMultiplier As Double = Self.mTemplate.BlueprintChanceMultiplier(TemplateSelector)
		    Var WeightMultiplier As Double = Self.mTemplate.WeightMultiplier(TemplateSelector)
		    
		    Var QuantityLabel As String = "x " + QuantityMultiplier.PrettyText(True)
		    Var BlueprintLabel As String = "x " + BlueprintMultiplier.PrettyText(True)
		    Var MinQualityLabel, MaxQualityLabel As String
		    If MinQualityModifier = 0 Then
		      MinQualityLabel = "No Change"
		    Else
		      MinQualityLabel = MinQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MinQualityModifier) <> 1, "s", "")
		    End If
		    If MaxQualityModifier = 0 Then
		      MaxQualityLabel = "No Change"
		    Else
		      MaxQualityLabel = MaxQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MaxQualityModifier) <> 1, "s", "")
		    End If
		    Var WeightLabel As String = "x " + WeightMultiplier.PrettyText(True)
		    
		    Self.ModifiersList.AddRow(TemplateSelector.Label, MinQualityLabel, MaxQualityLabel, QuantityLabel, BlueprintLabel, WeightLabel)
		    Self.ModifiersList.RowTagAt(Self.ModifiersList.LastAddedRowIndex) = TemplateSelector.UUID
		  Next TemplateSelector
		  Self.ModifiersList.HeadingIndex = 0
		  Self.ModifiersList.Sort
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "templates", "Templates")
		  Else
		    Return If(Lowercase, "template", "Template")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As FolderItem)
		  #Pragma Unused Sender
		  
		  Self.Modified = False
		  NotificationKit.Post("Template Saved", Self.mTemplate)
		  
		  Self.Progress = BeaconSubview.ProgressNone
		  Self.ViewID = EncodeHex(Crypto.MD5(Destination.NativePath))
		  
		  If Self.mCloseAfterSave Then
		    Self.RequestClose()
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCloseAfterSave As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplate As Ark.MutableLootTemplate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnBlueprint, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWeight, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModifierClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.presetmodifier", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageContents, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageModifiers, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSettings, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var GeneralTab As OmniBarItem = Self.TemplateToolbar.Item("GeneralTab")
		  If (GeneralTab Is Nil) = False Then
		    GeneralTab.Toggled = Me.SelectedPanelIndex = Self.PageSettings
		  End If
		  
		  Var ContentsTab As OmniBarItem = Self.TemplateToolbar.Item("ContentsTab")
		  If (ContentsTab Is Nil) = False Then
		    ContentsTab.Toggled = Me.SelectedPanelIndex = Self.PageContents
		  End If
		  
		  Var ModifiersTab As OmniBarItem = Self.TemplateToolbar.Item("ModifiersTab")
		  If (ModifiersTab Is Nil) = False Then
		    ModifiersTab.Toggled = Me.SelectedPanelIndex = Self.PageModifiers
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsStepper
	#tag Event
		Sub DownPressed()
		  Var NewValue As Integer = CDbl(Self.MaxItemsField.Text) - 1
		  Self.MaxItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var NewValue As Integer = CDbl(Self.MaxItemsField.Text) + 1
		  Self.MaxItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsStepper
	#tag Event
		Sub DownPressed()
		  Var NewValue As Integer = CDbl(Self.MinItemsField.Text) - 1
		  Self.MinItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  Var NewValue As Integer = CDbl(Self.MinItemsField.Text) + 1
		  Self.MinItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As Integer = Max(CDbl(Me.Text), 1)
		  If Self.mTemplate.MaxEntriesSelected <> Value Then
		    Self.mTemplate.MaxEntriesSelected = Value
		    Self.Modified = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Self.mTemplate.MaxEntriesSelected.ToString(Locale.Raw, "0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  Me.Text = Self.mTemplate.MaxEntriesSelected.ToString(Locale.Raw, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As Integer = Max(CDbl(Me.Text), 1)
		  If Self.mTemplate.MinEntriesSelected <> Value Then
		    Self.mTemplate.MinEntriesSelected = Value
		    Self.Modified = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Self.mTemplate.MinEntriesSelected.ToString(Locale.Raw, "0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  Me.Text = Self.mTemplate.MinEntriesSelected.ToString(Locale.Raw, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupingField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As String = Me.Text.Trim
		  If Value <> "" And Self.mTemplate.Grouping.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mTemplate.Grouping = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As String = Me.Text.Trim
		  If Value <> "" And Self.mTemplate.Label.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mTemplate.Label = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddModifierButton
	#tag Event
		Sub Pressed()
		  Self.ShowModifierEditor(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditModifierButton
	#tag Event
		Sub Pressed()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteModifierButton
	#tag Event
		Sub Pressed()
		  Self.ModifiersList.DoClear()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(Self.ColumnIncluded) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnQuantity) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnQuality) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnBlueprint) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnWeight) = DesktopListBox.CellTypes.CheckBox
		  Me.TypeaheadColumn = Self.ColumnDescription
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Var State As DesktopCheckbox.VisualStates = Me.CellCheckBoxStateAt(Row, Column)
		    If State = DesktopCheckbox.VisualStates.Indeterminate Then
		      Return
		    End If
		    
		    Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Row)
		    Var Maps() As Ark.Map = Self.FilteredMaps
		    For Each Map As Ark.Map In Maps
		      If Entry.ValidForMap(Map) <> (State = DesktopCheckbox.VisualStates.Checked) Then
		        Entry.ValidForMap(Map) = (State = DesktopCheckbox.VisualStates.Checked)
		        Self.mTemplate.Add(Entry)
		        Self.Modified = True
		      End If
		    Next
		    Return
		  Case Self.ColumnQuantity
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Row)
		    If Entry.RespectQuantityMultipliers <> Checked Then
		      Entry.RespectQuantityMultipliers = Checked
		      Self.mTemplate.Add(Entry)
		      Self.Modified = True
		    End If
		  Case Self.ColumnQuality
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Row)
		    If Entry.RespectQualityOffsets <> Checked Then
		      Entry.RespectQualityOffsets = Checked
		      Self.mTemplate.Add(Entry)
		      Self.Modified = True
		    End If
		  Case Self.ColumnBlueprint
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Row)
		    If Entry.RespectBlueprintChanceMultipliers <> Checked Then
		      Entry.RespectBlueprintChanceMultipliers = Checked
		      Self.mTemplate.Add(Entry)
		      Self.Modified = True
		    End If
		  Case Self.ColumnWeight
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Row)
		    If Entry.RespectWeightMultipliers <> Checked Then
		      Entry.RespectWeightMultipliers = Checked
		      Self.mTemplate.Add(Entry)
		      Self.Modified = True
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var Item As DesktopMenuItem
		  
		  Item = New DesktopMenuItem
		  Item.Text = "Create Blueprint Entry"
		  Item.Enabled = Me.SelectedRowCount > 0
		  Item.Tag = "createblueprintentry"
		  Base.AddMenu(Item)
		  
		  Item = New DesktopMenuItem
		  Item.Text = "Match Official Availability"
		  Item.Enabled = Me.SelectedRowCount > 0
		  Item.Tag = "matchavailability"
		  Base.AddMenu(Item)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Var Entries() As Ark.LootTemplateEntry
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(Idx) = False Then
		        Continue
		      End If
		      
		      Entries.Add(Me.RowTagAt(Idx))
		    Next Idx
		    
		    Var CreatedEntries() As Ark.LootTemplateEntry = Self.mTemplate.AddBlueprintEntries(Entries)
		    If CreatedEntries.Count = 0 Then
		      Return True
		    End If
		    
		    Var SelectedMaps() As Ark.Map = Self.FilteredMaps()
		    For Each Entry As Ark.LootTemplateEntry In CreatedEntries
		      Self.PutEntryInRow(Entry, -1, SelectedMaps, True)
		    Next Entry
		    
		    Me.Sort
		    Me.EnsureSelectionIsVisible()
		    Self.Modified = True
		  Case "matchavailability"
		    Var Changed As Boolean
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(Idx) = False Then
		        Continue
		      End If
		      
		      Var Entry As Ark.MutableLootTemplateEntry = Me.RowTagAt(Idx)
		      Var Availability As UInt64
		      For Each Option As Ark.LootItemSetEntryOption In Entry
		        Availability = Availability Or Option.Engram.Availability
		      Next
		      If Entry.Availability <> Availability Then
		        Self.mTemplate.Add(Entry)
		        Changed = True
		        Self.PutEntryInRow(Entry, Idx, Self.FilteredMaps)
		      End If
		    Next
		    
		    If Changed Then
		      Me.Sort
		      Me.EnsureSelectionIsVisible()
		      Self.Modified = True
		    End If
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.DeleteSelectedEntries(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var EditEntriesButton As OmniBarItem = Self.TemplateToolbar.Item("EditEntriesButton")
		  If (EditEntriesButton Is Nil) = False Then
		    EditEntriesButton.Enabled = Me.CanEdit()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModifiersList
	#tag Event
		Sub SelectionChanged()
		  EditModifierButton.Enabled = Me.SelectedRowCount = 1
		  DeleteModifierButton.Enabled = Me.SelectedRowCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.ModifierClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn And Not Self.ShowConfirm(if(Self.ModifiersList.SelectedRowCount = 1, "Are you sure you want to delete this modifier?", "Are you sure you want to delete these " + Self.ModifiersList.SelectedRowCount.ToString(Locale.Raw, "0") + " modifiers?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ModifiersList.RowCount - 1 DownTo 0
		    If Not Self.ModifiersList.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var ModifierID As String = Self.ModifiersList.RowTagAt(I)
		    Self.mTemplate.ClearSelector(ModifierID)
		    Self.ModifiersList.RemoveRowAt(I)
		    Self.Modified = True
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Modifiers As New Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var ModifierID As String = Me.RowTagAt(I)
		    Var Dict As New Dictionary
		    Dict.Value("Quantity") = Self.mTemplate.QuantityMultiplier(ModifierID)
		    Dict.Value("MinQuality") = Self.mTemplate.MinQualityOffset(ModifierID)
		    Dict.Value("MaxQuality") = Self.mTemplate.MaxQualityOffset(ModifierID)
		    Dict.Value("Blueprint") = Self.mTemplate.BlueprintChanceMultiplier(ModifierID)
		    Dict.Value("Weight") = Self.mTemplate.WeightMultiplier(ModifierID)
		    Modifiers.Value(ModifierID) = Dict
		  Next
		  
		  Board.RawData(Self.ModifierClipboardType) = Beacon.GenerateJSON(Modifiers, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.ModifierClipboardType) Then
		    Return
		  End If
		  
		  Try
		    Var Data As String = Board.RawData(Self.ModifierClipboardType).DefineEncoding(Encodings.UTF8)
		    Var Modifiers As Dictionary = Beacon.ParseJSON(Data)
		    
		    For Each Entry As DictionaryEntry In Modifiers
		      Var ModifierID As String = Entry.Key
		      Var Dict As Dictionary = Entry.Value
		      
		      If Dict.HasKey("Quantity") Then
		        Self.mTemplate.QuantityMultiplier(ModifierID) = Dict.Value("Quantity")
		      End If
		      If Dict.HasKey("MinQuality") And Dict.HasKey("MaxQuality") Then
		        Self.mTemplate.MinQualityOffset(ModifierID) = Dict.Value("MinQuality")
		        Self.mTemplate.MaxQualityOffset(ModifierID) = Dict.Value("MaxQuality")
		      ElseIf Dict.HasKey("Quality") Then
		        Self.mTemplate.MinQualityOffset(ModifierID) = Dict.Value("Quality")
		        Self.mTemplate.MaxQualityOffset(ModifierID) = Dict.Value("Quality")
		      End If
		      If Dict.HasKey("Blueprint") Then
		        Self.mTemplate.BlueprintChanceMultiplier(ModifierID) = Dict.Value("Blueprint")
		      End If
		      If Dict.HasKey("Weight") Then
		        Self.mTemplate.WeightMultiplier(ModifierID) = Dict.Value("Weight")
		      End If
		    Next
		    
		    Self.UpdateUI()
		    Self.Modified = True
		  Catch Err As RuntimeException
		    Return
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapSelector
	#tag Event
		Sub Pressed()
		  If Self.mUpdating = True Then
		    Return
		  End If
		  
		  Self.mUpdating = True
		  
		  Var Maps() As Ark.Map = Self.FilteredMaps
		  Preferences.LastPresetMapFilter = Maps.Mask
		  
		  For I As Integer = ContentsList.RowCount - 1 DownTo 0
		    Var Entry As Ark.LootTemplateEntry = ContentsList.RowTagAt(I)
		    Self.PutEntryInRow(Entry, I, Maps, ContentsList.RowSelectedAt(I))
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplateToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTab("GeneralTab", "General"))
		  Me.Append(OmniBarItem.CreateTab("ContentsTab", "Contents"))
		  Me.Append(OmniBarItem.CreateTab("ModifiersTab", "Modifiers"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddEntriesButton", "New Entry", IconToolbarAdd, "Add engrams to this template."))
		  Me.Append(OmniBarItem.CreateButton("EditEntriesButton", "Edit", IconToolbarEdit, "Edit the selected entries.", False))
		  
		  Me.Item("GeneralTab").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEntriesButton"
		    Self.ShowAddDialog()
		  Case "EditEntriesButton"
		    Self.EditSelectedEntries()
		  Case "GeneralTab"
		    Self.Pages.SelectedPanelIndex = Self.PageSettings
		  Case "ContentsTab"
		    Self.Pages.SelectedPanelIndex = Self.PageContents
		  Case "ModifiersTab"
		    Self.Pages.SelectedPanelIndex = Self.PageModifiers
		  End Select
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
