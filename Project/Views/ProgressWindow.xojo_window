#tag DesktopWindow
Begin BeaconDialog ProgressWindow Implements Beacon.ProgressDisplayer
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   156
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   156
   MaximumWidth    =   500
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   156
   MinimumWidth    =   500
   Resizeable      =   False
   Title           =   "Progress"
   Type            =   8
   Visible         =   False
   Width           =   500
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
      Text            =   "Progress"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   460
   End
   Begin DesktopProgressBar Indicator
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   20
      Indeterminate   =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumValue    =   100
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Value           =   50.0
      Visible         =   True
      Width           =   460
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel DetailLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Detail"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   460
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   400
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Timer UpdateTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   10
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.UpdateUI
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CancelPressed() As Boolean
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mCancelPressed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  If Self.mShowLaterKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mShowLaterKey)
		    Self.mShowLaterKey = ""
		  End If
		  
		  If Thread.Current = Nil Then
		    Super.Close()
		  Else
		    Self.mShouldClose = True
		    If Self.UpdateTimer.RunMode = Timer.RunModes.Off Then
		      Self.UpdateTimer.RunMode = Timer.RunModes.Single
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String, Detail As String = "Initializing", Progress As NullableDouble = Nil)
		  Self.mMessage = Message
		  Self.mDetail = Detail
		  Self.mProgress = Progress
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Detail() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mDetail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Detail(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  If Self.mDetail.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) = 0 Then
		    Return
		  End If
		  
		  Self.mDetail = Value
		  
		  If Self.UpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.UpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  If Self.mMessage.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) = 0 Then
		    Return
		  End If
		  
		  Self.mMessage = Value
		  
		  If Self.UpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.UpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As NullableDouble
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Value As NullableDouble)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  If Self.mProgress = Value Then
		    Return
		  End If
		  
		  Self.mProgress = Value
		  
		  If Self.UpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.UpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(Parent As DesktopWindow = Nil)
		  If Self.mShowLaterKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mShowLaterKey)
		    Self.mShowLaterKey = ""
		  End If
		  
		  Super.Show(parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowDelayed(Parent As DesktopWindow = Nil)
		  If Self.mShowLaterKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mShowLaterKey)
		    Self.mShowLaterKey = ""
		  End If
		  
		  If Parent Is Nil Then
		    Self.mShowLaterKey = CallLater.Schedule(1500, WeakAddressOf ShowNow)
		  Else
		    Self.mShowLaterKey = CallLater.Schedule(1500, WeakAddressOf ShowNowWithin, Parent)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowNow()
		  Self.Show()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowNowWithin(Parent As Variant)
		  Self.Show(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If Self.MessageLabel.Text.Compare(Self.mMessage, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.MessageLabel.Text = Self.mMessage
		  End If
		  
		  If Self.Title.Compare(Self.mMessage, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.Title = Self.mMessage
		  End If
		  
		  If Self.DetailLabel.Text.Compare(Self.mDetail, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.DetailLabel.Text = Self.mDetail
		  End If
		  
		  Var ProgressValue, ProgressMaximum As Integer
		  If IsNull(Self.mProgress) Then
		    ProgressMaximum = 0
		    ProgressValue = 0
		  Else
		    ProgressMaximum = Self.Indicator.Width
		    ProgressValue = ProgressMaximum * Self.mProgress.DoubleValue
		  End If
		  
		  If Self.Indicator.MaximumValue <> ProgressMaximum Then
		    Self.Indicator.MaximumValue = ProgressMaximum
		  End If
		  If Self.Indicator.Value <> ProgressValue Then
		    Self.Indicator.Value = ProgressValue
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDetail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldClose As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowLaterKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartTime As Double
	#tag EndProperty


#tag EndWindowCode

#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelPressed = True
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateTimer
	#tag Event
		Sub Action()
		  If Self.mShouldClose Then
		    Self.Close
		    Return
		  End If
		  
		  Self.UpdateUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
			"9 - Modeless Dialog"
		#tag EndEnumValues
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
#tag EndViewBehavior
