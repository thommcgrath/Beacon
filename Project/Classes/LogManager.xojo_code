#tag Class
Protected Class LogManager
	#tag Method, Flags = &h0
		Sub Claim(File As FolderItem)
		  #if SimpleDebugMode = False Or DebugBuild = False
		    If File Is Nil Or File.Exists = False Or Self.mFolder Is Nil Then
		      Return
		    End If
		    
		    Var Now As DateTime = DateTime.Now(New TimeZone(0))
		    Var Filename As String = Now.SQLDate + ".log"
		    Var Destination As FolderItem = Self.mFolder.Child(Filename)
		    
		    Var AppendContent As String
		    If Destination.Exists Then
		      Var InStream As TextInputStream = TextInputStream.Open(Destination)
		      AppendContent = InStream.ReadAll(Encodings.UTF8)
		      InStream.Close
		      Destination.Remove
		    End If
		    
		    File.MoveTo(Destination)
		    
		    If AppendContent.IsEmpty = False Then
		      Var OutStream As TextOutputStream = TextOutputStream.Open(Destination)
		      OutStream.WriteLine(AppendContent)
		      OutStream.Close
		    End If
		  #else
		    #Pragma Unused File
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cleanup()
		  #if SimpleDebugMode = False Or DebugBuild = False
		    Var Filter As New Regex
		    Filter.SearchPattern = "^(\d{4})-(\d{2})-(\d{2})\.log$"
		    
		    Var Now As DateTime = DateTime.Now(New TimeZone(0))
		    Var StartOfDay As New DateTime(Now.Year, Now.Month, Now.Day, 0, 0, 0, 0, Now.Timezone)
		    Var Duration As New DateInterval(0, 0, 30)
		    Var Cutoff As DateTime = StartOfDay - Duration
		    
		    For Each File As FolderItem In Self.mFolder.Children
		      Try
		        Var Matches As RegexMatch = Filter.Search(File.Name)
		        If Matches Is Nil Then
		          Continue
		        End If
		        
		        Var Year As Integer = Val(Matches.SubExpressionString(1))
		        Var Month As Integer = Val(Matches.SubExpressionString(2))
		        Var Day As Integer = Val(Matches.SubExpressionString(3))
		        Var LogDate As New DateTime(Year, Month, Day, 0, 0, 0, 0, New TimeZone(0))
		        
		        If LogDate.SecondsFrom1970 < Cutoff.SecondsFrom1970 Then
		          File.Remove
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFlushTimer = New Timer
		  AddHandler mFlushTimer.Action, WeakAddressOf mFlushTimer_Action
		  
		  Self.mPendingMessages = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Destination() As FolderItem
		  Return Self.mFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destination(Assigns Parent As FolderItem)
		  #if SimpleDebugMode = False Or DebugBuild = False
		    If Parent.Exists = False Then
		      Parent.CreateFolder
		    ElseIf Parent.IsFolder = False Then
		      Parent.Remove
		      Parent.CreateFolder
		    End If
		  #endif
		  
		  Self.mFolder = Parent
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush()
		  #Pragma BackgroundTasks False
		  
		  #if SimpleDebugMode = False Or DebugBuild = False
		    If Self.mFolder Is Nil Then
		      Return
		    End If
		    
		    For Each Entry As DictionaryEntry In Self.mPendingMessages
		      Var Filename As String = Entry.Key
		      Var Messages() As String = Entry.Value
		      
		      Var Stream As TextOutputStream = TextOutputStream.Open(Self.mFolder.Child(Filename))
		      While Messages.Count > 0
		        Stream.WriteLine(Messages(0))
		        Messages.RemoveAt(0)
		      Wend
		      Stream.Close
		    Next
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Err As RuntimeException, Location As String, MoreDetail As String = "")
		  If Err Is Nil Then
		    Return
		  End If
		  
		  // https://tracker.xojo.com/xojoinc/xojo/-/issues/72314
		  #if TargetMacOS And TargetX86 And XojoVersion < 2023.020
		    Return
		  #endif
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  If Info Is Nil Then
		    Return
		  End If
		  
		  #if TargetDesktop
		    Var Stack() As StackFrame = Err.StackFrames
		    While Stack.LastIndex >= 0 And (Stack(0).Name = "RuntimeRaiseException" Or (Stack(0).Name.BeginsWith("Raise") And Stack(0).Name.EndsWith("Exception")))
		      Stack.RemoveAt(0)
		    Wend
		    
		    Var Origin As String = "Unknown"
		    If Stack.LastIndex >= 0 Then
		      Origin = Stack(0).Name
		    End If
		    
		    Self.Log("Unhandled " + Info.FullName + " in " + Origin + ", caught in " + Location + If(MoreDetail.IsEmpty = False, " (" + MoreDetail + ")", "") + ": " + Err.Message)
		  #else
		    Self.Log("Unhandled " + Info.FullName + " in " + Location + If(MoreDetail.IsEmpty = False, " (" + MoreDetail + ")", "") + ": " + Err.Message)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  #if SimpleDebugMode = False Or DebugBuild = False
		    // Use local time for the actual log message
		    Var Now As DateTime = DateTime.Now
		    Var Fraction As Double = Now.Nanosecond / 1000000000
		    Var DetailedMessage As String = Now.ToString(Locale.Raw) + Fraction.ToString(Locale.Raw, ".0000000000") + " " + Now.TimeZone.Abbreviation + Encodings.UTF8.Chr(9) + Message
		    
		    // But use GMT for the filename
		    Now = New DateTime(Now.SecondsFrom1970, New TimeZone(0))
		    Var Filename As String = Now.SQLDate + ".log"
		    
		    Try
		      Var Messages() As String
		      If Self.mPendingMessages.HasKey(Filename) Then
		        Messages = Self.mPendingMessages.Value(Filename)
		      End If
		      Messages.Add(DetailedMessage)
		      Self.mPendingMessages.Value(Filename) = Messages
		      
		      Self.mFlushTimer.RunMode = Timer.RunModes.Single
		      Self.mFlushTimer.Period = 500
		    Catch Err As RuntimeException
		    End Try
		  #else
		    System.DebugLog(Message)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mFlushTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.Flush()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFlushTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingMessages As Dictionary
	#tag EndProperty


	#tag Constant, Name = SimpleDebugMode, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant


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
