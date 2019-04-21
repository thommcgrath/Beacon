#tag Window
Begin LibrarySubview LibraryPaneSearch
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
   Height          =   300
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
   Width           =   300
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Search"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
   Begin UITweaks.ResizedTextField SearchField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   "Search"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   50
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   280
   End
   Begin Timer SearchTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   300
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection SearchSocket
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ControlCanvas Area
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   218
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   82
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ToolbarCaption = "Search"
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.SearchField.SetFocus()
		  Self.SearchField.SelectAll()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DrawResult(G As Graphics, Top As Integer, Dict As Dictionary, Selected As Boolean) As REALbasic.Rect
		  Const FontSizePoints = 14.0
		  Dim SmallFontSizePoints As Double = FontSizePoints * 0.8
		  
		  Dim Type As String = Dict.Lookup("type", "")
		  Dim Title As String = Dict.Lookup("title", "")
		  Dim Summary As String = Dict.Lookup("summary", "")
		  
		  G.TextFont = "System"
		  G.TextSize = FontSizePoints
		  Dim TitleCapHeight As Double = G.CapHeight
		  Dim TitleWidth As Integer = Ceil(G.StringWidth(Title))
		  
		  G.TextSize = SmallFontSizePoints
		  Dim TypeCapHeight As Double = G.CapHeight
		  
		  Dim RectHeight As Integer = ((Self.ResultPadding + 1) * 2) + Max(TitleCapHeight, TypeCapHeight)
		  Dim MaxTextWidth As Integer = G.Width - ((Self.ResultSpacing + Self.ResultPadding + 1) * 2)
		  If Summary <> "" Then
		    RectHeight = RectHeight + Self.ResultPadding + G.StringHeight(Summary, MaxTextWidth)
		  End If
		  
		  Dim Rect As New REALbasic.Rect(Self.ResultSpacing, Top, G.Width - (Self.ResultSpacing * 2), RectHeight)
		  Dim TitleLeft As Integer = Rect.Left + 1 + Self.ResultPadding
		  Dim TypeWidth As Integer = Ceil(G.StringWidth(Type)) + 8
		  Dim TypeLeft As Integer = Min(TitleLeft + TitleWidth + Self.ResultPadding, (TitleLeft + MaxTextWidth) - TypeWidth)
		  Dim TitleBaseline As Integer = Rect.Top + 1 + Self.ResultPadding + TitleCapHeight
		  Dim TypeTop As Integer = TitleBaseline - (TypeCapHeight + 5)
		  Dim TypeBottom As Integer = TitleBaseline + 5
		  Dim TypeHeight As Integer = TypeBottom - TypeTop
		  Dim TitleMaxWidth As Integer = Min(MaxTextWidth, (TypeLeft - (TitleLeft + Self.ResultPadding)))
		  
		  If Rect.Bottom < 0 Or Rect.Top > Self.Height Then
		    Return Rect
		  End If
		  
		  Dim BackgroundColor, TypeFrameColor, TypeTextColor, LinkColor, SummaryColor As Color
		  If Selected Then
		    BackgroundColor = SystemColors.SelectedContentBackgroundColor
		    TypeFrameColor = SystemColors.AlternateSelectedControlTextColor
		    TypeTextColor = BackgroundColor
		    LinkColor = TypeFrameColor
		    SummaryColor = TypeFrameColor
		  Else
		    BackgroundColor = SystemColors.ControlColor
		    TypeFrameColor = SystemColors.ControlBackgroundColor
		    TypeFrameColor = SystemColors.AlternateSelectedControlTextColor
		    LinkColor = SystemColors.LinkColor
		    SummaryColor = SystemColors.LabelColor
		  End If
		  
		  G.ForeColor = BackgroundColor
		  G.FillRoundRect(Rect.Left, Rect.Top, Rect.Width, Rect.Height, 12, 12)
		  G.ForeColor = TypeFrameColor
		  G.FillRoundRect(TypeLeft, TypeTop, TypeWidth, TypeHeight, 6, 6)
		  G.TextSize = FontSizePoints
		  G.ForeColor = LinkColor
		  G.Underline = True
		  G.DrawString(Title, Rect.Left + 1 + Self.ResultPadding, TitleBaseline, TitleMaxWidth, True)
		  G.TextSize = SmallFontSizePoints
		  G.Underline = False
		  If Summary <> "" Then
		    G.ForeColor = SummaryColor
		    G.DrawString(Summary, Rect.Left + 1 + Self.ResultPadding, TitlebaseLine + 4 + Self.ResultPadding + TypeCapHeight, MaxTextWidth, False)
		  End If
		  G.ForeColor = TypeTextColor
		  G.DrawString(Type, TypeLeft + 4, TitleBaseline)
		  
		  Return Rect
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reset()
		  Self.mSearchTerms = ""
		  Self.mScrollPosition = 0
		  Redim Self.mResultDicts(-1)
		  Redim Self.mResultRects(-1)
		  Self.Area.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectDict(Dict As Dictionary)
		  Dim URL As String = Dict.Lookup("url", "")
		  If URL = "" Then
		    Self.ShowAlert("Unable to show search result", "Something is wrong, the result has no url.")
		    Return
		  End If
		  If URL.BeginsWith("/") Then
		    URL = Beacon.WebURL(URL)
		  End If
		  
		  ShowURL(URL)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mContentHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePressIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResultDicts() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResultRects() As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSearchTerms As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedURL As String
	#tag EndProperty


	#tag Constant, Name = ResultPadding, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ResultSpacing, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StringNoResults, Type = String, Dynamic = True, Default = \"No Results", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StringSearchHelp, Type = String, Dynamic = True, Default = \"Search for anything\x2C including help topics\x2C community documents\x2C and engrams. If Beacon knows about it\x2C it can be found here.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SearchField
	#tag Event
		Sub TextChange()
		  Self.SearchTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SearchTimer
	#tag Event
		Sub Action()
		  Dim Terms As String = Trim(Self.SearchField.Text)
		  
		  If Terms = "" Then
		    Self.Reset()
		    Return
		  End If
		  
		  Self.SearchSocket.Disconnect
		  Self.SearchSocket.ClearRequestHeaders
		  
		  Self.SearchSocket.RequestHeader("Accept") = "application/json"
		  Self.SearchSocket.Send("GET", Beacon.WebURL("/search/?query=" + Beacon.URLEncode(Terms)))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SearchSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  Self.Reset()
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    Return
		  End If
		  
		  Dim Details As Dictionary
		  Try
		    Details = Beacon.ParseJSON(Content)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return
		  End Try
		  
		  Dim Results() As Variant
		  Try
		    Results = Details.Value("results")
		    Self.mSearchTerms = Details.Value("terms")
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  For Each ResultDict As Dictionary In Results
		    Self.mResultDicts.Append(ResultDict)
		    Self.mResultRects.Append(Nil)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Area
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.ForeColor = SystemColors.LabelColor
		  
		  If Self.mResultDicts.Ubound = -1 Then
		    If Self.mSearchTerms = "" Then
		      G.TextFont = "System"
		      G.TextSize = 0
		      G.DrawString(Self.StringSearchHelp, 10, 20 + G.CapHeight, G.Width - 20, False)
		    Else
		      G.Bold = True
		      Dim CaptionWidth As Integer = Ceil(G.StringWidth(Self.StringNoResults))
		      Dim CaptionLeft As Integer = (G.Width - CaptionWidth) / 2
		      Dim CaptionBaseline As Integer = (G.Height / 2) + (G.CapHeight / 2)
		      G.DrawString(Self.StringNoResults, CaptionLeft, CaptionBaseline, G.Width - 20, True)
		    End If
		    Return
		  End If
		  
		  Self.mContentHeight = Self.ResultSpacing
		  Dim NextTop As Integer = Self.ResultSpacing - Self.mScrollPosition
		  For I As Integer = 0 To Self.mResultDicts.Ubound
		    Dim Dict As Dictionary = Self.mResultDicts(I)
		    Dim Rect As REALbasic.Rect = Self.DrawResult(G, NextTop, Dict, Self.mMousePressIndex = I)
		    If Rect <> Nil Then
		      Self.mResultRects(I) = Rect
		      NextTop = Rect.Bottom + Self.ResultSpacing
		      Self.mContentHeight = Self.mContentHeight + Self.ResultSpacing + Rect.Height
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Integer, PixelsY As Integer, WheelData As BeaconUI.ScrollEvent) As Boolean
		  #Pragma Unused MouseX
		  #Pragma Unused MouseY
		  #Pragma Unused PixelsX
		  #Pragma Unused WheelData
		  
		  Dim ScrollMax As Integer = Max(Self.mContentHeight - Self.Height, 0)
		  Self.mScrollPosition = Min(Max(Self.mScrollPosition + PixelsY, 0), ScrollMax)
		  Me.Invalidate()
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New REALbasic.Point(X, Y)
		  
		  Self.mMouseDownIndex = -1
		  For I As Integer = 0 To Self.mResultRects.Ubound
		    If Self.mResultRects(I) <> Nil And Self.mResultRects(I).Contains(Point) Then
		      Self.mMouseDownIndex = I
		      Exit For I
		    End If
		  Next
		  Self.mMousePressIndex = Self.mMouseDownIndex
		  
		  Self.Invalidate()
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownIndex = -1 Then
		    Return
		  End If
		  
		  Dim Point As New REALbasic.Point(X, Y)
		  Dim Rect As REALbasic.Rect = Self.mResultRects(Self.mMouseDownIndex)
		  If Rect.Contains(Point) Then
		    If Self.mMousePressIndex <> Self.mMouseDownIndex Then
		      Self.mMousePressIndex = Self.mMouseDownIndex
		      Self.Invalidate
		    End If
		  Else
		    If Self.mMousePressIndex <> -1 Then
		      Self.mMousePressIndex = -1
		      Self.Invalidate
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownIndex = -1 Then
		    Return
		  End If
		  
		  Dim Point As New REALbasic.Point(X, Y)
		  Dim Rect As REALbasic.Rect = Self.mResultRects(Self.mMouseDownIndex)
		  If Rect.Contains(Point) Then
		    Self.SelectDict(Self.mResultDicts(Self.mMouseDownIndex))
		  End If
		  Self.mMousePressIndex = -1
		  Self.mMouseDownIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
