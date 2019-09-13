#tag Window
Begin BeaconContainer ModDetailView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   864
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   419
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   "True"
      Top             =   0
      Transparent     =   False
      Value           =   3
      Visible         =   True
      Width           =   864
      Begin UITweaks.ResizedTextField ConfirmField
         AcceptTabs      =   False
         Alignment       =   "2"
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   380
      End
      Begin ReactionButton CopyButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Copy To Clipboard"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   131
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label ConfirmExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   86
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "You have not yet confirmed ownership of this mod. To so do, please copy the value below and insert it anywhere on the mod's Steam page. Then press the ""Confirm Ownership"" button below. Once confirmed, the text can be removed from your Steam page."
         TextAlign       =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   101
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   380
      End
      Begin UITweaks.ResizedPushButton ConfirmButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Confirm Ownership"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   288
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label NoSelectionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "No Mod Selected"
         TextAlign       =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   824
      End
      Begin ProgressBar LoadingIndicator
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   262
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   "True"
         Top             =   199
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   340
      End
      Begin BeaconListbox EngramList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   False
         ColumnCount     =   11
         ColumnsResizable=   False
         ColumnWidths    =   "*,*,100,75,75,75,75,75,75,75,75"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   "0"
         GridLinesVertical=   "0"
         HasHeading      =   True
         HeadingIndex    =   1
         Height          =   378
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Path	Label	Blueprintable	Island	Scorched	Aberration	Extinction	Genesis	Center	Ragnarok	Valguero"
         Italic          =   False
         Left            =   0
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
         SelectionType   =   "1"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   41
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   False
         Visible         =   True
         Width           =   864
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconToolbar Header
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Mod Detail"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   40
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Resizer         =   ""
         ResizerEnabled  =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   864
      End
      Begin BeaconToolbar NoSelectionHeader
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "No Mod Selected"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   41
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Resizer         =   ""
         ResizerEnabled  =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   864
      End
      Begin BeaconToolbar LoadingHeader
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Mod Detail"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   41
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Resizer         =   ""
         ResizerEnabled  =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   864
      End
      Begin BeaconToolbar ConfirmationHeader
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Untitled"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   41
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Resizer         =   ""
         ResizerEnabled  =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   864
      End
   End
   Begin BeaconAPI.Socket Socket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin FadedSeparator HeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   864
   End
   Begin Beacon.EngramSearcherThread Searcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Self.Searcher.Cancel
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.mEngramSets = New Dictionary
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  ConfirmField.Left = Panel.Left + ((Panel.Width - ConfirmField.Width) / 2)
		  ConfirmExplanation.Left = ConfirmField.Left
		  CopyButton.Left = Panel.Left + ((Panel.Width - (CopyButton.Width + 12 + ConfirmButton.Width)) / 2)
		  ConfirmButton.Left = CopyButton.Left + CopyButton.Width + 12
		  
		  ConfirmField.Top = Panel.Top + ((Panel.Height - ConfirmField.Height) / 2)
		  ConfirmExplanation.Top = ConfirmField.Top - (12 + ConfirmExplanation.Height)
		  CopyButton.Top = ConfirmField.Top + ConfirmField.Height + 12
		  ConfirmButton.Top = CopyButton.Top
		  
		  NoSelectionLabel.Top = Panel.Top + ((Panel.Height - NoSelectionLabel.Height) / 2)
		  
		  LoadingIndicator.Top = Panel.Top + ((Panel.Height - LoadingIndicator.Height) / 2)
		  LoadingIndicator.Left = Panel.Left + ((Panel.Width - LoadingIndicator.Width) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_ConfirmMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.Success Then
		    Self.CurrentMod.Constructor(Response.JSON)
		    If Self.CurrentMod.Confirmed Then
		      Panel.SelectedPanelIndex = PageEngrams
		      Self.ShowAlert("Mod ownership confirmed.", "You may now remove the confirmation code from your Steam page.")
		    Else
		      Panel.SelectedPanelIndex = PageNeedsConfirmation
		      Self.ShowAlert("Mod ownership has not been confirmed.", "The confirmation code was not found on mod's Steam page.")
		    End If
		  Else
		    Panel.SelectedPanelIndex = PageNeedsConfirmation
		    Self.ShowAlert("Mod ownership has not been confirmed.", Response.Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsDelete(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    Panel.SelectedPanelIndex = PageEngrams
		    Self.ShowAlert("Unable to delete engrams.", Response.Message)
		    Return
		  End If
		  
		  Panel.SelectedPanelIndex = PageEngrams
		  Self.EngramSet.ClearModifications(False)
		  Header.PublishButton.Enabled = False
		  Self.ShowAlert("Engrams published.", "Your changes are now live.")
		  LocalData.SharedInstance.CheckForEngramUpdates()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsLoad(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.mEngramSets.Value(Self.CurrentMod.ModID) = New BeaconAPI.EngramSet(Response.JSON)
		  Self.ShowCurrentEngrams()
		  Panel.SelectedPanelIndex = PageEngrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsPost(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    Panel.SelectedPanelIndex = PageEngrams
		    Self.ShowAlert("Unable to save engrams.", Response.Message)
		    Return
		  End If
		  
		  If Self.DeletePendingEngrams Then
		    Return
		  End If
		  
		  Panel.SelectedPanelIndex = PageEngrams
		  Self.EngramSet.ClearModifications(False)
		  Header.PublishButton.Enabled = False
		  Self.ShowAlert("Engrams published.", "Your changes are now live.")
		  LocalData.SharedInstance.CheckForEngramUpdates()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mStates = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DeletePendingEngrams() As Boolean
		  Dim DeletedEngrams() As BeaconAPI.Engram = Self.EngramSet.EngramsToDelete
		  If DeletedEngrams.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Panel.SelectedPanelIndex = PageLoading
		  
		  Dim UIDs() As String
		  For Each Engram As BeaconAPI.Engram In DeletedEngrams
		    UIDs.Append(Engram.UID)
		  Next
		  
		  Dim Request As New BeaconAPI.Request("engram.php", "DELETE", UIDs.Join(","), "text/plain", AddressOf APICallback_EngramsDelete)
		  Request.Authenticate(Preferences.OnlineToken)
		  Self.Socket.Start(Request)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EngramSet() As BeaconAPI.EngramSet
		  If Self.mCurrentMod = Nil Then
		    Return Nil
		  End If
		  
		  If Self.mEngramSets = Nil Then
		    Self.mEngramSets = New Dictionary
		  End If
		  
		  If Not Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) Then
		    Dim Placeholder() As Variant
		    Self.mEngramSets.Value(Self.mCurrentMod.ModID) = New BeaconAPI.EngramSet(Placeholder)
		  End If
		  
		  Return Self.mEngramSets.Value(Self.mCurrentMod.ModID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportText(Contents As String)
		  Self.Searcher.Search(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Publish()
		  If Self.SavePendingEngrams() Then
		    Return
		  End If
		  
		  If Self.DeletePendingEngrams() Then
		    Return
		  End If
		  
		  Self.ShowAlert("Nothing to publish", "Sorry about that, it seems like the publish button should not be enabled.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RestoreListState()
		  If Self.mCurrentMod = Nil Then
		    Return
		  End If
		  
		  Dim ModID As String = Self.mCurrentMod.ModID
		  If Not Self.mStates.HasKey(ModID) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary = Self.mStates.Value(ModID)
		  
		  Dim Selected() As String = Dict.Value("Selected")
		  For I As Integer = 0 To Self.EngramList.RowCount - 1
		    Dim Engram As BeaconAPI.Engram = Self.EngramList.RowTagAt(I)
		    Self.EngramList.Selected(I) = Selected.IndexOf(Engram.ID) > -1
		  Next
		  
		  Self.EngramList.ScrollPosition = Dict.Value("Position")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveListState()
		  If Self.mCurrentMod = Nil Then
		    Return
		  End If
		  
		  Dim Selected() As String
		  For I As Integer = 0 To Self.EngramList.RowCount - 1
		    Dim Engram As BeaconAPI.Engram = Self.EngramList.RowTagAt(I)
		    If Self.EngramList.Selected(I) Then
		      Selected.Append(Engram.ID)
		    End If
		  Next
		  
		  Dim ModID As String = Self.mCurrentMod.ModID
		  
		  Dim Dict As New Dictionary
		  Dict.Value("Position") = Self.EngramList.ScrollPosition
		  Dict.Value("Selected") = Selected
		  Self.mStates.Value(ModID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SavePendingEngrams() As Boolean
		  Dim NewEngrams() As BeaconAPI.Engram = Self.EngramSet.EngramsToSave
		  If NewEngrams.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Panel.SelectedPanelIndex = PageLoading
		  
		  Dim Dicts() As Dictionary
		  For Each Engram As BeaconAPI.Engram In NewEngrams
		    Dicts.Append(Engram.AsDictionary)
		  Next
		  
		  Dim Content As String = Beacon.GenerateJSON(Dicts, False)
		  Dim Request As New BeaconAPI.Request("engram.php", "POST", Content, "application/json", AddressOf APICallback_EngramsPost)
		  Request.Authenticate(Preferences.OnlineToken)
		  Self.Socket.Start(Request)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCurrentEngrams()
		  Self.EngramList.RemoveAllRows
		  
		  If Self.mCurrentMod = Nil Or Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) = False Then
		    Return
		  End If
		  
		  Dim EngramSet As BeaconAPI.EngramSet = Self.mEngramSets.Value(Self.mCurrentMod.ModID)
		  Dim Engrams() As BeaconAPI.Engram = EngramSet.ActiveEngrams
		  For Each Engram As BeaconAPI.Engram In Engrams
		    Self.EngramList.AddRow("")
		    Self.ShowEngramInRow(Self.EngramList.LastAddedRowIndex, Engram)
		  Next
		  Self.EngramList.Sort
		  Self.RestoreListState()
		  
		  Self.Header.PublishButton.Enabled = EngramSet.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEngramInRow(Index As Integer, Engram As BeaconAPI.Engram)
		  EngramList.CellValueAt(Index, 0) = Engram.Path
		  EngramList.CellValueAt(Index, 1) = Engram.Label
		  EngramList.CellCheckBoxValueAt(Index, 2) = Engram.CanBeBlueprint
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnIsland) = Engram.ValidForMap(Beacon.Maps.TheIsland)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnScorched) = Engram.ValidForMap(Beacon.Maps.ScorchedEarth)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnCenter) = Engram.ValidForMap(Beacon.Maps.TheCenter)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnRagnarok) = Engram.ValidForMap(Beacon.Maps.Ragnarok)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnAberration) = Engram.ValidForMap(Beacon.Maps.Aberration)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnExtinction) = Engram.ValidForMap(Beacon.Maps.Extinction)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnValguero) = Engram.ValidForMap(Beacon.Maps.Valguero)
		  EngramList.CellCheckBoxValueAt(Index, Self.ColumnGenesis) = Engram.ValidForMap(Beacon.Maps.Genesis)
		  
		  EngramList.RowTagAt(Index) = Engram
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowFileImport()
		  Dim Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File = Nil Then
		    Return
		  End If
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Self.ImportText(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowURLImport()
		  Dim Contents As String = DeveloperImportURLDialog.Present(Self)
		  If Contents <> "" Then
		    Self.ImportText(Contents)
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ImportFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportStarted()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentMod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.mCurrentMod Then
			    Return
			  End If
			  
			  Self.CopyButton.Restore
			  
			  Self.SaveListState()
			  Self.mCurrentMod = Value
			  
			  If Self.mCurrentMod = Nil Then
			    Panel.SelectedPanelIndex = Self.PageNoSelection
			    Return
			  End If
			  
			  Self.LoadingHeader.Caption = Value.Name
			  Self.ConfirmationHeader.Caption = Value.Name
			  Self.Header.Caption = Value.Name
			  
			  If Not Self.mCurrentMod.Confirmed Then
			    ConfirmField.Value = Self.mCurrentMod.ConfirmationCode
			    Panel.SelectedPanelIndex = PageNeedsConfirmation
			    Return
			  End If
			  
			  If Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) Then
			    Self.ShowCurrentEngrams()
			    Panel.SelectedPanelIndex = PageEngrams
			  Else
			    // Load engrams
			    Panel.SelectedPanelIndex = PageLoading
			    Dim Request As New BeaconAPI.Request(Self.mCurrentMod.EngramsURL, "GET", AddressOf APICallback_EngramsLoad)
			    Self.Socket.Start(Request)
			  End If
			End Set
		#tag EndSetter
		CurrentMod As BeaconAPI.WorkshopMod
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentMod As BeaconAPI.WorkshopMod
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramSets As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStates As Dictionary
	#tag EndProperty


	#tag Constant, Name = ColumnAberration, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnCenter, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnExtinction, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnGenesis, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIsland, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRagnarok, Type = Double, Dynamic = False, Default = \"9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnScorched, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnValguero, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageEngrams, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLoading, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNeedsConfirmation, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CopyButton
	#tag Event
		Sub Pressed()
		  Dim C As New Clipboard
		  C.Text = ConfirmField.Value
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmButton
	#tag Event
		Sub Pressed()
		  Panel.SelectedPanelIndex = PageLoading
		  
		  Dim Request As New BeaconAPI.Request(Self.CurrentMod.ConfirmURL, "GET", AddressOf APICallback_ConfirmMod)
		  Request.Authenticate(Preferences.OnlineToken)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim Engram As BeaconAPI.Engram = Me.RowTagAt(Row)
		  
		  Select Case Column
		  Case 0
		    Engram.Path = Me.CellValueAt(Row, Column)
		  Case 1
		    Engram.Label = Me.CellValueAt(Row, Column)
		  Case 2
		    Engram.CanBeBlueprint = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnIsland
		    Engram.ValidForMap(Beacon.Maps.TheIsland) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnScorched
		    Engram.ValidForMap(Beacon.Maps.ScorchedEarth) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnCenter
		    Engram.ValidForMap(Beacon.Maps.TheCenter) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnRagnarok
		    Engram.ValidForMap(Beacon.Maps.Ragnarok) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnAberration
		    Engram.ValidForMap(Beacon.Maps.Aberration) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnExtinction
		    Engram.ValidForMap(Beacon.Maps.Extinction) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnValguero
		    Engram.ValidForMap(Beacon.Maps.Valguero) = Me.CellCheckBoxValueAt(Row, Column)
		  Case Self.ColumnGenesis
		    Engram.ValidForMap(Beacon.Maps.Genesis) = Me.CellCheckBoxValueAt(Row, Column)
		  End Select
		  
		  Self.EngramSet.Add(Engram)
		  Header.PublishButton.Enabled = Self.EngramSet.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Header.RemoveButton.Enabled = Me.SelectedRowIndex > -1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.TextField
		  Me.ColumnTypeAt(1) = Listbox.CellTypes.TextField
		  Me.ColumnTypeAt(2) = Listbox.CellTypes.CheckBox
		  Me.ColumnAlignmentAt(2) = Listbox.Alignments.Center
		  For I As Integer = Self.ColumnIsland To Self.ColumnValguero
		    Me.ColumnTypeAt(I) = Listbox.CellTypes.CheckBox
		    Me.ColumnAlignmentAt(I) = Listbox.Alignments.Center
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Pressed(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Dim Engram As New BeaconAPI.Engram
		    Engram.ModID = Self.CurrentMod.ModID
		    EngramList.AddRow("")
		    Self.ShowEngramInRow(EngramList.LastAddedRowIndex, Engram)
		    EngramList.EditCellAt(EngramList.LastAddedRowIndex, 0)
		    Self.EngramSet.Add(Engram)
		  Case "RemoveButton"
		    For I As Integer = EngramList.RowCount -1 DownTo 0
		      If EngramList.Selected(I) Then
		        Dim Engram As BeaconAPI.Engram = EngramList.RowTagAt(I)
		        Self.EngramSet.Remove(Engram)
		        EngramList.RemoveRowAt(I)
		      End If
		    Next
		    Me.PublishButton.Enabled = Self.EngramSet.Modified
		  Case "PublishButton"
		    Self.Publish()
		  Case "ImportFileButton"
		    Self.ShowFileImport()
		  Case "ImportURLButton"
		    Self.ShowURLImport()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddButton", IconToolbarAdd, "Add new engram."))
		  Me.LeftItems.Append(New BeaconToolbarItem("RemoveButton", IconRemove, False, "Delete selected engrams."))
		  
		  Me.LeftItems.Append(New BeaconToolbarItem("PublishButton", IconToolbarPublish, False, "Publish changes to make them live."))
		  
		  Me.RightItems.Append(New BeaconToolbarItem("ImportFileButton", IconToolbarFile, "Import engrams from file."))
		  Me.RightItems.Append(New BeaconToolbarItem("ImportURLButton", IconToolbarLink, "Import engrams from url."))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Searcher
	#tag Event
		Sub Finished()
		  RaiseEvent ImportFinished
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  RaiseEvent ImportStarted
		End Sub
	#tag EndEvent
	#tag Event
		Sub EngramsFound()
		  Dim Blueprints() As Beacon.Blueprint = Me.Blueprints(True)
		  Dim Engrams() As Beacon.Engram = Blueprints.Engrams
		  
		  If Engrams.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim Set As BeaconAPI.EngramSet = Self.EngramSet
		  Dim CurrentEngrams() As BeaconAPI.Engram = Set.ActiveEngrams
		  Dim EngramDict As New Dictionary
		  For Each Engram As BeaconAPI.Engram In CurrentEngrams
		    EngramDict.Value(Engram.Path) = True
		  Next
		  
		  For Each Engram As Beacon.Engram In Engrams
		    If EngramDict.HasKey(Engram.Path) Then
		      Continue
		    End If
		    
		    Dim APIEngram As New BeaconAPI.Engram(Engram)
		    APIEngram.ModID = Self.mCurrentMod.ModID
		    Set.Add(APIEngram)
		    EngramList.AddRow("")
		    Self.ShowEngramInRow(EngramList.LastAddedRowIndex, APIEngram)
		    EngramDict.Value(Engram.Path) = True
		  Next
		  
		  Header.PublishButton.Enabled = Set.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
