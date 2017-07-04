#tag Class
Protected Class SetEntryOption
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram, Weight As Double)
		  Self.mEngram = Engram
		  Self.mWeight = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntryOption)
		  Self.mEngram = Source.mEngram
		  Self.mWeight = Source.mWeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  If Self.mEngram.IsValid Then
		    Return
		  End If
		  
		  Dim ClassString As Text = Self.mEngram.ClassString
		  For Each Engram As Beacon.Engram In Engrams
		    If Engram.ClassString = ClassString Then
		      Self.mEngram = New Beacon.Engram(Engram)
		      Self.mModified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Beacon.Engram
		  Return Self.mEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Path As Text = Self.Engram.Path
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  If Path <> "" Then
		    Keys.Value("Path") = Path
		  End If
		  Keys.Value("Class") = Self.Engram.ClassString
		  Keys.Value("Weight") = Self.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Dim Path As Text = Self.mEngram.Path
		  If Path = "" Then
		    Path = Self.mEngram.ClassString
		  End If
		  
		  Return Beacon.MD5(Path.Lowercase + "@" + Self.mWeight.ToText(Xojo.Core.Locale.Raw, "0.0000")).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary) As Beacon.SetEntryOption
		  Dim Weight As Double = Dict.Value("Weight")
		  Dim Engram, BackupEngram As Beacon.Engram
		  
		  If Dict.HasKey("Path") Then
		    Engram = Beacon.Data.GetEngramByPath(Dict.Value("Path"))
		    If Engram = Nil Then
		      BackupEngram = Beacon.Engram.CreateUnknownEngram(Dict.Value("Path"))
		    End If
		  End If
		  
		  If Engram = Nil And Dict.HasKey("Class") Then
		    Engram = Beacon.Data.GetEngramByClass(Dict.Value("Class"))
		    If Engram = Nil And BackupEngram = Nil Then
		      BackupEngram = Beacon.Engram.CreateUnknownEngram(Dict.Value("Class"))
		    End If
		  End If
		  
		  If Engram = Nil Then
		    If BackupEngram = Nil Then
		      Return Nil
		    End If
		    Engram = BackupEngram
		  End If
		  
		  Return New Beacon.SetEntryOption(Engram, Weight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mEngram <> Nil And Self.mEngram.IsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SetEntryOption) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfHash As Text = Self.Hash
		  Dim OtherHash As Text = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
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
