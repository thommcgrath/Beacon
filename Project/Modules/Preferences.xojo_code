#tag Module
Protected Module Preferences
	#tag Method, Flags = &h1
		Protected Sub AddToRecentDocuments(URL As Beacon.DocumentURL)
		  If URL.Scheme = Beacon.DocumentURL.TypeTransient Then
		    Return
		  End If
		  
		  Dim Recents() As Beacon.DocumentURL = RecentDocuments
		  For I As Integer = Recents.Ubound DownTo 0
		    If Recents(I) = URL Then
		      Recents.Remove(I)
		    End If
		  Next
		  Recents.Insert(0, URL)
		  
		  While Recents.Ubound > 19
		    Recents.Remove(20)
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
		Protected Function LastUsedConfigName(DocumentID As Text) As Text
		  Dim Dict As Xojo.Core.Dictionary = mManager.AutoValue("Last Used Config", New Xojo.Core.Dictionary)
		  If Dict.HasKey(DocumentID) Then
		    Return Dict.Value(DocumentID)
		  Else
		    Return BeaconConfigs.LootDrops.ConfigName
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LastUsedConfigName(DocumentID As Text, Assigns ConfigName As Text)
		  Dim Dict As Xojo.Core.Dictionary = mManager.AutoValue("Last Used Config", New Xojo.Core.Dictionary)
		  Dict.Value(DocumentID) = ConfigName
		  mManager.AutoValue("Last Used Config") = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RecentDocuments() As Beacon.DocumentURL()
		  Init
		  
		  // When used with a freshly parsed file, the return type will be Auto()
		  // Once the array is updated, the local copy will return Text()
		  
		  Dim Temp As Auto = mManager.AutoValue("Documents")
		  Dim StoredData() As Text
		  If Temp <> Nil Then
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Temp)
		    If Info.Name = "Text()" Then
		      StoredData = Temp
		    ElseIf Info.Name = "Text" Then
		      StoredData.Append(Temp)
		    ElseIf Info.Name = "Auto()" Then
		      Dim Arr() As Auto = Temp
		      For Each Item As Auto In Arr
		        Try
		          StoredData.Append(Item)
		        Catch Err As TypeMismatchException
		          Continue
		        End Try
		      Next
		    End If
		  End If
		  
		  Dim Values() As Beacon.DocumentURL
		  For Each Value As Text In StoredData
		    Try
		      Values.Append(New Beacon.DocumentURL(Value))
		    Catch Err As RuntimeException
		      
		    End Try
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecentDocuments(Assigns Values() As Beacon.DocumentURL)
		  Dim URLs() As Text
		  Redim URLs(Values.Ubound)
		  For I As Integer = 0 To Values.Ubound
		    URLs(I) = Values(I).URL
		  Next
		  
		  Init
		  mManager.AutoValue("Documents") = URLs
		  NotificationKit.Post(Notification_RecentsChanged, Values)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Init
			  Return mManager.SizeValue("Entry Editor Size", New Xojo.Core.Size(900, 500))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.SizeValue("Entry Editor Size") = Value
			End Set
		#tag EndSetter
		EntryEditorSize As Xojo.Core.Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		HasShownExperimentalWarning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		HasShownSubscribeDialog As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		ItemSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		LastPresetMapFilter As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		MainWindowPosition As Xojo.Core.Rect
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mManager As PreferencesManager
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
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
		OnlineEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Init
			  Return mManager.TextValue("Online Token", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If OnlineToken = Value Then
			    Return
			  End If
			  
			  mManager.TextValue("Online Token") = Value
			  NotificationKit.Post(Notification_OnlineTokenChanged, Value)
			End Set
		#tag EndSetter
		OnlineToken As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		ShowExperimentalLootSources As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		SimulatorSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		SimulatorVisible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		SourcesSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Init
			  Return mManager.ColorValue("UI Color", BeaconUI.DefaultPrimaryColor)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.ColorValue("UI Color") = Value
			End Set
		#tag EndSetter
		UIColor As Color
	#tag EndComputedProperty


	#tag Constant, Name = Notification_OnlineStateChanged, Type = Text, Dynamic = False, Default = \"Online State Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineTokenChanged, Type = Text, Dynamic = False, Default = \"Online Token Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_RecentsChanged, Type = Text, Dynamic = False, Default = \"Recent Documents Changed", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="HasShownSubscribeDialog"
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
			Name="SourcesSplitterPosition"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OnlineEnabled"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OnlineToken"
			Group="Behavior"
			Type="Text"
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
		#tag ViewProperty
			Name="UIColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SimulatorSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SimulatorVisible"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ItemSetsSplitterPosition"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastPresetMapFilter"
			Group="Behavior"
			Type="UInt64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowExperimentalLootSources"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
