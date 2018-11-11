#tag Class
Protected Class CustomContent
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary)
		  Self.mGameIniContent = Dict.Lookup("Game.ini", "")
		  Self.mGameUserSettingsIniContent = Dict.Lookup("GameUserSettings.ini", "")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary)
		  Dict.Value("Game.ini") = Self.mGameIniContent
		  Dict.Value("GameUserSettings.ini") = Self.mGameUserSettingsIniContent
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "CustomContent"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As Text
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(SupportedConfigs As Xojo.Core.Dictionary = Nil, Assigns Value As Text)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ShooterGameHeader, Value, SupportedConfigs)
		    Dim ConfigDict As New Xojo.Core.Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict)
		  End If
		  
		  If Self.mGameIniContent.Compare(Value, Text.CompareCaseSensitive, Xojo.Core.Locale.Raw) <> 0 Then
		    Self.mGameIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameIniValues(SourceDocument, New Xojo.Core.Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ShooterGameHeader, Self.mGameIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As Text
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(SupportedConfigs As Xojo.Core.Dictionary = Nil, Assigns Value As Text)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ServerSettingsHeader, Value, SupportedConfigs)
		    Dim ConfigDict As New Xojo.Core.Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict)
		  End If
		  
		  If Self.mGameUserSettingsIniContent.Compare(Value, Text.CompareCaseSensitive, Xojo.Core.Locale.Raw) <> 0 Then
		    Self.mGameUserSettingsIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameUserSettingsIniValues(SourceDocument, New Xojo.Core.Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ServerSettingsHeader, Self.mGameUserSettingsIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSkippedKeys(Header As Text, ExistingConfigs As Xojo.Core.Dictionary) As Text()
		  Dim SkippedKeys() As Text
		  If Not ExistingConfigs.HasKey(Header) Then
		    Return SkippedKeys
		  End If
		  
		  Dim Siblings As Xojo.Core.Dictionary = ExistingConfigs.Value(Header)
		  For Each Entry As Xojo.Core.DictionaryEntry In Siblings
		    SkippedKeys.Append(Entry.Key)
		  Next
		  Return SkippedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IniValues(InitialHeader As Text, Source As Text, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  Source = Source.ReplaceLineEndings(Text.FromUnicodeCodepoint(10))
		  
		  Dim Lines() As Text = Source.Split(Text.FromUnicodeCodepoint(10))
		  Dim CurrentHeader As Text = InitialHeader
		  Dim Values() As Beacon.ConfigValue
		  Dim SkippedKeys() As Text = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		  For Each Line As Text In Lines
		    Line = Line.Trim
		    
		    If Line.Length = 0 Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      CurrentHeader = Line.Mid(1, Line.Length - 2)
		      SkippedKeys = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		    End If
		    
		    If CurrentHeader = "" Then
		      Continue
		    End If
		    
		    Dim KeyPos As Integer = Line.IndexOf("=")
		    If KeyPos = -1 Then
		      Continue
		    End If
		    
		    Dim Key As Text = Line.Left(KeyPos).Trim
		    If SkippedKeys.IndexOf(Key) > -1 Then
		      Continue
		    End If
		    
		    Dim Value As Text = Line.Mid(KeyPos + 1).Trim
		    Values.Append(New Beacon.ConfigValue(CurrentHeader, Key, Value))
		  Next
		  Return Values
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mGameIniContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As Text
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
	#tag EndViewBehavior
End Class
#tag EndClass
