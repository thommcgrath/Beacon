#tag Window
Begin Window MiniBrowser Implements Beacon.WebView
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   600
   MinimizeButton  =   True
   MinWidth        =   800
   Placement       =   2
   Resizeable      =   False
   Title           =   "Browser"
   Visible         =   True
   Width           =   800
   Begin HTMLViewer View
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   600
      HelpTag         =   ""
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Renderer        =   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Visible         =   True
      Width           =   800
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Close()
		  // Part of the Beacon.WebView interface.
		  
		  Super.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ShowURL(URL As Text) As MiniBrowser
		  Dim Win As New MiniBrowser
		  Win.View.LoadURL(URL)
		  Return Win
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLHandler() As Beacon.URLHandler
		  Return Self.mHandler
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub URLHandler(Assigns Handler As Beacon.URLHandler)
		  Self.mHandler = Handler
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHandler As Beacon.URLHandler
	#tag EndProperty


#tag EndWindowCode

#tag Events View
	#tag Event
		Sub TitleChanged(newTitle as String)
		  Self.Title = NewTitle
		End Sub
	#tag EndEvent
	#tag Event
		Function NewWindow() As HTMLViewer
		  Dim Win As New MiniBrowser
		  Win.Left = Self.Left + 20
		  Win.Top = Self.Top + 20
		  Win.Show
		  Return Win.View
		End Function
	#tag EndEvent
	#tag Event
		Function CancelLoad(URL as String) As Boolean
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
		  
		  If Not Beacon.IsBeaconURL(URL) Then
		    Return False
		  End If
		  
		  If Self.mHandler <> Nil And Self.mHandler.Invoke(URL.ToText) Then
		    Return True
		  End If
		  
		  If App.HandleURL(URL, True) Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub DocumentBegin(URL as String)
		  #if false
		    // Cocoa can't seem to see the redirects
		    Declare Function GetMainFrame Lib "Cocoa" Selector "mainFrame" (Target As Integer) As Integer
		    Declare Function GetDataSource Lib "Cocoa" Selector "provisionalDataSource" (Target As Integer) As Integer
		    Declare Function GetRequest Lib "Cocoa" Selector "request" (Target As Integer) As Integer
		    Declare Function GetMainDocumentURL Lib "Cocoa" Selector "mainDocumentURL" (Target As Integer) As Integer
		    Declare Function GetAbsoluteURL Lib "Cocoa" Selector "absoluteString" (Target As Integer) As CFStringRef
		    
		    Dim FrameHandle As Integer = GetMainFrame(Me.Handle)
		    Dim DataSourceHandle As Integer = GetDataSource(FrameHandle)
		    Dim RequestHandle As Integer = GetRequest(DataSourceHandle)
		    Dim URLHandle As Integer = GetMainDocumentURL(RequestHandle)
		    URL = GetAbsoluteURL(URLHandle)
		    Break
		  #endif
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
