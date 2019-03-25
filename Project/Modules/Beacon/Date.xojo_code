#tag Class
Protected Class Date
Inherits Global.Date
	#tag Method, Flags = &h0
		Sub Constructor(SecondsFrom1970 As Double)
		  Super.Constructor
		  Self.SecondsFrom1970 = SecondsFrom1970
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SQLDateTimeWithOffset As String)
		  Self.Constructor()
		  Self.SQLDateTimeWithOffset = SQLDateTimeWithOffset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Xojo.Core.Date)
		  Self.Constructor(Source.SecondsFrom1970)
		  Self.GMTOffset = Source.TimeZone.SecondsFromGMT / 3600
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Date) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.SecondsFrom1970 = Other.SecondsFrom1970 Then
		    Return 0
		  ElseIf Self.SecondsFrom1970 > Other.SecondsFrom1970 Then
		    Return 1
		  Else
		    Return -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Other As Global.Date)
		  Self.Constructor(Other)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.TotalSeconds - 2082844800) - (Self.GMTOffset * 3600)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.TotalSeconds = Value + 2082844800 + (Self.GMTOffset * 3600)
			End Set
		#tag EndSetter
		SecondsFrom1970 As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Offset As Double = Abs(Self.GMTOffset)
			  Dim Hours As Integer = Floor(Offset)
			  Dim Minutes As Integer = (Offset - Floor(Offset)) * 60
			  
			  Return Str(Self.Year, "0000") + "-" + Str(Self.Month, "00") + "-" + Str(Self.Day, "00") + " " + Str(Self.Hour, "00") + ":" + Str(Self.Minute, "00") + ":" + Str(Self.Second, "00") + If(Self.GMTOffset < 0, "-", "+") + Str(Hours, "00") + ":" + Str(Minutes, "00")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Validator As New Regex
			  Validator.SearchPattern = "^(\d{4})-(\d{2})-(\d{2})( (\d{2}):(\d{2}):(\d{2})(\.\d+)?((\+|-)(\d{1,2})(:(\d{2}))?)?)?$"
			  
			  Dim Matches As RegexMatch = Validator.Search(Value)
			  If Matches = Nil Then
			    Dim Err As New UnsupportedFormatException
			    Err.Message = "Invalid SQL timestamp"
			    Raise Err
			    Return
			  End If
			  
			  Dim Year As Integer = Val(Matches.SubExpressionString(1))
			  Dim Month As Integer = Val(Matches.SubExpressionString(2))
			  Dim Day As Integer = Val(Matches.SubExpressionString(3))
			  Dim Hour As Integer
			  Dim Minute As Integer
			  Dim Second As Integer
			  Dim Offset As Double
			  
			  If Matches.SubExpressionString(4) <> "" Then
			    Hour = Val(Matches.SubExpressionString(5))
			    Minute = Val(Matches.SubExpressionString(6))
			    Second = Val(Matches.SubExpressionString(7))
			    
			    If Matches.SubExpressionString(9) <> "" Then
			      Dim OffsetHour As Integer = Val(Matches.SubExpressionString(11))
			      Dim OffsetMinute As Integer
			      If Matches.SubExpressionString(13) <> "" Then
			        OffsetMinute = Val(Matches.SubExpressionString(13))
			      End If
			      Offset = OffsetHour + (OffsetMinute / 60)
			      If Matches.SubExpressionString(10) = "-" Then
			        Offset = Offset * -1
			      End If
			    End If
			  End If
			  
			  Self.Constructor(Year, Month, Day, Hour, Minute, Second, Offset)
			End Set
		#tag EndSetter
		SQLDateTimeWithOffset As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbbreviatedDate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Day"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DayOfWeek"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DayOfYear"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GMTOffset"
			Group="Behavior"
			InitialValue="0"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hour"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LongDate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LongTime"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minute"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Month"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Second"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortDate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortTime"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SQLDate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SQLDateTime"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TotalSeconds"
			Group="Behavior"
			InitialValue="0"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WeekOfYear"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Year"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondsFrom1970"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SQLDateTimeWithOffset"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
