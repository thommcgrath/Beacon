#tag DesktopWindow
Begin DesktopWindow ExceptionWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   3
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "Beacon Error"
   Type            =   1
   Visible         =   True
   Width           =   600
   Begin ControlCanvas LogoCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   64
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Visible         =   True
      Width           =   64
   End
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   476
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   38
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   476
   End
   Begin UITweaks.ResizedPushButton QuitButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Quit"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin FadedSeparator TopBorder
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   102
      Transparent     =   True
      Visible         =   True
      Width           =   476
   End
   Begin FadedSeparator LeftBorder
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   236
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin FadedSeparator BottomBorder
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   104
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   339
      Transparent     =   True
      Visible         =   True
      Width           =   476
   End
   Begin FadedSeparator RightBorder
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   236
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   579
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
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
      Top             =   103
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   236
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   105
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   474
      Begin DesktopLabel CheckingLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin DesktopProgressBar CheckingIndicator
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   155
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   434
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopLabel PermissionLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   70
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton PermissionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Allow Connection"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   274
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   205
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   135
      End
      Begin LinkLabel PermissionPolicyLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   237
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   434
      End
      Begin DesktopLabel SolutionLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   38
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton SolutionOpenButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "View Online"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   287
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   173
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   110
      End
      Begin DesktopLabel NoSolutionLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   90
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin UITweaks.ResizedPushButton ReportButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add Comments"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   281
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   225
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   121
      End
      Begin DesktopLabel CommentsAnonLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "These comments are anonymous."
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   299
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
      Begin DesktopTextArea CommentsArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   132
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   125
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   155
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   434
      End
      Begin DesktopLabel CommentsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Please include anything that would help find the problem."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   434
      End
   End
   Begin DesktopLabel ErrorIDLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   361
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   475
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub BeginChecking()
		  Self.Pages.SelectedPanelIndex = Self.PageStart
		  
		  Var Body As New Dictionary
		  Body.Value("lookup") = "True"
		  Body.Value("trace") = Self.mExceptionFields.Value("trace")
		  Body.Value("type") = Self.mExceptionFields.Value("type")
		  Body.Value("hash") = Self.mExceptionFields.Value("hash")
		  
		  SimpleHTTP.Post(Beacon.WebURL("/reportaproblem"), Body, AddressOf Reporter_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildPostFields(Err As RuntimeException, Comments As String) As Dictionary
		  // https://tracker.xojo.com/xojoinc/xojo/-/issues/72314
		  #if TargetMacOS And TargetX86 And XojoVersion < 2023.020
		    Return Nil
		  #endif
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Var Stack() As StackFrame = Err.StackFrames
		  While Stack.LastIndex >= 0 And (Stack(0).Name = "RuntimeRaiseException" Or (Stack(0).Name.BeginsWith("Raise") And Stack(0).Name.EndsWith("Exception")))
		    Stack.RemoveAt(0)
		  Wend
		  
		  Var Location As String = "Unknown"
		  If Stack.LastIndex >= 0 Then
		    Location = Stack(0).Name
		  End If
		  Var Reason As String = Err.Message
		  If Reason.IsEmpty Then
		    Reason = Err.Message
		  End If
		  
		  App.Log("Unhandled " + Info.FullName + " in " + Location + ": " + Reason)
		  
		  If Location.BeginsWith("Delegate.IM_Invoke") Then
		    // Ignore this one
		    Return Nil
		  End If
		  
		  Var Lines() As String
		  For Each Frame As StackFrame In Stack
		    Lines.Add(Frame.Name)
		  Next
		  
		  Var Fields As New Dictionary
		  Fields.Value("build") = App.BuildNumber.ToString
		  Fields.Value("trace") = Lines.Join(EndOfLine.UNIX)
		  Fields.Value("hash") = EncodeHex(Crypto.SHA1(Fields.Value("trace").StringValue)).Lowercase
		  Fields.Value("type") = Info.FullName
		  Fields.Value("reason") = Reason
		  Fields.Value("location") = Location
		  Fields.Value("comments") = Comments.Trim.ReplaceLineEndings(EndOfLine.UNIX)
		  Fields.Value("time") = DateTime.Now.SQLDateTimeWithOffset
		  If App.IdentityManager <> Nil And App.IdentityManager.CurrentIdentity <> Nil Then
		    Fields.Value("user_id") = App.IdentityManager.CurrentIdentity.UserID
		  End If
		  
		  Return Fields
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(ExceptionFields As Dictionary)
		  Self.mExceptionFields = ExceptionFields
		  Self.mExceptionHash = Self.mExceptionFields.Value("hash")
		  
		  Var WriteFile As Boolean = True
		  Try
		    Var ErrorsFolder As FolderItem = App.ExceptionsFolder(False)
		    If (ErrorsFolder Is Nil) = False And ErrorsFolder.Exists Then
		      Var Filename As String = Self.mExceptionFields.Value("hash").StringValue + ".beaconerror"
		      Var ErrorFile As FolderItem = ErrorsFolder.Child(Filename)
		      Var Fields As Dictionary = Beacon.ParseJSON(ErrorFile.Read)
		      Var Comments As String = Fields.Value("comments").StringValue
		      Self.mPreviousComments = Comments.ReplaceLineEndings(EndOfLine)
		      WriteFile = False
		    End If
		  Catch ReadErr As RuntimeException
		  End Try
		  
		  If WriteFile Then
		    Call Self.SaveReport(Self.mExceptionFields)
		  End If
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Err As RuntimeException)
		  Var Fields As Dictionary = BuildPostFields(Err, "")
		  If Fields Is Nil Then
		    Return
		  End If
		  
		  Var Win As New ExceptionWindow(Fields)
		  Win.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Report(Err As RuntimeException, Comments As String = "")
		  Var Fields As Dictionary = BuildPostFields(Err, Comments)
		  Call SaveReport(Fields)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reporter_Callback(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    Self.Pages.SelectedPanelIndex = Self.PageNoSolution
		    Return
		  End If
		  
		  Try
		    Var Dict As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Dict.HasKey("solution") And Dict.Value("solution") <> Nil Then
		      Self.Pages.SelectedPanelIndex = Self.PageSolutionFound
		      Self.mSolutionURL = Dict.Value("solution")
		    Else
		      Self.Pages.SelectedPanelIndex = Self.PageNoSolution
		    End If
		  Catch Err As RuntimeException
		    Self.Pages.SelectedPanelIndex = Self.PageNoSolution
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SaveReport(Fields As Dictionary) As Boolean
		  Try
		    Var ErrorsFolder As FolderItem = App.ExceptionsFolder(True)
		    If ErrorsFolder Is Nil Or ErrorsFolder.Exists = False Then
		      Return False
		    End If
		    
		    Var Filename As String = Fields.Value("hash").StringValue + ".beaconerror"
		    Var ErrorFile As FolderItem = ErrorsFolder.Child(Filename)
		    Return ErrorFile.Write(Beacon.GenerateJSON(Fields, True))
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowModal()
		  If Not Preferences.OnlineEnabled Then
		    Self.Pages.SelectedPanelIndex = Self.PagePermission
		  Else
		    Self.BeginChecking()
		  End If
		  
		  Self.ErrorIDLabel.Text = Self.ErrorIDLabel.Text.Replace("<hash>", Self.mExceptionHash)
		  
		  Super.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub SubmitPendingReports()
		  If Preferences.OnlineEnabled = False Then
		    Return
		  End If
		  
		  Var SubmitThread As New Thread
		  SubmitThread.Priority = Thread.LowestPriority
		  AddHandler SubmitThread.Run, AddressOf SubmitPendingReports_Run
		  SubmitThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub SubmitPendingReports_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If SubmitLock Is Nil Then
		    SubmitLock = New CriticalSection
		  End If
		  
		  SubmitLock.Enter
		  
		  Var ErrorsFolder As FolderItem = App.ExceptionsFolder(False)
		  If ErrorsFolder Is Nil Or ErrorsFolder.Exists = False Then
		    // Nothing to do
		    SubmitLock.Leave
		    Return
		  End If
		  
		  Var Bound As Integer = ErrorsFolder.Count - 1
		  For Idx As Integer = Bound DownTo 0
		    Var File As FolderItem = ErrorsFolder.ChildAt(Idx)
		    If File.Name.EndsWith(".beaconerror") = False Then
		      Continue
		    End If
		    
		    Try
		      Var Fields As Dictionary = Beacon.ParseJSON(File.Read)
		      
		      Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		      Socket.SetFormData(Fields)
		      Socket.Send("POST", Beacon.WebURL("/reportaproblem"))
		      
		      If Socket.LastHTTPStatus = 200 Then
		        // The server accepted it
		        File.Remove
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  SubmitLock.Leave
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExceptionFields As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExceptionHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreviousComments As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSolutionURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared SubmitLock As CriticalSection
	#tag EndProperty


	#tag Constant, Name = PageComments, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSolution, Type = Double, Dynamic = False, Default = \"3", Scope = Private
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
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  G.DrawPicture(IconApp, 0, 0, G.Width, G.Height, 0, 0, IconApp.Width, IconApp.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QuitButton
	#tag Event
		Sub Pressed()
		  Var Comments As String = Self.CommentsArea.Text.Trim
		  If Comments.IsEmpty = False Then
		    Self.mExceptionFields.Value("comments") = Comments.ReplaceLineEndings(EndOfLine.UNIX)
		    Call Self.SaveReport(Self.mExceptionFields)
		  End If
		  
		  App.Terminate(0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Self.QuitButton.Enabled = Me.SelectedPanelIndex <> Self.PageStart
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PermissionButton
	#tag Event
		Sub Pressed()
		  Self.BeginChecking()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PermissionPolicyLabel
	#tag Event
		Sub Opening()
		  Me.URL = Beacon.WebURL("/help/about_user_privacy")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SolutionOpenButton
	#tag Event
		Sub Pressed()
		  If Self.mSolutionURL <> "" Then
		    System.GotoURL(Self.mSolutionURL)
		  Else
		    Var Path As String = "/reportaproblem?build=" + App.BuildNumber.ToString
		    If Self.mExceptionHash.IsEmpty = False Then
		      Path = Path + "&exception=" + Self.mExceptionHash
		    End If
		    System.GotoURL(Beacon.WebURL(Path))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReportButton
	#tag Event
		Sub Pressed()
		  Self.Pages.SelectedPanelIndex = Self.PageComments
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CommentsArea
	#tag Event
		Sub Opening()
		  Me.Text = Self.mPreviousComments
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
