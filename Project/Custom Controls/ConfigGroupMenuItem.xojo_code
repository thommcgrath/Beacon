#tag Class
Protected Class ConfigGroupMenuItem
Inherits MenuItem
	#tag Event
		Function Action() As Boolean
		  If RaiseEvent Action = True Then
		    Return True
		  End If
		  
		  Var View As BeaconSubview = MainWindow.CurrentView
		  If View = Nil Then
		    Return False
		  End If
		  
		  If Not (View IsA DocumentEditorView) Then
		    Return False
		  End If
		  
		  DocumentEditorView(View).CurrentConfigName = Self.Tag.StringValue
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenu()
		  Self.HasCheckMark = False
		  
		  If IsEventImplemented("EnableMenu") Then
		    Return
		  End If
		  
		  Var View As BeaconSubview = MainWindow.CurrentView
		  If View = Nil Or (View IsA DocumentEditorView) = False Then
		    Return
		  End If
		  
		  If DocumentEditorView(View).CurrentConfigName = Self.Tag.StringValue Then
		    Self.HasCheckMark = True
		  End If
		  
		  Self.Enable
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(ConfigName As String)
		  Var Label As String = Language.LabelForConfig(ConfigName)
		  Super.Constructor(Label, ConfigName)
		  Self.AutoEnabled = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenu()
	#tag EndHook


End Class
#tag EndClass
