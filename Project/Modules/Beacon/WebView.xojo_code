#tag Interface
Protected Interface WebView
	#tag Method, Flags = &h0
		Sub Close()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLHandler() As Beacon.URLHandler
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub URLHandler(Assigns Handler As Beacon.URLHandler)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
