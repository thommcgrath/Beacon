#tag Class
Protected Class JSONWriter
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Self.mSuccess = False
		  Self.mFinished = False
		  Self.mRunning = True
		  #if Not TargetiOS
		    Self.mLock.Enter
		  #endif
		  Try
		    Self.mSuccess = Self.WriteSynchronous(Self.mSource, Self.mDestination)
		  Catch Err As RuntimeException
		    
		  End Try
		  #if Not TargetiOS
		    Self.mLock.Leave
		  #endif
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
		  Const Indent = &h09
		  Const EndOfLine = &h0A
		  
		  Dim Bytes() As UInt8
		  Dim Indents As UInteger
		  
		  Dim AddAsIs, InQuote As Boolean
		  
		  Dim Mem As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(JSON)
		  Dim Bound As UInteger = Mem.Size - 1
		  Dim Pointer As Ptr = Mem.Data
		  For Offset As UInteger = 0 To Bound
		    Dim Char As UInt8 = Pointer.UInt8(Offset)
		    
		    If AddAsIs Then
		      Bytes.Append(Char)
		      AddAsIs = False
		    ElseIf Char = &h22 Then
		      Bytes.Append(Char)
		      InQuote = Not InQuote
		    ElseIf InQuote Then
		      Bytes.Append(Char)
		      If Char = &h5C Then
		        AddAsIs = True
		      End If
		    ElseIf Char = &h7B Or Char = &h5B Then
		      Indents = Indents + 1
		      Bytes.Append(Char)
		      Bytes.Append(EndOfLine)
		      For I As UInteger = 1 To Indents
		        Bytes.Append(Indent)
		      Next
		    ElseIf Char = &h7D Or Char = &h5D Then
		      Indents = Indents - 1
		      Bytes.Append(EndOfLine)
		      For I As UInteger = 1 To Indents
		        Bytes.Append(Indent)
		      Next
		      Bytes.Append(Char)
		    ElseIf Char = &h2C Then
		      Bytes.Append(Char)
		      Bytes.Append(EndOfLine)
		      For I As UInteger = 1 To Indents
		        Bytes.Append(Indent)
		      Next
		    ElseIf Char = &h3A Then
		      Bytes.Append(Char)
		      Bytes.Append(&h20)
		    ElseIf Char = &h0A Or Char = &h0D Or Char = &h20 Or Char = &h09 Then
		      // Skip it
		    Else
		      Bytes.Append(Char)
		    End If
		  Next
		  
		  Return Xojo.Core.TextEncoding.UTF8.ConvertDataToText(New Xojo.Core.MemoryBlock(Bytes))
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
		  Content = JSONPrettyPrint(Content)
		  
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
