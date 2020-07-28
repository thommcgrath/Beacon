#tag Window
Begin ConfigEditor AccountsConfigEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   508
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
   Width           =   784
   Begin BeaconToolbar Header
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   True
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "Accounts"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   784
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   "#BeaconListbox.StandardRowHeight"
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   1
      Height          =   467
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Provider	Account Name	Used By"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   784
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub RestoreToDefault()
		  Self.Document.Accounts.RemoveAll
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Selected() As String
		  For I As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(I) Then
		      Selected.AddRow(Beacon.ExternalAccount(Self.List.RowTagAt(I)).UUID)
		    End If
		  Next
		  
		  Var Accounts() As Beacon.ExternalAccount = Self.Document.Accounts.All
		  Self.List.RowCount = Accounts.Count
		  
		  Var ProfileCount As Integer = Self.Document.ServerProfileCount
		  Var Profiles() As Beacon.ServerProfile
		  For Idx As Integer = 0 To ProfileCount - 1
		    Profiles.AddRow(Self.Document.ServerProfile(Idx))
		  Next
		  
		  For Idx As Integer = Accounts.FirstRowIndex To Accounts.LastRowIndex
		    Var Account As Beacon.ExternalAccount = Accounts(Idx)
		    Var ServerCount As Integer
		    For Each Profile As Beacon.ServerProfile In Profiles
		      If Profile.ExternalAccountUUID = Account.UUID Then
		        ServerCount = ServerCount + 1
		      End If
		    Next
		    
		    Self.List.RowTagAt(Idx) = Account
		    Self.List.CellValueAt(Idx, Self.ColumnProvider) = Account.Provider
		    Self.List.CellValueAt(Idx, Self.ColumnLabel) = Account.Label
		    Self.List.CellValueAt(Idx, Self.ColumnServerCount) = Language.NounWithQuantity(ServerCount, "Server", "Servers")
		  Next
		  
		  Self.List.Sort
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.SetupUI
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return "Accounts"
		End Function
	#tag EndMethod


	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnProvider, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnServerCount, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.account", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.LastRowIndex
		  Var Accounts() As Beacon.ExternalAccount
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Accounts.AddRow(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Accounts, "account", "accounts") = False Then
		    Return
		  End If
		  
		  For Each Account As Beacon.ExternalAccount In Accounts
		    Self.Document.Accounts.Remove(Account)
		  Next
		  
		  Self.SetupUI
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Accounts() As Dictionary
		  For Idx As Integer = 0 To Me.LastRowIndex
		    Var Account As Beacon.ExternalAccount = Me.RowTagAt(Idx)
		    Accounts.AddRow(Account.AsDictionary)
		  Next
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Accounts, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.kClipboardType) Then
		    Return
		  End If
		  
		  Var Accounts() As Variant
		  Try
		    Accounts = Beacon.ParseJSON(Board.RawData(Self.kClipboardType))
		  Catch Err As RuntimeException
		  End Try
		  
		  Var Changed As Boolean
		  For Each Dict As Dictionary In Accounts
		    Var Account As Beacon.ExternalAccount = Beacon.ExternalAccount.FromDictionary(Dict)
		    If Account Is Nil Then
		      Continue
		    End If
		    
		    Self.Document.Accounts.Add(Account)
		    Changed = True
		  Next
		  
		  If Changed Then
		    Self.SetupUI
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
