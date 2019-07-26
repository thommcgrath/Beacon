#tag Window
Begin BeaconDialog DocumentMergerWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   DefaultLocation =   "1"
   Frame           =   "8"
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   MinWidth        =   600
   Placement       =   "1"
   Resizable       =   True
   Resizeable      =   "False"
   SystemUIVisible =   True
   Title           =   "Import From Document"
   Type            =   "8"
   Visible         =   True
   Width           =   600
   Begin Label MessageLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      Text            =   "Select Parts to Import"
      TextAlign       =   "0"
      TextAlignment   =   "1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Select Parts to Import"
      Visible         =   True
      Width           =   560
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
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
      DropIndicatorVisible=   False
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontal=   "0"
      GridLinesHorizontalStyle=   "0"
      GridLinesVertical=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   True
      HasHeader       =   False
      HasHeading      =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
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
      RowCount        =   "0"
      RowSelectionType=   "0"
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionRequired=   False
      SelectionType   =   "0"
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
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
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      MacButtonStyle  =   "0"
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
		  Dim OAuthData As New Xojo.Core.Dictionary
		  For Each Document As Beacon.Document In SourceDocuments
		    For I As Integer = 0 To Document.ServerProfileCount - 1
		      Dim Profile As Beacon.ServerProfile = Document.ServerProfile(I)
		      If Profile.OAuthProvider <> "" Then
		        OAuthData.Value(Profile.OAuthProvider) = Document.OAuthData(Profile.OAuthProvider)
		      End If
		    Next
		  Next
		  
		  Dim MapMask As UInt64
		  For Each Document As Beacon.Document In SourceDocuments
		    MapMask = MapMask Or Document.MapCompatibility
		  Next
		  Dim NewMaps() As Beacon.Map = Beacon.Maps.ForMask(MapMask)
		  For I As Integer = NewMaps.Ubound DownTo 0
		    If DestinationDocument.SupportsMap(NewMaps(I)) Then
		      NewMaps.Remove(I)
		    End If
		  Next
		  Dim OldMaps() As Beacon.Map = DestinationDocument.Maps
		  For I As Integer = OldMaps.Ubound DownTo 0
		    If OldMaps(I).Matches(MapMask) Then
		      OldMaps.Remove(I)
		    End If
		  Next
		  
		  Dim Win As New DocumentMergerWindow
		  Win.mDestination = DestinationDocument
		  Win.mOAuthData = OAuthData
		  Win.mCallback = Callback
		  Dim Enabled As Boolean
		  Dim UsePrefixes As Boolean = SourceDocuments.Ubound > 0
		  For Each Document As Beacon.Document In SourceDocuments
		    Dim Prefix As String = If(UsePrefixes, Document.Title + ": ", "")
		    Dim Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		    For Each Config As Beacon.ConfigGroup In Configs
		      Dim CurrentConfig As Beacon.ConfigGroup = DestinationDocument.ConfigGroup(Config.ConfigName)
		      Dim CellContent As String = Prefix + Language.LabelForConfig(Config)
		      If Not Config.WasPerfectImport Then
		        If Win.List.DefaultRowHeight <> 40 Then
		          Win.List.DefaultRowHeight = 40
		        End If
		        CellContent = CellContent + EndOfLine + "This imported config is not perfect. Beacon will make a close approximation."
		      End If
		      Win.List.AddRow("", CellContent)
		      Win.List.CellCheck(Win.List.LastAddedRowIndex, 0) = UsePrefixes = False And Config.DefaultImported And (CurrentConfig = Nil Or CurrentConfig.IsImplicit)
		      Win.List.RowTag(Win.List.LastAddedRowIndex) = Config
		      Enabled = Enabled Or Win.List.CellCheck(Win.List.LastAddedRowIndex, 0)
		    Next
		    For I As Integer = 0 To Document.ServerProfileCount - 1
		      For X As Integer = 0 To DestinationDocument.ServerProfileCount - 1
		        If DestinationDocument.ServerProfile(X) = Document.ServerProfile(I) Then
		          Continue For I
		        End If
		      Next
		      Win.List.AddRow("", "Server Link: " + Document.ServerProfile(I).Name)
		      Win.List.CellCheck(Win.List.LastAddedRowIndex, 0) = True
		      Win.List.RowTag(Win.List.LastAddedRowIndex) = Document.ServerProfile(I)
		      Enabled = Enabled Or Win.List.CellCheck(Win.List.LastAddedRowIndex, 0)
		    Next
		  Next
		  For Each Map As Beacon.Map In NewMaps
		    Win.List.AddRow("", "Add Map: " + Map.Name)
		    Win.List.CellCheck(Win.List.LastAddedRowIndex, 0) = True
		    Win.List.RowTag(Win.List.LastAddedRowIndex) = "Map+" + Str(Map.Mask)
		    Enabled = Enabled Or Win.List.CellCheck(Win.List.LastAddedRowIndex, 0)
		  Next
		  For Each Map As Beacon.Map In OldMaps
		    Win.List.AddRow("", "Remove Map: " + Map.Name)
		    Win.List.CellCheck(Win.List.LastAddedRowIndex, 0) = True
		    Win.List.RowTag(Win.List.LastAddedRowIndex) = "Map-" + Str(Map.Mask)
		    Enabled = Enabled Or Win.List.CellCheck(Win.List.LastAddedRowIndex, 0)
		  Next
		  Win.ActionButton.Enabled = Enabled
		  
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
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
		Private mDestination As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthData As Xojo.Core.Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeCheckbox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.CellCheck(I, 0) Then
		      Self.ActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ActionButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Dim PreviousMods As New Beacon.TextList(Self.mDestination.Mods)
		  
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.CellCheck(I, 0) Or Self.List.RowTag(I) = Nil Then
		      Continue
		    End If
		    
		    Dim Tag As Variant = Self.List.RowTag(I)
		    Select Case Tag.Type
		    Case Variant.TypeObject
		      Select Case Tag
		      Case IsA Beacon.ConfigGroup
		        Dim Config As Beacon.ConfigGroup = Tag
		        Self.mDestination.AddConfigGroup(Config)
		      Case IsA Beacon.ServerProfile
		        Dim Profile As Beacon.ServerProfile = Tag
		        Self.mDestination.Add(Profile)
		        
		        If Profile.OAuthProvider <> "" And Self.mOAuthData.HasKey(Profile.OAuthProvider) Then
		          Dim OAuthData As Xojo.Core.Dictionary = Self.mOAuthData.Value(Profile.OAuthProvider)
		          If OAuthData <> Nil Then
		            Self.mDestination.OAuthData(Profile.OAuthProvider) = OAuthData
		          End If
		        End If
		      End Select
		    Case Variant.TypeString
		      Dim StringValue As String = Tag.StringValue
		      If StringValue.BeginsWith("Map") Then
		        Dim Operator As String = StringValue.Mid(4, 1)
		        Dim Mask As UInt64 = Val(StringValue.Mid(5))
		        If Operator = "+" Then
		          Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility Or Mask
		        Else
		          Self.mDestination.MapCompatibility = Self.mDestination.MapCompatibility And Not Mask
		        End If
		      End If
		    End Select
		  Next
		  
		  If Self.mDestination.Mods <> PreviousMods Then
		    Dim Notification As New Beacon.UserNotification("The list of mods enabled for document """ + Self.mDestination.Title + """ has changed.")
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="SystemUIVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
#tag EndViewBehavior
