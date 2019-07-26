#tag Class
Protected Class JSONWriter
Inherits Thread
	#tag Event
		Sub Run()
		  Self.mSuccess = False
		  Self.mFinished = False
		  Self.mRunning = True
		  #if Not TargetiOS
		    Self.mLock.Enter
		  #endif
		  Try
		    Dim Source As Xojo.Core.Dictionary
		    Dim Compress As Boolean = False
		    If Self.mSource <> Nil Then
		      Source = Self.mSource
		    ElseIf Self.mSourceDocument <> Nil And Self.mSourceIdentity <> Nil Then
		      Source = Self.mSourceDocument.ToDictionary(Self.mSourceIdentity)
		      Compress = Self.mSourceDocument.UseCompression
		    Else
		      Dim Err As New NilObjectException
		      Err.Reason = "No source dictionary or document."
		      Raise Err
		    End If
		    
		    Self.mSuccess = Self.WriteSynchronous(Source, Self.mDestination, Compress)
		  Catch Err As RuntimeException
		    Self.mError = Err
		  End Try
		  Self.mSource = Nil
		  Self.mSourceDocument = Nil
		  Self.mSourceIdentity = Nil
		  #if Not TargetiOS
		    Self.mLock.Leave
		  #endif
		  Self.mFinished = True
		  Self.mRunning = False
		  Self.mRaiseFinishedCallbackKey = CallLater.Schedule(0, AddressOf RaiseFinished)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.Priority = 1
		  #if Not TargetiOS
		    Self.mLock = New CriticalSection
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document, Identity As Beacon.Identity, Destination As FolderItem)
		  Self.Constructor()
		  Self.mSourceDocument = Document
		  Self.mSourceIdentity = Identity
		  Self.mDestination = Destination
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Sub Constructor(Source As Xojo.Core.Dictionary, Destination As FolderItem)
		  Self.Constructor()
		  Self.mSource = Source
		  Self.mDestination = Destination
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mRaiseFinishedCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function PrettyPrint(JSON As Text) As Text
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

	#tag Method, Flags = &h21
		Private Sub RaiseFinished()
		  RaiseEvent Finished(Self.mDestination)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function WriteSynchronous(Source As Xojo.Core.Dictionary, File As FolderItem, Compress As Boolean) As Boolean
		  // Prepare
		  Dim Content As Text = Xojo.Data.GenerateJSON(Source)
		  
		  #if TargetiOS
		    Content = PrettyPrint(Content)
		    Return File.Write(Content, Xojo.Core.TextEncoding.UTF8)
		  #else
		    If Compress Then
		      Dim Compressor As New _GZipString
		      Compressor.UseHeaders = True
		      
		      Dim Bytes As MemoryBlock = Compressor.Compress(Content, _GZipString.DefaultCompression)
		      Return File.Write(Bytes)
		    Else
		      Content = PrettyPrint(Content)
		      Return File.Write(Content, Xojo.Core.TextEncoding.UTF8)
		    End If
		  #endif
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Destination As FolderItem)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mError
			End Get
		#tag EndGetter
		Error As RuntimeException
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinished
			End Get
		#tag EndGetter
		Finished As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Private mDestination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRaiseFinishedCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceIdentity As Beacon.Identity
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
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Running"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Success"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
