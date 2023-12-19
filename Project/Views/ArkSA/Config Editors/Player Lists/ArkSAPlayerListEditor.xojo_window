#tag DesktopWindow
Begin BeaconContainer ArkSAPlayerListEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   300
   Begin StatusBarContainer Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Caption         =   "Status"
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   31
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   269
      Transparent     =   True
      Visible         =   True
      Width           =   300
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   ""
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   228
      Index           =   -2147483648
      InitialValue    =   "Name	EOS ID"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      Width           =   300
      _ScrollWidth    =   -1
   End
   Begin OmniBar EditorToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   300
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function PlayerList() As ArkSA.PlayerList
		  If Self.mList Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.mList.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerList(Assigns Target As ArkSA.PlayerList)
		  If Target Is Nil Then
		    Self.mList = Nil
		  Else
		    Self.mList = Target.MutableVersion
		  End If
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddPlayer()
		  Var Player As ArkSA.PlayerInfo = ArkSAPlayerPropertiesDialog.Present(Self, ArkSAPlayerPropertiesDialog.SpecIdHidden)
		  If Player Is Nil Then
		    Return
		  End If
		  
		  Self.mList.Add(Player)
		  RaiseEvent ListChanged(Self.PlayerList)
		  Self.UpdatePlayerList(Player)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePlayerList()
		  Var SelectedPlayers() As ArkSA.PlayerInfo
		  For Row As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Row) = False Then
		      Continue
		    End If
		    
		    Var Player As ArkSA.PlayerInfo = Self.List.RowTagAt(Row)
		    If Player Is Nil Then
		      Continue
		    End If
		    
		    SelectedPlayers.Add(Player)
		  Next
		  Self.UpdatePlayerList(SelectedPlayers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePlayerList(SelectedPlayers() As ArkSA.PlayerInfo)
		  If Self.mList Is Nil Then
		    Self.List.RemoveAllRows
		    Self.UpdateStatus()
		    Return
		  End If
		  
		  Var SelectedPlayerIds() As String
		  For Each Player As ArkSA.PlayerInfo In SelectedPlayers
		    If Player Is Nil Then
		      Continue
		    End If
		    SelectedPlayerIds.Add(Player.EpicId)
		  Next
		  
		  Self.List.SelectionChangeBlocked = True
		  Self.List.RowCount = Self.mList.Count
		  For Idx As Integer = 0 To Self.mList.LastIndex
		    Var Player As ArkSA.PlayerInfo = Self.mList.Member(Idx)
		    Self.List.CellTextAt(Idx, Self.ColumnName) = Player.Name
		    Self.List.CellTextAt(Idx, Self.ColumnEpicId) = Player.EpicId
		    Self.List.RowTagAt(Idx) = Player
		    Self.List.RowSelectedAt(Idx) = SelectedPlayerIds.IndexOf(Player.EpicId) > -1
		  Next
		  Self.List.SelectionChangeBlocked = False
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePlayerList(SelectedPlayer As ArkSA.PlayerInfo)
		  Var SelectedPlayers() As ArkSA.PlayerInfo
		  If (SelectedPlayer Is Nil) = False Then
		    SelectedPlayers.Add(SelectedPlayer)
		  End If
		  Self.UpdatePlayerList(SelectedPlayers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  If Self.List.SelectedRowCount > 0 Then
		    Self.Status.Caption = Self.List.SelectedRowCount.ToString(Locale.Current, "#,##0") + " of " + Language.NounWithQuantity(Self.List.RowCount, "Player", "Players") + " Selected"
		  Else
		    Self.Status.Caption = Language.NounWithQuantity(Self.List.RowCount, "Player", "Players")
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ListChanged(List As ArkSA.PlayerList)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mList As ArkSA.MutablePlayerList
	#tag EndProperty


	#tag Constant, Name = ColumnEpicId, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinEditorWidth, Type = Double, Dynamic = False, Default = \"300", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(BeaconFileTypes.ArkProfile)
		  Me.AcceptRawDataDrop(ArkSA.PlayerInfo.ClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  
		  Var NewPlayers() As ArkSA.PlayerInfo
		  
		  Do
		    If Obj.FolderItemAvailable Then
		      Var File As FolderItem = Obj.FolderItem
		      If File.ExtensionMatches(Beacon.FileExtensionArkProfile) = False Then
		        Continue
		      End If
		      
		      Try
		        Var Player As ArkSA.PlayerInfo = ArkSA.PlayerInfo.FromPlayerFile(File)
		        If (Player Is Nil) = False Then
		          Self.mList.Add(Player)
		          NewPlayers.Add(Player)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    ElseIf Obj.RawDataAvailable(ArkSA.PlayerInfo.ClipboardType) Then
		      Try
		        Var SaveData As Dictionary = Beacon.ParseJSON(Obj.RawData(ArkSA.PlayerInfo.ClipboardType))
		        Var Player As ArkSA.PlayerInfo = ArkSA.PlayerInfo.FromSaveData(SaveData)
		        If (Player Is Nil) = False Then
		          Self.mList.Add(Player)
		          NewPlayers.Add(Player)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		  Loop Until Obj.NextItem = False
		  
		  Self.UpdatePlayerList(NewPlayers)
		  
		  If NewPlayers.Count > 0 Then
		    RaiseEvent ListChanged(Self.PlayerList)
		  End If
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
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(ArkSA.PlayerInfo.ClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Players() As ArkSA.PlayerInfo
		  Var Indexes() As Integer
		  For Idx As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Player As ArkSA.PlayerInfo = Me.RowTagAt(Idx)
		    If (Player Is Nil) = False Then
		      Players.Add(Player)
		      Indexes.Add(Idx)
		    End If
		  Next
		  
		  If Players.Count = 0 Then
		    Return
		  End If
		  
		  If Warn And Self.ShowDeleteConfirmation(Players, "player", "players") = False Then
		    Return
		  End If
		  
		  For Idx As Integer = Indexes.LastIndex DownTo 0
		    Self.mList.RemoveAt(Indexes(Idx))
		  Next
		  RaiseEvent ListChanged(Self.PlayerList)
		  Self.UpdatePlayerList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var SourcePlayer As ArkSA.PlayerInfo = Me.RowTagAt(Me.SelectedRowIndex)
		  If SourcePlayer Is Nil Then
		    Return
		  End If
		  
		  Var EditedPlayer As ArkSA.PlayerInfo = ArkSAPlayerPropertiesDialog.Present(Self, ArkSAPlayerPropertiesDialog.SpecIdHidden, SourcePlayer)
		  If EditedPlayer Is Nil Then
		    Return
		  End If
		  
		  Self.mList.Add(EditedPlayer)
		  RaiseEvent ListChanged(Self.PlayerList)
		  Self.UpdatePlayerList(EditedPlayer)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  If Me.CanCopy = False Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(I) Then
		      Var Player As ArkSA.PlayerInfo = Me.RowTagAt(I)
		      Dicts.Add(Player.SaveData)
		    End If
		  Next
		  
		  If Dicts.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(ArkSA.PlayerInfo.ClipboardType, Dicts)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(ArkSA.PlayerInfo.ClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Dicts() As Variant = Contents
		      Var Players() As ArkSA.PlayerInfo
		      For Each Dict As Dictionary In Dicts
		        Var Player As ArkSA.PlayerInfo = ArkSA.PlayerInfo.FromSaveData(Dict)
		        If Player Is Nil Then
		          Continue
		        End If
		        Self.mList.Add(Player)
		        Players.Add(Player)
		      Next
		      
		      Self.UpdatePlayerList(Players)
		      If Players.Count > 0 Then
		        RaiseEvent ListChanged(Self.PlayerList)
		      End If
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditorToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("Title", "Players"))
		  Me.Append(OmniBarItem.CreateSeparator("TitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddPlayerButton", "Add Player", IconToolbarAdd, "Add a player to the selected list."))
		  
		  Me.Item("Title").Priority = 5
		  Me.Item("TitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  If Item Is Nil Then
		    Return
		  End If
		  
		  Select Case Item.Name
		  Case "AddPlayerButton"
		    Self.ShowAddPlayer()
		    Return
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
#tag EndViewBehavior
