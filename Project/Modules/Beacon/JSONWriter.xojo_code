#tag Class
Private Class JSONWriter
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Self.Write
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Constructor(Source As Xojo.Core.Dictionary, Destination As Global.FolderItem)
		  Super.Constructor
		  Self.Source = Source
		  Self.Destination = Destination
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub Constructor(Source As Xojo.Core.Dictionary, Destination As Xojo.IO.FolderItem)
		  Super.Constructor
		  Self.Source = Source
		  Self.Destination = Destination
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function JSONPrettyPrint(json As Text) As Text
		  // From https://forum.xojo.com/conversation/post/332504
		  
		  const kBuffer as text = "  "
		  const kEOL as text = &u0A
		  
		  dim outArr() as text
		  dim indents( 0 ) as text
		  
		  dim addAsIs as boolean
		  dim inQuote as boolean
		  
		  for each char as text in json.Characters
		    if addAsIs then
		      outArr.Append char
		      addAsIs = false
		      
		    elseif char = """" then
		      outArr.Append char
		      inQuote = not inQuote
		      
		    elseif inQuote then
		      outArr.Append char
		      if char = "\" then
		        addAsIs = true
		      end if
		      
		    elseif char = "{" or char = "[" then
		      indents.Append indents( indents.Ubound ) + kBuffer
		      outArr.Append char
		      outArr.Append kEOL
		      outArr.Append indents( indents.Ubound )
		      
		    elseif char = "}" or char = "]" then
		      call indents.Pop
		      outArr.Append kEOL
		      outArr.Append indents( indents.Ubound )
		      outArr.Append char
		      
		    elseif char = "," then
		      outArr.Append char
		      outArr.Append kEOL
		      outArr.Append indents( indents.Ubound )
		      
		    elseif char = ":" then
		      outArr.Append " : "
		      
		    elseif char = &u0A or char = &u0D or char = " " or char = &u09 then
		      //
		      // Skip it
		      //
		      
		    else
		      outArr.Append char
		      
		    end if
		  next
		  
		  dim result as text = Text.Join( outArr, "" )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub Write()
		  // Prepare
		  Dim Content As Text = Xojo.Data.GenerateJSON(Self.Source)
		  
		  // Pretty
		  Content = Self.JSONPrettyPrint(Content)
		  
		  // Temporary
		  Dim Temp As FolderItem = SpecialFolder.Temporary.Child(Beacon.CreateUUID + ".beacon")
		  
		  // Stream
		  Dim Stream As TextOutputStream = TextOutputStream.Create(Temp)
		  Stream.Write(Content)
		  Stream.Close
		  
		  // Delete the existing one
		  If Destination.Exists Then
		    Destination.Delete
		  End If
		  
		  // Move the temporary
		  Temp.MoveFileTo(Destination)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private Sub Write()
		  // Prepare
		  Dim Content As Text = Xojo.Data.GenerateJSON(Self.Source)
		  
		  // Pretty
		  Content = Self.JSONPrettyPrint(Content)
		  
		  // Temporary
		  Dim Temp As Xojo.IO.FolderItem = Xojo.IO.SpecialFolder.Temporary.Child(Beacon.CreateUUID + ".beacon")
		  
		  // Stream
		  Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(Temp, Xojo.Core.TextEncoding.UTF8)
		  Stream.Write(Content)
		  Stream.Close
		  
		  // Delete the existing one
		  If Destination.Exists Then
		    Destination.Delete
		  End If
		  
		  // Move the temporary
		  Temp.MoveTo(Destination)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Destination As Global.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private Destination As Xojo.IO.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Source As Xojo.Core.Dictionary
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
			Name="Priority"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Group="Behavior"
			Type="Beacon.Thread.States"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Suspended"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
