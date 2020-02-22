#tag Class
Protected Class LocalDeploymentEngine
Inherits Beacon.TaskQueue
Implements Beacon.DeploymentEngine
	#tag Event
		Sub Finished()
		  Self.ClearTasks()
		  Self.mFinished = True
		  Self.mErrored = False
		  Self.mStatus = "Finished"
		  RaiseEvent Finished()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function BackupGameIni() As String
		  Return Self.mGameIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupGameUserSettingsIni() As String
		  Return Self.mGameUserSettingsIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(Label As String, Document As Beacon.Document, Identity As Beacon.Identity, StopMessage As String)
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  #Pragma Unused Label
		  #Pragma Unused StopMessage
		  
		  Self.mDocument = Document
		  Self.mIdentity = Identity
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.LocalServerProfile)
		  Self.mProfile = Profile
		  
		  Self.mGameIniRewriter = New Beacon.Rewriter
		  AddHandler mGameIniRewriter.Finished, WeakAddressOf mGameIniRewriter_Finished
		  
		  Self.mGameUserSettingsIniRewriter = New Beacon.Rewriter
		  AddHandler mGameUserSettingsIniRewriter.Finished, WeakAddressOf mGameUserSettingsIniRewriter_Finished
		  
		  Self.AppendTask(AddressOf ReadGameIni, AddressOf ReadGameUserSettingsIni, AddressOf GenerateGameIni, AddressOf GenerateGameUserSettingsIni, AddressOf WriteGameIni, AddressOf WriteGameUserSettingsIni)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GenerateGameIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Generating Game.ini…"
		  Self.mGameIniRewriter.Rewrite(Self.mGameIniOriginal, Beacon.RewriteModeGameIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GenerateGameUserSettingsIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Generating GameUserSettings.ini…"
		  Self.mGameUserSettingsIniRewriter.Rewrite(Self.mGameUserSettingsIniOriginal, Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  If Sender.Errored Then
		    Self.mErrored = True
		    Self.mStatus = "Error generating Game.ini"
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.mGameIniRewritten = Sender.UpdatedContent
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameUserSettingsIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  If Sender.Errored Then
		    Self.mErrored = True
		    Self.mStatus = "Error generating GameUserSettings.ini"
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.mGameUserSettingsIniRewritten = Sender.UpdatedContent
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadGameIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Loading Game.ini…"
		  
		  If Self.mProfile.GameIniFile = Nil Then
		    Self.mStatus = "Game.ini file not specified"
		    Self.mErrored = True
		    Self.mFinished = True
		    Return
		  End If
		  
		  If Self.mProfile.GameIniFile.Exists Then
		    Self.mGameIniOriginal = Self.mProfile.GameIniFile.Read
		  End If
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadGameUserSettingsIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Loading GameUserSettings.ini…"
		  
		  If Self.mProfile.GameUserSettingsIniFile = Nil Then
		    Self.mStatus = "GameUserSettings.ini file not specified"
		    Self.mErrored = True
		    Self.mFinished = True
		    Return
		  End If
		  
		  If Self.mProfile.GameUserSettingsIniFile.Exists Then
		    Self.mGameUserSettingsIniOriginal = Self.mProfile.GameUserSettingsIniFile.Read
		  End If
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteGameIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Writing Game.ini…"
		  
		  If Not Self.mProfile.GameIniFile.Write(Self.mGameIniRewritten) Then
		    Self.mStatus = "Unable to write to " + Self.mProfile.GameIniFile.NativePath
		    Self.mErrored = True
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteGameUserSettingsIni()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mStatus = "Writing GameUserSettings.ini…"
		  
		  If Not Self.mProfile.GameUserSettingsIniFile.Write(Self.mGameUserSettingsIniRewritten) Then
		    Self.mStatus = "Unable to write to " + Self.mProfile.GameUserSettingsIniFile.NativePath
		    Self.mErrored = True
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.LocalServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
End Class
#tag EndClass
