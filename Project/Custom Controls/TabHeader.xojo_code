#tag Class
Protected Class TabHeader
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mPressedIndex = Self.CellAtXY(X, Y)
		  Self.mMouseDownIndex = Self.mPressedIndex
		  Self.Refresh()
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Dim Idx As Integer = Self.CellAtXY(X, Y)
		  If Idx <> Self.mMouseDownIndex Then
		    Idx = -1
		  End If
		  If Self.mPressedIndex <> Idx Then
		    Self.mPressedIndex = Idx
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Dim UpIndex As Integer = Self.CellAtXY(X, Y)
		  If UpIndex = Self.mMouseDownIndex And Self.mMouseDownIndex > -1 Then
		    Self.Value = UpIndex
		  End If
		  
		  Self.mPressedIndex = -1
		  Self.Invalidate()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.mShaded = True
		  Self.mInverted = False
		  
		  #if TargetCocoa
		    Dim TargetWindow As Window = Self.TrueWindow
		    
		    Declare Function NSSelectorFromString Lib "Foundation" (SelectorName As CFStringRef) As Ptr
		    Declare Function RespondsToSelector Lib "Foundation" Selector "respondsToSelector:" (Target As WindowPtr, SelectorRef As Ptr) As Boolean
		    
		    If RespondsToSelector(TargetWindow, NSSelectorFromString("setTitlebarAppearsTransparent:")) Then
		      Declare Sub SetTitlebarAppearsTransparent Lib "AppKit" Selector "setTitlebarAppearsTransparent:" (Target As WindowPtr, Value As Boolean)
		      SetTitlebarAppearsTransparent(TargetWindow, True)
		      Self.mShaded = False
		    End If
		  #endif
		  
		  Self.Inverted = False
		  
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  If Self.mShaded Then
		    G.ForeColor = &c000000F2
		    G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		  End If
		  
		  Dim BaseRGB As Integer = if(Self.mInverted, 255, 0)
		  
		  Dim Cells() As Picture
		  Dim CellsWidth As Integer
		  For I As Integer = 0 To UBound(Self.mChoices)
		    G.Bold = True
		    Dim CellWidth As Integer = Ceil(G.StringWidth(Self.mChoices(I))) + 10
		    Dim CellHeight As Integer = G.Height - 10
		    
		    Dim Mask As New Picture(CellWidth * G.ScaleX, CellHeight * G.ScaleY)
		    Mask.Graphics.ScaleX = G.ScaleX
		    Mask.Graphics.ScaleY = G.ScaleY
		    Mask.HorizontalResolution = 72 * G.ScaleX
		    Mask.VerticalResolution = 72 * G.ScaleY
		    Mask.Graphics.ForeColor = &cFFFFFF
		    Mask.Graphics.FillRect(-1, -1, Mask.Graphics.Width + 2, Mask.Graphics.Height + 2)
		    If Self.mPressedIndex = I Then
		      Mask.Graphics.ForeColor = rgb(0, 0, 0, 255 * 0.2)
		    Else
		      Mask.Graphics.ForeColor = rgb(0, 0, 0, 255 * 0.4)
		    End If
		    If Self.mSelectedIndex = I Or Self.mPressedIndex = I Then
		      Mask.Graphics.FillRoundRect(0, 0, Mask.Graphics.Width, Mask.Graphics.Height, 4, 4)
		      Mask.Graphics.ForeColor = rgb(255, 255, 255)
		    End If
		    Mask.Graphics.Bold = G.Bold
		    Mask.Graphics.DrawString(Self.mChoices(I), 5, Mask.Graphics.Height - 6, Mask.Graphics.Width - 10, True)
		    
		    Cells.Append(Mask)
		    CellsWidth = CellsWidth + CellWidth
		  Next
		  
		  Const CellSpacing = 5
		  
		  CellsWidth = CellsWidth + (CellSpacing * UBound(Cells))
		  Dim NextLeft As Integer = (G.Width - CellsWidth) / 2
		  Redim Self.mRegions(UBound(Cells))
		  For I As Integer = 0 To UBound(Cells)
		    Dim Cell As Picture = Cells(I)
		    
		    Dim Foreground As New Picture(Cell.Width, Cell.Height)
		    Foreground.Graphics.ScaleX = G.ScaleX
		    Foreground.Graphics.ScaleY = G.ScaleY
		    Foreground.HorizontalResolution = 72 * G.ScaleX
		    Foreground.VerticalResolution = 72 * G.ScaleY
		    Foreground.Graphics.ForeColor = rgb(BaseRGB, BaseRGB, BaseRGB)
		    Foreground.Graphics.FillRect(-1, -1, Foreground.Graphics.Width + 2, Foreground.Graphics.Height + 2)
		    Foreground.ApplyMask(Cell)
		    
		    Dim Shadow As New Picture(Cell.Width, Cell.Height)
		    Shadow.Graphics.ScaleX = G.ScaleX
		    Shadow.Graphics.ScaleY = G.ScaleY
		    Shadow.HorizontalResolution = 72 * G.ScaleX
		    Shadow.VerticalResolution = 72 * G.ScaleY
		    Shadow.Graphics.ForeColor = rgb(255 - BaseRGB, 255 - BaseRGB, 255 - BaseRGB)
		    Shadow.Graphics.FillRect(-1, -1, Shadow.Graphics.Width + 2, Shadow.Graphics.Height + 2)
		    Shadow.ApplyMask(Cell)
		    
		    G.DrawPicture(Shadow, NextLeft, 6)
		    G.DrawPicture(Foreground, NextLeft, 5)
		    
		    Self.mRegions(I) = New Xojo.Core.Rect(NextLeft, 5, Cell.Graphics.Width, Cell.Graphics.Height)
		    
		    NextLeft = NextLeft + Cell.Graphics.Width + CellSpacing
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Item As String)
		  Dim Idx As Integer = Self.mChoices.IndexOf(Item)
		  If Idx = -1 Then
		    Self.mChoices.Append(Item)
		    Self.Value = Self.Value // Causes a selection update only if necessary
		    Self.Invalidate()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CellAtXY(X As Integer, Y As Integer) As Integer
		  Dim Point As New Xojo.Core.Point(X, Y)
		  For I As Integer = 0 To UBound(Self.mRegions)
		    If Self.mRegions(I).Contains(Point) Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Choice(Index As Integer) As String
		  Return Self.mChoices(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Choice(Index As Integer, Assigns Value As String)
		  Self.mChoices(Index) = Value
		  Self.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mChoices) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As String)
		  Dim Idx As Integer = Self.mChoices.IndexOf(Item)
		  If Idx = -1 Then
		    Self.mChoices.Insert(Index, Item)
		    If Index <= Self.mSelectedIndex Then
		      Self.mSelectedIndex = Self.mSelectedIndex + 1
		    End If
		    Self.Invalidate()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Inverted() As Boolean
		  Return Self.mInverted
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Inverted(Assigns Value As Boolean)
		  #if TargetCocoa
		    Declare Function NSClassFromString Lib "Foundation" (ClassName As CFStringRef) As Ptr
		    Declare Sub SetAppearance Lib "AppKit" Selector "setAppearance:" (Target As WindowPtr, AppearanceRef As Ptr)
		    Declare Function GetAppearance Lib "AppKit" Selector "appearanceNamed:" (Target As Ptr, Name As CFStringRef) As Ptr
		    
		    Dim AppearanceRef As Ptr = GetAppearance(NSClassFromString("NSAppearance"), if(Value, "NSAppearanceNameVibrantDark", "NSAppearanceNameAqua"))
		    SetAppearance(Self.TrueWindow, AppearanceRef)
		    Self.mInverted = Value
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mChoices.Remove(Index)
		  If Self.mSelectedIndex >= Index Then
		    Self.mSelectedIndex = Self.mSelectedIndex - 1
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Item As String)
		  Dim Idx As Integer = Self.mChoices.IndexOf(Item)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mChoices() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInverted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRegions() As Xojo.Core.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShaded As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Min(Max(0, Value), UBound(Self.mChoices))
			  If Self.mSelectedIndex <> Value Then
			    Self.mSelectedIndex = Value
			    RaiseEvent Change
			    Self.Invalidate()
			  End If
			End Set
		#tag EndSetter
		Value As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
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
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
