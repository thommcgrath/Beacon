#tag Class
Protected Class ConfigValue
	#tag Method, Flags = &h0
		Sub Constructor(Key As Ark.ConfigKey, Command As String, Index As Integer = 0)
		  Self.ParseCommand(Command)
		  Self.mSortKey = Self.mSimplifiedKey + ":" + Index.ToString("00000")
		  Self.mKeyDetails = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Key As Ark.ConfigKey, Command As String, SortKey As String)
		  Self.ParseCommand(Command)
		  Self.mSortKey = SortKey
		  Self.mKeyDetails = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Header As String, Command As String, Index As Integer = 0)
		  Self.ParseCommand(Command)
		  Self.mSortKey = Self.mSimplifiedKey + ":" + Index.ToString("00000")
		  
		  Var Keys() As Ark.ConfigKey = Ark.DataSource.Pool.Get(False).GetConfigKeys(File, Header, Self.mSimplifiedKey, False)
		  Var ConfigKey As Ark.ConfigKey
		  If Keys.Count >= 1 Then
		    ConfigKey = Keys(0)
		  Else
		    ConfigKey = New Ark.ConfigKey(File, Header, Self.mSimplifiedKey)
		  End If
		  
		  Self.mKeyDetails = ConfigKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Header As String, Command As String, SortKey As String)
		  Self.ParseCommand(Command)
		  Self.mSortKey = SortKey
		  
		  Var Keys() As Ark.ConfigKey = Ark.DataSource.Pool.Get(False).GetConfigKeys(File, Header, Self.mSimplifiedKey, False)
		  Var ConfigKey As Ark.ConfigKey
		  If Keys.Count >= 1 Then
		    ConfigKey = Keys(0)
		  Else
		    ConfigKey = New Ark.ConfigKey(File, Header, Self.mSimplifiedKey)
		  End If
		  
		  Self.mKeyDetails = ConfigKey
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseCommand(Command As String)
		  Self.mCommand = Command
		  
		  Var Pos As Integer = Command.IndexOf("=")
		  If Pos > -1 Then
		    Self.mAttributedKey = Command.Left(Pos)
		    Self.mValue = Command.Middle(Pos + 1).Trim
		  Else
		    Self.mAttributedKey = Command
		    Self.mValue = "True"
		  End If
		  
		  Self.mSimplifiedKey = Self.SimplifyKey(Self.mAttributedKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SimplifyKey(Key As String) As String
		  Var Idx As Integer = Key.IndexOf("[")
		  If Idx = -1 Then
		    Return Key
		  Else
		    Return Key.Left(Idx)
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAttributedKey
			End Get
		#tag EndGetter
		AttributedKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCommand
			End Get
		#tag EndGetter
		Command As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails
			End Get
		#tag EndGetter
		Details As Ark.ConfigKey
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails.File
			End Get
		#tag EndGetter
		File As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mHash.IsEmpty Then
			    Var Raw As String = Self.mKeyDetails.File.Lowercase + ":" + Self.mKeyDetails.Header.Lowercase + ":" + Self.mSortKey.Lowercase
			    #if DebugBuild
			      Self.mHash = Raw
			    #else
			      Self.mHash = EncodeHex(Crypto.SHA256(Raw)).Lowercase
			    #endif
			  End If
			  Return Self.mHash
			End Get
		#tag EndGetter
		Hash As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails.Header
			End Get
		#tag EndGetter
		Header As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAttributedKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyDetails As Ark.ConfigKey
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimplifiedKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSortKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSimplifiedKey
			End Get
		#tag EndGetter
		SimplifiedKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mKeyDetails Is Nil Then
			    Return False
			  Else
			    Return (Self.mKeyDetails.MaxAllowed Is Nil) = False And Self.mKeyDetails.MaxAllowed.DoubleValue = 1
			  End If
			End Get
		#tag EndGetter
		SingleInstance As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSortKey
			End Get
		#tag EndGetter
		SortKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mValue
			End Get
		#tag EndGetter
		Value As String
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Header"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SimplifiedKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Command"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="File"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hash"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AttributedKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SortKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SingleInstance"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
