#tag Window
Begin Window ExceptionWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   "Beacon Error"
   Visible         =   True
   Width           =   600
   Begin ControlCanvas LogoCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   64
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   64
   End
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   104
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Beacon has encountered an unrecoverable error"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   476
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   38
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   104
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Well this is embarrassing. Something has gone wrong that Beacon wasn't prepared for. Beacon will need to stop now."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   476
   End
   Begin UITweaks.ResizedPushButton QuitButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Quit"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
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
   Begin FadedSeparator TopBorder
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   102
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   476
   End
   Begin FadedSeparator LeftBorder
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   236
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   103
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin FadedSeparator BottomBorder
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   339
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   476
   End
   Begin FadedSeparator RightBorder
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   236
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   579
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   103
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   236
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   105
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   103
      Transparent     =   False
      Value           =   3
      Visible         =   True
      Width           =   474
      Begin Label CheckingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Checking for solution…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin ProgressBar CheckingIndicator
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   155
         Transparent     =   False
         Value           =   0
         Visible         =   True
         Width           =   434
      End
      Begin Label PermissionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   70
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Your privacy settings prevent Beacon from looking for a solution to this problem. Would you like to allow a one-time connection? No information about you or your computer will be sent to Beacon's server."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton PermissionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Allow Connection"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   274
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   205
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   135
      End
      Begin LinkLabel PermissionPolicyLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         ShowAsLink      =   True
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Privacy Policy"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   237
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   434
      End
      Begin Label SolutionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   38
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Good news! It seems like there is more information about this problem available online."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton SolutionOpenButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "View Online"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   287
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   173
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   110
      End
      Begin Label NoSolutionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   90
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Unfortunately, Beacon could not find any new information about this problem. You may be the first to experience it.\n\nIf the error happens consistently, please report it with as much detail as possible. Doing so may help other users."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton ReportButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Add Comments"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   281
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   225
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   121
      End
   End
   Begin Label ErrorIDLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Error ID: <hash>"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   361
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   475
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub BeginChecking()
		  Self.Pages.Value = Self.PageStart
		  
		  Dim Trace() As Xojo.Core.StackFrame = Self.mExceptionDetails.Value("Trace")
		  Dim Lines() As Text
		  For Each Frame As Xojo.Core.StackFrame In Trace
		    Lines.Append(Frame.Name)
		  Next
		  
		  Dim Fields As New Xojo.Core.Dictionary
		  Fields.Value("build") = App.BuildNumber.ToText
		  Fields.Value("hash") = Self.mExceptionHash
		  Fields.Value("type") = Self.mExceptionDetails.Value("Type")
		  Fields.Value("reason") = Self.mExceptionDetails.Value("Reason")
		  Fields.Value("location") = Self.mExceptionDetails.Value("Location")
		  Fields.Value("trace") = Lines.Join(Text.FromUnicodeCodepoint(10))
		  If Self.mExceptionDetails.HasKey("UserID") Then
		    Fields.Value("user_id") = Self.mExceptionDetails.Value("UserID")
		  End If
		  
		  SimpleHTTP.Post(Beacon.WebURL("/reportaproblem.php"), Fields, AddressOf Reporter_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Dict As Xojo.Core.Dictionary)
		  Dim Trace() As Xojo.Core.StackFrame = Dict.Value("Trace")
		  Dim Lines() As Text
		  Lines.Append(Dict.Value("Type"))
		  Lines.Append(Dict.Value("Reason"))
		  For Each Frame As Xojo.Core.StackFrame In Trace
		    Lines.Append(Frame.Name)
		  Next
		  
		  Dim HashContent As Text = Lines.Join(Text.FromUnicodeCodepoint(10))
		  Dim Hash As Text = Beacon.EncodeHex(Xojo.Crypto.SHA1(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(HashContent)))
		  
		  Dim Win As New ExceptionWindow
		  Win.mExceptionHash = Hash.Lowercase
		  Win.mExceptionDetails = Dict
		  Win.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reporter_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    Self.Pages.Value = Self.PageNoSolution
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, True)
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Dict.HasKey("solution") And Dict.Value("solution") <> Nil Then
		      Self.Pages.Value = Self.PageSolutionFound
		      Self.mSolutionURL = Dict.Value("solution")
		    Else
		      Self.Pages.Value = Self.PageNoSolution
		    End If
		  Catch Err As RuntimeException
		    Self.Pages.Value = Self.PageNoSolution
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowModal()
		  If Not Preferences.OnlineEnabled Then
		    Self.Pages.Value = Self.PagePermission
		  Else
		    Self.BeginChecking()
		  End If
		  
		  Self.ErrorIDLabel.Text = Self.ErrorIDLabel.Text.Replace("<hash>", Self.mExceptionHash)
		  
		  Super.ShowModal()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExceptionDetails As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExceptionHash As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSolutionURL As Text
	#tag EndProperty


	#tag Constant, Name = PageNoSolution, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePermission, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSolutionFound, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageStart, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events LogoCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.DrawPicture(LogoColor, 0, 0, G.Width, G.Height, 0, 0, LogoColor.Width, LogoColor.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QuitButton
	#tag Event
		Sub Action()
		  App.Terminate(0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub Change()
		  Self.QuitButton.Enabled = Me.Value <> Self.PageStart
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PermissionButton
	#tag Event
		Sub Action()
		  Self.BeginChecking()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PermissionPolicyLabel
	#tag Event
		Sub Open()
		  Me.URL = Beacon.WebURL("/privacy.php")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SolutionOpenButton
	#tag Event
		Sub Action()
		  If Self.mSolutionURL <> "" Then
		    ShowURL(Self.mSolutionURL)
		  Else
		    App.ShowBugReporter(Self.mExceptionHash)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReportButton
	#tag Event
		Sub Action()
		  App.ShowBugReporter(Self.mExceptionHash)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
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
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
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
#tag EndViewBehavior
