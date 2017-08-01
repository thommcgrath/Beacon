#tag IOSView
Begin iosView AvailableLootSourcesView
   BackButtonTitle =   ""
   Compatibility   =   ""
   Left            =   0
   NavigationBarVisible=   True
   TabIcon         =   ""
   TabTitle        =   ""
   Title           =   "Add Loot Source"
   Top             =   0
   Begin iOSLabel Label1
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Label1, 9, <Parent>, 9, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Label1, 7, , 0, False, +1.00, 1, 1, 100, 
      AutoLayout      =   Label1, 10, <Parent>, 10, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Label1, 8, , 0, False, +1.00, 1, 1, 30, 
      Enabled         =   True
      Height          =   30.0
      Left            =   110
      LineBreakMode   =   "0"
      LockedInPosition=   False
      Scope           =   2
      Text            =   "List"
      TextAlignment   =   "1"
      TextColor       =   &c007AFF00
      TextFont        =   ""
      TextSize        =   0
      Top             =   225
      Visible         =   True
      Width           =   100.0
   End
   Begin iOSButton Button1
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button1, 1, Label1, 1, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Button1, 2, Label1, 2, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Button1, 3, Label1, 4, False, +1.00, 1, 1, *kStdControlGapV, 
      AutoLayout      =   Button1, 8, , 0, False, +1.00, 1, 1, 30, 
      Caption         =   "Close"
      Enabled         =   True
      Height          =   30.0
      Left            =   110
      LockedInPosition=   False
      Scope           =   0
      TextColor       =   &c007AFF00
      TextFont        =   ""
      TextSize        =   0
      Top             =   263
      Visible         =   True
      Width           =   100.0
   End
End
#tag EndIOSView

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.LeftNavigationToolbar.Add(iOSToolButton.NewSystemItem(iOSToolButton.Types.SystemCancel))
		  Self.RightNavigationToolbar.Add(iOSToolButton.NewSystemItem(iOSToolButton.Types.SystemAdd))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ToolbarPressed(button As iOSToolButton)
		  Select Case Button.Type
		  Case iOSToolButton.Types.SystemAdd
		    
		  Case iOSToolButton.Types.SystemCancel
		    Self.Dismiss
		  End Select
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Action()
		  Self.Dismiss
		End Sub
	#tag EndEvent
#tag EndEvents
