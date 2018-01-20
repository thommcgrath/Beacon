#tag Class
Private Class ConfigParser
	#tag Method, Flags = &h0
		Function AddCharacter(Char As Text) As Boolean
		  If Self.SubParser <> Nil Then
		    If Self.SubParser.AddCharacter(Char) Then
		      // This parser is done
		      Select Case Self.Type
		      Case Self.TypeIntrinsic
		        Self.mValue = Text.Join(Self.Buffer, "").Trim
		        Self.SubParser = Nil
		        Return True
		      Case Self.TypePair
		        Self.mValue = New Beacon.Pair(Self.Key, Self.SubParser.Value)
		        Self.SubParser = Nil
		        Return True
		      Case Self.TypeArray
		        Dim Values() As Auto = Self.mValue
		        Values.Append(Self.SubParser.Value)
		        Self.mValue = Values
		        If Char = "," Then
		          Self.SubParser = New Beacon.ConfigParser
		          Return False
		        Else
		          Self.SubParser = Nil
		          Return True
		        End If
		      End Select
		    End If
		    Return False
		  End If
		  
		  If InQuotes Then
		    If Char = """" Then
		      InQuotes = False
		    Else
		      Self.Buffer.Append(Char)
		    End If
		    Return False
		  End If
		  
		  If Char = "(" Then
		    Self.SubParser = New Beacon.ConfigParser
		    Self.Type = Self.TypeArray
		    
		    Dim Values() As Auto
		    Self.mValue = Values
		    Return False
		  End If
		  
		  If Self.Type = Self.TypeIntrinsic And Char = "=" Then
		    Self.Key = Text.Join(Self.Buffer, "").Trim
		    Redim Self.Buffer(-1)
		    Self.Type = Self.TypePair
		    Self.SubParser = New Beacon.ConfigParser
		    Return False
		  End If
		  
		  Select Case Char
		  Case """"
		    InQuotes = True
		  Case ")", ",", Text.FromUnicodeCodepoint(13)
		    Select Case Self.Type
		    Case Self.TypeIntrinsic
		      Self.mValue = Text.Join(Self.Buffer, "").Trim
		    Case Self.TypePair
		      Self.mValue = New Beacon.Pair(Self.Key, Text.Join(Self.Buffer, "").Trim)
		    Case Self.TypeArray
		      Dim Values() As Auto = Self.mValue
		      Values.Append(Text.Join(Self.Buffer, "").Trim)
		      Self.mValue = Values
		    End Select
		    Redim Self.Buffer(-1)
		    Return True
		  Else
		    Self.Buffer.Append(Char)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Type = Self.TypeIntrinsic
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Auto
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Buffer() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private InQuotes As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Key As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Auto
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SubParser As Beacon.ConfigParser
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Type As Integer
	#tag EndProperty


	#tag Constant, Name = TypeArray, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypeIntrinsic, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypePair, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


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
