#tag Window
Begin LibrarySubview LibraryPaneNotifications Implements NotificationKit.Receiver
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
      Caption         =   "Notifications"
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
   Begin ControlCanvas DrawCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   260
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, LocalData.Notification_NewAppNotification)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, LocalData.Notification_NewAppNotification)
		  
		  Self.RefreshNotifications()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_NewAppNotification
		    Self.RefreshNotifications()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintInto(G As Graphics, VerticalOffset As Integer)
		  Const CellPadding = 10
		  Const CloseHitBox = 20
		  
		  Dim OldUnreadCount As Integer = Self.UnreadCount
		  
		  Dim CloseIcon As Picture
		  Dim CellWidth As Double = G.Width - (CellPadding * 2)
		  Dim Pos As Double = VerticalOffset
		  Dim ContentHeight As Integer
		  Redim Self.mNotificationRects(Self.mNotifications.Ubound)
		  Redim Self.mCloseRects(Self.mNotifications.Ubound)
		  For I As Integer = 0 To Self.mNotifications.Ubound
		    Dim DrawBottomBorder As Boolean = I < Self.mNotifications.Ubound
		    
		    Dim Message As String = Self.mNotifications(I).Message
		    Dim MessageHeight As Double = G.StringHeight(Message, CellWidth)
		    Dim MessageBaseline As Double = Pos + CellPadding + G.CapHeight
		    G.ForeColor = SystemColors.LabelColor
		    G.DrawString(Message, CellPadding, MessageBaseline, CellWidth, False)
		    
		    Dim CellHeight As Double = CellPadding + MessageHeight + CellPadding
		    
		    Dim SecondaryMessage As String = Self.mNotifications(I).SecondaryMessage
		    If SecondaryMessage <> "" Then
		      Dim SecondaryMessageHeight As Double = G.StringHeight(SecondaryMessage, CellWidth)
		      Dim SecondaryMessageBaseline As Double = Pos + CellPadding + MessageHeight + (CellPadding / 2) + G.CapHeight
		      G.ForeColor = SystemColors.SecondaryLabelColor
		      G.DrawString(SecondaryMessage, CellPadding, SecondaryMessageBaseline, CellWidth, False)
		      CellHeight = CellHeight + (CellPadding / 2) + SecondaryMessageHeight
		    End If
		    
		    Dim NotificationRect As New BeaconUI.Rect(0, Pos, G.Width, CellHeight)
		    Self.mNotificationRects(I) = NotificationRect
		    
		    If CloseIcon = Nil Then
		      CloseIcon = BeaconUI.IconWithColor(IconClose, SystemColors.TertiaryLabelColor)
		    End If
		    Self.mCloseRects(I) = New BeaconUI.Rect(NotificationRect.Right - CloseHitBox, NotificationRect.Top, CloseHitBox, CloseHitBox)
		    G.DrawPicture(CloseIcon, Self.mCloseRects(I).Left + ((Self.mCloseRects(I).Width - CloseIcon.Width) / 2), Self.mCloseRects(I).Top + ((Self.mCloseRects(I).Height - CloseIcon.Height) / 2))
		    If Self.mPressed And Self.mDownIndex = I Then
		      G.ForeColor = &c00000080
		      If Self.mPressedOnClose Then
		        G.FillRoundRect(Self.mCloseRects(I).Left, Self.mCloseRects(I).Top, Self.mCloseRects(I).Width, Self.mCloseRects(I).Height, 2, 2)
		      Else
		        G.FillRect(NotificationRect.Left, NotificationRect.Top, NotificationRect.Width, NotificationRect.Height)
		      End If
		    End If
		    
		    Pos = Pos + NotificationRect.Height
		    If Pos > 0 And Pos < G.Height And Self.mNotifications(I).Read = False Then
		      // The entire notification is visible and should be marked as read
		      Self.mNotifications(I).Read = True
		      LocalData.SharedInstance.SaveNotification(Self.mNotifications(I))
		    End If
		    If DrawBottomBorder Then
		      G.ForeColor = SystemColors.SeparatorColor
		      G.FillRect(0, Pos, G.Width, 1)
		      Pos = Pos + 1
		    Else
		      ContentHeight = Pos
		    End If
		  Next
		  
		  Self.mContentOverflow = Max(ContentHeight - G.Height, 0)
		  
		  Dim NewUnreadCount As Integer = Self.UnreadCount
		  
		  If OldUnreadCount <> NewUnreadCount Then
		    RaiseEvent UnreadCountChanged(NewUnreadCount)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshNotifications()
		  Dim OldUnreadCount As Integer = Self.UnreadCount
		  
		  Self.mNotifications = LocalData.SharedInstance.GetNotifications
		  Redim Self.mNotificationRects(Self.mNotifications.Ubound)
		  Redim Self.mCloseRects(Self.mNotifications.Ubound)
		  Self.DrawCanvas.Invalidate
		  
		  Dim NewUnreadCount As Integer = Self.UnreadCount
		  
		  If OldUnreadCount <> NewUnreadCount Then
		    RaiseEvent UnreadCountChanged(NewUnreadCount)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnreadCount() As Integer
		  Dim Count As Integer
		  For Each Notification As Beacon.UserNotification In Self.mNotifications
		    If Not Notification.Read Then
		      Count = Count + 1
		    End If
		  Next
		  Return Count
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event UnreadCountChanged(UnreadCount As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCloseRects() As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentOverflow As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownRect As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotificationRects() As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotifications() As Beacon.UserNotification
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedOnClose As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPosition As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events DrawCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  If Self.mScrollPosition > 0 Then
		    G.ForeColor = SystemColors.SeparatorColor
		    G.FillRect(0, 0, G.Width, 1)
		    Self.PaintInto(G.Clip(0, 1, G.Width, G.Height - 1), (Self.mScrollPosition * -1) - 1)
		  Else
		    Self.PaintInto(G, 0)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Integer, PixelsY As Integer, WheelData As BeaconUI.ScrollEvent) As Boolean
		  If PixelsY <> 0 Then
		    Self.mScrollPosition = Min(Max(Self.mScrollPosition + PixelsY, 0), Self.mContentOverflow)
		    Me.Invalidate
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  For I As Integer = 0 To Self.mNotificationRects.Ubound
		    If Self.mNotificationRects(I).Contains(X, Y) Then
		      If Self.mCloseRects(I).Contains(X, Y) Then
		        Self.mDownRect = Self.mCloseRects(I)
		        Self.mPressedOnClose = True
		        Self.mPressed = True
		        Self.mDownIndex = I
		      ElseIf Self.mNotifications(I).ActionURL <> "" Then
		        Self.mDownRect = Self.mNotificationRects(I)
		        Self.mPressedOnClose = False
		        Self.mPressed = True
		        Self.mDownIndex = I
		      Else
		        Self.mDownRect = Nil
		        Self.mPressedOnClose = False
		        Self.mPressed = False
		        Self.mDownIndex = -1
		      End If
		      Self.Invalidate
		      Return True
		    End If
		  Next
		  
		  Self.mDownRect = Nil
		  Self.mPressedOnClose = False
		  Self.mPressed = False
		  Self.mDownIndex = -1
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mDownIndex = -1 Then
		    Return
		  End If
		  
		  If Self.mDownRect.Contains(X, Y) Then
		    If Self.mPressed = False Then
		      Self.mPressed = True
		      Self.Invalidate
		    End If
		  Else
		    If Self.mPressed = True Then
		      Self.mPressed = False
		      Self.Invalidate
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mDownIndex = -1 Then
		    Return
		  End If
		  
		  If Self.mDownRect.Contains(X, Y) Then
		    Dim OldUnreadCount As Integer = Self.UnreadCount
		    If Not Self.mPressedOnClose Then
		      Dim URL As Text = Self.mNotifications(Self.mDownIndex).ActionURL
		      If Beacon.IsBeaconURL(URL) Then
		        Call App.HandleURL(URL, True)
		      ElseIf URL.BeginsWith("https://") Then
		        ShowURL(URL)
		      Else
		        Dim Notification As New Beacon.UserNotification("Well this is embarrassing, but that notification is broken.")
		        Notification.SecondaryMessage = "Beacon does not know what to do with the URL " + URL
		        LocalData.SharedInstance.SaveNotification(Notification)
		      End If
		    End If
		    
		    // Clicking a notification dismisses it
		    LocalData.SharedInstance.DeleteNotification(Self.mNotifications(Self.mDownIndex))
		    Self.mNotifications.Remove(Self.mDownIndex)
		    Self.mCloseRects.Remove(Self.mDownIndex)
		    Self.mNotificationRects.Remove(Self.mDownIndex)
		    
		    // Update counts. Painting should handle this, but just in case.
		    Dim NewUnreadCount As Integer = Self.UnreadCount
		    If OldUnreadCount <> NewUnreadCount Then
		      RaiseEvent UnreadCountChanged(NewUnreadCount)
		    End If
		  End If
		  Self.mPressed = False
		  Self.mDownRect = Nil
		  Self.mDownIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
