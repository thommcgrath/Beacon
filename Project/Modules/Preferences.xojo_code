#tag Module
Protected Module Preferences
	#tag Method, Flags = &h1
		Protected Sub AddToRecentDocuments(URL As Beacon.DocumentURL)
		  If URL.Scheme = Beacon.DocumentURL.TypeTransient Then
		    Return
		  End If
		  
		  Var Recents() As Beacon.DocumentURL = RecentDocuments
		  For I As Integer = Recents.LastRowIndex DownTo 0
		    If Recents(I) = URL Then
		      Recents.RemoveRowAt(I)
		    End If
		  Next
		  Recents.AddRowAt(0, URL)
		  
		  While Recents.LastRowIndex > 19
		    Recents.RemoveRowAt(20)
		  Wend
		  
		  RecentDocuments = Recents
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Init()
		  If mManager = Nil Then
		    mManager = New PreferencesManager(App.ApplicationSupport.Child("Preferences.json"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LastUsedConfigName(DocumentID As String) As String
		  Var Dict As Dictionary = mManager.DictionaryValue("Last Used Config", New Dictionary)
		  If Dict.HasKey(DocumentID) Then
		    Return Dict.Value(DocumentID)
		  Else
		    Return BeaconConfigs.LootDrops.ConfigName
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LastUsedConfigName(DocumentID As String, Assigns ConfigName As String)
		  Var Dict As Dictionary = mManager.DictionaryValue("Last Used Config", New Dictionary)
		  Dict.Value(DocumentID) = ConfigName
		  mManager.DictionaryValue("Last Used Config") = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadWindowPosition(Extends Win As Window)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Win)
		  
		  Init
		  
		  Var Bounds As Rect = mManager.RectValue(Info.Name + " Position")
		  If Bounds <> Nil Then
		    // Find the best screen
		    Var IdealScreen As Screen = Screen(0)
		    If ScreenCount > 1 Then
		      Var MaxArea As Integer
		      For I As Integer = 0 To ScreenCount - 1
		        Var ScreenBounds As New Rect(Screen(I).AvailableLeft, Screen(I).AvailableTop, Screen(I).AvailableWidth, Screen(I).AvailableHeight)
		        Var Intersection As Rect = ScreenBounds.Intersection(Bounds)
		        If Intersection = Nil Then
		          Continue
		        End If
		        Var Area As Integer = Intersection.Width * Intersection.Height
		        If Area <= 0 Then
		          Continue
		        End If
		        If Area > MaxArea Then
		          MaxArea = Area
		          IdealScreen = Screen(I)
		        End If
		      Next
		    End If
		    
		    Var AvailableBounds As New Rect(IdealScreen.AvailableLeft, IdealScreen.AvailableTop, IdealScreen.AvailableWidth, IdealScreen.AvailableHeight)
		    
		    Var Width As Integer = Min(Max(Bounds.Width, Win.MinimumWidth), Win.MaximumWidth, AvailableBounds.Width)
		    Var Height As Integer = Min(Max(Bounds.Height, Win.MinimumHeight), Win.MaximumHeight, AvailableBounds.Height)
		    Var Left As Integer = Min(Max(Bounds.Left, AvailableBounds.Left), AvailableBounds.Right - Width)
		    Var Top As Integer = Min(Max(Bounds.Top, AvailableBounds.Top), AvailableBounds.Bottom - Height)
		    Win.Bounds = New Rect(Left, Top, Width, Height)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RecentDocuments() As Beacon.DocumentURL()
		  Init
		  
		  // When used with a freshly parsed file, the return type will be Auto()
		  // Once the array is updated, the local copy will return Text()
		  
		  Var Temp As Variant = mManager.VariantValue("Documents")
		  Var StoredData() As String
		  If Temp <> Nil Then
		    If Temp.IsArray Then
		      Select Case Temp.ArrayElementType
		      Case Variant.TypeString
		        StoredData = Temp
		      Case Variant.TypeObject
		        Var Objects() As Variant = Temp
		        For Each Element As Variant In Objects
		          Try
		            StoredData.AddRow(Element.StringValue)
		          Catch Err As RuntimeException
		            Continue
		          End Try
		        Next
		      End Select
		    Else
		      Try
		        StoredData.AddRow(Temp.StringValue)
		      Catch Err As RuntimeException
		      End Try
		    End If
		  End If
		  
		  Var Values() As Beacon.DocumentURL
		  For Each Value As String In StoredData
		    Try
		      Values.AddRow(New Beacon.DocumentURL(Value))
		    Catch Err As RuntimeException
		      
		    End Try
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecentDocuments(Assigns Values() As Beacon.DocumentURL)
		  Var URLs() As String
		  URLs.ResizeTo(Values.LastRowIndex)
		  For I As Integer = 0 To Values.LastRowIndex
		    URLs(I) = Values(I).URL
		  Next
		  
		  Init
		  mManager.VariantValue("Documents") = URLs
		  NotificationKit.Post(Notification_RecentsChanged, Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveWindowPosition(Extends Win As Window)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Win)
		  
		  Init
		  mManager.RectValue(Info.Name + " Position") = Win.Bounds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTag(Category As String, Subgroup As String) As String
		  Var Key As String = "Selected " + Category.TitleCase
		  If Subgroup <> "" Then
		    Key = Key + "." + Subgroup.TitleCase
		  End If
		  Key = Key + " Tag"
		  
		  Var Default As String
		  
		  Select Case Category
		  Case Beacon.CategoryEngrams
		    Select Case Subgroup
		    Case "Harvesting"
		      Default = "(""object"" AND ""harvestable"") NOT (""deprecated"" OR ""cheat"")"
		    Case "Crafting"
		      Default = "(""object"") NOT (""deprecated"" OR ""cheat"")"
		    Case "Resources"
		      Default = "(""object"" AND ""resource"") NOT (""deprecated"" OR ""cheat"")"
		    Else
		      Default = "(""object"") NOT (""deprecated"" OR ""cheat"" OR ""event"" OR ""reward"" OR ""generic"" OR ""blueprint"")"
		    End Select
		  Case Beacon.CategoryCreatures
		    Default = "(""object"") NOT (""minion"" OR ""boss"" OR ""event"" OR ""generic"")"
		  End Select
		  
		  Init
		  Return mManager.StringValue(Key, Default)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SelectedTag(Category As String, Subgroup As String, Assigns Value As String)
		  Var Key As String = "Selected " + Category.TitleCase
		  If Subgroup <> "" Then
		    Key = Key + "." + Subgroup.TitleCase
		  End If
		  Key = Key + " Tag"
		  
		  mManager.StringValue(Key) = Value
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Breeding Tuner Creatures", "*")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If BreedingTunerCreatures = Value Then
			    Return
			  End If
			  
			  mManager.StringValue("Breeding Tuner Creatures") = Value
			End Set
		#tag EndSetter
		Protected BreedingTunerCreatures As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Crafting Costs Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Crafting Costs Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected CraftingSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Create Backup", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Create Backup") = Value
			End Set
		#tag EndSetter
		Protected DeployCreateBackup As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Review Changes", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Review Changes") = Value
			End Set
		#tag EndSetter
		Protected DeployReviewChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Run Advisor", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Run Advisor") = Value
			End Set
		#tag EndSetter
		Protected DeployRunAdvisor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.SizeValue("Entry Editor Size", New Size(900, 500))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.SizeValue("Entry Editor Size") = Value
			End Set
		#tag EndSetter
		Protected EntryEditorSize As Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Has Shown Experimental Warning", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Has Shown Experimental Warning") = Value
			End Set
		#tag EndSetter
		Protected HasShownExperimentalWarning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Has Shown Subscribe Dialog", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Has Shown Subscribe Dialog") = Value
			End Set
		#tag EndSetter
		Protected HasShownSubscribeDialog As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Item Sets Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Item Sets Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ItemSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Last Preset Map Filter", Beacon.Maps.All.Mask)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Last Preset Map Filter") = Value
			End Set
		#tag EndSetter
		Protected LastPresetMapFilter As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Last Stop Message", "Server is now stopping for a few minutes for changes.")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.StringValue("Last Stop Message") = Value
			End Set
		#tag EndSetter
		Protected LastStopMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.RectValue("Main Window Size", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.RectValue("Main Window Size") = Value
			End Set
		#tag EndSetter
		Protected MainWindowPosition As Rect
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mManager As PreferencesManager
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Online Enabled", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = OnlineEnabled Then
			    Return
			  End If
			  
			  mManager.BooleanValue("Online Enabled") = Value
			  NotificationKit.Post(Notification_OnlineStateChanged, Value)
			End Set
		#tag EndSetter
		Protected OnlineEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Online Token", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If OnlineToken = Value Then
			    Return
			  End If
			  
			  mManager.StringValue("Online Token") = Value
			  NotificationKit.Post(Notification_OnlineTokenChanged, Value)
			End Set
		#tag EndSetter
		Protected OnlineToken As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Show Experimental Sources", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If ShowExperimentalLootSources = Value Then
			    Return
			  End If
			  
			  mManager.BooleanValue("Show Experimental Sources") = Value
			End Set
		#tag EndSetter
		Protected ShowExperimentalLootSources As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Simulator Size", 200)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Simulator Size") = Value
			End Set
		#tag EndSetter
		Protected SimulatorSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Simulator Visible")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Simulator Visible") = Value
			End Set
		#tag EndSetter
		Protected SimulatorVisible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Sources Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Sources Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SourcesSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Point Editor Limits Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Point Editor Limits Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SpawnPointEditorLimitsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Point Editor Sets Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Point Editor Sets Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SpawnPointEditorSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Points Splitter Position", 250)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Points Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SpawnPointsSplitterPosition As Integer
	#tag EndComputedProperty


	#tag Constant, Name = Notification_OnlineStateChanged, Type = Text, Dynamic = False, Default = \"Online State Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineTokenChanged, Type = Text, Dynamic = False, Default = \"Online Token Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_RecentsChanged, Type = Text, Dynamic = False, Default = \"Recent Documents Changed", Scope = Protected
	#tag EndConstant


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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
End Module
#tag EndModule
