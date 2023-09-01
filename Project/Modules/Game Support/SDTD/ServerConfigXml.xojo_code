#tag Class
Protected Class ServerConfigXml
Implements Iterable
	#tag Method, Flags = &h0
		Sub Add(Value As SDTD.ConfigValue)
		  Self.mValues.Value(Value.Details.ConfigOptionId) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildString() As String
		  Var Doc As XmlDocument
		  Try
		    Return Self.BuildXml.Transform(Beacon.PrettyPrintXsl)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building XMLDocument")
		    Return ""
		  End Try
		  
		  Return Doc.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildXml() As XmlDocument
		  Var SortedValues() As SDTD.ConfigValue = Self.Values
		  Var SortKeys() As String
		  SortKeys.ResizeTo(SortedValues.LastIndex)
		  For Idx As Integer = 0 To SortKeys.LastIndex
		    SortKeys(Idx) = SortedValues(Idx).SortKey
		  Next
		  SortKeys.SortWith(SortedValues)
		  
		  Var Doc As New XmlDocument
		  Var Root As XmlNode = Doc.AppendChild(Doc.CreateElement("ServerSettings"))
		  
		  For Each Value As SDTD.ConfigValue In SortedValues
		    Var Node As XmlNode = Root.AppendChild(Doc.CreateElement("property"))
		    Node.SetAttribute("name", Value.Key)
		    Node.SetAttribute("value", Value.Value)
		  Next
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Values() As SDTD.ConfigValue)
		  Self.mValues = New Dictionary
		  
		  For Each Value As SDTD.ConfigValue In Values
		    Self.mValues.Value(Value.Details.ConfigOptionId) = Value
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mValues.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(File As BookmarkedFolderItem) As SDTD.ServerConfigXml
		  If File Is Nil Or File.Exists = False Then
		    Return Nil
		  End If
		  
		  Var Doc As XmlDocument
		  Try
		    Doc = New XmlDocument(File)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing XML file")
		    Return Nil
		  End Try
		  Return Create(Doc)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Values() As SDTD.ConfigValue) As SDTD.ServerConfigXml
		  If Values Is Nil Or Values.Count = 0 Then
		    Return Nil
		  End If
		  
		  Return New SDTD.ServerConfigXml(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Source As String) As SDTD.ServerConfigXml
		  Var Doc As XmlDocument
		  Try
		    Doc = New XmlDocument(Source)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing XML string")
		    Return Nil
		  End Try
		  Return Create(Doc)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Doc As XmlDocument) As SDTD.ServerConfigXml
		  Var Root As XmlElement = Doc.DocumentElement
		  If Root.Name <> "ServerSettings" Then
		    App.Log("Expected root element of ServerSettings, got " + Root.Name + ".")
		    Return Nil
		  End If
		  
		  Var Values() As SDTD.ConfigValue
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  Var Bound As Integer = Root.ChildCount - 1
		  For Idx As Integer = 0 To Bound
		    Var Child As XmlNode = Root.Child(Idx)
		    If Child.Name <> "property" Then
		      Continue
		    End If
		    
		    Var KeyName As String = Child.GetAttribute("name")
		    Var Value As String = Child.GetAttribute("value")
		    Var Options() As SDTD.ConfigOption = DataSource.GetConfigOptions(SDTD.ConfigFileServerConfigXml, KeyName)
		    If Options.Count = 0 Then
		      Options.Add(New SDTD.ConfigOption(SDTD.ConfigFileServerConfigXml, KeyName))
		    End If
		    
		    Values.Add(New SDTD.ConfigValue(Options(0), Value))
		  Next
		  
		  Return Create(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(Option As SDTD.ConfigOption) As SDTD.ConfigValue
		  If Option Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.mValues.Lookup(Option.ConfigOptionId, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Arr() As Variant
		  For Each Entry As DictionaryEntry In Self.mValues
		    Arr.Add(Entry.Value)
		  Next
		  Return New Beacon.GenericIterator(Arr)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Key As SDTD.ConfigOption)
		  If Self.mValues.HasKey(Key.ConfigOptionId) Then
		    Self.mValues.Remove(Key.ConfigOptionId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Value As SDTD.ConfigValue)
		  If Value Is Nil Then
		    Return
		  End If
		  
		  Self.Remove(Value.Details)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Key As SDTD.ConfigOption) As String
		  If Key Is Nil Then
		    Return ""
		  End If
		  
		  Var Value As SDTD.ConfigValue = Self.mValues.Lookup(Key.ConfigOptionId, Nil)
		  If Value Is Nil Then
		    Return ""
		  End If
		  Return Value.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As SDTD.ConfigOption, Assigns Value As String)
		  Self.mValues.Value(Key.ConfigOptionId) = New SDTD.ConfigValue(Key, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values() As SDTD.ConfigValue()
		  Var Arr() As SDTD.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mValues
		    Arr.Add(Entry.Value)
		  Next
		  Return Arr
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValues As Dictionary
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
