#tag Window
Begin BeaconWindow DocWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   580
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   817604607
   MenuBarVisible  =   True
   MinHeight       =   580
   MinimizeButton  =   True
   MinWidth        =   1100
   Placement       =   2
   Resizeable      =   True
   Title           =   "Untitled Document"
   Visible         =   True
   Width           =   1100
   Begin BeaconListbox BeaconList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "30,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   30
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   492
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
      RequiresSelection=   False
      RowCount        =   0
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
      Top             =   63
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   234
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   580
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   234
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin LootSourceEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      ConsoleSafe     =   False
      DoubleBuffer    =   False
      Enabled         =   False
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   580
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   235
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MapMask         =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   865
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   555
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   234
   End
   Begin Beacon.ImportThread Importer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   0
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
   Begin ListHeader LootSourceHeader
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DisplayAsMenu   =   True
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   63
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      SegmentIndex    =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TintColor       =   &cEAEEF100
      Title           =   "Loot Sources"
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   234
   End
   Begin BeaconAPI.Socket Socket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #Pragma Unused appQuitting
		  
		  If Not Self.ContentsChanged Then
		    Return False
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Do you want to save changes to """ + Self.Title + """ before closing?"
		  Dialog.Explanation = "If you don't save, your changes will be lost."
		  Dialog.ActionButton.Caption = "Save"
		  Dialog.AlternateActionButton.Caption = "Don't Save"
		  Dialog.CancelButton.Visible = True
		  Dialog.AlternateActionButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  Select Case Choice
		  Case Dialog.ActionButton
		    If Self.Save() Then
		      Return False
		    Else
		      Return True
		    End If
		  Case Dialog.CancelButton
		    Return True
		  Case Dialog.AlternateActionButton
		    Return False
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub ContentsChanged()
		  Self.ScanForErrors()
		  Self.BeaconList.Invalidate()
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSave.Enable
		  FileSaveAs.Enable
		  FileClose.Enable
		  DocumentAddBeacon.Enable
		  
		  
		  
		  Select Case BeaconList.SelCount
		  Case 0
		    DocumentRemoveBeacon.Text = "Remove Loot Source"
		    For I As Integer = DocumentAddItemSet.Count - 1 DownTo 0
		      DocumentAddItemSet.Remove(I)
		    Next
		    DocumentAddItemSet.Append(New MenuItem("New Empty Set"))
		    DocumentAddItemSet.Item(0).Enabled = False
		  Case 1
		    DocumentRemoveBeacon.Text = "Remove Loot Source"
		    DocumentDuplicateBeacon.Enable
		    DocumentRemoveBeacon.Enable
		    Editor.EnableMenuItems
		    EditClear.Enable
		  Else
		    DocumentRemoveBeacon.Text = "Remove Loot Sources"
		    DocumentRemoveBeacon.Enable
		    Editor.EnableMenuItems
		    EditClear.Enable
		  End Select
		  
		  If Self.Doc.LootSourceCount > 0 Then
		    DocumentRebuildPresets.Enable
		    FileExport.Enable
		    If Self.mIsPublished = False Or (Self.mIsPublished = True And Self.mPublishedByUser) Then
		      DocumentPublishDocument.Enable
		    End If
		  End If
		  If Self.mIsPublished = True And Self.mPublishedByUser Then
		    DocumentUnpublishDocument.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.UpdateSourceList()
		  
		  If Self.Doc.LootSourceCount > 0 Then
		    // Check publish status
		    Dim Request As New BeaconAPI.Request("document.php/" + Self.Doc.Identifier + "?simple", "GET", AddressOf APICallback_DocumentStatus)
		    Self.Socket.Start(Request)
		  Else
		    Self.mIsPublished = False
		    Self.mPublishedByUser = True
		  End If
		  
		  Self.ScanForErrors()
		  ResolveIssuesDialog.Present(Self, Self.Doc)
		  Self.ScanForErrors() // In case the problems were resolved
		  Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentAddBeacon() As Boolean Handles DocumentAddBeacon.Action
			Self.ShowAddBeacon()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentDuplicateBeacon() As Boolean Handles DocumentDuplicateBeacon.Action
			If BeaconList.SelCount <> 1 Then
			Return True
			End If
			
			Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentDuplicate(Self, Self.Doc, BeaconList.RowTag(BeaconList.ListIndex))
			If LootSource <> Nil Then
			Self.AddLootSource(LootSource)
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentPublishDocument() As Boolean Handles DocumentPublishDocument.Action
			Dim OriginalTitle As Text = Self.Doc.Title
			Dim OriginalDescription As Text = Self.Doc.Description
			If DocumentPublishWindow.Present(Self, Self.Doc) Then
			Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Title.Compare(OriginalTitle, 0) <> 0 Or Self.Doc.Description.Compare(OriginalDescription, 0) <> 0
			Self.ShowAlert("Your document has been published.", "You can view more about your document in the Library window.")
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRebuildPresets() As Boolean Handles DocumentRebuildPresets.Action
			Self.Doc.ReconfigurePresets()
			Self.UpdateSourceList()
			Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRemoveBeacon() As Boolean Handles DocumentRemoveBeacon.Action
			Self.RemoveSelectedBeacons(True)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentUnpublishDocument() As Boolean Handles DocumentUnpublishDocument.Action
			Dim Dialog As New MessageDialog
			Dialog.Title = ""
			Dialog.Message = "Are you sure you want to unpublish this document?"
			Dialog.Explanation = "This document will no longer be available to download. If you choose to publish again, the document url will remain the same, so you can always change your mind."
			Dialog.ActionButton.Caption = "Unpublish"
			Dialog.CancelButton.Visible = True
			
			Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
			If Choice = Dialog.ActionButton Then
			Dim Request As New BeaconAPI.Request("document.php/" + Self.Doc.Identifier, "DELETE", AddressOf APICallback_DocumentDelete)
			Request.Sign(App.Identity)
			Self.Socket.Start(Request)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			DeployDialog.Present(Self, Self.Doc)
			Self.ScanForErrors()
			Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
			
			#if false
			If Not Self.Doc.IsValid Then
			Beep
			ResolveIssuesDialog.Present(Self, Self.Doc)
			Self.ScanForErrors()
			Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
			If Self.Footer.Button("ErrorsButton") <> Nil Then
			Return True
			End If
			End If
			
			Dim LootSources() As Beacon.LootSource = Self.Doc.LootSources
			
			If UBound(LootSources) = -1 Then
			Dim Warning As New MessageDialog
			Warning.Title = ""
			Warning.Message = "No loot sources to export"
			Warning.Explanation = "Beacon cannot export anything from this document because it contains no loot sources for either environment."
			Call Warning.ShowModalWithin(Self)
			Return True
			End If
			
			Dim UpdateOrCreateDialog As New MessageDialog
			UpdateOrCreateDialog.Title = ""
			UpdateOrCreateDialog.Message = "Would you like to update an existing config file or create a new one?"
			UpdateOrCreateDialog.Explanation = "Pressing ""Update"" will allow ask you to select an ini file, and Beacon will add or replace the ConfigOverrideSupplyCrateItems as necessary. Press ""Create"" to create a new ini file."
			UpdateOrCreateDialog.ActionButton.Caption = "Create"
			UpdateOrCreateDialog.AlternateActionButton.Caption = "Update"
			UpdateOrCreateDialog.CancelButton.Visible = True
			UpdateOrCreateDialog.AlternateActionButton.Visible = True
			
			Dim File As FolderItem
			Dim OriginalContent As String
			Dim EOL As String = EndOfLine
			Select Case UpdateOrCreateDialog.ShowModalWithin(Self)
			Case UpdateOrCreateDialog.ActionButton
			Dim Dialog As New SaveAsDialog
			Dialog.SuggestedFileName = "Game.ini"
			Dialog.Filter = BeaconFileTypes.IniFile
			
			File = Dialog.ShowModalWithin(Self)
			If File = Nil Then
			Return True
			End If
			Case UpdateOrCreateDialog.AlternateActionButton
			Dim Dialog As New OpenDialog
			Dialog.SuggestedFileName = "Game.ini"
			Dialog.Filter = BeaconFileTypes.IniFile
			
			File = Dialog.ShowModalWithin(Self)
			If File = Nil Then
			Return True
			End If
			
			Dim InStream As TextInputStream = TextInputStream.Open(File)
			OriginalContent = ReplaceLineEndings(InStream.ReadAll(Encodings.UTF8), EOL)
			InStream.Close
			Else
			Return True
			End Select
			
			Dim Lines() As String = OriginalContent.Split(EOL)
			For I As Integer = Lines.Ubound DownTo 0
			If Lines(I).Left(31) = "ConfigOverrideSupplyCrateItems=" Then
			Lines.Remove(I)
			End If
			Next
			
			Dim PrefixLines(), SectionLines(), SuffixLines() As String
			Dim PrefixMode As Boolean = True
			Dim SectionMode As Boolean = False
			Dim SuffixMode As Boolean = False
			For I As Integer = 0 To Lines.Ubound
			If Lines(I) = "[/script/shootergame.shootergamemode]" Then
			PrefixMode = False
			SectionMode = True
			SuffixMode = False
			PrefixLines.Append(Lines(I))
			ElseIf Lines(I).Left(1) = "[" And Lines(I).Right(1) = "]" And SectionMode = True Then
			PrefixMode = False
			SectionMode = False
			SuffixMode = True
			SuffixLines.Append(Lines(I))
			Else
			If PrefixMode Then
			PrefixLines.Append(Lines(I))
			ElseIf SectionMode Then
			SectionLines.Append(Lines(I))
			ElseIf SuffixMode Then
			SuffixLines.Append(Lines(I))
			End If
			End If
			Next
			
			If PrefixMode Then
			// Section is not included in the file
			PrefixLines.Append("")
			PrefixLines.Append("[/script/shootergame.shootergamemode]")
			End If
			
			For Each LootSource As Beacon.LootSource In LootSources
			If Self.Doc.SupportsLootSource(LootSource) Then
			SectionLines.Append("ConfigOverrideSupplyCrateItems=" + LootSource.TextValue(Self.Doc.DifficultyValue))
			End If
			Next
			
			Dim UpdatedContent As String = Join(PrefixLines, EOL).Trim + EOL + Join(SectionLines, EOL).Trim + if(SuffixLines.Ubound > -1, EOL + EOL, "") + Join(SuffixLines, EOL).Trim
			
			Dim OutStream As TextOutputStream = TextOutputStream.Create(File)
			OutStream.Write(UpdatedContent)
			OutStream.Close
			#endif
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			Call Self.Save()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddLootSource(LootSource As Beacon.LootSource)
		  Dim Arr(0) As Beacon.LootSource
		  Arr(0) = LootSource
		  Self.AddLootSources(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddLootSources(Sources() As Beacon.LootSource, Silent As Boolean = False)
		  If Sources.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim IgnoredSources() As Beacon.LootSource
		  
		  For Each Source As Beacon.LootSource In Sources
		    If Self.Doc.HasLootSource(Source) Then
		      Self.Doc.Remove(Source)
		    End If
		    
		    If Self.Doc.SupportsLootSource(Source) Then
		      Self.Doc.Add(Source)
		    Else
		      IgnoredSources.Append(Source)
		    End If
		    Self.ContentsChanged = True
		  Next
		  
		  Self.UpdateSourceList(Sources)
		  
		  If IgnoredSources.Ubound > -1 And Not Silent Then
		    Dim SourcesList() As Text
		    For Each IgnoredSource As Beacon.LootSource In IgnoredSources
		      SourcesList.Append(IgnoredSource.Label)
		    Next
		    
		    Dim IgnoredCount As Integer = IgnoredSources.Ubound + 1
		    Self.ShowAlert(IgnoredCount.ToText + if(IgnoredCount = 1, " loot source was", " loot sources were") + " not added because " + if(IgnoredCount = 1, "it is", "they are") + " not compatible with the selected maps.", "The following " + if(IgnoredCount = 1, "loot source was", "loot sources were") + " skipped: " + Text.Join(SourcesList, ", "))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  #Pragma Unused Message
		  #Pragma Unused Details
		  
		  If Not Success Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Unable to unpublish document"
		    Dialog.Explanation = "The server denied your request to unpublish the document. Would you like to report this problem?"
		    Dialog.ActionButton.Caption = "Report"
		    Dialog.CancelButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		    If Choice = Dialog.ActionButton Then
		      App.ShowBugReporter()
		    End If
		    Return
		  End If
		  
		  Self.mIsPublished = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentStatus(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  #Pragma Unused Message
		  
		  If Success Then
		    Self.mIsPublished = True
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Document As New BeaconAPI.Document(Dict)
		    Self.mPublishedByUser = Document.UserID = App.Identity.Identifier
		  Else
		    Self.mIsPublished = False
		    Self.mPublishedByUser = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  Importer.Stop
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Close
		    Self.ImportProgress = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Doc As Beacon.Document, File As FolderItem = Nil)
		  Self.Doc = Doc
		  Self.File = File
		  Super.Constructor
		  Self.DocumentCounter = Self.DocumentCounter + 1
		  If File <> Nil Then
		    Self.Title = File.DisplayName
		  ElseIf Doc.Title <> "" Then
		    Self.Title = Doc.Title
		  Else
		    Self.Title = "Untitled " + Str(Self.DocumentCounter, "-0")
		  End If
		  Self.ContentsChanged = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentMask() As UInt64
		  Return Self.Doc.MapCompatibility
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(File As FolderItem)
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = File.Name
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self)
		  Self.Importer.AddContent(File)
		  Self.Importer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String, Source As String)
		  If Content.Encoding = Nil Then
		    If Encodings.UTF8.IsValidData(Content) Then
		      Content = Content.DefineEncoding(Encodings.UTF8)
		    Else
		      Self.ShowAlert("Unable to import from clipboard", "The data is using an unknown encoding and cannot be imported.")
		      Return
		    End If
		  End If
		  
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = Source
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self)
		  
		  Self.Importer.AddContent(Content.ToText)
		  Self.Importer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesFile(File As Global.FolderItem) As Boolean
		  Return Self.File <> Nil And File <> Nil And Self.File.NativePath = File.NativePath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedBeacons(RequireConfirmation As Boolean)
		  If BeaconList.SelCount = 0 Then
		    Return
		  End If
		  
		  If RequireConfirmation Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    If BeaconList.SelCount = 1 Then
		      Dialog.Message = "Are you sure you want to delete the selected loot source?"
		    Else
		      Dialog.Message = "Are you sure you want to delete these " + Str(BeaconList.SelCount, "-0") + " loot sources?"
		    End If
		    Dialog.Explanation = "This action cannot be undone."
		    Dialog.ActionButton.Caption = "Delete"
		    Dialog.CancelButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		    If Choice = Dialog.CancelButton Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = BeaconList.ListCount - 1 DownTo 0
		    If BeaconList.Selected(I) Then
		      Self.Doc.Remove(Beacon.LootSource(BeaconList.RowTag(I)))
		      BeaconList.RemoveRow(I)
		    End If
		  Next
		  
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As Boolean
		  If Self.File <> Nil Then
		    Self.SaveAs(Self.File)
		    Return True
		  Else
		    Return Self.SaveAs()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveAs() As Boolean
		  Dim Dialog As New SaveAsDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self)
		  If File <> Nil Then
		    Self.SaveAs(File)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As FolderItem)
		  Self.File = File
		  Self.Title = File.Name
		  Self.ContentsChanged = False
		  Self.Doc.Modified = False
		  App.AddToRecentDocuments(File)
		  
		  Dim Writer As New Beacon.JSONWriter(Self.Doc.Export(App.Identity), File)
		  AddHandler Writer.Finished, AddressOf WriterFinished
		  Writer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanForErrors()
		  If Self.Doc.IsValid Then
		    Dim Button As FooterBarButton = Self.Footer.Button("ErrorsButton")
		    If Button <> Nil Then
		      Self.Footer.Remove(Button)
		    End If
		  Else
		    Dim Button As FooterBarButton = Self.Footer.Button("ErrorsButton")
		    If Button = Nil Then
		      Button = New FooterBarButton("ErrorsButton", IconAlert, FooterBarButton.AlignRight)
		      Button.Caption = "Issues"
		      Self.Footer.Append(Button)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddBeacon()
		  Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentAdd(Self, Self.Doc)
		  If LootSource <> Nil Then
		    Self.AddLootSource(LootSource)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSourceList(SelectedSources() As Beacon.LootSource = Nil)
		  Dim SelectedClasses() As Text
		  If SelectedSources <> Nil Then
		    For Each Source As Beacon.LootSource In SelectedSources
		      SelectedClasses.Append(Source.ClassString)
		    Next
		  Else
		    For I As Integer = 0 To BeaconList.ListCount
		      If BeaconList.Selected(I) Then
		        SelectedClasses.Append(Beacon.LootSource(BeaconList.RowTag(I)).ClassString)
		      End If
		    Next
		  End If
		  
		  Dim TargetRowCount As Integer = Self.Doc.LootSourceCount
		  While BeaconList.ListCount > TargetRowCount
		    BeaconList.RemoveRow(0)
		  Wend
		  While BeaconList.ListCount < TargetRowCount
		    BeaconList.AddRow("")
		  Wend
		  
		  Self.mBlockSelectionChanged = True
		  Dim Selection() As Beacon.LootSource
		  Dim RowIndex As Integer
		  For Each Source As Beacon.LootSource In Self.Doc.LootSources
		    BeaconList.RowTag(RowIndex) = Source
		    BeaconList.Cell(RowIndex, 0) = "" // Causes a redraw of the cell
		    BeaconList.Cell(RowIndex, 1) = Source.Label
		    If SelectedClasses.IndexOf(Source.ClassString) > -1 Then
		      BeaconList.Selected(RowIndex) = True
		      Selection.Append(Source)
		    Else
		      BeaconList.Selected(RowIndex) = False
		    End If
		    RowIndex = RowIndex + 1
		  Next
		  Self.mBlockSelectionChanged = False
		  
		  Editor.MapMask = Self.CurrentMask()
		  Editor.Sources = Selection
		  Editor.Enabled = UBound(Selection) > -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WarnFailedWrite()
		  Self.ContentsChanged = True
		  Self.ShowAlert("File did not save", "It may be locked or in use.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriterFinished(Sender As Beacon.JSONWriter)
		  If Sender.Success Then
		    Return
		  End If
		  
		  Xojo.Core.Timer.CallLater(1, AddressOf WarnFailedWrite)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Doc As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared DocumentCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private File As Global.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlockSelectionChanged As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			The default value is true to prevent the publish option from
			enabling before the status check has completed
		#tag EndNote
		Private mIsPublished As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishedByUser As Boolean = False
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.beacon", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events BeaconList
	#tag Event
		Sub Change()
		  Footer.Button("EditButton").Enabled = Me.SelCount = 1
		  Footer.Button("DeleteButton").Enabled = Me.SelCount > 0
		  
		  If Self.mBlockSelectionChanged Then
		    Return
		  End If
		  
		  Dim Sources() As Beacon.LootSource
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.Selected(I) Then
		      Sources.Append(Me.RowTag(I))
		    End If
		  Next
		  
		  Editor.Sources = Sources
		  Editor.Enabled = UBound(Sources) > -1
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Left(Board.Text, 30) = "ConfigOverrideSupplyCrateItems")
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  If Me.SelCount = 0 Then
		    Return
		  End If
		  
		  Dim Lines() As Text
		  Dim Dicts() As Xojo.Core.Dictionary
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.Selected(I) Then
		      Dim Source As Beacon.LootSource = Me.RowTag(I)
		      Dicts.Append(Source.Export)
		      If Source.IsValid Then
		        Lines.Append("ConfigOverrideSupplyCrateItems=" + Source.TextValue(Self.Doc.Difficulty))
		      End If
		    End If
		  Next
		  
		  Dim RawData As Text
		  If UBound(Dicts) = 0 Then
		    RawData = Xojo.Data.GenerateJSON(Dicts(0))
		  Else
		    RawData = Xojo.Data.GenerateJSON(Dicts)
		  End If
		  
		  Board.AddRawData(RawData, Self.kClipboardType)
		  Board.Text = Text.Join(Lines, Text.FromUnicodeCodepoint(10))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.RemoveSelectedBeacons(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		    Dim Parsed As Auto
		    Try
		      Parsed = Xojo.Data.ParseJSON(Contents.ToText)
		    Catch Err As Xojo.Data.InvalidJSONException
		      Beep
		      Return
		    End Try
		    
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		    Dim Dicts() As Xojo.Core.Dictionary
		    If Info.FullName = "Xojo.Core.Dictionary" Then
		      Dicts.Append(Parsed)
		    ElseIf Info.FullName = "Auto()" Then
		      Dim Values() As Auto = Parsed
		      For Each Dict As Xojo.Core.Dictionary In Values
		        Dicts.Append(Dict)
		      Next
		    Else
		      Beep
		      Return
		    End If
		    
		    Dim Sources() As Beacon.LootSource
		    For Each Dict As Xojo.Core.Dictionary In Dicts
		      Sources.Append(Beacon.LootSource.ImportFromBeacon(Dict))
		    Next
		    Self.AddLootSources(Sources)
		  ElseIf Board.TextAvailable Then
		    Dim Contents As String = Board.Text
		    If Left(Contents, 30) = "ConfigOverrideSupplyCrateItems" Then
		      Self.Import(Contents, "Clipboard")
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  
		  If Row >= Me.ListCount Then
		    Return
		  End If
		  
		  If Column = 0 Then
		    Dim Source As Beacon.LootSource = Me.RowTag(Row)
		    Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, RGB(TextColor.Red, TextColor.Green, TextColor.Blue, 150))
		    Dim SpaceWidth As Integer = Me.Column(Column).WidthActual
		    Dim SpaceHeight As Integer = Me.DefaultRowHeight
		    
		    G.DrawPicture(Icon, (SpaceWidth - Icon.Width) / 2, (SpaceHeight - Icon.Height) / 2)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cCCCCCC
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  For I As Integer = 0 To BeaconList.ListCount - 1
		    If BeaconList.Selected(I) Then
		      BeaconList.Cell(I, 0) = Beacon.LootSource(BeaconList.RowTag(I)).Label
		    End If
		  Next
		  
		  Self.ContentsChanged = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Footer
	#tag Event
		Sub Action(Button As FooterBarButton)
		  Select Case Button.Name
		  Case "AddButton"
		    Self.ShowAddBeacon()
		  Case "EditButton"
		    If BeaconList.SelCount <> 1 Then
		      Return
		    End If
		    
		    Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentEdit(Self, Self.Doc, BeaconList.RowTag(BeaconList.ListIndex))
		    If LootSource <> Nil Then
		      Self.AddLootSource(LootSource)
		    End If
		  Case "DeleteButton"
		    Self.RemoveSelectedBeacons(True)
		  Case "ErrorsButton"
		    ResolveIssuesDialog.Present(Self, Self.Doc)
		    Self.ScanForErrors()
		    Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseHold(Button As FooterBarButton) As Boolean
		  Select Case Button.Name
		  Case "AddButton"
		    Dim Base As New MenuItem
		    Dim LootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", Self.Doc.ConsoleModsOnly)
		    For I As Integer = UBound(LootSources) DownTo 0
		      If Self.Doc.HasLootSource(LootSources(I)) Then
		        LootSources.Remove(I)
		        Continue For I
		      End If
		      If Not Self.Doc.SupportsLootSource(LootSources(I)) Then
		        LootSources.Remove(I)
		      End If
		    Next
		    
		    If UBound(LootSources) = -1 Then
		      Return False
		    End If
		    
		    Beacon.Sort(LootSources)
		    
		    For Each LootSource As Beacon.LootSource In LootSources
		      Base.Append(New MenuItem(LootSource.Label, LootSource))
		    Next
		    
		    Dim Position As Xojo.Core.Point = Self.GlobalPosition
		    Dim Choice As MenuItem = Base.PopUp(Position.X + Me.Left + Button.Left, Position.Y + Me.Top + Button.Top + Button.Height)
		    If Choice = Nil Then
		      Return True
		    End If
		    
		    Dim SelectedLootSource As Beacon.LootSource = Choice.Tag
		    
		    If SelectedLootSource <> Nil Then
		      Self.AddLootSource(SelectedLootSource)
		    End If
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  Dim AddButton As New FooterBarButton("AddButton", IconAddWithMenu)
		  Dim EditButton As New FooterBarButton("EditButton", IconEdit)
		  Dim DeleteButton As New FooterBarButton("DeleteButton", IconRemove)
		  Dim SettingsButton As New FooterBarButton("SettingsButton", IconSettings, FooterBarButton.AlignRight)
		  
		  EditButton.Enabled = False
		  DeleteButton.Enabled = False
		  
		  Me.Append(AddButton)
		  Me.Append(EditButton)
		  Me.Append(DeleteButton)
		  Me.Append(SettingsButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Progress = Me.Progress
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(ParsedData As Xojo.Core.Dictionary)
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Close
		    Self.ImportProgress = Nil
		  End If
		  
		  If Not ParsedData.HasKey("ConfigOverrideSupplyCrateItems") Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto
		  Try
		    Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		  Catch Err As TypeMismatchException
		    Dicts.Append(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		  End Try
		  
		  For Each ConfigDict As Xojo.Core.Dictionary In Dicts
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, Self.Doc.DifficultyValue)
		    If Source <> Nil Then
		      Self.AddLootSource(Source)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LootSourceHeader
	#tag Event
		Sub Resize(NewSize As Integer)
		  Me.Height = NewSize
		  BeaconList.Top = NewSize
		  BeaconList.Height = Footer.Top - NewSize
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
