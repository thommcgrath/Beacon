#tag Class
Protected Class MutableLootContainerSelector
Inherits Ark.LootContainerSelector
	#tag Method, Flags = &h0
		Sub Code(Assigns Source As String)
		  Self.mCode = Source
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootContainerSelector
		  Return New Ark.LootContainerSelector(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Language(Assigns Value As String)
		  Select Case Value
		  Case Self.LanguageRegEx, Self.LanguageJavaScript
		    Self.mLanguage = Value
		    Self.Modified = True
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.LootContainerSelector
		  Return Self
		End Function
	#tag EndMethod


End Class
#tag EndClass
