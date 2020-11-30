#tag Window
Begin BeaconSubview NewsPane Implements NotificationKit.Receiver
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
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   False
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   300
   Begin BeaconToolbar Header
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "News"
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   0
      ResizerEnabled  =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   300
   End
   Begin ControlCanvas DrawCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   260
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   True
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   300
   End
   Begin Timer RefreshTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   21600000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, LocalData.Notification_NewsUpdated)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, LocalData.Notification_NewsUpdated)
		  Self.RefreshNews()
		  LocalData.SharedInstance.UpdateNews()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_NewsUpdated
		    Self.RefreshNews()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintInto(G As Graphics, VerticalOffset As Integer, SafeArea As Rect)
		  Const CellPadding = 10
		  
		  G.FontName = "System"
		  G.FontUnit = FontUnits.Point
		  G.FontSize = 0
		  
		  Var CellWidth As Double = SafeArea.Width - (CellPadding * 2)
		  Var Pos As Double = VerticalOffset
		  Var ContentHeight As Integer
		  Self.mNewsRects.ResizeTo(Self.mNews.LastIndex)
		  For I As Integer = 0 To Self.mNews.LastIndex
		    Var DrawBottomBorder As Boolean = I < Self.mNews.LastIndex
		    
		    Var Message As String = Self.mNews(I).Title
		    Var MessageTop As Double = Pos + CellPadding
		    Var MessageHeight As Double = G.ActualStringHeight(Message, CellWidth)
		    Var MessageBaseline As Double = MessageTop + G.FontAscent
		    Var LastBottom As Double = MessageTop + MessageHeight
		    G.DrawingColor = SystemColors.LabelColor
		    G.DrawText(Message, CellPadding, MessageBaseline, CellWidth, False)
		    
		    Var CellHeight As Double = CellPadding + MessageHeight + CellPadding
		    
		    Var SecondaryMessage As String = Self.mNews(I).Detail
		    If SecondaryMessage.IsEmpty = False Then
		      Var SecondaryMessageTop As Double = LastBottom + (CellPadding / 2)
		      Var SecondaryMessageHeight As Double = G.ActualStringHeight(SecondaryMessage, CellWidth)
		      Var SecondaryMessageBaseline As Double = SecondaryMessageTop + G.FontAscent
		      LastBottom = SecondaryMessageTop + SecondaryMessageHeight
		      G.DrawingColor = SystemColors.SecondaryLabelColor
		      G.DrawText(SecondaryMessage, CellPadding, SecondaryMessageBaseline, CellWidth, False)
		      CellHeight = CellHeight + SecondaryMessageHeight + (CellPadding / 2)
		    End If
		    
		    Var URL As String = Self.mNews(I).URL
		    If URL.IsEmpty = False Then
		      Var MoreTop As Double = LastBottom + (CellPadding / 2)
		      Var MoreHeight As Double = G.ActualStringHeight("Read More…", CellWidth)
		      Var MoreBaseline As Double = MoreTop + G.FontAscent
		      LastBottom = MoreTop + MoreHeight
		      
		      G.DrawingColor = SystemColors.LinkColor
		      G.Underline = True
		      G.DrawText("Read More…", CellPadding, MoreBaseline, CellWidth, True)
		      G.Underline = False
		      
		      CellHeight = CellHeight + MoreHeight + (CellPadding / 2)
		    End If
		    
		    Var NotificationRect As New BeaconUI.Rect(0, Pos, G.Width, CellHeight)
		    Self.mNewsRects(I) = NotificationRect
		    
		    If Self.mPressed And Self.mDownIndex = I Then
		      G.DrawingColor = &c000000C0
		      G.FillRectangle(NotificationRect.Left, NotificationRect.Top, NotificationRect.Width, NotificationRect.Height)
		    End If
		    
		    ContentHeight = ContentHeight + NotificationRect.Height
		    Pos = Pos + NotificationRect.Height
		    
		    If DrawBottomBorder Then
		      G.DrawingColor = SystemColors.SeparatorColor
		      G.FillRectangle(0, Pos, G.Width, 1)
		      Pos = Pos + 1
		      ContentHeight = ContentHeight + 1
		    End If
		  Next
		  
		  Self.DrawCanvas.ContentHeight = ContentHeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshNews()
		  Self.mNews = LocalData.SharedInstance.GetNews
		  Self.mNewsRects.ResizeTo(Self.mNews.LastIndex)
		  Self.DrawCanvas.Invalidate
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownRect As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNews() As NewsItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewsRects() As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events DrawCanvas
	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  If Me.ScrollPosition > 0 Then
		    Self.PaintInto(G.Clip(0, 1, G.Width, G.Height - 1), (Me.ScrollPosition * -1) - 1, SafeArea)
		    
		    Var Ratio As Double = Min(Me.ScrollPosition / 60, 1.0)
		    
		    Var Brush As New ShadowBrush
		    Brush.Offset = New Point(0, 3 * Ratio)
		    Brush.BlurAmount = 6 * Ratio
		    
		    G.ShadowBrush = Brush
		    G.DrawingColor = SystemColors.SeparatorColor
		    G.FillRectangle(-10, 0 - Me.Top, G.Width + 20, Me.Top + 1) // Draw it larger so the shadow has more effect
		    G.ShadowBrush = Nil
		  Else
		    Self.PaintInto(G, 0, SafeArea)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  For I As Integer = 0 To Self.mNewsRects.LastIndex
		    Try
		      If Self.mNewsRects(I).Contains(X, Y) Then
		        If Self.mNews(I).URL.IsEmpty = False Then
		          Self.mDownRect = Self.mNewsRects(I)
		          Self.mPressed = True
		          Self.mDownIndex = I
		        Else
		          Self.mDownRect = Nil
		          Self.mPressed = False
		          Self.mDownIndex = -1
		        End If
		        Me.Invalidate
		        Return True
		      End If
		    Catch Err As RuntimeException
		      // Just move to the next one
		    End Try
		  Next
		  
		  Self.mDownRect = Nil
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
		  
		  If Self.mDownRect <> Nil And Self.mDownRect.Contains(X, Y) Then
		    If Self.mPressed = False Then
		      Self.mPressed = True
		      Me.Invalidate
		    End If
		  Else
		    If Self.mPressed = True Then
		      Self.mPressed = False
		      Me.Invalidate
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mDownIndex = -1 Then
		    Return
		  End If
		  
		  Try
		    If Self.mDownRect <> Nil And Self.mDownIndex <= Self.mNews.LastIndex And Self.mDownRect.Contains(X, Y) Then
		      Var URL As String = Self.mNews(Self.mDownIndex).URL
		      If Beacon.IsBeaconURL(URL) Then
		        Call App.HandleURL(URL, True)
		      ElseIf URL.BeginsWith("https://") Then
		        ShowURL(URL)
		      End If
		    End If
		  Catch Err As RuntimeException
		    // Something stupid happens here, see c98692bf11365681a86986ee3beca03b16b30da9
		  End Try
		  
		  Self.mPressed = False
		  Self.mDownRect = Nil
		  Self.mDownIndex = -1
		  Me.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  LocalData.SharedInstance.UpdateNews()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="500"
		Type="Integer"
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
		Name="TabIndex"
		Visible=true
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
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
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
#tag EndViewBehavior
