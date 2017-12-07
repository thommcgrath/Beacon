#tag Class
Protected Class MobilePreferences
Inherits Preferences
	#tag CompatibilityFlags = ( TargetIOS and ( Target32Bit or Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Constructor(File As Xojo.IO.FolderItem)
		  Super.Constructor()
		  
		  Self.mFile = File
		  
		  If Self.mFile.Exists Then
		    Try
		      Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(Self.mFile, Xojo.Core.TextEncoding.UTF8)
		      Dim Contents As Text = Stream.ReadAll
		      Stream.Close
		      
		      Self.mValues = Xojo.Data.ParseJSON(Contents)
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
		  Dim Writer As New Beacon.JSONWriter(Self.mValues, Self.mFile)
		  Writer.Run
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFile As Xojo.IO.FolderItem
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
