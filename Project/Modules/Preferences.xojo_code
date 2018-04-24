#tag Module
Protected Module Preferences
	#tag Method, Flags = &h21
		Private Sub Init()
		  If mManager = Nil Then
		    mManager = New PreferencesManager(App.ApplicationSupport.Child("Preferences.json"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RecentDocuments() As Text()
		  Init
		  
		  Dim StoredData() As Auto
		  StoredData = mManager.AutoValue("Documents", StoredData)
		  
		  Dim Values() As Text
		  For Each Value As Text In StoredData
		    Values.Append(Value)
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecentDocuments(Assigns Values() As Text)
		  Init
		  mManager.AutoValue("Documents") = Values
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
			  Return mManager.IntegerValue("Main Splitter Position", 300)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Main Splitter Position") = Value
			End Set
		#tag EndSetter
		MainSplitterPosition As Integer
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
			  Init
			  mManager.BooleanValue("Online Enabled") = Value
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
			  Init
			  mManager.TextValue("Online Token") = Value
			End Set
		#tag EndSetter
		OnlineToken As Text
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


	#tag ViewBehavior
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
End Module
#tag EndModule
