#tag Window
Begin LibrarySubview LibraryPaneSearch
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
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
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Search"
      DoubleBuffer    =   False
      Enabled         =   True
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
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   300
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection SearchSocket
      AllowCertificateValidation=   False
      Enabled         =   True
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
		Private Function DrawResult(G As Graphics, Top As Integer, Dict As Dictionary, Selected As Boolean) As Xojo.Rect
		  Const FontSizePoints = 14.0
		  Var SmallFontSizePoints As Double = FontSizePoints * 0.8
		  
		  Var Type As String = Dict.Lookup("type", "")
		  Var Title As String = Dict.Lookup("title", "")
		  Var Summary As String = Dict.Lookup("summary", "")
		  
		  G.FontName = "System"
		  G.FontSize = FontSizePoints
		  Var TitleCapHeight As Double = G.CapHeight
		  Var TitleWidth As Integer = Ceiling(G.TextWidth(Title))
		  
		  G.FontSize = SmallFontSizePoints
		  Var TypeCapHeight As Double = G.CapHeight
		  
		  Var RectHeight As Integer = ((Self.ResultPadding + 1) * 2) + Max(TitleCapHeight, TypeCapHeight)
		  Var MaxTextWidth As Integer = G.Width - ((Self.ResultSpacing + Self.ResultPadding + 1) * 2)
		  If Summary <> "" Then
		    RectHeight = RectHeight + Self.ResultPadding + G.TextHeight(Summary, MaxTextWidth)
		  End If
		  
		  Var Rect As New Xojo.Rect(Self.ResultSpacing, Top, G.Width - (Self.ResultSpacing * 2), RectHeight)
		  Var TitleLeft As Integer = Rect.Left + 1 + Self.ResultPadding
		  Var TypeWidth As Integer = Ceiling(G.TextWidth(Type)) + 8
		  Var TypeLeft As Integer = Min(TitleLeft + TitleWidth + Self.ResultPadding, (TitleLeft + MaxTextWidth) - TypeWidth)
		  Var TitleBaseline As Integer = Rect.Top + 1 + Self.ResultPadding + TitleCapHeight
		  Var TypeTop As Integer = TitleBaseline - (TypeCapHeight + 5)
		  Var TypeBottom As Integer = TitleBaseline + 5
		  Var TypeHeight As Integer = TypeBottom - TypeTop
		  Var TitleMaxWidth As Integer = Min(MaxTextWidth, (TypeLeft - (TitleLeft + Self.ResultPadding)))
		  
		  If Rect.Bottom < 0 Or Rect.Top > Self.Height Then
		    Return Rect
		  End If
		  
		  Var BackgroundColor, TypeFrameColor, TypeTextColor, LinkColor, SummaryColor As Color
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
		  
		  G.DrawingColor = BackgroundColor
		  G.FillRoundRectangle(Rect.Left, Rect.Top, Rect.Width, Rect.Height, 12, 12)
		  G.DrawingColor = TypeFrameColor
		  G.FillRoundRectangle(TypeLeft, TypeTop, TypeWidth, TypeHeight, 6, 6)
		  G.FontSize = FontSizePoints
		  G.DrawingColor = LinkColor
		  G.Underline = True
		  G.DrawText(Title, Rect.Left + 1 + Self.ResultPadding, TitleBaseline, TitleMaxWidth, True)
		  G.FontSize = SmallFontSizePoints
		  G.Underline = False
		  If Summary <> "" Then
		    G.DrawingColor = SummaryColor
		    G.DrawText(Summary, Rect.Left + 1 + Self.ResultPadding, TitlebaseLine + 4 + Self.ResultPadding + TypeCapHeight, MaxTextWidth, False)
		  End If
		  G.DrawingColor = TypeTextColor
		  G.DrawText(Type, TypeLeft + 4, TitleBaseline)
		  
		  Return Rect
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reset()
		  Self.mSearchTerms = ""
		  Self.mScrollPosition = 0
		  Self.mResultDicts.ResizeTo(-1)
		  Self.mResultRects.ResizeTo(-1)
		  Self.Area.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectDict(Dict As Dictionary)
		  Var URL As String = Dict.Lookup("url", "")
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
		Private mResultRects() As Xojo.Rect
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
		  Self.SearchTimer.RunMode = Timer.RunModes.Single
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SearchTimer
	#tag Event
		Sub Action()
		  Var Terms As String = Self.SearchField.Value.Trim
		  
		  If Terms = "" Then
		    Self.Reset()
		    Return
		  End If
		  
		  Self.SearchSocket.Disconnect
		  Self.SearchSocket.ClearRequestHeaders
		  
		  Self.SearchSocket.RequestHeader("Accept") = "application/json"
		  Self.SearchSocket.Send("GET", Beacon.WebURL("/search/?query=" + EncodeURLComponent(Terms)))
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
		  
		  Var Details As Dictionary
		  Try
		    Details = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Results() As Variant
		  Try
		    Results = Details.Value("results")
		    Self.mSearchTerms = Details.Value("terms")
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  For Each ResultDict As Dictionary In Results
		    Self.mResultDicts.AddRow(ResultDict)
		    Self.mResultRects.AddRow(Nil)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Area
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.DrawingColor = SystemColors.LabelColor
		  
		  If Self.mResultDicts.LastRowIndex = -1 Then
		    If Self.mSearchTerms = "" Then
		      G.FontName = "System"
		      G.FontSize = 0
		      G.DrawText(Self.StringSearchHelp, 10, 20 + G.CapHeight, G.Width - 20, False)
		    Else
		      G.Bold = True
		      Var CaptionWidth As Integer = Ceiling(G.TextWidth(Self.StringNoResults))
		      Var CaptionLeft As Integer = (G.Width - CaptionWidth) / 2
		      Var CaptionBaseline As Integer = (G.Height / 2) + (G.CapHeight / 2)
		      G.DrawText(Self.StringNoResults, CaptionLeft, CaptionBaseline, G.Width - 20, True)
		    End If
		    Return
		  End If
		  
		  Self.mContentHeight = Self.ResultSpacing
		  Var NextTop As Integer = Self.ResultSpacing - Self.mScrollPosition
		  For I As Integer = 0 To Self.mResultDicts.LastRowIndex
		    Var Dict As Dictionary = Self.mResultDicts(I)
		    Var Rect As Xojo.Rect = Self.DrawResult(G, NextTop, Dict, Self.mMousePressIndex = I)
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
		  
		  Var ScrollMax As Integer = Max(Self.mContentHeight - Self.Height, 0)
		  Self.mScrollPosition = Min(Max(Self.mScrollPosition + PixelsY, 0), ScrollMax)
		  Me.Invalidate()
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var Point As New Xojo.Point(X, Y)
		  
		  Self.mMouseDownIndex = -1
		  For I As Integer = 0 To Self.mResultRects.LastRowIndex
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
		  
		  Var Point As New Xojo.Point(X, Y)
		  Var Rect As Xojo.Rect = Self.mResultRects(Self.mMouseDownIndex)
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
		  
		  Var Point As New Xojo.Point(X, Y)
		  Var Rect As Xojo.Rect = Self.mResultRects(Self.mMouseDownIndex)
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
