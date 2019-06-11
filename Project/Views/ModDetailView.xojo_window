#tag Window
Begin BeaconContainer ModDetailView
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
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   864
      Begin UITweaks.ResizedTextField ConfirmField
         AcceptTabs      =   False
         Alignment       =   2
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
         TextAlign       =   1
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
         TextAlign       =   1
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
         TabStop         =   True
         Top             =   199
         Transparent     =   False
         Value           =   0
         Visible         =   True
         Width           =   340
      End
      Begin BeaconListbox EngramList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   False
         ColumnCount     =   9
         ColumnsResizable=   False
         ColumnWidths    =   "*,*,100,75,75,75,75,75,75"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   1
         Height          =   378
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Path	Label	Blueprintable	Island	Scorched	Center	Ragnarok	Aberration	Extinction"
         Italic          =   False
         Left            =   0
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
         SelectionChangeBlocked=   False
         SelectionType   =   1
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
         EraseBackground =   False
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
         EraseBackground =   False
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
         EraseBackground =   False
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
         EraseBackground =   False
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
      EraseBackground =   True
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
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.Searcher.Cancel
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.mEngramSets = New Xojo.Core.Dictionary
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
		Private Sub APICallback_ConfirmMod(Response As BeaconAPI.Response)
		  If Response.Success Then
		    Self.CurrentMod.Constructor(Response.JSON)
		    If Self.CurrentMod.Confirmed Then
		      Panel.Value = PageEngrams
		      Self.ShowAlert("Mod ownership confirmed.", "You may now remove the confirmation code from your Steam page.")
		    Else
		      Panel.Value = PageNeedsConfirmation
		      Self.ShowAlert("Mod ownership has not been confirmed.", "The confirmation code was not found on mod's Steam page.")
		    End If
		  Else
		    Panel.Value = PageNeedsConfirmation
		    Self.ShowAlert("Mod ownership has not been confirmed.", Response.Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsDelete(Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    Panel.Value = PageEngrams
		    Self.ShowAlert("Unable to delete engrams.", Response.Message)
		    Return
		  End If
		  
		  Panel.Value = PageEngrams
		  Self.EngramSet.ClearModifications(False)
		  Header.PublishButton.Enabled = False
		  Self.ShowAlert("Engrams published.", "Your changes are now live.")
		  LocalData.SharedInstance.CheckForEngramUpdates()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsLoad(Response As BeaconAPI.Response)
		  Self.mEngramSets.Value(Self.CurrentMod.ModID) = New BeaconAPI.EngramSet(Response.JSON)
		  Self.ShowCurrentEngrams()
		  Panel.Value = PageEngrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsPost(Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    Panel.Value = PageEngrams
		    Self.ShowAlert("Unable to save engrams.", Response.Message)
		    Return
		  End If
		  
		  If Self.DeletePendingEngrams Then
		    Return
		  End If
		  
		  Panel.Value = PageEngrams
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
		  If UBound(DeletedEngrams) = -1 Then
		    Return False
		  End If
		  
		  Panel.Value = PageLoading
		  
		  Dim UIDs() As Text
		  For Each Engram As BeaconAPI.Engram In DeletedEngrams
		    UIDs.Append(Engram.UID)
		  Next
		  
		  Dim Request As New BeaconAPI.Request("engram.php", "DELETE", UIDs.Join(","), "text/plain", AddressOf APICallback_EngramsDelete)
		  Request.Sign(App.Identity)
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
		    Self.mEngramSets = New Xojo.Core.Dictionary
		  End If
		  
		  If Not Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) Then
		    Dim Placeholder() As Auto
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
		  For I As Integer = 0 To Self.EngramList.ListCount - 1
		    Dim Engram As BeaconAPI.Engram = Self.EngramList.RowTag(I)
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
		  For I As Integer = 0 To Self.EngramList.ListCount - 1
		    Dim Engram As BeaconAPI.Engram = Self.EngramList.RowTag(I)
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
		  If UBound(NewEngrams) = -1 Then
		    Return False
		  End If
		  
		  Panel.Value = PageLoading
		  
		  Dim Dicts() As Xojo.Core.Dictionary
		  For Each Engram As BeaconAPI.Engram In NewEngrams
		    Dicts.Append(Engram.AsDictionary)
		  Next
		  
		  Dim Content As Text = Xojo.Data.GenerateJSON(Dicts)
		  Dim Request As New BeaconAPI.Request("engram.php", "POST", Content, "application/json", AddressOf APICallback_EngramsPost)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCurrentEngrams()
		  Self.EngramList.DeleteAllRows
		  
		  If Self.mCurrentMod = Nil Or Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) = False Then
		    Return
		  End If
		  
		  Dim EngramSet As BeaconAPI.EngramSet = Self.mEngramSets.Value(Self.mCurrentMod.ModID)
		  Dim Engrams() As BeaconAPI.Engram = EngramSet.ActiveEngrams
		  For Each Engram As BeaconAPI.Engram In Engrams
		    Self.EngramList.AddRow("")
		    Self.ShowEngramInRow(Self.EngramList.LastIndex, Engram)
		  Next
		  Self.EngramList.Sort
		  Self.RestoreListState()
		  
		  Self.Header.PublishButton.Enabled = EngramSet.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEngramInRow(Index As Integer, Engram As BeaconAPI.Engram)
		  EngramList.Cell(Index, 0) = Engram.Path
		  EngramList.Cell(Index, 1) = Engram.Label
		  EngramList.CellCheck(Index, 2) = Engram.CanBeBlueprint
		  EngramList.CellCheck(Index, 3) = Engram.ValidForMap(Beacon.Maps.TheIsland)
		  EngramList.CellCheck(Index, 4) = Engram.ValidForMap(Beacon.Maps.ScorchedEarth)
		  EngramList.CellCheck(Index, 5) = Engram.ValidForMap(Beacon.Maps.TheCenter)
		  EngramList.CellCheck(Index, 6) = Engram.ValidForMap(Beacon.Maps.Ragnarok)
		  EngramList.CellCheck(Index, 7) = Engram.ValidForMap(Beacon.Maps.Aberration)
		  EngramList.CellCheck(Index, 8) = Engram.ValidForMap(Beacon.Maps.Extinction)
		  
		  EngramList.RowTag(Index) = Engram
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowFileImport()
		  Dim Dialog As New OpenDialog
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
		  Dim Contents As Text = DeveloperImportURLDialog.Present(Self)
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
			    Panel.Value = Self.PageNoSelection
			    Return
			  End If
			  
			  Self.LoadingHeader.Caption = Value.Name
			  Self.ConfirmationHeader.Caption = Value.Name
			  Self.Header.Caption = Value.Name
			  
			  If Not Self.mCurrentMod.Confirmed Then
			    ConfirmField.Text = Self.mCurrentMod.ConfirmationCode
			    Panel.Value = PageNeedsConfirmation
			    Return
			  End If
			  
			  If Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) Then
			    Self.ShowCurrentEngrams()
			    Panel.Value = PageEngrams
			  Else
			    // Load engrams
			    Panel.Value = PageLoading
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
		Private mEngramSets As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStates As Dictionary
	#tag EndProperty


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
		Sub Action()
		  Dim C As New Clipboard
		  C.Text = ConfirmField.Text
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmButton
	#tag Event
		Sub Action()
		  Panel.Value = PageLoading
		  
		  Dim Request As New BeaconAPI.Request(Self.CurrentMod.ConfirmURL, "GET", AddressOf APICallback_ConfirmMod)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeEditableTextField
		  Me.ColumnType(1) = Listbox.TypeEditableTextField
		  Me.ColumnType(2) = Listbox.TypeCheckbox
		  Me.ColumnType(3) = Listbox.TypeCheckbox
		  Me.ColumnType(4) = Listbox.TypeCheckbox
		  Me.ColumnType(5) = Listbox.TypeCheckbox
		  Me.ColumnType(6) = Listbox.TypeCheckbox
		  Me.ColumnType(7) = Listbox.TypeCheckbox
		  Me.ColumnType(8) = Listbox.TypeCheckbox
		  
		  Me.ColumnAlignment(2) = Listbox.AlignCenter
		  Me.ColumnAlignment(3) = Listbox.AlignCenter
		  Me.ColumnAlignment(4) = Listbox.AlignCenter
		  Me.ColumnAlignment(5) = Listbox.AlignCenter
		  Me.ColumnAlignment(6) = Listbox.AlignCenter
		  Me.ColumnAlignment(7) = Listbox.AlignCenter
		  Me.ColumnAlignment(8) = Listbox.AlignCenter
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim Engram As BeaconAPI.Engram = Me.RowTag(Row)
		  
		  Select Case Column
		  Case 0
		    Engram.Path = Me.Cell(Row, Column).ToText
		  Case 1
		    Engram.Label = Me.Cell(Row, Column).ToText
		  Case 2
		    Engram.CanBeBlueprint = Me.CellCheck(Row, Column)
		  Case 3
		    Engram.ValidForMap(Beacon.Maps.TheIsland) = Me.CellCheck(Row, Column)
		  Case 4
		    Engram.ValidForMap(Beacon.Maps.ScorchedEarth) = Me.CellCheck(Row, Column)
		  Case 5
		    Engram.ValidForMap(Beacon.Maps.TheCenter) = Me.CellCheck(Row, Column)
		  Case 6
		    Engram.ValidForMap(Beacon.Maps.Ragnarok) = Me.CellCheck(Row, Column)
		  Case 7
		    Engram.ValidForMap(Beacon.Maps.Aberration) = Me.CellCheck(Row, Column)
		  Case 8
		    Engram.ValidForMap(Beacon.Maps.Extinction) = Me.CellCheck(Row, Column)
		  End Select
		  
		  Self.EngramSet.Add(Engram)
		  Header.PublishButton.Enabled = Self.EngramSet.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Header.RemoveButton.Enabled = Me.ListIndex > -1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Dim Engram As New BeaconAPI.Engram
		    Engram.ModID = Self.CurrentMod.ModID
		    EngramList.AddRow("")
		    Self.ShowEngramInRow(EngramList.LastIndex, Engram)
		    EngramList.EditCell(EngramList.LastIndex, 0)
		    Self.EngramSet.Add(Engram)
		  Case "RemoveButton"
		    For I As Integer = EngramList.ListCount -1 DownTo 0
		      If EngramList.Selected(I) Then
		        Dim Engram As BeaconAPI.Engram = EngramList.RowTag(I)
		        Self.EngramSet.Remove(Engram)
		        EngramList.RemoveRow(I)
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
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddButton", IconAdd, "Add new engram."))
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
		  Dim Engrams() As Beacon.Engram = Me.Engrams(True)
		  
		  If Engrams.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim Set As BeaconAPI.EngramSet = Self.EngramSet
		  Dim CurrentEngrams() As BeaconAPI.Engram = Set.ActiveEngrams
		  Dim EngramDict As New Xojo.Core.Dictionary
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
		    Self.ShowEngramInRow(EngramList.LastIndex, APIEngram)
		    EngramDict.Value(Engram.Path) = True
		  Next
		  
		  Header.PublishButton.Enabled = Set.Modified
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
