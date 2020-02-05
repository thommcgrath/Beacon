#tag Class
Protected Class LogFile
	#tag Method, Flags = &h0
		Shared Function Analyze(Contents As String) As Beacon.LogFile
		  Var Encoding As TextEncoding = Contents.Encoding
		  Contents = Contents.ReplaceLineEndings(EndOfLine)
		  Var Lines() As String = Contents.Split(EndOfLine)
		  
		  Var File As New Beacon.LogFile
		  
		  For Each Line As String In Lines
		    Var StartPos As Integer = Line.IndexOf("CommandLine: ")
		    If StartPos = -1 Then
		      Continue
		    End If
		    
		    Var EndPos As Integer
		    StartPos = StartPos + 13
		    If (Line.Middle(StartPos, 1) = "=") Then
		      StartPos = StartPos + 1
		      EndPos = Line.IndexOf(StartPos, """")
		    Else
		      EndPos = Line.Length
		    End If
		    
		    Var LineContent As String = Line.Middle(StartPos, EndPos - StartPos)
		    Var InQuotes As Boolean
		    Var Chars() As String = LineContent.Split("")
		    Var Buffer As New MemoryBlock(0)
		    Var Params() As String
		    For Each Char As String In Chars
		      If Char = """" Then
		        If InQuotes Then
		          Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		          Buffer = New MemoryBlock(0)
		          InQuotes = False
		        Else
		          InQuotes = True
		        End If
		        Continue
		      ElseIf Char = " " Then
		        If InQuotes = False Then
		          Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		          Buffer = New MemoryBlock(0)
		        End If
		      ElseIf Char = "-" And Buffer.Size = 0 Then
		        Continue
		      Else
		        Buffer.Append(Char)
		      End If
		    Next
		    If Buffer.Size > 0 Then
		      Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		      Buffer = New MemoryBlock(0)
		    End If
		    
		    Var StartupParams() As String = Params(0).Split("?")
		    Params.RemoveRowAt(0)
		    
		    File.mMaps = Beacon.Maps.MaskForIdentifier(StartupParams(0))
		    StartupParams.RemoveRowAt(0)
		    
		    StartupParams.RemoveRowAt(0) // The Listen statement
		    
		    Var Merged() As String
		    For Each Param As String In StartupParams
		      Merged.AddRow(Param)
		    Next
		    For Each Param As String In Params
		      Merged.AddRow(Param)
		    Next
		    Params.ResizeTo(-1)
		    StartupParams.ResizeTo(-1)
		    
		    Var Options As New Dictionary
		    For Each Param As String In Merged
		      If Param = "" Then
		        Continue
		      End If
		      
		      Var EqualsPos As Integer = Param.IndexOf("=")
		      If EqualsPos > -1 Then
		        Options.Value(Param.Left(EqualsPos)) = Param.Middle(EqualsPos + 1)
		      Else
		        Options.Value(Param) = True
		      End If
		    Next
		    File.mOptions = Options
		  Next
		  
		  Return File
		  
		  Exception Err As RuntimeException
		    Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOptions = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As UInt64
		  Return Self.mMaps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options() As Dictionary
		  Return Self.mOptions.Clone
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMaps As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			InitialValue="0"
			Type="Integer"
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
