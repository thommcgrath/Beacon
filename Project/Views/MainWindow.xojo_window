#tag Window
Begin Window MainWindow Implements BeaconUI.SheetPositionHandler
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   800
   Placement       =   2
   Resizeable      =   True
   Title           =   "Beacon"
   Visible         =   True
   Width           =   800
   Begin LibraryPane LibraryPane1
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   400
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   300
   End
   Begin PagePanel Views
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   301
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   499
      Begin BeaconToolbar EmptyToolbar
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Welcome to Beacon"
         CaptionEnabled  =   False
         CaptionIsButton =   False
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   False
         HasResizer      =   False
         Height          =   41
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   301
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   499
      End
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   319
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   321
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Select Something"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   459
      End
   End
   Begin FadedSeparator Divider
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  Dim ModifiedViews() As BeaconSubview
		  
		  For Each View As BeaconSubview In Self.mSubviews
		    If View.ContentsChanged Then
		      ModifiedViews.Append(View)
		    End If
		  Next
		  
		  Select Case ModifiedViews.Ubound
		  Case -1
		    Return False
		  Case 0
		    Return Not Self.DiscardView(ModifiedViews(0))
		  Else
		    Dim NumChanges As Integer = ModifiedViews.Ubound + 1
		    
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "You have " + NumChanges.ToText + " documents with unsaved changes. Do you want to review these changes before quitting?"
		    Dialog.Explanation = "If you don't review your documents, all your changes will be lost."
		    Dialog.ActionButton.Caption = "Review Changes…"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Caption = "Discard Changes"
		    Dialog.AlternateActionButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		    If Choice = Dialog.ActionButton Then
		      For Each View As BeaconSubview In ModifiedViews
		        If Not Self.DiscardView(View) Then
		          Return True
		        End If
		      Next      
		      Return False
		    ElseIf Choice = Dialog.CancelButton Then
		      Return True
		    ElseIf Choice = Dialog.AlternateActionButton Then
		      Return False
		    End If
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If Self.mCurrentView <> Nil Then
		    Self.mCurrentView.EnableMenuItems()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Moved()
		  If Self.mOpened Then
		    App.Preferences.RectValue("Main Window Size") = New Xojo.Core.Rect(Self.Left, Self.Top, Self.Width, Self.Height)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Dim Bounds As Xojo.Core.Rect = App.Preferences.RectValue("Main Window Size")
		  If Bounds <> Nil Then
		    // Find the best screen
		    Dim IdealScreen As Screen = Screen(0)
		    If ScreenCount > 1 Then
		      Dim MaxArea As Integer
		      For I As Integer = 0 To ScreenCount - 1
		        Dim ScreenBounds As New Xojo.Core.Rect(Screen(I).AvailableLeft, Screen(I).AvailableTop, Screen(I).AvailableWidth, Screen(I).AvailableHeight)
		        Dim Intersection As Xojo.Core.Rect = ScreenBounds.Intersection(Bounds)
		        If Intersection = Nil Then
		          Continue
		        End If
		        Dim Area As Integer = Intersection.Width * Intersection.Height
		        If Area <= 0 Then
		          Continue
		        End If
		        If Area > MaxArea Then
		          MaxArea = Area
		          IdealScreen = Screen(I)
		        End If
		      Next
		    End If
		    
		    Dim AvailableBounds As New Xojo.Core.Rect(IdealScreen.AvailableLeft, IdealScreen.AvailableTop, IdealScreen.AvailableWidth, IdealScreen.AvailableHeight)
		    
		    Dim Width As Integer = Min(Max(Bounds.Width, Self.MinWidth), Self.MaxWidth, AvailableBounds.Width)
		    Dim Height As Integer = Min(Max(Bounds.Height, Self.MinHeight), Self.MaxHeight, AvailableBounds.Height)
		    Dim Left As Integer = Min(Max(Bounds.Left, AvailableBounds.Left), AvailableBounds.Right - Width)
		    Dim Top As Integer = Min(Max(Bounds.Top, AvailableBounds.Top), AvailableBounds.Bottom - Height)
		    
		    Self.Width = Width
		    Self.Height = Height
		    Self.Left = Left
		    Self.Top = Top
		  End If
		  
		  Dim SplitterPosition As Integer = App.Preferences.IntegerValue("Main Splitter Position", 300)
		  Self.ResizeSplitter(SplitterPosition)
		  
		  Self.mOpened = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If Self.mOpened Then
		    App.Preferences.RectValue("Main Window Size") = New Xojo.Core.Rect(Self.Left, Self.Top, Self.Width, Self.Height)
		  End If
		  
		  Dim Value As Integer = Self.LibraryPane1.Width
		  Self.ResizeSplitter(Value)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Dim Value As Integer = Self.LibraryPane1.Width
		  Self.ResizeSplitter(Value)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  
		  #if TargetCocoa And BeaconUI.ToolbarHasBackground = False
		    Declare Function NSSelectorFromString Lib "Cocoa" (SelectorName As CFStringRef) As Ptr
		    Declare Function RespondsToSelector Lib "Cocoa" Selector "respondsToSelector:" (Target As Integer, SelectorRef As Ptr) As Boolean
		    Declare Sub SetTitlebarAppearsTransparent Lib "Cocoa" Selector "setTitlebarAppearsTransparent:" (Target As Integer, Value As Boolean)
		    
		    If RespondsToSelector(Self.Handle, NSSelectorFromString("setTitlebarAppearsTransparent:")) Then
		      SetTitlebarAppearsTransparent(Self.Handle, True)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DiscardView(View As BeaconSubview) As Boolean
		  If View.ContentsChanged Then
		    Self.ShowView(View)
		    If Not View.ConfirmClose Then
		      Return False
		    End If
		  End If
		  
		  If View = Self.mCurrentView Then
		    Self.ShowView(Nil)
		  End If
		  
		  Dim ViewIndex As Integer = Self.mSubviews.IndexOf(View)
		  If ViewIndex = -1 Then
		    Return True
		  End If
		  
		  Self.mSubviews.Remove(ViewIndex)
		  View.Close
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Documents() As LibraryPaneDocuments
		  Return Self.LibraryPane1.DocumentsPane
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PositionSheet(Sheet As Window, InitialPosition As REALbasic.Rect) As REALbasic.Rect
		  // Part of the BeaconUI.SheetPositionHandler interface.
		  
		  #if Not BeaconUI.ToolbarHasBackground
		    Dim Frame As REALbasic.Rect = Self.Bounds
		    Dim TitlebarHeight As Integer = Self.Top - Frame.Top
		    
		    InitialPosition.Top = InitialPosition.Top - (Self.EmptyToolbar.Height + TitlebarHeight)
		  #endif
		  
		  Return InitialPosition
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As LibraryPanePresets
		  Return Self.LibraryPane1.PresetsPane
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResizeSplitter(ByRef NewSize As Integer)
		  NewSize = Max(NewSize, Self.MinSplitterPosition)
		  
		  Dim View As BeaconSubview = Self.mCurrentView
		  If View <> Nil Then
		    NewSize = Min(NewSize, Self.Width - View.MinWidth)
		  Else
		    NewSize = Min(NewSize, Self.Width - 200)
		  End If
		  
		  If LibraryPane1.Width = NewSize Then
		    Return
		  End If
		  
		  LibraryPane1.Width = NewSize
		  Divider.Left = NewSize
		  Views.Left = Divider.Left + Divider.Width
		  Views.Width = Self.Width - Views.Left
		  
		  If Self.mOpened Then
		    App.Preferences.IntegerValue("Main Splitter Position") = NewSize
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowView(View As BeaconSubview)
		  If Self.mCurrentView = View Then
		    Return
		  End If
		  
		  If Self.mCurrentView <> Nil Then
		    Self.mCurrentView.Visible = False
		  End If
		  
		  If View = Nil Then
		    Self.ContentsChanged = False
		    Self.mCurrentView = Nil
		    Self.Views.Value = 0
		    Return
		  End If
		  
		  View.Visible = True
		  Self.mCurrentView = View
		  
		  If Self.mSubviews.IndexOf(View) = -1 Then
		    Self.mSubviews.Append(View)
		    View.EmbedWithinPanel(Self.Views, 1, 0, 0, Self.Views.Width, Self.Views.Height)
		    
		    AddHandler View.ContentsChanged, WeakAddressOf Subview_ContentsChanged
		  End If
		  
		  Self.ContentsChanged = View.ContentsChanged
		  Self.MinWidth = Max(Self.MinSplitterPosition + View.MinWidth, Self.AbsoluteMinWidth)
		  Self.MinHeight = Max(View.MinHeight, Self.AbsoluteMinHeight)
		  If Self.Width < Self.MinWidth Then
		    Self.Width = Self.MinWidth
		  End If
		  If Self.Height < Self.MinHeight Then
		    Self.Height = Self.MinHeight
		  End If
		  
		  If View.Title <> "" Then
		    Self.Title = "Beacon: " + View.Title
		  Else
		    Self.Title = "Beacon"
		  End If
		  
		  Self.Views.Value = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Subview_ContentsChanged(Sender As ContainerControl)
		  If Self.mCurrentView = Sender Then
		    Self.ContentsChanged = Sender.ContentsChanged
		    If Sender.Title <> "" Then
		      Self.Title = "Beacon: " + Sender.Title
		    Else
		      Self.Title = "Beacon"
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentView As BeaconSubview
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubviews(-1) As BeaconSubview
	#tag EndProperty


	#tag Constant, Name = AbsoluteMinHeight, Type = Double, Dynamic = False, Default = \"400", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AbsoluteMinWidth, Type = Double, Dynamic = False, Default = \"800", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinSplitterPosition, Type = Double, Dynamic = False, Default = \"300", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events LibraryPane1
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.ResizeSplitter(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  Self.ShowView(View)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return Self.DiscardView(View)
		End Function
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
		Visible=true
		Group="Deprecated"
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
