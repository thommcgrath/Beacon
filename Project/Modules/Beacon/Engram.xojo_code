#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintPath() As String
		  Return "Blueprint'" + Self.mPath + "'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "IsTagged(""blueprintable"")" )  Function CanBeBlueprint() As Boolean
		  Return Self.IsTagged("blueprintable")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  If Self.IsValid Then
		    Dim Components() As String = Split(Self.mPath, "/")
		    Dim Tail As String = Components(Components.Ubound)
		    Components = Split(Tail, ".")
		    Return Components(Components.Ubound) + "_C"
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
		  Self.mAvailability = Beacon.Maps.All.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Engram)
		  Self.Constructor()
		  
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mLabel = Source.mLabel
		  Self.mIsValid = Source.mIsValid
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  
		  Redim Self.mTags(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Append(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCSV(Engrams() As Beacon.Engram) As String
		  Dim Columns(3) As String
		  Columns(0) = """Path"""
		  Columns(1) = """Label"""
		  Columns(2) = """Availability Mask"""
		  Columns(3) = """Tags"""
		  
		  Dim Lines(0) As String
		  Lines(0) = Join(Columns, ",")
		  
		  For Each Engram As Beacon.Engram In Engrams
		    Columns(0) = """" + Engram.mPath + """"
		    Columns(1) = """" + Engram.mLabel + """"
		    Columns(2) = Str(Engram.mAvailability, "0")
		    Columns(3) = Engram.TagString
		    Lines.Append(Columns.Join(","))
		  Next
		  
		  Return Lines.Join(Text.FromUnicodeCodepoint(13) + Text.FromUnicodeCodepoint(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateUnknownEngram(Path As String) As Beacon.Engram
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
		Function GeneratedClassBlueprintPath() As String
		  Return "BlueprintGeneratedClass'" + Self.mPath + "_C'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  Tag = Self.NormalizeTag(Tag)
		  Return Self.mTags.IndexOf(Tag) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mIsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mLabel = "" Then
		    // Create a label from the class String
		    Dim ClassString As String = Self.ClassString
		    Dim Parts() As String = Split(ClassString, "_")
		    If Parts.Ubound <= 1 Then
		      Return ClassString
		    End If
		    Parts.Remove(0)
		    Parts.Remove(UBound(Parts))
		    
		    Self.mLabel = Self.MakeHumanReadableText(Join(Parts, " "))
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MakeHumanReadableText(Value As String) As String
		  Dim Chars() As String
		  Dim InChars() As String = Split(Value, "")
		  For Each InChar As String In InChars
		    Dim Codepoint As Integer = Asc(InChar)
		    If Codepoint = 32 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      Chars.Append(InChar)
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      Chars.Append(" ")
		      Chars.Append(InChar)
		    ElseIf CodePoint = 95 Then
		      Chars.Append(" ")
		    End If
		  Next
		  Value = Join(Chars, "")
		  
		  While Value.IndexOf("  ") > -1
		    Value = Value.ReplaceAll("  ", " ")
		  Wend
		  
		  Return Value.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  If Self.mModID <> LocalData.UserModID Then
		    Return Self.mModName
		  End If
		  
		  If Not Self.IsValid Or Self.mPath.Length < 6 Or Self.mPath.Left(6) <> "/Game/" Then
		    Return ""
		  End If
		  
		  Dim Idx As Integer = Self.mPath.IndexOf(6, "/")
		  If Idx = -1 Then
		    Return "Unknown"
		  End If
		  Dim Name As String = Self.mPath.SubString(6, Idx - 6)
		  Select Case Name
		  Case "PrimalEarth"
		    Return "Ark Prime"
		  Case "ScorchedEarth"
		    Return "Scorched Earth"
		  Case "Mods"
		    Dim StartAt As Integer = Idx + 1
		    Dim EndAt As Integer = Self.mPath.IndexOf(StartAt, "/")
		    If EndAt = -1 Then
		      EndAt = Self.mPath.Length
		    End If
		    Return Self.MakeHumanReadableText(Self.mPath.SubString(StartAt, EndAt - StartAt))
		  Else
		    Return Self.MakeHumanReadableText(Name)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function NormalizeTag(Tag As String) As String
		  Dim Sanitizer As New RegEx
		  Sanitizer.SearchPattern = "[^\w]"
		  Sanitizer.ReplacementPattern = ""
		  
		  Return Sanitizer.Replace(Tag.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Engram) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfPath As String = Self.Path
		  Dim OtherPath As String = Other.Path
		  Return StrComp(SelfPath, OtherPath, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  If Self.IsValid Then
		    Return Self.mPath
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Return Self.mTags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString() As String
		  Return Join(Self.mTags, ",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Map.Matches(Self.mAvailability)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  Return Mask = 0 Or (Self.mAvailability And Mask) > 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
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
