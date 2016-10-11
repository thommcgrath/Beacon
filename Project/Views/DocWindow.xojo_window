#tag Window
Begin Window DocWindow
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
   MinWidth        =   1000
   Placement       =   0
   Resizeable      =   True
   Title           =   "Beacon"
   Visible         =   True
   Width           =   1000
   Begin BeaconListbox BeaconList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   555
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   190
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
      Left            =   190
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
      Left            =   191
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
      Width           =   809
   End
   Begin GraphicButton AddBeaconButton
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   24
      HelpTag         =   "Add a loot source. Click to show the  ""Add Loot Source"" dialog, hold to show a menu of possible loot sources."
      IconDisabled    =   0
      IconNormal      =   0
      IconPressed     =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   30
   End
   Begin GraphicButton RemoveBeaconButton
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   False
      EraseBackground =   True
      Height          =   24
      HelpTag         =   "Remove the selected loot source."
      IconDisabled    =   0
      IconNormal      =   0
      IconPressed     =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   31
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   30
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   24
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   62
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   128
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   24
      HelpTag         =   ""
      Index           =   1
      InitialParent   =   ""
      Left            =   30
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   24
      HelpTag         =   ""
      Index           =   2
      InitialParent   =   ""
      Left            =   61
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   556
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   1
      HelpTag         =   ""
      Index           =   3
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   555
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   190
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
   Begin Beacon.RepositoryEngine Repository
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
		    FileExportConfig.Enable
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
		  For Each LootSource As Beacon.LootSource In LootSources
		    BeaconList.AddRow(LootSource.Label)
		    BeaconList.RowTag(BeaconList.LastIndex) = LootSource
		  Next
		  
		  If UBound(LootSources) > -1 Then
		    // Check publish status
		    Self.Repository.GetDocumentStatus(Self.Doc)
		  Else
		    Self.mIsPublished = False
		    Self.mPublishedByUser = True
		  End If
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
			
			Dim LootSource As Beacon.LootSource = LootSourceAddSheet.Present(Self, Self.Doc)
			If LootSource <> Nil Then
			Dim Type As Text = LootSource.Type
			Dim Label As Text = LootSource.Label
			Dim Source As Beacon.LootSource = BeaconList.RowTag(BeaconList.ListIndex)
			LootSource.Constructor(Source)
			LootSource.Type = Type
			LootSource.Label = Label
			
			BeaconList.AddRow(LootSource.Label)
			BeaconList.RowTag(BeaconList.LastIndex) = LootSource
			BeaconList.ListIndex = BeaconList.LastIndex
			
			Self.Doc.Add(LootSource)
			Self.ContentsChanged = True
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
			Dialog.Message = "Are you sure you want to unpublish this document?"
			Dialog.Explanation = "This document will no longer be available to download. If you choose to publish again, the document url will remain the same, so you can always change your mind."
			Dialog.ActionButton.Caption = "Unpublish"
			Dialog.CancelButton.Visible = True
			
			Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
			If Choice = Dialog.ActionButton Then
			Repository.DeleteDocument(Self.Doc, App.Identity)
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
		Function FileExportConfig() As Boolean Handles FileExportConfig.Action
			Dim Dialog As New SaveAsDialog
			Dialog.SuggestedFileName = "Game.ini"
			Dialog.Filter = BeaconFileTypes.IniFile
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self)
			If File <> Nil Then
			Dim Lines() As String
			Lines.Append("[/script/shootergame.shootergamemode]")
			
			Dim LootSources() As Beacon.LootSource = Self.Doc.LootSources
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
		  
		  BeaconList.ListIndex = -1
		  For Each Source As Beacon.LootSource In Sources
		    Dim Idx As Integer
		    If Self.Doc.HasBeacon(Source) Then
		      Self.Doc.Remove(Source)
		      
		      For I As Integer = 0 To BeaconList.ListCount - 1
		        If Beacon.LootSource(BeaconList.RowTag(I)).Type = Source.Type Then
		          Idx = I
		          Exit For I
		        End If
		      Next
		    Else
		      BeaconList.AddRow("")
		      Idx = BeaconList.LastIndex
		    End If
		    
		    BeaconList.RowTag(Idx) = Source
		    BeaconList.Cell(Idx, 0) = Source.Label
		    BeaconList.Selected(Idx) = True
		    Self.Doc.Add(Source)
		  Next
		  
		  Self.ContentsChanged = True
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Doc As Beacon.Document)
		  Self.Doc = Doc
		  Super.Constructor
		  Self.ContentsChanged = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem)
		  If File.IsType(BeaconFileTypes.BeaconDocument) Then
		    // Beacon document
		    Self.File = New Xojo.IO.FolderItem(File.NativePath.ToText)
		    Self.Doc = Beacon.Document.Read(Self.File)
		    Self.Title = File.Name
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
		  Self.SaveAs(New Xojo.IO.FolderItem(File.NativePath.ToText))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As Xojo.IO.FolderItem)
		  Self.File = File
		  Self.Doc.Write(File)
		  Self.Title = File.Name
		  Self.ContentsChanged = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddBeacon()
		  Dim LootSource As Beacon.LootSource = LootSourceAddSheet.Present(Self, Self.Doc)
		  If LootSource <> Nil Then
		    Self.AddLootSource(LootSource)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Doc As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private File As Xojo.IO.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCanPublish As Boolean
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
		  RemoveBeaconButton.Enabled = Me.SelCount > 0
		  
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
		      Lines.Append("ConfigOverrideSupplyCrateItems=" + Source.TextValue())
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
		  Self.ContentsChanged = True
		  
		  For I As Integer = 0 To BeaconList.ListCount - 1
		    If BeaconList.Selected(I) Then
		      BeaconList.Cell(I, 0) = Beacon.LootSource(BeaconList.RowTag(I)).Label
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddBeaconButton
	#tag Event
		Sub Open()
		  Me.IconNormal = IconAddWithMenuNormal
		  Me.IconPressed = IconAddWithMenuPressed
		  Me.IconDisabled = IconAddWithMenuDisabled
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.ShowAddBeacon()
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseHold(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim Base As New MenuItem
		  Dim LootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("")
		  For I As Integer = UBound(LootSources) DownTo 0
		    If Self.Doc.HasBeacon(LootSources(I)) Then
		      LootSources.Remove(I)
		    End If
		  Next
		  
		  For Each LootSource As Beacon.LootSource In LootSources
		    Base.Append(New MenuItem(LootSource.Label, LootSource))
		  Next
		  
		  If UBound(LootSources) > -1 Then
		    Base.Append(New MenuItem(MenuItem.TextSeparator))
		  End If
		  
		  Base.Append(New MenuItem("New custom beacon…"))
		  
		  Dim Position As Xojo.Core.Point = Self.GlobalPosition
		  Dim Choice As MenuItem = Base.PopUp(Position.X + Me.Left, Position.Y + Me.Top + Me.Height)
		  If Choice = Nil Then
		    Return True
		  End If
		  
		  Dim SelectedLootSource As Beacon.LootSource
		  If Choice.Tag = Nil Then
		    SelectedLootSource = CustomLootSourceSheet.Present(Self)
		  Else
		    SelectedLootSource = Choice.Tag
		  End If
		  
		  If SelectedLootSource <> Nil Then
		    Self.AddLootSource(SelectedLootSource)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events RemoveBeaconButton
	#tag Event
		Sub Open()
		  Me.IconNormal = IconRemoveNormal
		  Me.IconPressed = IconRemovePressed
		  Me.IconDisabled = IconRemoveDisabled
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Self.RemoveSelectedBeacons()
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
		      LootSource.Label = Beacon.Data.NameOfLootSource(LootSource.Type)
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
#tag Events Repository
	#tag Event
		Sub DocumentStatus(Published As Boolean, AuthorID As Text, LastUpdate As Xojo.Core.Date, ContentHash As Text)
		  Self.mIsPublished = Published
		  Self.mPublishedByUser = AuthorID = App.Identity.Identifier
		End Sub
	#tag EndEvent
	#tag Event
		Sub DeleteError()
		  Dim Dialog As New MessageDialog
		  Dialog.Message = "Unable to unpublish document"
		  Dialog.Explanation = "The server denied your request to unpublish the document. Would you like to report this problem?"
		  Dialog.ActionButton.Caption = "Report"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    Beacon.ReportAProblem()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DeleteSuccess()
		  Self.mIsPublished = False
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
