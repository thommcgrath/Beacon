#tag Class
Protected Class PreferencesManager
	#tag Method, Flags = &h0
		Sub BeginTransaction()
		  If Self.mTransactionLevel = 0 Then
		    Self.mSavedValues = Self.mValues.Clone
		  End If
		  
		  Self.mTransactionLevel = Self.mTransactionLevel + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BinaryValue(Key As String, Default As MemoryBlock = Nil) As MemoryBlock
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeString Then
		    Return Default
		  End If
		  
		  Return DecodeHex(Value.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BinaryValue(Key As String, Assigns Value As MemoryBlock)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = EncodeHex(Value)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BooleanValue(Key As String, Default As Boolean = False) As Boolean
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeBoolean Then
		    Return Default
		  End If
		  
		  Return Value.BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BooleanValue(Key As String, Assigns Value As Boolean)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearAllValues()
		  Self.BeginTransaction()
		  Self.mValues.RemoveAll
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearValue(Key As String)
		  If Self.mValues.HasKey(Key) Then
		    Self.BeginTransaction()
		    Self.mValues.Remove(Key)
		    Self.Commit()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ColorValue(Key As String, Assigns Value As Color)
		  Var RedHex As String = Value.Red.ToHex(2)
		  Var GreenHex As String = Value.Green.ToHex(2)
		  Var BlueHex As String = Value.Blue.ToHex(2)
		  Var AlphaHex As String = Value.Alpha.ToHex(2)
		  
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = RedHex + GreenHex + BlueHex + AlphaHex
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColorValue(Key As String, Default As Color) As Color
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeString Then
		    Return Default
		  End If
		  
		  Var StringValue As String = Value.StringValue
		  If StringValue.Length < 8 Then
		    Return Default
		  End If
		  
		  Var RedHex As String = StringValue.Middle(0, 2)
		  Var GreenHex As String = StringValue.Middle(2, 2)
		  Var BlueHex As String = StringValue.Middle(4, 2)
		  Var AlphaHex As String = StringValue.Middle(6, 2)
		  
		  Return Color.RGB(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Commit()
		  Self.mTransactionLevel = Self.mTransactionLevel - 1
		  
		  If Self.mTransactionLevel = 0 Then
		    Self.mSavedValues = Nil
		    Self.Write()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Constructor(File As FolderItem)
		  Self.mFile = File
		  
		  If Self.mFile.Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(Self.mFile)
		    Var Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Self.Constructor(Contents)
		  Else
		    Self.Constructor("")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Contents As String)
		  If Contents <> "" Then
		    Try
		      Self.mValues = Beacon.ParseJSON(Contents)
		    Catch Err As RuntimeException
		      Self.mValues = New Dictionary
		    End Try
		    Self.mValues.Value("Existing User") = True
		  Else
		    Self.mValues = New Dictionary
		    Self.mValues.Value("Existing User") = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue(Key As String, Default As Dictionary = Nil) As Dictionary
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary) = False Then
		    Return Default
		  End If
		  
		  Return Dictionary(Value.ObjectValue).Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DictionaryValue(Key As String, Assigns Value As Dictionary)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value.Clone
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Key As String, Default As Double = 0) As Double
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeDouble Then
		    Return Default
		  End If
		  
		  Return Value.DoubleValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoubleValue(Key As String, Assigns Value As Double)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(Key As String, Default As Int32 = 0) As Int32
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeInt32 Then
		    Return Default
		  End If
		  
		  Return Value.Int32Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerValue(Key As String, Assigns Value As Int32)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PointValue(Key As String, Default As Point = Nil) As Point
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary) = False Then
		    Return Default
		  End If
		  
		  Var Dict As Dictionary = Value
		  Return New Point(Dict.Value("Left"), Dict.Value("Top"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PointValue(Key As String, Assigns Value As Point)
		  Var Dict As New Dictionary
		  Dict.Value("Left") = Value.X
		  Dict.Value("Top") = Value.Y
		  
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Dict
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectValue(Key As String, Default As Rect = Nil) As Rect
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary) = False Then
		    Return Default
		  End If
		  
		  Var Dict As Dictionary = Value
		  Return New Rect(Dict.Value("Left"), Dict.Value("Top"), Dict.Value("Width"), Dict.Value("Height"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RectValue(Key As String, Assigns Value As Rect)
		  Var Dict As New Dictionary
		  Dict.Value("Left") = Value.Left
		  Dict.Value("Top") = Value.Top
		  Dict.Value("Width") = Value.Width
		  Dict.Value("Height") = Value.Height
		  
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Dict
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rollback()
		  Self.mTransactionLevel = Self.mTransactionLevel - 1
		  
		  If Self.mTransactionLevel = 0 Then
		    Self.mValues = Self.mSavedValues
		    Self.mSavedValues = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SizeValue(Key As String, Default As Size = Nil) As Size
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary) = False Then
		    Return Default
		  End If
		  
		  Var Dict As Dictionary = Value
		  Return New Size(Dict.Value("Width"), Dict.Value("Height"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SizeValue(Key As String, Assigns Value As Size)
		  Var Dict As New Dictionary
		  Dict.Value("Width") = Value.Width
		  Dict.Value("Height") = Value.Height
		  
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Dict
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Key As String, Default As String = "") As String
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or Value.Type <> Variant.TypeString Then
		    Return Default
		  End If
		  
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Key As String, Assigns Value As String)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VariantValue(Key As String, Default As Variant = Nil) As Variant
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Return Self.mValues.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VariantValue(Key As String, Assigns Value As Variant)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Write()
		  Try
		    Call Self.mFile.Write(Beacon.GenerateJSON(Self.mValues, True))
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSavedValues As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactionLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mValues As Dictionary
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
