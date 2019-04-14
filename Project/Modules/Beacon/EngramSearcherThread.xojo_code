#tag Class
Protected Class EngramSearcherThread
Inherits Beacon.Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) )
	#tag Event
		Sub Run()
		  Dim StartTime As Double = Microseconds
		  Dim StartTriggered As Boolean
		  
		  Const DebugEventDelay = 1
		  
		  // First try to parse as a csv
		  If Self.mTryAsCSV Then
		    Try
		      Dim CarriageReturn As String = Chr(13)
		      
		      Dim Characters() As String = Split(ReplaceLineEndings(Self.mContents.Trim, CarriageReturn), "")
		      Dim Lines() As Variant
		      Dim ColumnBuffer(), Columns() As String
		      Dim Started, InQuotes As Boolean
		      For Each Character As String In Characters
		        If Self.ShouldStop Then
		          Return
		        End If
		        If StartTriggered = False And Microseconds - StartTime > 1000000 Then
		          StartTriggered = True
		          Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		        End If
		        
		        If InQuotes Then
		          Started = True
		          If Character = """" Then
		            InQuotes = False
		          Else
		            ColumnBuffer.Append(Character)
		          End If
		        Else
		          If Character = """" Then
		            InQuotes = True
		            If Started Then
		              ColumnBuffer.Append(Character)
		            End If
		          ElseIf Character = "," Then
		            Columns.Append(Join(ColumnBuffer, ""))
		            Redim ColumnBuffer(-1)
		            Started = False
		          ElseIf Character = CarriageReturn Then
		            // Next line
		            Columns.Append(Join(ColumnBuffer, ""))
		            Lines.Append(Columns)
		            Redim ColumnBuffer(-1)
		            Columns = Array("") // To create a new array
		            Redim Columns(-1)
		            Started = False
		          Else
		            ColumnBuffer.Append(Character)
		          End If
		        End If
		      Next
		      Columns.Append(Join(ColumnBuffer, ""))
		      Lines.Append(Columns)
		      
		      Dim LastPushTime As Double = Microseconds
		      Dim FoundSinceLastPush As Boolean
		      For Each Columns In Lines
		        If Self.ShouldStop Then
		          Return
		        End If
		        If StartTriggered = False And Microseconds - StartTime > 1000000 Then
		          StartTriggered = True
		          Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		        End If
		        
		        If Columns.Ubound <> 3 Then
		          Dim Err As New UnsupportedFormatException
		          Err.Message = "Incorrect number of columns"
		          Raise Err
		        End If
		        
		        If Columns(0) = "Path" And Columns(1) = "Label" And Columns(2) = "Availability Mask" And Columns(3) = "Can Blueprint" Then
		          // Header
		          Continue
		        End If
		        
		        Dim Path As String = Columns(0).ToText
		        Dim Label As String = Columns(1).ToText
		        Dim Availability As UInt64 = UInt64.FromText(Columns(2).ToText)
		        Dim CanBlueprint As Boolean = If(Columns(3) = "True", True, False)
		        
		        Dim Engram As New Beacon.MutableEngram(Path)
		        Engram.Availability = Availability
		        Engram.CanBeBlueprint = CanBlueprint
		        Engram.Label = Label
		        
		        Self.mEngramsLock.Enter
		        If Self.ShouldStop Then
		          Return
		        End If
		        Self.mEngrams.Append(New Beacon.Engram(Engram))
		        Self.mEngramsLock.Leave
		        FoundSinceLastPush = True
		        
		        If Microseconds - LastPushTime > 1000000 Then
		          Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		          LastPushTime = Microseconds
		          FoundSinceLastPush = False
		        End If
		      Next
		      
		      If Self.mEngrams.Ubound > -1 Then
		        Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		      End If
		      Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		      Return
		    Catch Err As RuntimeException
		      // Probably not a CSV
		    End Try
		  End If
		  
		  Const QuotationCharacters = "'‘’""“”"
		  
		  Dim Regex As New Regex
		  Regex.SearchPattern = "(cheat giveitem [" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|(cheat giveitem [" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|(cheat giveitem [" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "])"
		  
		  Dim Match As RegexMatch = Regex.Search(Self.mContents)
		  Dim Paths As New Dictionary
		  Do
		    If Self.ShouldStop Then
		      Return
		    End If
		    If Match = Nil Then
		      Continue
		    End If
		    
		    If StartTriggered = False And Microseconds - StartTime > 1000000 Then
		      StartTriggered = True
		      Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		    End If
		    
		    Dim Path As String
		    If Match.SubExpressionString(2) <> "" Then
		      Path = Match.SubExpressionString(2)
		    ElseIf Match.SubExpressionString(4) <> "" Then
		      Path = Match.SubExpressionString(4)
		    ElseIf Match.SubExpressionString(6) <> "" Then
		      Path = Match.SubExpressionString(6)
		    Else
		      Continue
		    End If
		    
		    Paths.Value(Path) = True
		    
		    Match = Regex.Search
		  Loop Until Match Is Nil
		  
		  If Self.ShouldStop Then
		    Return
		  End If
		  
		  If Paths.Count = 0 Then
		    Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		    Return
		  End If
		  
		  Dim Keys() As Variant = Paths.Keys
		  Dim LastPushTime As Double = Microseconds
		  Dim FoundSinceLastPush As Boolean
		  For Each Key As String In Keys
		    If Self.ShouldStop Then
		      Return
		    End If
		    
		    If StartTriggered = False And Microseconds - StartTime > 1000000 Then
		      StartTriggered = True
		      Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		    End If
		    
		    Dim Path As String = Key.ToText
		    Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateUnknownEngram(Path)
		    End If
		    
		    Self.mEngramsLock.Enter
		    If Self.ShouldStop Then
		      Return
		    End If
		    Self.mEngrams.Append(Engram)
		    Self.mEngramsLock.Leave
		    FoundSinceLastPush = True
		    
		    If Microseconds - LastPushTime > 1000000 Then
		      Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		      LastPushTime = Microseconds
		      FoundSinceLastPush = False
		    End If
		  Next
		  
		  If Self.ShouldStop Then
		    Return
		  End If
		  
		  If FoundSinceLastPush Then
		    Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		  End If
		  
		  Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  For I As Integer = Self.mPendingTriggers.Ubound DownTo 0
		    CallLater.Cancel(Self.mPendingTriggers(I))
		    Self.mPendingTriggers.Remove(I)
		  Next
		  If Self.State <> Thread.NotRunning Then
		    Self.Stop
		    Do Until Self.State = Thread.NotRunning
		      App.YieldToNextThread()
		    Loop
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramsLock = New CriticalSection
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.Cancel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams(ClearList As Boolean) As Beacon.Engram()
		  Dim Arr() As Beacon.Engram
		  Redim Arr(Self.mEngrams.Ubound)
		  
		  Self.mEngramsLock.Enter
		  
		  For I As Integer = 0 To Self.mEngrams.Ubound
		    Arr(I) = New Beacon.Engram(Self.mEngrams(I))
		  Next
		  
		  If ClearList Then
		    Redim Self.mEngrams(-1)
		  End If
		  
		  Self.mEngramsLock.Leave
		  
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Search(Content As String, TryCSV As Boolean = True)
		  Self.Cancel
		  Self.mContents = Content
		  Self.mTryAsCSV = TryCSV
		  Self.mEngramsLock.Enter
		  Redim Self.mEngrams(-1)
		  Self.mEngramsLock.Leave
		  Self.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFinished()
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFound()
		  RaiseEvent EngramsFound
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerStarted()
		  RaiseEvent Started
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EngramsFound()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mContents As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngrams() As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Private mEngramsLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingTriggers() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTryAsCSV As Boolean
	#tag EndProperty


	#tag ViewBehavior
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
			Name="StackSize"
			Group="Behavior"
			Type="Integer"
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
