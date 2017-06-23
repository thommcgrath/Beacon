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
   Placement       =   0
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
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   63
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin BeaconEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   False
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   580
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   235
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
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
		  
		  If Self.Doc.BeaconCount > 0 Then
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
		  Dim LootSources() As Beacon.LootSource = Self.Doc.LootSources
		  Self.UpdateSourceList()
		  
		  If UBound(LootSources) > -1 Then
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
			
			Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentDuplicate(Self, Self.Doc, BeaconList.RowTag(BeaconList.ListIndex), Self.CurrentMap)
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
			Self.ShowAlert("Your document has been published.", "You can view more about your document in the Developer Tools window.")
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRemoveBeacon() As Boolean Handles DocumentRemoveBeacon.Action
			Self.RemoveSelectedBeacons()
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
			
			Dim Dialog As New SaveAsDialog
			Dialog.SuggestedFileName = "Game.ini"
			Dialog.Filter = BeaconFileTypes.IniFile
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self)
			If File <> Nil Then
			Dim Lines() As String
			Lines.Append("[/script/shootergame.shootergamemode]")
			
			For Each LootSource As Beacon.LootSource In LootSources
			Lines.Append("ConfigOverrideSupplyCrateItems=" + LootSource.TextValue())
			Next
			
			Dim Stream As TextOutputStream = TextOutputStream.Create(File)
			Stream.Write(Join(Lines, EndOfLine))
			Stream.Close
			End If
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
		Private Sub AddLootSources(Sources() As Beacon.LootSource)
		  If UBound(Sources) = -1 Then
		    Return
		  End If
		  
		  Dim CurrentMap As Beacon.Map = Self.CurrentMap
		  
		  Dim ChangeView As Boolean
		  For Each Source As Beacon.LootSource In Sources
		    If Self.Doc.HasLootSource(Source) Then
		      Self.Doc.Remove(Source)
		    End If
		    Self.Doc.Add(Source)
		    
		    If CurrentMap <> Nil And Not Source.ValidForMap(CurrentMap) Then
		      ChangeView = True
		    End If
		    Self.ContentsChanged = True
		  Next
		  ChangeView = ChangeView And Self.LootSourceHeader.SegmentIndex <> 0
		  
		  If ChangeView Then
		    Self.LootSourceHeader.SegmentIndex = 0
		  End If
		  Self.UpdateSourceList(Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto)
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
		      Beacon.ReportAProblem()
		    End If
		    Return
		  End If
		  
		  Self.mIsPublished = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentStatus(Success As Boolean, Message As Text, Details As Auto)
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
		Sub Constructor()
		  Self.Doc = New Beacon.Document
		  Super.Constructor
		  Self.DocumentCounter = Self.DocumentCounter + 1
		  Self.Title = "Untitled " + Str(Self.DocumentCounter, "-0")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Doc As Beacon.Document)
		  Self.Doc = Doc
		  Super.Constructor
		  Self.DocumentCounter = Self.DocumentCounter + 1
		  Self.Title = "Untitled " + Str(Self.DocumentCounter, "-0")
		  Self.ContentsChanged = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem)
		  If File.IsType(BeaconFileTypes.BeaconDocument) Then
		    // Beacon document
		    Self.File = File
		    Self.Doc = Beacon.Document.Read(Self.File)
		    Self.Title = File.Name
		    Self.ContentsChanged = Self.ContentsChanged Or Self.Doc.Modified
		    Super.Constructor
		    Return
		  End If
		  
		  Self.Constructor
		  
		  If File.IsType(BeaconFileTypes.IniFile) Then
		    // Config file
		    Self.Import(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentMap() As Beacon.Map
		  Dim MapName As Text = Self.LootSourceHeader.CurrentSegment
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    If Map.Name = MapName Then
		      Return Map
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(File As FolderItem)
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = File.Name
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self)
		  Self.Importer.Run(File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String, Source As String)
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = Source
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self)
		  Self.Importer.Run(Content.ToText)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedBeacons()
		  If BeaconList.SelCount = 0 Then
		    Return
		  End If
		  
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
		  
		  For I As Integer = BeaconList.ListCount - 1 DownTo 0
		    If BeaconList.Selected(I) Then
		      Self.Doc.Remove(BeaconList.RowTag(I))
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
		  
		  Dim Writer As New Beacon.JSONWriter(Self.Doc.Export, File)
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
		  Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentAdd(Self, Self.Doc, Self.CurrentMap)
		  If LootSource <> Nil Then
		    Self.AddLootSource(LootSource)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSourceList(SelectedSources() As Beacon.LootSource = Nil)
		  Dim CurrentMap As Beacon.Map = Self.CurrentMap
		  Editor.CurrentMap = CurrentMap
		  Self.Doc.MapPreference = CurrentMap.Mask
		  
		  Dim Sources() As Beacon.LootSource = Self.Doc.LootSources
		  Dim Filter As Integer = LootSourceHeader.SegmentIndex
		  Dim VisibleSources() As Beacon.LootSource
		  For Each Source As Beacon.LootSource In Sources
		    If Source.ValidForMap(CurrentMap) Then
		      VisibleSources.Append(Source)
		    End If
		  Next
		  VisibleSources.Sort
		  
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
		  
		  Dim TargetRowCount As Integer = UBound(VisibleSources) + 1
		  While BeaconList.ListCount > TargetRowCount
		    BeaconList.RemoveRow(0)
		  Wend
		  While BeaconList.ListCount < TargetRowCount
		    BeaconList.AddRow("")
		  Wend
		  
		  Self.mBlockSelectionChanged = True
		  Dim Selection() As Beacon.LootSource
		  For I As Integer = 0 To UBound(VisibleSources)
		    BeaconList.RowTag(I) = VisibleSources(I)
		    BeaconList.Cell(I, 1) = VisibleSources(I).Label
		    If SelectedClasses.IndexOf(VisibleSources(I).ClassString) > -1 Then
		      BeaconList.Selected(I) = True
		      Selection.Append(VisibleSources(I))
		    Else
		      BeaconList.Selected(I) = False
		    End If
		  Next
		  Self.mBlockSelectionChanged = False
		  Editor.Sources = Selection
		  Editor.Enabled = UBound(Selection) > -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriterFinished(Sender As Beacon.JSONWriter)
		  If Sender.Success Then
		    Return
		  End If
		  
		  Self.ContentsChanged = True
		  Self.ShowAlert("File did not save", "It may be locked or in use.")
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
		        Lines.Append("ConfigOverrideSupplyCrateItems=" + Source.TextValue())
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
		Sub PerformClear()
		  Self.RemoveSelectedBeacons()
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
		      Sources.Append(Beacon.LootSource.Import(Dict))
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
		Function CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused BackgroundColor
		  
		  If Row >= Me.ListCount Then
		    Return False
		  End If
		  
		  Dim ReturnValue As Boolean
		  Dim Source As Beacon.LootSource = Me.RowTag(Row)
		  If Not Source.IsValid Then
		    G.ForeColor = BeaconUI.BackgroundColorForInvalidRow(G.ForeColor, IsHighlighted, Me.Selected(Row))
		    G.FillRect(0, 0, G.Width, G.Height)
		    ReturnValue = True
		    TextColor = BeaconUI.TextColorForInvalidRow(IsHighlighted, Me.Selected(Row))
		  End If
		  
		  If Column = 0 Then
		    Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, RGB(TextColor.Red, TextColor.Green, TextColor.Blue, 150))
		    Dim SpaceWidth As Integer = Me.Column(Column).WidthActual
		    Dim SpaceHeight As Integer = Me.DefaultRowHeight
		    
		    G.DrawPicture(Icon, (SpaceWidth - Icon.Width) / 2, (SpaceHeight - Icon.Height) / 2)
		    
		    ReturnValue = True
		  End If
		  
		  Return ReturnValue
		End Function
	#tag EndEvent
	#tag Event
		Function CellTextPaint(G As Graphics, Row As Integer, Column As Integer, ByRef TextColor As Color, DrawSpace As Xojo.Core.Rect, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused TextColor
		  #Pragma Unused DrawSpace
		  #Pragma Unused VerticalPosition
		  
		  If Column = 0 Then
		    Return True
		  End If
		  
		  If Column = 1 Then
		    Dim Source As Beacon.LootSource = Me.RowTag(Row)
		    If Not Source.IsValid Then
		      TextColor = BeaconUI.TextColorForInvalidRow(IsHighlighted, Me.Selected(Row))
		      G.Bold = True
		    End If
		  End If
		End Function
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
		    
		    Dim LootSource As Beacon.LootSource = LootSourceWizard.PresentEdit(Self, Self.Doc, BeaconList.RowTag(BeaconList.ListIndex), Self.CurrentMap)
		    If LootSource <> Nil Then
		      Self.AddLootSource(LootSource)
		    End If
		  Case "DeleteButton"
		    Self.RemoveSelectedBeacons()
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
		    Dim LootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("")
		    Dim CurrentMap As Beacon.Map = Self.CurrentMap
		    For I As Integer = UBound(LootSources) DownTo 0
		      If Self.Doc.HasLootSource(LootSources(I)) Then
		        LootSources.Remove(I)
		        Continue For I
		      End If
		      If Not LootSources(I).ValidForMap(CurrentMap) Then
		        LootSources.Remove(I)
		      End If
		    Next
		    
		    If UBound(LootSources) = -1 Then
		      Return False
		    End If
		    
		    LootSources.Sort
		    
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
		  
		  EditButton.Enabled = False
		  DeleteButton.Enabled = False
		  
		  Me.Append(AddButton)
		  Me.Append(EditButton)
		  Me.Append(DeleteButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Me.LootSourcesProcessed = Me.BeaconCount Then
		    If Self.ImportProgress <> Nil Then
		      Self.ImportProgress.Close
		      Self.ImportProgress = Nil
		    End If
		    
		    Dim LootSources() As Beacon.LootSource = Me.LootSources
		    Me.Reset
		    
		    For Each LootSource As Beacon.LootSource In LootSources
		      Self.AddLootSource(LootSource)
		    Next
		    Return
		  End If
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.BeaconCount = Me.BeaconCount
		    Self.ImportProgress.LootSourcesProcessed = Me.LootSourcesProcessed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LootSourceHeader
	#tag Event
		Sub Open()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    Me.AddSegment(Map.Name, Map.Mask = Self.Doc.MapPreference)
		  Next
		  
		  If Me.SegmentIndex = -1 Then
		    Me.SegmentIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Resize(NewSize As Integer)
		  Me.Height = NewSize
		  BeaconList.Top = NewSize
		  BeaconList.Height = Footer.Top - NewSize
		End Sub
	#tag EndEvent
	#tag Event
		Sub SegmentChange()
		  Self.UpdateSourceList()
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
