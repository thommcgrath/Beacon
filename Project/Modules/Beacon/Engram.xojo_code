#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintPath() As Text
		  Return "Blueprint'" + Self.mPath + "'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  Return Self.mCanBeBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As Text
		  If Self.IsValid Then
		    Dim Components() As Text = Self.mPath.Split("/")
		    Dim Tail As Text = Components(UBound(Components))
		    Components = Tail.Split(".")
		    Return Components(UBound(Components)) + "_C"
		  Else
		    If Self.mPath.Length > 2 And Self.mPath.Right(2) = "_C" Then
		      Return Self.mPath
		    Else
		      Return Self.mPath + "_C"
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mCanBeBlueprint = True
		  Self.mAvailability = Beacon.Maps.All.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Engram)
		  Self.Constructor()
		  
		  Self.mAvailability = Source.mAvailability
		  Self.mCanBeBlueprint = Source.mCanBeBlueprint
		  Self.mPath = Source.mPath
		  Self.mLabel = Source.mLabel
		  Self.mIsValid = Source.mIsValid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateUnknownEngram(Path As Text) As Beacon.Engram
		  Dim Engram As New Beacon.Engram
		  If Path.Length > 6 And Path.Left(6) = "/Game/" Then
		    If Path.Right(2) = "_C" Then
		      // Appears to be a BlueprintGeneratedClass Path
		      Path = Path.Left(Path.Length - 2)
		    End If
		    Engram.mIsValid = True
		  End If
		  Engram.mPath = Path
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GeneratedClassBlueprintPath() As Text
		  Return "BlueprintGeneratedClass'" + Self.mPath + "_C'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mIsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  If Self.mLabel = "" Then
		    // Create a label from the class String
		    Dim ClassString As Text = Self.ClassString
		    Dim Parts() As Text = ClassString.Split("_")
		    If UBound(Parts) <= 1 Then
		      Return ClassString
		    End If
		    Parts.Remove(0)
		    Parts.Remove(UBound(Parts))
		    
		    Self.mLabel = Self.MakeHumanReadableText(Text.Join(Parts, " "))
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MakeHumanReadableText(Value As Text) As Text
		  Dim Chars() As Text
		  For Each Codepoint As Integer In Value.Codepoints
		    If Codepoint = 32 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      Chars.Append(Text.FromUnicodeCodepoint(Codepoint))
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      Chars.Append(" ")
		      Chars.Append(Text.FromUnicodeCodepoint(Codepoint))
		    ElseIf CodePoint = 95 Then
		      Chars.Append(" ")
		    End If
		  Next
		  Value = Text.Join(Chars, "")
		  
		  While Value.IndexOf("  ") > -1
		    Value = Value.ReplaceAll("  ", " ")
		  Wend
		  
		  Return Value.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As Text
		  If Not Self.IsValid Or Self.mPath.Length < 6 Or Self.mPath.Left(6) <> "/Game/" Then
		    Return ""
		  End If
		  
		  Dim Idx As Integer = Self.mPath.IndexOf(6, "/")
		  Dim Name As Text = Self.mPath.Mid(6, Idx - 6)
		  Select Case Name
		  Case "PrimalEarth"
		    Return "Ark Prime"
		  Case "ScorchedEarth"
		    Return "Scorched Earth"
		  Case "Mods"
		    Dim StartAt As Integer = Idx + 1
		    Dim EndAt As Integer = Self.mPath.IndexOf(StartAt, "/")
		    Return Self.MakeHumanReadableText(Self.mPath.Mid(StartAt, EndAt - StartAt))
		  Else
		    Return Self.MakeHumanReadableText(Name)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As Text
		  If Self.IsValid Then
		    Return Self.mPath
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Map.Matches(Self.mAvailability)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCanBeBlueprint As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As Text
	#tag EndProperty


	#tag ViewBehavior
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
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
