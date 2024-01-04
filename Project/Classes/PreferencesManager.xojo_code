#tag Class
Protected Class PreferencesManager
	#tag Method, Flags = &h0
		Sub BeginTransaction()
		  If Self.mTransactionLevel = 0 Then
		    Self.mSavedValues = New JSONItem(Self.mValues.ToString)
		    Self.mSavedValues.Compact = False
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

	#tag Method, Flags = &h0
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
		  If Contents.IsEmpty = False Then
		    Try
		      Self.mValues = New JSONItem(Contents)
		    Catch Err As RuntimeException
		      Self.mValues = New JSONItem
		    End Try
		    Self.mValues.Value("Existing User") = True
		  Else
		    Self.mValues = New JSONItem
		    Self.mValues.Value("Existing User") = False
		  End If
		  Self.mValues.Compact = False
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
		Function HasKey(Key As String) As Boolean
		  Return Self.mValues.HasKey(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(Key As String, Default As Integer = 0) As Integer
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type <> Variant.TypeInt32 And Value.Type <> Variant.TypeInt64) Then
		    Return Default
		  End If
		  
		  Return Value.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerValue(Key As String, Assigns Value As Integer)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Value
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JSONValue(Key As String, Default As JSONItem = Nil) As JSONItem
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Self.mValues.Value(Key)
		  If IsNull(Value) Or (Value.Type = Variant.TypeObject And Value.ObjectValue IsA JSONItem) = False Then
		    Return Default
		  End If
		  
		  Return New JSONItem(JSONItem(Value.ObjectValue).ToString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub JSONValue(Key As String, Assigns Value As JSONItem)
		  Self.BeginTransaction()
		  If (Value Is Nil) = False Then
		    Self.mValues.Child(Key) = New JSONItem(Value.ToString)
		  Else
		    Self.mValues.Child(Key) = Nil
		  End If
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PointValue(Key As String, Default As Point = Nil) As Point
		  Var JSON As JSONItem = Self.JSONValue(Key)
		  If JSON Is Nil Then
		    Return Default
		  End If
		  
		  Return New Point(JSON.Value("Left").DoubleValue, JSON.Value("Top").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PointValue(Key As String, Assigns Value As Point)
		  Var JSON As New JSONItem
		  JSON.Value("Left") = Value.X
		  JSON.Value("Top") = Value.Y
		  Self.JSONValue(Key) = JSON
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectValue(Key As String, Default As Rect = Nil) As Rect
		  Var JSON As JSONItem = Self.JSONValue(Key)
		  If JSON Is Nil Then
		    Return Default
		  End If
		  
		  Return New Rect(JSON.Value("Left").DoubleValue, JSON.Value("Top").DoubleValue, JSON.Value("Width").DoubleValue, JSON.Value("Height").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RectValue(Key As String, Assigns Value As Rect)
		  Var JSON As New JSONItem
		  JSON.Value("Left") = Value.Left
		  JSON.Value("Top") = Value.Top
		  JSON.Value("Width") = Value.Width
		  JSON.Value("Height") = Value.Height
		  Self.JSONValue(Key) = JSON
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
		  Var JSON As JSONItem = Self.JSONValue(Key)
		  If JSON Is Nil Then
		    Return Default
		  End If
		  
		  Return New Size(JSON.Value("Width").DoubleValue, JSON.Value("Height").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SizeValue(Key As String, Assigns Value As Size)
		  Var JSON As New JSONItem
		  JSON.Value("Width") = Value.Width
		  JSON.Value("Height") = Value.Height
		  Self.JSONValue(Key) = JSON
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

	#tag Method, Flags = &h1
		Protected Sub Write()
		  Try
		    Call Self.mFile.Write(Self.mValues.ToString())
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSavedValues As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactionLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mValues As JSONItem
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
