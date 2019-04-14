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
		    Dim Source As Dictionary
		    Dim Compress As Boolean = False
		    If Self.mSource <> Nil Then
		      Source = Self.mSource
		    ElseIf Self.mSourceDocument <> Nil And Self.mSourceIdentity <> Nil Then
		      Source = Self.mSourceDocument.ToDictionary(Self.mSourceIdentity)
		      Compress = Self.mSourceDocument.UseCompression
		    Else
		      Dim Err As New NilObjectException
		      Err.Message = "No source dictionary or document."
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
		  Self.Priority = Thread.LowestPriority
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
		Sub Constructor(Source As Dictionary, Destination As FolderItem)
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
		Private Sub RaiseFinished()
		  RaiseEvent Finished(Self.mDestination)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function WriteSynchronous(Source As Dictionary, File As FolderItem, Compress As Boolean) As Boolean
		  // Prepare
		  
		  #Pragma Unused Source
		  
		  Dim Content As String = Beacon.GenerateJSON(Not Compress)
		  If Compress Then
		    Dim Compressor As New _GZipString
		    Compressor.UseHeaders = True
		    
		    File.Write(Compressor.Compress(Content))
		  Else
		    File.Write(Content)
		  End If
		  
		  Return True
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
		Private mSource As Dictionary
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
			Group="Behavior"
			Type="Boolean"
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
			Type="String"
			EditorType="String"
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
			Type="Integer"
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
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
