#tag Class
Protected Class TagPicker
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  For I As Integer = 0 To Self.mCells.LastIndex
		    If Self.mCells(I) <> Nil And Self.mCells(I).Contains(X, Y) Then
		      Self.mMouseDownCellIndex = I
		      Self.mMousePressedIndex = I
		      Self.Invalidate
		      Return True
		    End If
		  Next
		  
		  Self.mMouseDownCellIndex = -1
		  Self.mMousePressedIndex = -1
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownCellIndex > -1 Then
		    If Self.mCells(Self.mMouseDownCellIndex).Contains(X, Y) Then
		      If Self.mMousePressedIndex <> Self.mMouseDownCellIndex Then
		        Self.mMousePressedIndex = Self.mMouseDownCellIndex
		        Self.Invalidate
		      End If
		    Else
		      If Self.mMousePressedIndex = Self.mMouseDownCellIndex Then
		        Self.mMousePressedIndex = -1
		        Self.Invalidate
		      End If
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownCellIndex > -1 And Self.mCells(Self.mMouseDownCellIndex).Contains(X, Y) Then
		    Var Tag As String = Self.mTags(Self.mMouseDownCellIndex)
		    Var RequireIndex As Integer = Self.mRequireTags.IndexOf(Tag)
		    Var ExcludeIndex As Integer = Self.mExcludeTags.IndexOf(Tag)
		    
		    If RequireIndex > -1 Then
		      Self.mRequireTags.RemoveAt(RequireIndex)
		      Self.mExcludeTags.Add(Tag)
		    ElseIf ExcludeIndex > -1 Then
		      Self.mExcludeTags.RemoveAt(ExcludeIndex)
		    Else
		      Self.mRequireTags.Add(Tag)
		    End If
		    
		    RaiseEvent TagsChanged
		  End If
		  
		  Self.mMousePressedIndex = -1
		  Self.mMouseDownCellIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Double, PixelsY As Double, WheelData As BeaconUI.ScrollEvent) As Boolean
		  #Pragma Unused WheelData
		  #Pragma Unused PixelsX
		  #Pragma Unused MouseY
		  #Pragma Unused MouseX
		  
		  Var ScrollPosition As Integer = Min(Max(Self.mScrollPosition + PixelsY, 0), Self.mOverflowHeight)
		  If Self.mScrollPosition <> ScrollPosition Then
		    Self.mScrollPosition = ScrollPosition
		    Self.Invalidate
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open()
		  Self.AutoResize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  Var HeightDelta As Integer
		  Self.Paint(G, HeightDelta)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ArrayToString(Source() As String) As String
		  Var Clone() As String
		  For Each Value As String In Source
		    Clone.Add(Value)
		  Next
		  Clone.Sort
		  Return Clone.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoResize()
		  Var HeightDelta As Integer
		  Var Temp As New Picture(Self.Width, Self.Height)
		  Self.Paint(Temp.Graphics, HeightDelta)
		  If HeightDelta <> 0 Then
		    Self.ResizeBy(HeightDelta)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearSelections()
		  Var Arr() As String
		  Self.SetSelections(Arr, Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ColorsAreSimilar(Color1 As Color, Color2 As Color, Threshold As Double) As Boolean
		  Var Red As Double = (Color1.Red - Color2.Red)
		  Var Green As Double = (Color1.Green - Color2.Green)
		  Var Blue As Double = (Color1.Blue - Color2.Blue)
		  Return ((Red * Red) + (Green * Green) + (Blue * Blue)) <= Threshold * Threshold
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Border = Self.BorderTop Or Self.BorderLeft Or Self.BorderBottom Or Self.BorderRight
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ContentArea() As Xojo.Rect
		  Var X, Y, W, H As Integer
		  W = Self.Width
		  H = Self.Height
		  
		  Var Borders As Integer = Self.Border
		  If (Borders And Self.BorderTop) = Self.BorderTop Then
		    Y = Y + 1
		    H = H - 1
		  End If
		  If (Borders And Self.BorderBottom) = Self.BorderBottom Then
		    H = H - 1
		  End If
		  If (Borders And Self.BorderLeft) = Self.BorderLeft Then
		    X = X + 1
		    W = W - 1
		  End If
		  If (Borders And Self.BorderRight) = Self.BorderRight Then
		    W = W - 1
		  End If
		  
		  Return New Xojo.Rect(X, Y, W, H)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExcludedTags() As String()
		  Var Tags() As String
		  For Each Tag As String In Self.mExcludeTags
		    Tags.Add(Tag)
		  Next
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LocalizeCoordinates(ByRef X As Integer, ByRef Y As Integer)
		  If (Self.Border And Self.BorderTop) = Self.BorderTop Then
		    Y = Y + 1
		  End If
		  If (Self.Border And Self.BorderLeft) = Self.BorderLeft Then
		    X = X + 1
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Paint(G As Graphics, ByRef HeightDelta As Integer)
		  Var ContentArea As Xojo.Rect = Self.ContentArea
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.DrawRectangle(ContentArea.Left - 1, ContentArea.Top - 1, ContentArea.Width + 2, ContentArea.Height + 2)
		  G.DrawingColor = SystemColors.ControlBackgroundColor
		  G.FillRectangle(ContentArea.Left, ContentArea.Top, ContentArea.Width, ContentArea.Height)
		  
		  Const VerticalSpacing = 6
		  Const HorizontalSpacing = 6
		  Const VerticalPadding = 5
		  Const HorizontalPadding = 10
		  
		  Var XPos As Integer = HorizontalSpacing + ContentArea.Left
		  Var YPos As Integer = VerticalSpacing + ContentArea.Top
		  Var MaxCellWidth As Integer = ContentArea.Width - ((HorizontalSpacing * 2) + 10)
		  Var CapHeight As Integer = Ceiling(G.CapHeight)
		  Var CellHeight As Integer = CapHeight + (VerticalPadding * 2)
		  Var Clip As Graphics = G.Clip(ContentArea.Left, ContentArea.Top, ContentArea.Width, ContentArea.Height)
		  
		  Var CellTextColor As Color = &cFFFFFF
		  Var RequiredBackgroundColor As Color = BeaconUI.FindContrastingColor(CellTextColor, SystemColors.SystemBlueColor)
		  Var NeutralBackgroundColor As Color = BeaconUI.FindContrastingColor(CellTextColor, SystemColors.SystemGrayColor)
		  Var ExcludedBackgroundColor As Color = BeaconUI.FindContrastingColor(CellTextColor, SystemColors.SystemRedColor)
		  
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Var Tag As String = Self.mTags(I)
		    Var Required As Boolean = Self.mRequireTags.IndexOf(Tag) > -1
		    Var Excluded As Boolean = Self.mExcludeTags.IndexOf(Tag) > -1
		    Var Pressed As Boolean = Self.mMousePressedIndex = I
		    Tag = Tag.ReplaceAll("_", " ").Titlecase
		    
		    Var CaptionWidth As Integer = Ceiling(Clip.TextWidth(Tag))
		    Var CellWidth As Integer = Min(MaxCellWidth, CaptionWidth + (HorizontalPadding * 2))
		    If XPos + CellWidth > ContentArea.Right - HorizontalSpacing Then
		      XPos = ContentArea.Left + HorizontalSpacing
		      YPos = YPos + VerticalSpacing + CellHeight
		    End If
		    
		    Var CellRect As New Xojo.Rect(XPos, YPos - Self.mScrollPosition, CellWidth, CellHeight)
		    Self.mCells(I) = CellRect
		    
		    Var CaptionLeft As Integer = CellRect.Left + HorizontalPadding
		    Var CaptionBottom As Integer = CellRect.Top + VerticalPadding + CapHeight
		    
		    Var CellColor As Color
		    If Required Then
		      CellColor = RequiredBackgroundColor
		    ElseIf Excluded Then
		      CellColor = ExcludedBackgroundColor
		    Else
		      CellColor = NeutralBackgroundColor
		    End If
		    Clip.DrawingColor = CellColor
		    Clip.FillRoundRectangle(CellRect.Left - ContentArea.Left, CellRect.Top - ContentArea.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    Clip.DrawingColor = CellTextColor
		    Clip.DrawText(Tag, CaptionLeft - ContentArea.Left, CaptionBottom - ContentArea.Top, CellWidth - (HorizontalPadding * 2), True)
		    If Excluded Then
		      Clip.FillRectangle(CaptionLeft - ContentArea.Left, CellRect.VerticalCenter - ContentArea.Top, CellRect.Width - (HorizontalPadding * 2), 2)
		    End If
		    
		    If Pressed Then
		      Clip.DrawingColor = &c00000080
		      Clip.FillRoundRectangle(CellRect.Left - ContentArea.Left, CellRect.Top - ContentArea.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    End If
		    
		    XPos = XPos + HorizontalSpacing + CellRect.Width
		  Next
		  
		  Self.mContentHeight = YPos + CellHeight + VerticalSpacing
		  HeightDelta = Self.mContentHeight - ContentArea.Height
		  Self.mOverflowHeight = Max(HeightDelta, 0)
		  
		  If Self.mOverflowHeight > 0 Then
		    Var TrackHeight As Integer = ContentArea.Height - 10  
		    Var ThumbHeight As Integer = Round(TrackHeight * (ContentArea.Height / Self.mContentHeight))
		    Var ThumbTop As Integer = 5 + ((TrackHeight - ThumbHeight) * (Self.mScrollPosition / Self.mOverflowHeight))
		    
		    G.DrawingColor = SystemColors.LabelColor.AtOpacity(0.1)
		    G.FillRoundRectangle(ContentArea.Right - 10, ThumbTop, 5, ThumbHeight, 5, 5)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ParseSpec(Value As String, ByRef RequiredTags() As String, ByRef ExcludedTags() As String)
		  RequiredTags.ResizeTo(-1)
		  ExcludedTags.ResizeTo(-1)
		  
		  If Value.IsEmpty Then
		    Return
		  End If
		  
		  
		  Try
		    Var Spec As Dictionary = Beacon.ParseJSON(Value)
		    
		    Var Required() As Variant = Spec.Value("required")
		    For Each Tag As String In Required
		      RequiredTags.Add(Tag)
		    Next Tag
		    
		    Var Excluded() As Variant = Spec.Value("excluded")
		    For Each Tag As String In Excluded
		      ExcludedTags.Add(Tag)
		    Next Tag
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing tag spec")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredTags() As String()
		  Var Tags() As String
		  For Each Tag As String In Self.mRequireTags
		    Tags.Add(Tag)
		  Next
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResizeBy(Delta As Variant)
		  Try
		    Var OriginalHeight As Integer = Self.Height
		    RaiseEvent ShouldAdjustHeight(Delta)
		    If Self.Height <> OriginalHeight Then
		      Self.Invalidate()
		    End If
		  Catch Err As RuntimeException
		    
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetSelections(RequiredTags() As String, ExcludedTags() As String)
		  If RequiredTags = Nil Then
		    Var Temp() As String
		    RequiredTags = Temp
		  End If
		  If ExcludedTags = Nil Then
		    Var Temp() As String
		    ExcludedTags = Temp
		  End If
		  
		  For I As Integer = RequiredTags.LastIndex DownTo RequiredTags.FirstRowIndex
		    If RequiredTags(I) <> "object" And Self.mTags.IndexOf(RequiredTags(I)) = -1 Then
		      RequiredTags.RemoveAt(I)
		    End If
		  Next
		  For I As Integer = ExcludedTags.LastIndex DownTo ExcludedTags.FirstRowIndex
		    If Self.mTags.IndexOf(ExcludedTags(I)) = -1 Then
		      ExcludedTags.RemoveAt(I)
		    End If
		  Next
		  
		  Var RequireCurrentString As String = Self.ArrayToString(Self.mRequireTags)
		  Var RequireNewString As String = Self.ArrayToString(RequiredTags)
		  Var Changed As Boolean = RequireCurrentString <> RequireNewString
		  
		  If Not Changed Then
		    Var ExcludeCurrentString As String = Self.ArrayToString(Self.mExcludeTags)
		    Var ExcludeNewString As String = Self.ArrayToString(ExcludedTags)
		    Changed = ExcludeCurrentString <> ExcludeNewString
		  End If
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Self.mRequireTags = RequiredTags.Clone
		  Self.mExcludeTags = ExcludedTags.Clone
		  
		  If Thread.Current = Nil Then
		    RaiseEvent TagsChanged
		    Self.Invalidate
		  Else
		    Call CallLater.Schedule(0, AddressOf TriggerChange)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastIndex)
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Clone(I) = Self.mTags(I)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Values() As String)
		  If Values = Nil Then
		    Return
		  End If
		  
		  Var Changed As Boolean
		  If Self.mTags.LastIndex <> Values.LastIndex Then
		    Self.mTags.ResizeTo(Values.LastIndex)
		    Changed = True
		  End If
		  For I As Integer = 0 To Values.LastIndex
		    If Self.mTags(I).Compare(Values(I), ComparisonOptions.CaseSensitive) <> 0 Then
		      Self.mTags(I) = Values(I)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    Self.mCells.ResizeTo(-1)
		    Self.mCells.ResizeTo(Self.mTags.LastIndex)
		    
		    Var FireChangeEvent As Boolean
		    For I As Integer = Self.mRequireTags.LastIndex DownTo 0
		      If Self.mTags.IndexOf(Self.mRequireTags(I)) = -1 Then
		        Self.mRequireTags.RemoveAt(I)
		        FireChangeEvent = True
		      End
		      If Self.mTags.IndexOf(Self.mExcludeTags(I)) = -1 Then
		        Self.mExcludeTags.RemoveAt(I)
		        FireChangeEvent = True
		      End If
		    Next
		    
		    If FireChangeEvent Then
		      If Thread.Current = Nil Then
		        RaiseEvent TagsChanged
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerChange)
		      End If
		    End If
		    
		    Self.AutoResize()
		    Self.Invalidate()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerChange()
		  RaiseEvent TagsChanged
		  Self.Invalidate
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldAdjustHeight(Delta As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TagsChanged()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value And (Self.BorderTop Or Self.BorderLeft Or Self.BorderBottom Or Self.BorderRight)
			  If Value = Self.mBorder Then
			    Return
			  End If
			  
			  Self.mBorder = Value
			  Self.Invalidate
			End Set
		#tag EndSetter
		Border As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mBorder As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCells() As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExcludeTags() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownCellIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePressedIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverflowHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRepaintKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireTags() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTags() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var Dict As New Dictionary
			  Dict.Value("required") = Self.mRequireTags
			  Dict.Value("excluded") = Self.mExcludeTags
			  Return Beacon.GenerateJSON(Dict, False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var RequiredTags(), ExcludedTags() As String
			  Self.ParseSpec(Value, RequiredTags, ExcludedTags)
			  Self.SetSelections(RequiredTags, ExcludedTags)
			End Set
		#tag EndSetter
		Spec As String
	#tag EndComputedProperty


	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderLeft, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderRight, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollingEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
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
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
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
			Name="Visible"
			Visible=true
			Group="Appearance"
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
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Border"
			Visible=true
			Group="Behavior"
			InitialValue="15"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
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
			Name="Spec"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
