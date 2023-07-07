#tag DesktopWindow
Begin DesktopContainer ModSelectionGrid Implements PopoverContainer
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   280
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
   Width           =   512
   Begin DesktopCheckBox ModCheckbox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Untitled"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
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
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
   Begin DelayedSearchField FilterField
      Active          =   False
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
      Left            =   302
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   11
      Transparent     =   False
      Visible         =   True
      Width           =   200
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
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
      Top             =   250
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
      Top             =   250
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel NoResultsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Width           =   472
   End
   Begin BeaconSegmentedControl ViewSelector
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowMultipleSelection=   False
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Universal	Steam Only	Custom"
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   11
      Transparent     =   True
      Visible         =   True
      Width           =   280
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.BuildCheckboxes()
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildCheckboxes()
		  Self.mSettingUp = True
		  
		  Const MinWidth = 532
		  Const InnerSpacing = 20
		  
		  Const PageUniversal = 0
		  Const PageSteam = 1
		  Const PageLocal = 2
		  
		  Var PaddingLeft, PaddingTop, PaddingRight, PaddingBottom As Integer
		  Self.GetPadding(PaddingLeft, PaddingTop, PaddingRight, PaddingBottom)
		  Var HeaderHeight As Integer = PaddingTop + Max(Self.ViewSelector.Height, Self.FilterField.Height) + InnerSpacing
		  
		  Var RequiredType As Ark.ContentPack.Types
		  For Idx As Integer = 0 To Self.ViewSelector.LastIndex
		    If Self.ViewSelector.Segment(Idx).Selected Then
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
		    Self.mResultCount = Ark.DataSource.Pool.Get(False).CountContentPacks(Self.FilterField.Text.Trim, RequiredType)
		  End If
		  
		  Var Packs() As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks(Self.FilterField.Text.Trim, RequiredType, Self.mOffset, Self.ResultsPerPage)
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
		  
		  Var NextLeft As Integer = PaddingLeft
		  Var NextTop As Integer = HeaderHeight
		  For Idx As Integer = Packs.FirstIndex To Packs.LastIndex
		    Var Check As DesktopCheckBox = New ModCheckbox
		    Check.Caption = Packs(Idx).Name
		    Check.Width = CheckboxWidth
		    Check.Left = NextLeft
		    Check.Top = NextTop
		    Check.Value = Self.ModEnabled(Packs(Idx).ContentPackId)
		    Self.mMap(Idx) = Packs(Idx).ContentPackId
		    
		    If (Idx + 1) Mod ColumnCount = 0 Then
		      NextLeft = PaddingLeft
		      NextTop = NextTop + Check.Height + 12
		    Else
		      NextLeft = NextLeft + Check.Width + 12
		    End If
		  Next Idx
		  
		  Var ViewHeight As Integer = HeaderHeight + (RowCount * 20) + ((RowCount - 1) * 12) + PaddingBottom
		  If Self.mResultCount = 0 Then
		    Self.PrevPageButton.Visible = False
		    Self.NextPageButton.Visible = False
		    ViewHeight = HeaderHeight + Self.NoResultsLabel.Height + PaddingBottom
		    Self.NoResultsLabel.Top = HeaderHeight
		  ElseIf Self.mResultCount > Self.ResultsPerPage Then
		    ViewHeight = ViewHeight + Self.NextPageButton.Height + InnerSpacing
		    Self.PrevPageButton.Visible = True
		    Self.NextPageButton.Visible = True
		    Self.PrevPageButton.Enabled = Self.mOffset > 0
		    Self.NextPageButton.Enabled = Self.mOffset + Self.ResultsPerPage < Self.mResultCount
		  Else
		    Self.PrevPageButton.Visible = False
		    Self.NextPageButton.Visible = False
		  End If
		  
		  Self.NoResultsLabel.Visible = (Self.mResultCount = 0)
		  
		  Self.Width = Max(MinWidth, (ColumnCount * CheckboxWidth) + ((ColumnCount - 1) * 12) + PaddingLeft + PaddingRight)
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
		  
		  PaddingLeft = 10
		  PaddingTop = 10
		  PaddingRight = 10
		  PaddingBottom = 10
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

#tag Events ModCheckbox
	#tag Event
		Sub ValueChanged(index as Integer)
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
		Sub Pressed()
		  Self.mOffset = Self.mOffset + Self.ResultsPerPage
		  Self.BuildCheckboxes()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PrevPageButton
	#tag Event
		Sub Pressed()
		  Self.mOffset = Self.mOffset - Self.ResultsPerPage
		  Self.BuildCheckboxes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ViewSelector
	#tag Event
		Sub Pressed()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.mOffset = 0
		  Self.BuildCheckboxes()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Segment(0).Selected = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
#tag EndViewBehavior
