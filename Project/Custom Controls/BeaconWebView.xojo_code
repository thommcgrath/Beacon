#tag Class
Protected Class BeaconWebView
Inherits HTMLViewer
	#tag Event
		Function CancelLoad(URL as String) As Boolean
		  Self.FixURL(URL)
		  Self.mCurrentURL = URL
		  Return RaiseEvent CancelLoad(URL)
		End Function
	#tag EndEvent

	#tag Event
		Sub DocumentBegin(URL as String)
		  Self.FixURL(URL)
		  Self.mCurrentURL = URL
		  RaiseEvent DocumentBegin(URL)
		End Sub
	#tag EndEvent

	#tag Event
		Sub DocumentComplete(URL as String)
		  Self.FixURL(URL)
		  Self.mCurrentURL = URL
		  RaiseEvent DocumentComplete(URL)
		End Sub
	#tag EndEvent

	#tag Event
		Sub DocumentProgressChanged(URL as String, percentageComplete as Integer)
		  Self.FixURL(URL)
		  Self.mCurrentURL = URL
		  RaiseEvent DocumentProgressChanged(URL, PercentageComplete)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CurrentURL() As String
		  Return Self.mCurrentURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FixURL(ByRef URL As String)
		  #if TargetCocoa
		    // Bug on Mac means it can't see the redirects
		    Declare Function GetMainFrame Lib "Cocoa" Selector "mainFrame" (Target As Integer) As Integer
		    Declare Function GetDataSource Lib "Cocoa" Selector "provisionalDataSource" (Target As Integer) As Integer
		    Declare Function GetRequest Lib "Cocoa" Selector "request" (Target As Integer) As Integer
		    Declare Function GetMainDocumentURL Lib "Cocoa" Selector "mainDocumentURL" (Target As Integer) As Integer
		    Declare Function GetAbsoluteURL Lib "Cocoa" Selector "absoluteString" (Target As Integer) As CFStringRef
		    
		    Dim FrameHandle As Integer = GetMainFrame(Me.Handle)
		    If FrameHandle <> 0 Then
		      Dim DataSourceHandle As Integer = GetDataSource(FrameHandle)
		      If DataSourceHandle <> 0 Then
		        Dim RequestHandle As Integer = GetRequest(DataSourceHandle)
		        If RequestHandle <> 0 Then
		          Dim URLHandle As Integer = GetMainDocumentURL(RequestHandle)
		          If URLHandle <> 0 Then
		            URL = GetAbsoluteURL(URLHandle)
		          End If
		        End If
		      End If
		    End If
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CancelLoad(URL as String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentBegin(URL as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentComplete(URL as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentProgressChanged(URL as String, percentageComplete as Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentURL As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Renderer"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Native"
				"1 - WebKit"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
