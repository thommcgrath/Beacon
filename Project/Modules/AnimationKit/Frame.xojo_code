#tag Class
Protected Class Frame
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS)
		Sub Constructor(Image As iOSImage, RetinaImage As iOSImage)
		  If Image = Nil Then
		    Dim Err As New UnsupportedOperationException
		    Err.Reason = "Cannot create a frame without an image."
		    Raise Err
		  End If
		  
		  If RetinaImage <> Nil Then
		    If RetinaImage.Width <> Image.Width * 2 Or RetinaImage.Height <> Image.Height * 2 Then
		      Dim Err As New UnsupportedOperationException
		      Err.Reason = "Retina image must be exactly twice the dimensions of the standard image."
		      Raise Err
		    End If
		  End If
		  
		  Self.Constructor()
		  Self.PrivateImage = Image
		  Self.PrivateRetinaImage = RetinaImage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Image As Picture, RetinaImage As Picture)
		  If Image = Nil Then
		    Dim Err As New UnsupportedOperationException
		    Err.Reason = "Cannot create a frame without an image."
		    Raise Err
		  End If
		  
		  If RetinaImage <> Nil Then
		    If RetinaImage.Width <> Image.Width * 2 Or RetinaImage.Height <> Image.Height * 2 Then
		      Dim Err As New UnsupportedOperationException
		      Err.Reason = "Retina image must be exactly twice the dimensions of the standard image."
		      Raise Err
		    End If
		  End If
		  
		  Self.Constructor()
		  Self.PrivateImage = Image
		  Self.PrivateRetinaImage = RetinaImage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Dimensions() As Xojo.Core.Size
		  Return New Xojo.Core.Size(Self.Image.Width, Self.Image.Height)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, CompatibilityFlags = (TargetIOS)
		#tag Getter
			Get
			  Return Self.PrivateImage
			End Get
		#tag EndGetter
		Image As iOSImage
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		#tag Getter
			Get
			  Return Self.PrivateImage
			End Get
		#tag EndGetter
		Image As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS)
		Private PrivateImage As iOSImage
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Private PrivateImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS)
		Private PrivateRetinaImage As iOSImage
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Private PrivateRetinaImage As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, CompatibilityFlags = (TargetIOS)
		#tag Getter
			Get
			  Return Self.PrivateRetinaImage
			End Get
		#tag EndGetter
		RetinaImage As iOSImage
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		#tag Getter
			Get
			  Return Self.PrivateRetinaImage
			End Get
		#tag EndGetter
		RetinaImage As Picture
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Image"
			Group="Behavior"
			Type="iOSImage"
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
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RetinaImage"
			Group="Behavior"
			Type="iOSImage"
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
End Class
#tag EndClass
