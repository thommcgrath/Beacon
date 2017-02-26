#tag Class
Protected Class DesktopPreferences
Inherits Preferences
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor(File As Global.FolderItem)
		  Super.Constructor()
		  
		  Self.mFile = File
		  
		  If Self.mFile.Exists Then
		    Try
		      Dim Stream As TextInputStream = TextInputStream.Open(Self.mFile)
		      Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		      Stream.Close
		      
		      Self.mValues = Xojo.Data.ParseJSON(Contents.ToText)
		    Catch Err As RuntimeException
		      Self.mValues = New Xojo.Core.Dictionary
		    End Try
		  Else
		    Self.mValues = New Xojo.Core.Dictionary
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Write()
		  Dim Contents As Text = Xojo.Data.GenerateJSON(Self.mValues)
		  Dim Stream As TextOutputStream = TextOutputStream.Create(Self.mFile)
		  Stream.Write(Contents)
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFile As Global.FolderItem
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
