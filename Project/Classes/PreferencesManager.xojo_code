#tag Class
Protected Class PreferencesManager
	#tag Method, Flags = &h0
		Sub BeginTransaction()
		  If Self.mTransactionLevel = 0 Then
		    Self.mSavedValues = Self.CloneDictionary(Self.mValues)
		  End If
		  
		  Self.mTransactionLevel = Self.mTransactionLevel + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BinaryValue(Key As String, Default As MemoryBlock = Nil) As MemoryBlock
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  Dim Encoded As String
		  If Value.Type = Variant.TypeString Then
		    Encoded = Value.StringValue
		  ElseIf Value.Type = Variant.TypeText Then
		    Encoded = Value.TextValue
		  End If
		  
		  If Encoded <> "" Then
		    Return DecodeHex(Encoded)
		  Else
		    Return New MemoryBlock(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BinaryValue(Key As String, Assigns Value As MemoryBlock)
		  If Value <> Nil Then
		    Self.StringValue(Key) = EncodeHex(Value)
		  Else
		    Self.StringValue(Key) = ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BooleanValue(Key As String, Default As Boolean = False) As Boolean
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  Try
		    Return Value.BooleanValue
		  Catch Err As TypeMismatchException
		    Return Default
		  End Try
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

	#tag Method, Flags = &h21
		Private Shared Function CloneDictionary(Source As Dictionary) As Dictionary
		  If Source = Nil Then
		    Return Nil
		  End If
		  
		  Dim Clone As New Dictionary
		  
		  For Each Entry As DictionaryMember In Source.Members
		    Dim Key As Variant = Entry.Key
		    Dim Value As Variant = Entry.Value
		    If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		      Value = CloneDictionary(Dictionary(Value.ObjectValue))
		    End If
		    Clone.Value(Key) = Value
		  Next
		  
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ColorValue(Key As String, Assigns Value As Color)
		  Self.StringValue(Key) = Value.ToString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColorValue(Key As String, Default As Color) As Color
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim StringValue As String = Self.StringValue(Key, Default.ToString)
		  Return StringValue.ToColor
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
		    Self.Constructor(Self.mFile.Read(Encodings.UTF8))
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
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    Return Self.CloneDictionary(Dictionary(Value.ObjectValue))
		  End If
		  
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DictionaryValue(Key As String, Assigns Value As Dictionary)
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Self.CloneDictionary(Value)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Key As String, Default As Double = 0) As Double
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  Try
		    Return Value.DoubleValue
		  Catch Err As TypeMismatchException
		    Return Default
		  End Try
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
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  Try
		    Return Value.IntegerValue
		  Catch Err As TypeMismatchException
		    Return Default
		  End Try
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
		Function PointValue(Key As String, Default As REALbasic.Point = Nil) As REALbasic.Point
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary And Dictionary(Value.ObjectValue).HasAllKeys("Left", "Top") Then
		    Dim Dict As Dictionary = Value
		    Return New REALbasic.Point(Dict.Value("Left"), Dict.Value("Top"))
		  End If
		  
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PointValue(Key As String, Assigns Value As REALbasic.Point)
		  Dim Dict As New Dictionary
		  Dict.Value("Left") = Value.X
		  Dict.Value("Top") = Value.Y
		  
		  Self.BeginTransaction()
		  Self.mValues.Value(Key) = Dict
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectValue(Key As String, Default As REALbasic.Rect = Nil) As REALbasic.Rect
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary And Dictionary(Value.ObjectValue).HasAllKeys("Left", "Top", "Width", "Height") Then
		    Dim Dict As Dictionary = Value
		    Return New REALbasic.Rect(Dict.Value("Left"), Dict.Value("Top"), Dict.Value("Width"), Dict.Value("Height"))
		  End If
		  
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RectValue(Key As String, Assigns Value As REALbasic.Rect)
		  Dim Dict As New Dictionary
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
		Function SizeValue(Key As String, Default As REALbasic.Size = Nil) As REALbasic.Size
		  If Not Self.mValues.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary And Dictionary(Value.ObjectValue).HasAllKeys("Width", "Height") Then
		    Dim Dict As Dictionary = Value
		    Return New REALbasic.Size(Dict.Value("Width"), Dict.Value("Height"))
		  End If
		  
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SizeValue(Key As String, Assigns Value As REALbasic.Size)
		  Dim Dict As New Dictionary
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
		  
		  Dim Value As Variant = Self.mValues.Value(Key)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  If Value.Type = Variant.TypeString Then
		    Return Value.StringValue
		  ElseIf Value.Type = Variant.TypeText Then
		    Return Value.TextValue
		  Else
		    Return Default
		  End If
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
		Function VariantValue(Key As String, Default As Auto = Nil) As Variant
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
		  Self.mFile.Write(Beacon.GenerateJSON(Self.mValues, True))
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
