#tag Class
Protected Class TagPicker
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  For I As Integer = 0 To Self.mCells.LastRowIndex
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
		    Dim Tag As String = Self.mTags(Self.mMouseDownCellIndex)
		    Dim RequireIndex As Integer = Self.mRequireTags.IndexOf(Tag)
		    Dim ExcludeIndex As Integer = Self.mExcludeTags.IndexOf(Tag)
		    
		    If RequireIndex > -1 Then
		      Self.mRequireTags.Remove(RequireIndex)
		      Self.mExcludeTags.Append(Tag)
		    ElseIf ExcludeIndex > -1 Then
		      Self.mExcludeTags.Remove(ExcludeIndex)
		    Else
		      Self.mRequireTags.Append(Tag)
		    End If
		    
		    RaiseEvent TagsChanged
		  End If
		  
		  Self.mMousePressedIndex = -1
		  Self.mMouseDownCellIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Integer, PixelsY As Integer, WheelData As BeaconUI.ScrollEvent) As Boolean
		  #Pragma Unused WheelData
		  #Pragma Unused PixelsX
		  #Pragma Unused MouseY
		  #Pragma Unused MouseX
		  
		  Dim ScrollPosition As Integer = Min(Max(Self.mScrollPosition + PixelsY, 0), Self.mOverflowHeight)
		  If Self.mScrollPosition <> ScrollPosition Then
		    Self.mScrollPosition = ScrollPosition
		    Self.Invalidate
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim ContentArea As REALbasic.Rect = Self.ContentArea
		  G.ForeColor = SystemColors.SeparatorColor
		  G.DrawRect(ContentArea.Left - 1, ContentArea.Top - 1, ContentArea.Width + 2, ContentArea.Height + 2)
		  G.ForeColor = SystemColors.ControlBackgroundColor
		  G.FillRect(ContentArea.Left, ContentArea.Top, ContentArea.Width, ContentArea.Height)
		  
		  Const VerticalSpacing = 6
		  Const HorizontalSpacing = 6
		  Const VerticalPadding = 5
		  Const HorizontalPadding = 10
		  
		  Dim XPos As Integer = HorizontalSpacing + ContentArea.Left
		  Dim YPos As Integer = VerticalSpacing + ContentArea.Top
		  Dim MaxCellWidth As Integer = ContentArea.Width - ((HorizontalSpacing * 2) + 10)
		  Dim CapHeight As Integer = Ceil(G.CapHeight)
		  Dim CellHeight As Integer = CapHeight + (VerticalPadding * 2)
		  Dim Clip As Graphics = G.Clip(ContentArea.Left, ContentArea.Top, ContentArea.Width, ContentArea.Height)
		  
		  Dim RequiredBackgroundColor As Color = SystemColors.SelectedContentBackgroundColor
		  Dim RequiredTextColor As Color = SystemColors.AlternateSelectedControlTextColor
		  Dim NeutralBackgroundColor As Color = SystemColors.UnemphasizedSelectedTextBackgroundColor
		  Dim NeutralTextColor As Color = SystemColors.UnemphasizedSelectedTextColor
		  Dim ExcludedBackgroundColor As Color = SystemColors.SystemRedColor
		  Dim ExcludedTextColor As Color = SystemColors.AlternateSelectedControlTextColor
		  
		  If Self.ColorsAreSimilar(RequiredBackgroundColor, ExcludedBackgroundColor, 100) Then
		    ExcludedBackgroundColor = SystemColors.SystemBrownColor
		  End If
		  
		  For I As Integer = 0 To Self.mTags.LastRowIndex
		    Dim Tag As String = Self.mTags(I)
		    Dim Required As Boolean = Self.mRequireTags.IndexOf(Tag) > -1
		    Dim Excluded As Boolean = Self.mExcludeTags.IndexOf(Tag) > -1
		    Dim Pressed As Boolean = Self.mMousePressedIndex = I
		    Tag = Tag.ReplaceAll("_", " ").Titlecase
		    
		    Dim CaptionWidth As Integer = Ceil(Clip.StringWidth(Tag))
		    Dim CellWidth As Integer = Min(MaxCellWidth, CaptionWidth + (HorizontalPadding * 2))
		    If XPos + CellWidth > ContentArea.Right - HorizontalSpacing Then
		      XPos = ContentArea.Left + HorizontalSpacing
		      YPos = YPos + VerticalSpacing + CellHeight
		    End If
		    
		    Dim CellRect As New REALbasic.Rect(XPos, YPos - Self.mScrollPosition, CellWidth, CellHeight)
		    Self.mCells(I) = CellRect
		    
		    Dim CaptionLeft As Integer = CellRect.Left + HorizontalPadding
		    Dim CaptionBottom As Integer = CellRect.Top + VerticalPadding + CapHeight
		    
		    Dim CellColor, CellTextColor As Color
		    If Required Then
		      CellColor = RequiredBackgroundColor
		      CellTextColor = RequiredTextColor
		    ElseIf Excluded Then
		      CellColor = ExcludedBackgroundColor
		      CellTextColor = ExcludedTextColor
		    Else
		      CellColor = NeutralBackgroundColor
		      CellTextColor = NeutralTextColor
		    End If
		    Clip.ForeColor = CellColor
		    Clip.FillRoundRect(CellRect.Left - ContentArea.Left, CellRect.Top - ContentArea.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    Clip.ForeColor = CellTextColor
		    Clip.DrawString(Tag, CaptionLeft - ContentArea.Left, CaptionBottom - ContentArea.Top, CellWidth - (HorizontalPadding * 2), True)
		    If Excluded Then
		      Clip.FillRect(CaptionLeft - ContentArea.Left, CellRect.VerticalCenter - ContentArea.Top, CellRect.Width - (HorizontalPadding * 2), 2)
		    End If
		    
		    If Pressed Then
		      Clip.ForeColor = &c00000080
		      Clip.FillRoundRect(CellRect.Left - ContentArea.Left, CellRect.Top - ContentArea.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    End If
		    
		    XPos = XPos + HorizontalSpacing + CellRect.Width
		  Next
		  
		  Self.mContentHeight = YPos + CellHeight + VerticalSpacing
		  Dim HeightDelta As Integer = Self.mContentHeight - ContentArea.Height
		  Self.mOverflowHeight = Max(HeightDelta, 0)
		  If HeightDelta <> 0 Then
		    If Self.mRepaintKey <> "" Then
		      CallLater.Cancel(Self.mRepaintKey)
		    End If
		    Self.mRepaintKey = CallLater.Schedule(1, AddressOf ResizeBy, HeightDelta)
		  End If
		  
		  If Self.mOverflowHeight > 0 Then
		    Dim TrackHeight As Integer = ContentArea.Height - 10  
		    Dim ThumbHeight As Integer = Round(TrackHeight * (ContentArea.Height / Self.mContentHeight))
		    Dim ThumbTop As Integer = 5 + ((TrackHeight - ThumbHeight) * (Self.mScrollPosition / Self.mOverflowHeight))
		    
		    G.ForeColor = SystemColors.LabelColor.AtOpacity(0.1)
		    G.FillRoundRect(ContentArea.Right - 10, ThumbTop, 5, ThumbHeight, 5, 5)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ArrayToString(Source() As String) As String
		  Dim Clone() As String
		  For Each Value As String In Source
		    Clone.Append(Value)
		  Next
		  Clone.Sort
		  Return Join(Clone, ",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearSelections()
		  Dim Arr() As String
		  Self.SetSelections(Arr, Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ColorsAreSimilar(Color1 As Color, Color2 As Color, Threshold As Double) As Boolean
		  Dim Red As Double = (Color1.Red - Color2.Red)
		  Dim Green As Double = (Color1.Green - Color2.Green)
		  Dim Blue As Double = (Color1.Blue - Color2.Blue)
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
		Private Function ContentArea() As REALbasic.Rect
		  Dim X, Y, W, H As Integer
		  W = Self.Width
		  H = Self.Height
		  
		  Dim Borders As Integer = Self.Border
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
		  
		  Return New REALbasic.Rect(X, Y, W, H)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExcludedTags() As String()
		  Dim Tags() As String
		  For Each Tag As String In Self.mExcludeTags
		    Tags.Append(Tag)
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

	#tag Method, Flags = &h0
		Function RequiredTags() As String()
		  Dim Tags() As String
		  For Each Tag As String In Self.mRequireTags
		    Tags.Append(Tag)
		  Next
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResizeBy(Delta As Variant)
		  Try
		    Dim OriginalHeight As Integer = Self.Height
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
		    Dim Temp() As String
		    RequiredTags = Temp
		  End If
		  If ExcludedTags = Nil Then
		    Dim Temp() As String
		    ExcludedTags = Temp
		  End If
		  
		  For I As Integer = RequiredTags.LastRowIndex DownTo RequiredTags.FirstRowIndex
		    If RequiredTags(I) <> "object" And Self.mTags.IndexOf(RequiredTags(I)) = -1 Then
		      RequiredTags.RemoveRowAt(I)
		    End If
		  Next
		  For I As Integer = ExcludedTags.LastRowIndex DownTo ExcludedTags.FirstRowIndex
		    If Self.mTags.IndexOf(ExcludedTags(I)) = -1 Then
		      ExcludedTags.RemoveRowAt(I)
		    End If
		  Next
		  
		  Dim RequireCurrentString As String = Self.ArrayToString(Self.mRequireTags)
		  Dim RequireNewString As String = Self.ArrayToString(RequiredTags)
		  Dim Changed As Boolean = RequireCurrentString <> RequireNewString
		  
		  If Not Changed Then
		    Dim ExcludeCurrentString As String = Self.ArrayToString(Self.mExcludeTags)
		    Dim ExcludeNewString As String = Self.ArrayToString(ExcludedTags)
		    Changed = ExcludeCurrentString <> ExcludeNewString
		  End If
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Self.mRequireTags = RequiredTags.Clone
		  Self.mExcludeTags = ExcludedTags.Clone
		  
		  If App.CurrentThread = Nil Then
		    RaiseEvent TagsChanged
		    Self.Invalidate
		  Else
		    Call CallLater.Schedule(0, AddressOf TriggerChange)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Dim Clone() As String
		  Redim Clone(Self.mTags.LastRowIndex)
		  For I As Integer = 0 To Self.mTags.LastRowIndex
		    Clone(I) = Self.mTags(I)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Values() As String)
		  If Values = Nil Then
		    Return
		  End If
		  
		  Dim Changed As Boolean
		  If Self.mTags.LastRowIndex <> Values.LastRowIndex Then
		    Redim Self.mTags(Values.LastRowIndex)
		    Changed = True
		  End If
		  For I As Integer = 0 To Values.LastRowIndex
		    If StrComp(Self.mTags(I), Values(I), 0) <> 0 Then
		      Self.mTags(I) = Values(I)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    Redim Self.mCells(-1)
		    Redim Self.mCells(Self.mTags.LastRowIndex)
		    
		    Dim FireChangeEvent As Boolean
		    For I As Integer = Self.mRequireTags.LastRowIndex DownTo 0
		      If Self.mTags.IndexOf(Self.mRequireTags(I)) = -1 Then
		        Self.mRequireTags.Remove(I)
		        FireChangeEvent = True
		      End
		      If Self.mTags.IndexOf(Self.mExcludeTags(I)) = -1 Then
		        Self.mExcludeTags.Remove(I)
		        FireChangeEvent = True
		      End If
		    Next
		    
		    If FireChangeEvent Then
		      If App.CurrentThread = Nil Then
		        RaiseEvent TagsChanged
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerChange)
		      End If
		    End If
		    
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
		Private mCells() As REALbasic.Rect
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
			  Dim Value As String
			  If Self.mRequireTags.LastRowIndex > -1 Then
			    Value = "(""" + Join(Self.mRequireTags, """ AND """) + """)"
			  End If
			  If Self.mExcludeTags.LastRowIndex > -1 Then
			    If Value = "" Then
			      Value = "object"
			    End If
			    Value = Value + " NOT (""" + Join(Self.mExcludeTags, """ OR """) + """)"
			  End If
			  Return Value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim RequirePhrase, ExcludePhrase, RequiredTags(), ExcludedTags() As String
			  
			  Try
			    Dim RequireStartPos As Integer = Value.IndexOf("(")
			    Dim RequireEndPos As Integer = Value.IndexOf(RequireStartPos, ")")
			    RequirePhrase = Value.Middle(RequireStartPos + 2, RequireEndPos - (RequireStartPos + 3))
			    
			    If RequireStartPos > -1 And RequireEndPos > -1 Then
			      Dim ExcludeStartPos As Integer = Value.IndexOf(RequireEndPos, "(")
			      If ExcludeStartPos > -1 Then
			        Dim ExcludeEndPos As Integer = Value.IndexOf(ExcludeStartPos, ")")
			        ExcludePhrase = Value.Middle(ExcludeStartPos + 2, ExcludeEndPos - (ExcludeStartPos + 3))
			      End If
			      
			      RequiredTags = RequirePhrase.Split(""" AND """)
			      ExcludedTags = ExcludePhrase.Split(""" OR """)
			    End If
			  Catch Err As RuntimeException
			    
			  End Try
			  
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
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
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
			EditorType="Picture"
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
			EditorType="Boolean"
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
