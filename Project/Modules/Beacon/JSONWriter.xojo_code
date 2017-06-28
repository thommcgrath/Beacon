#tag Class
Protected Class JSONWriter
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Self.mSuccess = False
		  Self.mFinished = False
		  Self.mRunning = True
		  Self.mLock.Enter
		  Try
		    Self.mSuccess = Self.WriteSynchronous(Self.mSource, Self.mDestination)
		  Catch Err As RuntimeException
		    
		  End Try
		  Self.mLock.Leave
		  Self.mFinished = True
		  Self.mRunning = False
		  RaiseEvent Finished
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Constructor(Source As Xojo.Core.Dictionary, Destination As Global.FolderItem)
		  Super.Constructor
		  Self.mSource = Source
		  Self.mDestination = Destination
		  Self.mLock = New Mutex(EncodeHex(Crypto.MD5(Lowercase(Destination.NativePath))))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub Constructor(Source As Xojo.Core.Dictionary, Destination As Xojo.IO.FolderItem)
		  Super.Constructor
		  Self.mSource = Source
		  Self.mDestination = Destination
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function JSONPrettyPrint(json As Text) As Text
		  // Glacially slow on Windows
		  // From https://forum.xojo.com/conversation/post/332504
		  
		  #if TargetWin32
		    Return json
		  #endif
		  
		  const kBuffer as text = &u09
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
		      outArr.Append ": "
		      
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

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function WriteSynchronous(Source As Xojo.Core.Dictionary, File As Global.FolderItem) As Boolean
		  // Prepare
		  Dim Content As Text = Xojo.Data.GenerateJSON(Source)
		  
		  // Pretty
		  Content = JSONPrettyPrint(Content)
		  
		  // Temporary
		  Dim Temp As FolderItem = SpecialFolder.Temporary.Child(Beacon.CreateUUID + ".beacon")
		  
		  // Stream
		  Dim Stream As TextOutputStream = TextOutputStream.Create(Temp)
		  Stream.Write(Content)
		  Stream.Close
		  
		  // Delete the existing one
		  If File.Exists Then
		    File.Delete
		    Dim Err As Integer = File.LastErrorCode
		    If Err <> 0 Then
		      Return False
		    End If
		  End If
		  
		  // Move the temporary
		  Temp.MoveFileTo(File)
		  If Temp.LastErrorCode <> 0 Then
		    Dim Err As Integer = Temp.LastErrorCode
		    If Err <> 0 Then
		      Return False
		    End If
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function WriteSynchronous(Source As Xojo.Core.Dictionary, File As Xojo.IO.FolderItem) As Boolean
		  // Prepare
		  Dim Content As Text = Xojo.Data.GenerateJSON(Source)
		  
		  // Pretty
		  Content = Self.JSONPrettyPrint(Content)
		  
		  // Temporary
		  Dim Temp As Xojo.IO.FolderItem = Xojo.IO.SpecialFolder.Temporary.Child(Beacon.CreateUUID + ".beacon")
		  
		  // Stream
		  Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(Temp, Xojo.Core.TextEncoding.UTF8)
		  Stream.Write(Content)
		  Stream.Close
		  
		  // Delete the existing one
		  If File.Exists Then
		    File.Delete
		  End If
		  
		  // Move the temporary
		  Temp.MoveTo(File)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinished
			End Get
		#tag EndGetter
		Finished As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mDestination As Global.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private mDestination As Xojo.IO.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mLock As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mRunning
			End Get
		#tag EndGetter
		Running As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSuccess
			End Get
		#tag EndGetter
		Success As Boolean
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Finished"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			Name="Running"
			Group="Behavior"
			Type="Boolean"
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
			Name="Success"
			Group="Behavior"
			Type="Boolean"
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
