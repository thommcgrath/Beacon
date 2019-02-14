#tag Class
Protected Class SetEntryOption
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram, Weight As Double)
		  Self.mEngram = New Beacon.Engram(Engram)
		  Self.mWeight = Weight
		  Self.mLastModifiedTime = Microseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntryOption)
		  Self.mEngram = New Beacon.Engram(Source.mEngram)
		  Self.mHash = Source.mHash
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		  Self.mLastSaveTime = Source.mLastSaveTime
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
		      Self.mLastModifiedTime = Microseconds
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Beacon.Engram
		  Return New Beacon.Engram(Self.mEngram)
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
		  If Self.HashIsStale Then
		    Dim Path As Text
		    If Self.mEngram = Nil Then
		      Path = ""
		    Else
		      Path = If(Self.mEngram.Path <> "", Self.mEngram.Path, Self.mEngram.ClassString)
		    End If
		    
		    Self.mHash = Beacon.MD5(Path.Lowercase + "@" + Self.mWeight.ToText(Xojo.Core.Locale.Raw, "0.0000")).Lowercase
		    Self.mLastHashTime = Microseconds
		  End If
		  
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashIsStale() As Boolean
		  Return Self.mLastHashTime < Self.mLastModifiedTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Xojo.Core.Dictionary) As Beacon.SetEntryOption
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
		  
		  Dim Option As New Beacon.SetEntryOption(Engram, Weight)
		  Option.Modified = False
		  Return Option
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  Return Self.mEngram <> Nil And Self.mEngram.IsValid And (Document.Mods.Ubound = -1 Or Document.Mods.IndexOf(Self.mEngram.ModID) > -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mLastModifiedTime > Self.mLastSaveTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = Microseconds
		  Else
		    Self.mLastModifiedTime = Microseconds
		  End If
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
		Private mHash As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHashTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
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
