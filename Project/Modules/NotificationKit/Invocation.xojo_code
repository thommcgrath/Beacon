#tag Class
Private Class Invocation
	#tag Method, Flags = &h0
		Sub Constructor(Notification As NotificationKit.Notification, Receiver As NotificationKit.Receiver)
		  Self.mNotification = Notification
		  Self.mReceiver = Xojo.Core.WeakRef.Create(Receiver)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invoke()
		  If Self.mReceiver.Value <> Nil Then
		    Dim Receiver As NotificationKit.Receiver = NotificationKit.Receiver(Self.mReceiver.Value)
		    Receiver.NotificationKit_NotificationReceived(Self.mNotification)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mNotification As NotificationKit.Notification
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReceiver As Xojo.Core.WeakRef
	#tag EndProperty


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
End Class
#tag EndClass
