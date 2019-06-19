#tag Class
Protected Class CustomContentParser
	#tag Method, Flags = &h0
		Function AddLine(Line As String) As Beacon.ConfigValue()
		  If Self.mNestedParser <> Nil Then
		    Dim Values() As Beacon.ConfigValue = Self.mNestedParser.AddLine(Line)
		    If Values <> Nil Then
		      // Finished
		      Self.mNestedParser = Nil
		      
		      If Not Self.mDiscardNestedParser Then
		        For Each Value As Beacon.ConfigValue In Values
		          Self.mValues.Append(Value)
		        Next
		      End If
		    End If
		    Return Nil
		  End If
		  
		  Line = Line.Trim
		  
		  If Line.Length = 0 Or Line.BeginsWith("//") Then
		    Return Nil
		  End If
		  
		  If Line.BeginsWith("[") And Line.EndsWith("]") Then
		    Self.mCurrentHeader = Line.SubString(1, Line.Length - 2)
		    Self.mSkippedKeys = Self.GetSkippedKeys(Self.mCurrentHeader, Self.mExistingConfigs)
		  End If
		  
		  If Self.mCurrentHeader = "" Or Self.mCurrentHeader = "Beacon" Then
		    Return Nil
		  End If
		  
		  If Line.BeginsWith("#Server ") Or Line.BeginsWith("#Servers ") Then
		    Dim Pos As Integer = Line.IndexOf(7, " ") + 1
		    Dim Def As String = Line.SubString(Pos).Trim
		    Dim ProfileIDs() As String = Def.Split(",")
		    Self.mDiscardNestedParser = True
		    If Self.mProfile <> Nil Then
		      For Each ProfileID As String In ProfileIDs
		        If Self.mProfile.ProfileID.BeginsWith(ProfileID.Trim.ToText) Then
		          Self.mDiscardNestedParser = False
		        End If
		      Next
		    End If
		    
		    Self.mNestedParser = New CustomContentParser(Self.mCurrentHeader, Self.mExistingConfigs, Self.mProfile)
		    Return Nil
		  ElseIf Line = "#End" Then
		    Return Self.mValues
		  End If
		  
		  Dim KeyPos As Integer = Line.IndexOf("=")
		  If KeyPos = -1 Then
		    Return Nil
		  End If
		  
		  Dim Key As String = Line.Left(KeyPos).Trim
		  If Self.mSkippedKeys.IndexOf(Key) > -1 Then
		    Return Nil
		  End If
		  
		  Dim Value As String = Line.SubString(KeyPos + 1).Trim
		  Self.mValues.Append(New Beacon.ConfigValue(Self.mCurrentHeader.ToText, Key.ToText, Value.ToText))
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(InitialHeader As String, ExistingConfigs As Xojo.Core.Dictionary, Profile As Beacon.ServerProfile)
		  Self.mCurrentHeader = InitialHeader
		  Self.mExistingConfigs = ExistingConfigs
		  Self.mProfile = Profile
		  Self.mSkippedKeys = Self.GetSkippedKeys(Self.mCurrentHeader, Self.mExistingConfigs)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetSkippedKeys(Header As String, ExistingConfigs As Xojo.Core.Dictionary) As String()
		  Dim SkippedKeys() As String
		  If Not ExistingConfigs.HasKey(Header.ToText) Then
		    Return SkippedKeys
		  End If
		  
		  Dim Siblings As Xojo.Core.Dictionary = ExistingConfigs.Value(Header.ToText)
		  For Each Entry As Xojo.Core.DictionaryEntry In Siblings
		    SkippedKeys.Append(Entry.Key)
		  Next
		  Return SkippedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemainingValues() As Beacon.ConfigValue()
		  If Self.mNestedParser <> Nil Then
		    Dim Values() As Beacon.ConfigValue = Self.mNestedParser.RemainingValues()
		    If Values <> Nil Then
		      // Finished
		      Self.mNestedParser = Nil
		      
		      If Not Self.mDiscardNestedParser Then
		        For Each Value As Beacon.ConfigValue In Values
		          Self.mValues.Append(Value)
		        Next
		      End If
		    End If
		  End If
		  
		  Return Self.mValues
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentHeader As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscardNestedParser As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExistingConfigs As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNestedParser As CustomContentParser
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSkippedKeys() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValues() As Beacon.ConfigValue
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mNestedParser"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
