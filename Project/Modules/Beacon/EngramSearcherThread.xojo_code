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
		    #Pragma BreakOnExceptions False
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
		          Err.Reason = "Incorrect number of columns"
		          Raise Err
		        End If
		        
		        If Columns(0) = "Path" And Columns(1) = "Label" And Columns(2) = "Availability Mask" And Columns(3) = "Can Blueprint" Then
		          // Header
		          Continue
		        End If
		        
		        Dim Path As Text = Columns(0).ToText
		        Dim Label As Text = Columns(1).ToText
		        Dim Availability As UInt64 = UInt64.FromText(Columns(2).ToText)
		        Dim CanBlueprint As Boolean = If(Columns(3) = "True", True, False)
		        
		        Dim Engram As New Beacon.MutableEngram(Path, Beacon.CreateUUID)
		        Engram.Availability = Availability
		        If CanBlueprint Then
		          Engram.AddTag("blueprintable")
		        Else
		          Engram.RemoveTag("blueprintable")
		        End If
		        Engram.Label = Label
		        
		        Self.mBlueprintsLock.Enter
		        If Self.ShouldStop Then
		          Return
		        End If
		        Self.mBlueprints.Append(New Beacon.Engram(Engram))
		        Self.mBlueprintsLock.Leave
		        FoundSinceLastPush = True
		        
		        If Microseconds - LastPushTime > 1000000 Then
		          Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		          LastPushTime = Microseconds
		          FoundSinceLastPush = False
		        End If
		      Next
		      
		      If Self.mBlueprints.Ubound > -1 Then
		        Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		      End If
		      Self.mPendingTriggers.Append(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		      Return
		    Catch Err As RuntimeException
		      // Probably not a CSV
		    End Try
		    #Pragma BreakOnExceptions Default
		  End If
		  
		  Const QuotationCharacters = "'‘’""“”"
		  
		  Dim Regex As New Regex
		  Regex.Options.CaseSensitive = False
		  Regex.SearchPattern = "(giveitem|spawndino)\s+([" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "])"
		  
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
		    
		    Dim Command As String = Match.SubExpressionString(1)
		    Dim Path As String
		    If Match.SubExpressionCount >= 3 And Match.SubExpressionString(3) <> "" Then
		      Path = Match.SubExpressionString(3)
		    ElseIf Match.SubExpressionCount >= 5 And Match.SubExpressionString(5) <> "" Then
		      Path = Match.SubExpressionString(5)
		    ElseIf Match.SubExpressionCount >= 7 And Match.SubExpressionString(7) <> "" Then
		      Path = Match.SubExpressionString(7)
		    End If
		    If Path <> "" Then
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      Paths.Value(Path) = Command
		    End If
		    
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
		    
		    Dim Command As String = Paths.Value(Key)
		    Dim Path As Text = Key.ToText
		    Dim Blueprint As Beacon.Blueprint
		    Select Case Command
		    Case "giveitem"
		      Blueprint = Beacon.Data.GetEngramByPath(Path)
		      If Blueprint = Nil Then
		        Blueprint = Beacon.Engram.CreateUnknownEngram(Path)
		      End If
		    Case "spawndino"
		      Blueprint = New Beacon.MutableCreature(Path, Beacon.CreateUUID)
		    End Select
		    
		    If Blueprint = Nil Then
		      Continue
		    End If
		    
		    Self.mBlueprintsLock.Enter
		    If Self.ShouldStop Then
		      Return
		    End If
		    Self.mBlueprints.Append(Blueprint)
		    Self.mBlueprintsLock.Leave
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
		Function Blueprints(ClearList As Boolean) As Beacon.Blueprint()
		  Dim Arr() As Beacon.Blueprint
		  Redim Arr(Self.mBlueprints.Ubound)
		  
		  Self.mBlueprintsLock.Enter
		  
		  For I As Integer = 0 To Self.mBlueprints.Ubound
		    Arr(I) = Self.mBlueprints(I).Clone
		  Next
		  
		  If ClearList Then
		    Redim Self.mBlueprints(-1)
		  End If
		  
		  Self.mBlueprintsLock.Leave
		  
		  Return Arr
		End Function
	#tag EndMethod

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
		  Self.mBlueprintsLock = New CriticalSection
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.Cancel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Search(Content As String, TryCSV As Boolean = True)
		  Self.Cancel
		  Self.mContents = Content
		  Self.mTryAsCSV = TryCSV
		  Self.mBlueprintsLock.Enter
		  Redim Self.mBlueprints(-1)
		  Self.mBlueprintsLock.Leave
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
		Private mBlueprints() As Beacon.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Private mBlueprintsLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContents As String
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
