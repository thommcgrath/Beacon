#tag Window
Begin ContainerControl ModSelectionGrid Implements PopoverContainer
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
   Width           =   532
   BeginDesktopSegmentedButton DesktopSegmentedButton ViewSelector
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      Segments        =   "Universal\n\nFalse\rSteam Only\n\nFalse\rCustom\n\nFalse"
      SelectionStyle  =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   280
   End
   Begin CheckBox ModCheckbox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Untitled"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   64
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
   Begin DelayedSearchField FilterField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Mods"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   312
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Visible         =   True
      Width           =   200
   End
   Begin UITweaks.ResizedPushButton NextPageButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "More"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   273
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   260
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton PrevPageButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Back"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   179
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   260
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label NoResultsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "No Results"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   -80
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   492
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ViewSelector.Width = 280 // Because the design-time size is not being respected
		  Self.ViewSelector.ResizeCells
		  Self.ViewSelector.SegmentAt(0).Selected = True
		  Self.BuildCheckboxes()
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildCheckboxes()
		  Self.mSettingUp = True
		  
		  Const EdgePadding = 20
		  Const MinWidth = 532
		  
		  Const PageUniversal = 0
		  Const PageSteam = 1
		  Const PageLocal = 2
		  
		  Var RequiredType As Ark.ContentPack.Types
		  For Idx As Integer = 0 To Self.ViewSelector.LastSegmentIndex
		    If Self.ViewSelector.SegmentAt(Idx).Selected Then
		      Select Case Idx
		      Case PageUniversal
		        RequiredType = Ark.ContentPack.Types.Universal
		      Case PageSteam
		        RequiredType = Ark.ContentPack.Types.Steam
		      Case PageLocal
		        RequiredType = Ark.ContentPack.Types.Custom
		      End Select
		      Exit For Idx
		    End If
		  Next Idx
		  
		  For Idx As Integer = Self.CheckboxesBound DownTo 0
		    Self.ModCheckbox(Idx).Close
		  Next
		  
		  If Self.mOffset = 0 Then
		    Self.mResultCount = Ark.DataSource.SharedInstance.CountContentPacks(Self.FilterField.Text.Trim, RequiredType)
		  End If
		  
		  Var Packs() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks(Self.FilterField.Text.Trim, RequiredType, Self.mOffset, Self.ResultsPerPage)
		  Var Measure As New Picture(20, 20)
		  Var MeasuredWidth As Double
		  Self.CheckboxesBound = Packs.LastIndex
		  For Idx As Integer = Packs.FirstIndex To Packs.LastIndex
		    MeasuredWidth = Max(MeasuredWidth, Measure.Graphics.TextWidth(Packs(Idx).Name))
		  Next Idx
		  
		  Var CheckboxWidth As Integer = Ceiling(MeasuredWidth + 40)
		  Var ColumnCount As Integer = Min(Floor(MinWidth / CheckboxWidth), Packs.Count)
		  Var RowCount As Integer = Ceiling(Packs.Count / ColumnCount)
		  
		  Self.mMap.ResizeTo(Packs.LastIndex)
		  
		  Var NextLeft As Integer = EdgePadding
		  Var NextTop As Integer = (EdgePadding * 2) + Self.ViewSelector.Height
		  For Idx As Integer = Packs.FirstIndex To Packs.LastIndex
		    Var Check As CheckBox = New ModCheckbox
		    Check.Caption = Packs(Idx).Name
		    Check.Width = CheckboxWidth
		    Check.Left = NextLeft
		    Check.Top = NextTop
		    Check.Value = Self.ModEnabled(Packs(Idx).UUID)
		    Self.mMap(Idx) = Packs(Idx).UUID
		    
		    If (Idx + 1) Mod ColumnCount = 0 Then
		      NextLeft = EdgePadding
		      NextTop = NextTop + Check.Height + 12
		    Else
		      NextLeft = NextLeft + Check.Width + 12
		    End If
		  Next Idx
		  
		  Var ViewHeight As Integer = (RowCount * 20) + ((RowCount - 1) * 12) + (Self.ViewSelector.Height + (EdgePadding * 3))
		  If Self.mResultCount = 0 Then
		    Self.PrevPageButton.Visible = False
		    Self.NextPageButton.Visible = False
		    ViewHeight = ViewHeight + Self.NoResultsLabel.Height + EdgePadding
		    Self.NoResultsLabel.Top = Self.ViewSelector.Top + Self.ViewSelector.Height + EdgePadding
		  ElseIf Self.mResultCount > Self.ResultsPerPage Then
		    ViewHeight = ViewHeight + Self.NextPageButton.Height + EdgePadding
		    Self.PrevPageButton.Visible = True
		    Self.NextPageButton.Visible = True
		    Self.PrevPageButton.Enabled = Self.mOffset > 0
		    Self.NextPageButton.Enabled = Self.mOffset + Self.ResultsPerPage < Self.mResultCount
		  Else
		    Self.PrevPageButton.Visible = False
		    Self.NextPageButton.Visible = False
		  End If
		  
		  Self.NoResultsLabel.Visible = (Self.mResultCount = 0)
		  
		  Self.Width = Max(MinWidth, (ColumnCount * CheckboxWidth) + ((ColumnCount - 1) * 12) + (EdgePadding * 2))
		  Self.Height = ViewHeight
		  
		  Var TopBarWidth As Integer = Self.ViewSelector.Width + 12 + Self.FilterField.Width
		  Self.ViewSelector.Left = (Self.Width - TopBarWidth) / 2
		  Self.FilterField.Left = Self.ViewSelector.Left + Self.ViewSelector.Width + 12
		  
		  If Self.PrevPageButton.Visible Or Self.NextPageButton.Visible Then
		    Var BottomBarWidth As Integer = Self.PrevPageButton.Width + 12 + Self.NextPageButton.Width
		    Self.PrevPageButton.Left = (Self.Width - BottomBarWidth) / 2
		    Self.NextPageButton.Left = Self.PrevPageButton.Left + Self.PrevPageButton.Width + 12
		  End If
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(EnabledMods As Beacon.StringList)
		  Self.EnabledMods = EnabledMods
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EnabledMods() As Beacon.StringList
		  Var List As New Beacon.StringList
		  For Each Entry As DictionaryEntry In Self.mModStates
		    If Entry.Value.BooleanValue Then
		      List.Append(Entry.Key.StringValue)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EnabledMods(Assigns List As Beacon.StringList)
		  Self.mModStates = New Dictionary
		  
		  For Each ModID As String In List
		    Self.mModStates.Value(ModID) = True
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetPadding(ByRef PaddingLeft As Integer, ByRef PaddingTop As Integer, ByRef PaddingRight As Integer, ByRef PaddingBottom As Integer)
		  // Part of the PopoverContainer interface.
		  
		  PaddingLeft = 0
		  PaddingTop = 0
		  PaddingRight = 0
		  PaddingBottom = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModEnabled(ModID As String) As Boolean
		  Return Self.mModStates.Lookup(ModID, False).BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ModEnabled(ModID As String, Assigns Value As Boolean)
		  Self.mModStates.Value(ModID) = Value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private CheckboxesBound As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModStates As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOffset As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResultCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = ResultsPerPage, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewSelector
	#tag Event
		Sub Pressed(segmentIndex as integer)
		  #Pragma Unused SegmentIndex
		  
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.mOffset = 0
		  Self.BuildCheckboxes()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModCheckbox
	#tag Event
		Sub Action(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.ModEnabled(Self.mMap(Index)) = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.mOffset = 0
		  Self.BuildCheckboxes()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NextPageButton
	#tag Event
		Sub Action()
		  Self.mOffset = Self.mOffset + Self.ResultsPerPage
		  Self.BuildCheckboxes()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PrevPageButton
	#tag Event
		Sub Action()
		  Self.mOffset = Self.mOffset - Self.ResultsPerPage
		  Self.BuildCheckboxes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
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
