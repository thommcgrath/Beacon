#tag Class
Protected Class EngramSearcherThread
Inherits Beacon.Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) )
	#tag Event
		Sub Run()
		  Dim StartTime As Double = System.Microseconds
		  Dim StartTriggered As Boolean
		  
		  Const DebugEventDelay = 1
		  
		  // First try to parse as a csv
		  If Self.mTryAsCSV Then
		    #Pragma BreakOnExceptions False
		    Try
		      Dim CarriageReturn As String = Encodings.UTF8.Chr(13)
		      
		      Dim Characters() As String = Self.mContents.Trim.ReplaceLineEndings(CarriageReturn).Split("")
		      Dim Lines() As Variant
		      Dim ColumnBuffer(), Columns() As String
		      Dim Started, InQuotes As Boolean
		      For Each Character As String In Characters
		        If Self.ShouldStop Then
		          Return
		        End If
		        If StartTriggered = False And System.Microseconds - StartTime > 1000000 Then
		          StartTriggered = True
		          Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		        End If
		        
		        If InQuotes Then
		          Started = True
		          If Character = """" Then
		            InQuotes = False
		          Else
		            ColumnBuffer.AddRow(Character)
		          End If
		        Else
		          If Character = """" Then
		            InQuotes = True
		            If Started Then
		              ColumnBuffer.AddRow(Character)
		            End If
		          ElseIf Character = "," Then
		            Columns.AddRow(ColumnBuffer.Join(""))
		            Redim ColumnBuffer(-1)
		            Started = False
		          ElseIf Character = CarriageReturn Then
		            // Next line
		            Columns.AddRow(ColumnBuffer.Join(""))
		            Lines.AddRow(Columns)
		            Redim ColumnBuffer(-1)
		            Columns = Array("") // To create a new array
		            Redim Columns(-1)
		            Started = False
		          Else
		            ColumnBuffer.AddRow(Character)
		          End If
		        End If
		      Next
		      Columns.AddRow(ColumnBuffer.Join(""))
		      Lines.AddRow(Columns)
		      
		      Dim LastPushTime As Double = System.Microseconds
		      Dim FoundSinceLastPush As Boolean
		      
		      Dim HeaderColumns() As String
		      If Lines.LastRowIndex >= 0 Then
		        HeaderColumns = Lines(0)
		        Lines.RemoveRowAt(0)
		      End If
		      Dim PathColumnIdx, LabelColumnIdx, MaskColumnIdx, BlueprintColumnIdx, TagsColumnIndx, GroupColumnIdx As Integer
		      PathColumnIdx = HeaderColumns.IndexOf("Path")
		      LabelColumnIdx = HeaderColumns.IndexOf("Label")
		      MaskColumnIdx = HeaderColumns.IndexOf("Availability Mask")
		      TagsColumnIndx = HeaderColumns.IndexOf("Tags")
		      GroupColumnIdx = HeaderColumns.IndexOf("Group")
		      BlueprintColumnIdx = HeaderColumns.IndexOf("Can Blueprint")
		      
		      Dim AllAvailabilityMask As UInt64 = Beacon.Maps.All.Mask
		      
		      If PathColumnIdx = -1 Or LabelColumnIdx = -1 Then
		        Dim Err As New UnsupportedFormatException
		        Err.Message = "CSV import requires at least Path and Label columns. Make sure the data includes a header row."
		        Raise Err
		      End If
		      
		      For Each Columns In Lines
		        If Self.ShouldStop Then
		          Return
		        End If
		        If StartTriggered = False And System.Microseconds - StartTime > 1000000 Then
		          StartTriggered = True
		          Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		        End If
		        
		        Dim Path As String = Columns(PathColumnIdx)
		        Dim Label As String = Columns(LabelColumnIdx)
		        Dim Availability As UInt64
		        Dim Tags() As String
		        If MaskColumnIdx > -1 Then
		          Availability = UInt64.FromString(Columns(MaskColumnIdx))
		        Else
		          Availability = AllAvailabilityMask
		        End If
		        If TagsColumnIndx > -1 Then
		          Tags = Columns(TagsColumnIndx).Split(",")
		        ElseIf BlueprintColumnIdx > -1 Then
		          Dim CanBlueprint As Boolean = If(Columns(BlueprintColumnIdx) = "True", True, False)
		          If CanBlueprint Then
		            Tags.AddRow("blueprintable")
		          End If
		        End If
		        
		        Dim Category As String = "engrams"
		        If GroupColumnIdx > -1 Then
		          Category = Columns(GroupColumnIdx)
		        End If
		        
		        Dim Blueprint As Beacon.MutableBlueprint
		        Select Case Category
		        Case Beacon.CategoryEngrams
		          Blueprint = New Beacon.MutableEngram(Path, New v4UUID)
		        Case Beacon.CategoryCreatures
		          Blueprint = New Beacon.MutableCreature(Path, New v4UUID)
		        Else
		          Continue
		        End Select
		        
		        Blueprint.Tags = Tags
		        Blueprint.Availability = Availability
		        Blueprint.Label = Label
		        
		        Self.mBlueprintsLock.Enter
		        If Self.ShouldStop Then
		          Return
		        End If
		        Self.mBlueprints.AddRow(Blueprint.Clone)
		        Self.mBlueprintsLock.Leave
		        FoundSinceLastPush = True
		        
		        If System.Microseconds - LastPushTime > 1000000 Then
		          Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		          LastPushTime = System.Microseconds
		          FoundSinceLastPush = False
		        End If
		      Next
		      
		      If Self.mBlueprints.LastRowIndex > -1 Then
		        Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		      End If
		      Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
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
		    
		    If StartTriggered = False And System.Microseconds - StartTime > 1000000 Then
		      StartTriggered = True
		      Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
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
		  
		  If Paths.KeyCount = 0 Then
		    Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		    Return
		  End If
		  
		  Dim Keys() As Variant = Paths.Keys
		  Dim LastPushTime As Double = System.Microseconds
		  Dim FoundSinceLastPush As Boolean
		  For Each Key As String In Keys
		    If Self.ShouldStop Then
		      Return
		    End If
		    
		    If StartTriggered = False And System.Microseconds - StartTime > 1000000 Then
		      StartTriggered = True
		      Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerStarted))
		    End If
		    
		    Dim Command As String = Paths.Value(Key)
		    Dim Path As String = Key
		    Dim Blueprint As Beacon.Blueprint
		    Select Case Command
		    Case "giveitem"
		      Blueprint = Beacon.Data.GetEngramByPath(Path)
		      If Blueprint = Nil Then
		        Blueprint = Beacon.Engram.CreateFromPath(Path)
		      End If
		    Case "spawndino"
		      Blueprint = New Beacon.MutableCreature(Path, New v4UUID)
		    End Select
		    
		    If Blueprint = Nil Then
		      Continue
		    End If
		    
		    Self.mBlueprintsLock.Enter
		    If Self.ShouldStop Then
		      Return
		    End If
		    Self.mBlueprints.AddRow(Blueprint)
		    Self.mBlueprintsLock.Leave
		    FoundSinceLastPush = True
		    
		    If System.Microseconds - LastPushTime > 1000000 Then
		      Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		      LastPushTime = System.Microseconds
		      FoundSinceLastPush = False
		    End If
		  Next
		  
		  If Self.ShouldStop Then
		    Return
		  End If
		  
		  If FoundSinceLastPush Then
		    Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFound))
		  End If
		  
		  Self.mPendingTriggers.AddRow(CallLater.Schedule(DebugEventDelay, AddressOf TriggerFinished))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Blueprints(ClearList As Boolean) As Beacon.Blueprint()
		  Dim Arr() As Beacon.Blueprint
		  Redim Arr(Self.mBlueprints.LastRowIndex)
		  
		  Self.mBlueprintsLock.Enter
		  
		  For I As Integer = 0 To Self.mBlueprints.LastRowIndex
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
		  For I As Integer = Self.mPendingTriggers.LastRowIndex DownTo 0
		    CallLater.Cancel(Self.mPendingTriggers(I))
		    Self.mPendingTriggers.RemoveRowAt(I)
		  Next
		  If Self.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.Stop
		    Do Until Self.ThreadState = Thread.ThreadStates.NotRunning
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
		  Self.Start
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="StackSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
