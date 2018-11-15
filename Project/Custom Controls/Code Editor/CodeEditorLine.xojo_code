#tag Class
Protected Class CodeEditorLine
	#tag Method, Flags = &h0
		Function Baseline() As Double
		  Return Self.mBaseline
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawInto(G As Graphics, OriginX As Double, OriginY As Double, Colors As CodeEditorColors)
		  Const EncryptedPadding = 3
		  
		  OriginX = OriginX + 10
		  
		  Dim Source As String = Self.mDisplayContent
		  Dim OffsetChars As Integer
		  For Each Range As CodeEditorRange In Self.mRanges
		    Dim Prefix As String = Source.Left(Range.StartPos - OffsetChars)
		    Dim ColoredPortion As String = Source.Mid((Range.StartPos - OffsetChars) + 1, Range.Length)
		    Dim Suffix As String = Source.Mid((Range.EndPos - OffsetChars) + 1)
		    
		    If Prefix <> "" Then
		      G.ForeColor = Colors.TextColor
		      G.DrawString(Prefix, OriginX, OriginY)
		      OriginX = OriginX + G.StringWidth(Prefix)
		    End If
		    
		    Select Case Range.Tag
		    Case "header"
		      G.ForeColor = Colors.HeaderColor
		    Case "keyword"
		      G.ForeColor = Colors.KeywordColor
		    Case "number"
		      G.ForeColor = Colors.NumberColor
		    Case "true"
		      G.ForeColor = Colors.TrueColor
		    Case "false"
		      G.ForeColor = Colors.FalseColor
		    Case "encrypted"
		      Dim LockIcon As Picture = BeaconUI.IconWithColor(IconLock, Colors.EncryptedTextColor)
		      Dim RectTop As Double = OriginY - G.TextAscent
		      Dim RectHeight As Double = G.TextHeight
		      Dim RectLeft As Double = OriginX
		      Dim RectWidth As Double = G.StringWidth(ColoredPortion) + (EncryptedPadding * 3) + LockIcon.Width
		      OriginX = OriginX + (EncryptedPadding * 2) + LockIcon.Width
		      G.ForeColor = Colors.EncryptedBackgroundColor
		      G.FillRoundRect(RectLeft, RectTop, RectWidth, RectHeight, 4, 4)
		      G.DrawPicture(LockIcon, Round(RectLeft + EncryptedPadding), RectTop + ((RectHeight - LockIcon.Height) / 2))
		      G.ForeColor = Colors.EncryptedTextColor
		    Else
		      G.ForeColor = Colors.TextColor
		    End Select
		    G.DrawString(ColoredPortion, OriginX, OriginY)
		    OriginX = OriginX + G.StringWidth(ColoredPortion)
		    Select Case Range.Tag
		    Case "encrypted"
		      OriginX = OriginX + EncryptedPadding
		    End Select
		    Source = Suffix
		    OffsetChars = OffsetChars + Prefix.Length + ColoredPortion.Length
		  Next
		  
		  If Source <> "" Then
		    G.ForeColor = Colors.TextColor
		    G.DrawString(Source, OriginX, OriginY)
		  End If
		  Self.mBaseline = OriginY
		  Self.mNeedsRedraw = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LineWidth() As Double
		  Return Self.mLineWidth + 20
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NeedsRedraw() As Boolean
		  Return Self.mNeedsRedraw
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.mContent = Source
		  Self.mDisplayContent = Source
		  Self.mNeedsRedraw = True
		  
		  If Source.BeginsWith("[") And Source.EndsWith("]") Then
		    // Header
		    Self.mRanges.Append(New CodeEditorRange(0, Source.Length, "header"))
		  Else
		    
		  End If
		  
		  Dim EqualsPos As Integer = Source.IndexOf("=")
		  If EqualsPos > -1 Then
		    Dim KeyLength As Integer = EqualsPos
		    Self.mRanges.Append(New CodeEditorRange(0, KeyLength, "keyword"))
		    Self.mRanges.Append(New CodeEditorRange(KeyLength, 1, "header"))
		    
		    Dim NumberMatch As New RegEx
		    NumberMatch.SearchPattern = "^[-+]?[0-9]*\.?[0-9]+$"
		    Dim ValuePos As Integer = KeyLength + 1
		    Dim Value As String = Source.Mid(ValuePos + 1)
		    If Value = "True" Then
		      Self.mRanges.Append(New CodeEditorRange(ValuePos, Value.Length, "true"))
		    ElseIf Value = "False" Then
		      Self.mRanges.Append(New CodeEditorRange(ValuePos, Value.Length, "false"))
		    ElseIf NumberMatch.Search(Value) <> Nil Then
		      Self.mRanges.Append(New CodeEditorRange(ValuePos, Value.Length, "number"))
		    ElseIf Value.BeginsWith(BeaconConfigs.CustomContent.EncryptedTag) And Value.EndsWith(BeaconConfigs.CustomContent.EncryptedTag) Then
		      Value = Value.Mid(BeaconConfigs.CustomContent.EncryptedTag.Length + 1, Value.Length - (BeaconConfigs.CustomContent.EncryptedTag.Length * 2))
		      Self.mDisplayContent = Source.Left(ValuePos) + Value
		      Self.mRanges.Append(New CodeEditorRange(ValuePos, Value.Length, "encrypted"))
		    End If
		  End If
		  
		  Dim Metrics As New Picture(1, 1)
		  Metrics.Graphics.TextFont = "Source Code Pro"
		  Self.mLineWidth = Metrics.Graphics.StringWidth(Self.mDisplayContent)
		  
		  Self.SortRanges()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortRanges()
		  Dim Starts() As Integer
		  Redim Starts(Self.mRanges.Ubound)
		  For I As Integer = 0 To Self.mRanges.Ubound
		    Starts(I) = Self.mRanges(I).StartPos
		  Next
		  Starts.SortWith(Self.mRanges)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseline As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplayContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLineWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNeedsRedraw As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRanges() As CodeEditorRange
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
