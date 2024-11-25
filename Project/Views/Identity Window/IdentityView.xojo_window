#tag DesktopWindow
Begin BeaconSubview IdentityView Implements NotificationKit.Receiver
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   460
   HelpTag         =   ""
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   500
   Begin DesktopTextArea PrivateKeyArea
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   158
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   282
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   368
   End
   Begin DesktopLabel PrivateKeyLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Private Key:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   282
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopTextArea PublicKeyArea
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   132
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   138
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   368
   End
   Begin DesktopLabel PublicKeyLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Public Key:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   138
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField UserIdField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   368
   End
   Begin UITweaks.ResizedLabel UserIdLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "User Id:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   70
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin OmniBar IdentityToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   50
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   500
   End
   Begin UITweaks.ResizedTextField DeviceIdField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   104
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   368
   End
   Begin UITweaks.ResizedLabel DeviceIdLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Device Id:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   104
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ViewTitle = "Identity"
		  Self.mIdentity = App.IdentityManager.CurrentIdentity
		  Self.UpdateUI()
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DecryptFile(SourceFile As FolderItem, DestinationFile As FolderItem, Identity As Beacon.Identity) As Boolean
		  Try
		    Var SourceContent As MemoryBlock = SourceFile.Read(Identity)
		    DestinationFile.Write(SourceContent)
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged
		    Self.mIdentity = Dictionary(Notification.UserData).Value("newIdentity")
		    Self.UpdateUI()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDecrypt()
		  Var Dialog As New OpenFileDialog
		  Dialog.AllowMultipleSelections = True
		  
		  If Dialog.ShowModal(Self.TrueWindow) Is Nil Then
		    Return
		  End If
		  
		  Var Files() As FolderItem
		  For Each File As FolderItem In Dialog.SelectedFiles
		    Files.Add(File)
		  Next File
		  
		  If Files.Count = 1 Then
		    Var Extension As String = "." + Files(0).Extension
		    Var BaseName As String = Files(0).Name.Left(Files(0).Name.Length - Extension.Length)
		    
		    Var SaveDialog As New SaveFileDialog
		    SaveDialog.SuggestedFileName = BaseName + " (Decrypted)" + Extension
		    SaveDialog.InitialFolder = Files(0).Parent
		    Var Destination As FolderItem = SaveDialog.ShowModal(Self.TrueWindow)
		    If Destination Is Nil Then
		      Return
		    End If
		    
		    If Self.DecryptFile(Files(0), Destination, App.IdentityManager.CurrentIdentity) Then
		      Self.ShowAlert(Files(0).DisplayName + " has been decrypted", "")
		    Else
		      Self.ShowAlert(Files(0).DisplayName + " could not be decrypted", "The file may have been encrypted for another identity.")
		    End If
		  Else
		    Var FolderDialog As New SelectFolderDialog
		    FolderDialog.InitialFolder = Files(0).Parent
		    FolderDialog.SuggestedFileName = "Decrypted Files"
		    Var Destination As FolderItem = FolderDialog.ShowModal(Self.TrueWindow)
		    If Destination Is Nil Then
		      Return
		    End If
		    
		    Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		    Var DecryptedCount As Integer
		    For Each InputFile As FolderItem In Files
		      Var OutputFile As FolderItem = Destination.Child(InputFile.Name)
		      If Self.DecryptFile(InputFile, OutputFile, Identity) Then
		        DecryptedCount = DecryptedCount + 1
		      End If
		    Next InputFile
		    
		    If DecryptedCount = Files.Count Then
		      Self.ShowAlert("Good news, all files were decrypted.", "")
		    ElseIf DecryptedCount = 0 Then
		      Self.ShowAlert("None of the files could be decrypted.", "They may have been encrypted for another identity.")
		    Else
		      Self.ShowAlert(Language.NounWithQuantity(DecryptedCount, "file was", "files were") + " decrypted.", "The remaining files may have been encrypted for another identity.")
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If (Self.mIdentity Is Nil) = False Then
		    Self.UserIdField.Text = Self.mIdentity.UserId
		    Self.PublicKeyArea.Text = Self.mIdentity.PublicKey
		    Self.PrivateKeyArea.Text = If(Self.mPrivateKeyVisible, Self.mIdentity.PrivateKey, "")
		  Else
		    Self.UserIdField.Text = ""
		    Self.PublicKeyArea.Text = ""
		    Self.PrivateKeyArea.Text = ""
		  End If
		  Self.DeviceIdField.Text = Beacon.HardwareId
		  
		  BeaconUI.SizeToFit(Self.UserIdLabel, Self.DeviceIdLabel, Self.PublicKeyLabel, Self.PrivateKeyLabel)
		  Var FieldsLeft As Integer = Self.UserIdLabel.Right + 12
		  Var FieldsWidth As Integer = Self.Width - (20 + FieldsLeft)
		  Var MaxFieldsWidth As Integer = 500 - (20 + FieldsLeft)
		  Self.UserIdField.Left = FieldsLeft
		  Self.DeviceIdField.Left = FieldsLeft
		  Self.PublicKeyArea.Left = FieldsLeft
		  Self.PrivateKeyArea.Left = FieldsLeft
		  Self.UserIdField.Width = Min(FieldsWidth, MaxFieldsWidth)
		  Self.DeviceIdField.Width = Min(FieldsWidth, MaxFieldsWidth)
		  Self.PublicKeyArea.Width = FieldsWidth
		  Self.PrivateKeyArea.Width = FieldsWidth
		  
		  Var PrivateKeyButton As OmniBarItem = Self.IdentityToolbar.Item("ShowPrivateKey")
		  If (PrivateKeyButton Is Nil) = False Then
		    PrivateKeyButton.Toggled = Self.mPrivateKeyVisible
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKeyVisible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShownPrivateKeyNotice As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mPrivateKeyVisible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.mPrivateKeyVisible Then
			    Return
			  End If
			  
			  If Value And Self.mShownPrivateKeyNotice = False Then
			    Value = Self.ShowConfirm("Do you really need to see your private key?", "Your private key should be kept absolutely secret. You probably don't need to see it. Are you sure you want to show your private key?", "Show My Key", "Cancel")
			    Self.mShownPrivateKeyNotice = True
			  End If
			  
			  Self.mPrivateKeyVisible = Value
			  Self.UpdateUI()
			End Set
		#tag EndSetter
		Private PrivateKeyVisible As Boolean
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events IdentityToolbar
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "ShowPrivateKey"
		    Self.PrivateKeyVisible = Not Self.PrivateKeyVisible
		  Case "DecryptFile"
		    Self.ShowDecrypt()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("DecryptFile", "Decrypt File", IconToolbarUnlock, "Decrypt a file that was encrypted with your active identity."))
		  Me.Append(OmniBarItem.CreateSpace)
		  Me.Append(OmniBarItem.CreateButton("ShowPrivateKey", "Show Private Key", IconToolbarView, "Reveal your private key."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
