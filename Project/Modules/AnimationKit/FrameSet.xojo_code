#tag Class
Protected Class FrameSet
Implements Iterable
	#tag Method, Flags = &h0
		Sub Append(Frame As AnimationKit.Frame)
		  Self.VerifyFrame(Frame)
		  Self.Frames.AddRow(Frame)
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckCurrentFrames()
		  Var FirstFrame As AnimationKit.Frame
		  For I As Integer = 0 To Self.Frames.LastRowIndex
		    If Self.Frames(I) <> Nil Then
		      FirstFrame = Self.Frames(I)
		      Exit For I
		    End If
		  Next
		  
		  If FirstFrame = Nil Then
		    Self.Width = -1
		    Self.Height = -1
		  Else
		    Self.Width = FirstFrame.Dimensions.Width
		    Self.Height = FirstFrame.Dimensions.Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.Frames.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS)
		Shared Function CreateFromSpriteSheet(Sprites As iOSImage, RetinaSprites As iOSImage, CellWidth As Integer, CellHeight As Integer, Rows As Integer, Columns As Integer) As AnimationKit.FrameSet
		  Var StandardCells() As iOSImage = SplitSprites(Sprites, CellWidth, CellHeight, Rows, Columns)
		  Var RetinaCells() As iOSImage
		  If RetinaSprites <> Nil Then
		    RetinaCells = SplitSprites(RetinaSprites, CellWidth * 2, CellHeight * 2, Rows, Columns)
		  End If
		  
		  Var Set As New AnimationKit.FrameSet()
		  Set.ResizeTo(StandardCells.LastRowIndex)
		  For I As Integer = 0 To StandardCells.LastRowIndex
		    If RetinaSprites <> Nil Then
		      Set(I) = New AnimationKit.Frame(StandardCells(I), RetinaCells(I))
		    Else
		      Set(I) = New AnimationKit.Frame(StandardCells(I), Nil)
		    End If
		  Next
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI)
		Shared Function CreateFromSpriteSheet(Sprites As Picture, RetinaSprites As Picture, CellWidth As Integer, CellHeight As Integer, Rows As Integer, Columns As Integer) As AnimationKit.FrameSet
		  Var StandardCells() As Picture = SplitSprites(Sprites, CellWidth, CellHeight, Rows, Columns)
		  Var RetinaCells() As Picture
		  If RetinaSprites <> Nil Then
		    RetinaCells = SplitSprites(RetinaSprites, CellWidth * 2, CellHeight * 2, Rows, Columns)
		  End If
		  
		  Var Set As New AnimationKit.FrameSet()
		  Set.ResizeTo(StandardCells.LastRowIndex)
		  For I As Integer = 0 To StandardCells.LastRowIndex
		    If RetinaSprites <> Nil Then
		      Set(I) = New AnimationKit.Frame(StandardCells(I), RetinaCells(I))
		    Else
		      Set(I) = New AnimationKit.Frame(StandardCells(I), Nil)
		    End If
		  Next
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FirstFrame() As AnimationKit.Frame
		  If Self.Count > 0 Then
		    Return Self.Frames(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Frame(Index As Integer) As AnimationKit.Frame
		  Return Self.Frames(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Frame(Index As Integer, Assigns Value As AnimationKit.Frame)
		  Self.VerifyFrame(Value)
		  Self.Frames(Index) = Value
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Frame As AnimationKit.Frame) As Integer
		  For I As Integer = 0 To Self.Frames.LastRowIndex
		    If Self.Frames(I) = Frame Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Frame As AnimationKit.Frame)
		  Self.VerifyFrame(Frame)
		  Self.Frames.AddRowAt(Index, Frame)
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Return New AnimationKit.FrameSetIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastFrame() As AnimationKit.Frame
		  If Self.Count > 0 Then
		    Return Self.Frames(Self.Frames.LastRowIndex)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.Frames.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Self.Frames.ResizeTo(Bound)
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As AnimationKit.Frame
		  Return Self.Frame(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Frame As AnimationKit.Frame)
		  Self.Frame(Index) = Frame
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.Frames.RemoveRowAt(Index)
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.Frames.ResizeTo(Bound)
		  Self.CheckCurrentFrames()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reverse() As AnimationKit.FrameSet
		  Var Set As New AnimationKit.FrameSet
		  For I As Integer = Self.Frames.LastRowIndex DownTo 0
		    Set.Frames.AddRow(Self.Frames(I))
		  Next
		  Set.CheckCurrentFrames()
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS)
		Private Shared Function SplitSprites(Sprites As iOSImage, Width As Integer, Height As Integer, Rows As Integer, Columns As Integer) As iOSImage()
		  If Sprites.Width <> (Rows + 1) * Width Or Sprites.Height <> (Columns + 1) * Height Then
		    Var Err As New UnsupportedOperationException
		    Err.Reason = "Sprite sheet dimensions are not correct for the provided cell count."
		    Raise Err
		  End If
		  
		  Var Cells() As iOSImage
		  For Row As Integer = 0 To Rows - 1
		    For Column As Integer = 0 To Columns - 1
		      Var Sprite As New iOSBitmap(Width, Height, Sprites.Scale)
		      Sprite.Graphics.DrawImage(Sprites, (Row * Column) * -1, (Column * Height) * -1)
		      Cells.AddRow(Sprite.Image)
		    Next
		  Next
		  Return Cells
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetHasGUI)
		Private Shared Function SplitSprites(Sprites As Picture, Width As Integer, Height As Integer, Rows As Integer, Columns As Integer) As Picture()
		  If Sprites.Width <> (Rows + 1) * Width Or Sprites.Height <> (Columns + 1) * Height Then
		    Var Err As New UnsupportedOperationException
		    Err.Reason = "Sprite sheet dimensions are not correct for the provided cell count."
		    Raise Err
		  End If
		  
		  Var Cells() As Picture
		  For Row As Integer = 0 To Rows - 1
		    For Column As Integer = 0 To Columns - 1
		      Var Sprite As New Picture(Width, Height)
		      Sprite.Graphics.DrawPicture(Sprites, (Row * Column) * -1, (Column * Height) * -1)
		      Cells.AddRow(Sprite)
		    Next
		  Next
		  Return Cells
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub VerifyFrame(Frame As AnimationKit.Frame)
		  If Frame = Nil Or Self.Width = -1 Or Self.Height = -1 Then
		    Return
		  End If
		  
		  If Frame.Dimensions.Width <> Self.Width Or Frame.Dimensions.Height <> Self.Height Then
		    Var Err As New UnsupportedOperationException
		    Err.Reason = "Frame dimensions must match the set dimensions."
		    Raise Err
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Frames() As AnimationKit.Frame
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Height As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Width As Integer = -1
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
