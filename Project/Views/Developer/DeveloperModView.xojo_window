#tag Window
Begin ContainerControl DeveloperModView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   564
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   419
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   2
      Visible         =   True
      Width           =   564
      Begin UITweaks.ResizedTextField ConfirmField
         AcceptTabs      =   False
         Alignment       =   2
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   380
      End
      Begin UITweaks.ResizedPushButton CopyButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Copy To Clipboard"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   131
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label ConfirmExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   86
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         Text            =   "You have not yet confirmed ownership of this mod. To so do, please copy the value below and insert it anywhere on the mod's Steam page. Then press the ""Confirm Ownership"" button below. Once confirmed, the text can be removed from your Steam page."
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   101
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   380
      End
      Begin UITweaks.ResizedPushButton ConfirmButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Confirm Ownership"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   288
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label NoSelectionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         Text            =   "No Mod Selected"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   524
      End
      Begin ProgressBar LoadingIndicator
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   112
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         Top             =   199
         Value           =   0
         Visible         =   True
         Width           =   340
      End
   End
   Begin APISocket Socket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_ConfirmMod(Success As Boolean, Message As Text, Details As Auto)
		  If Success Then
		    Panel.Value = PageEngrams
		    Self.ShowAlert("Mod ownership confirmed.", "You may now remove the confirmation code from your Steam page.")
		  Else
		    Panel.Value = PageNeedsConfirmation
		    Self.ShowAlert("Mod ownership has not been confirmed", Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ModLoad(Success As Boolean, Message As Text, Details As Auto)
		  If Not Success Then
		    Self.SetModID("")
		    Self.ShowAlert("Unable to load mod", Message)
		    Return
		  End If
		  
		  Self.ModData = Details
		  Dim Confirmed As Boolean = Self.ModData.Value("confirmed")
		  If Not Confirmed Then
		    Dim Code As Text = Self.ModData.Value("confirmation_code")
		    ConfirmField.Text = Code
		    Panel.Value = PageNeedsConfirmation
		    Return
		  End If
		  
		  // Load engrams
		  
		  Panel.Value = PageEngrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  ConfirmField.Left = Panel.Left + ((Panel.Width - ConfirmField.Width) / 2)
		  ConfirmExplanation.Left = ConfirmField.Left
		  CopyButton.Left = Panel.Left + ((Panel.Width - (CopyButton.Width + 12 + ConfirmButton.Width)) / 2)
		  ConfirmButton.Left = CopyButton.Left + CopyButton.Width + 12
		  
		  ConfirmField.Top = Panel.Top + ((Panel.Height - ConfirmField.Height) / 2)
		  ConfirmExplanation.Top = ConfirmField.Top - (12 + ConfirmExplanation.Height)
		  CopyButton.Top = ConfirmField.Top + ConfirmField.Height + 12
		  ConfirmButton.Top = CopyButton.Top
		  
		  NoSelectionLabel.Top = Panel.Top + ((Panel.Height - NoSelectionLabel.Height) / 2)
		  
		  LoadingIndicator.Top = Panel.Top + ((Panel.Height - LoadingIndicator.Height) / 2)
		  LoadingIndicator.Left = Panel.Left + ((Panel.Width - LoadingIndicator.Width) / 2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RestoreCopyButton()
		  CopyButton.Caption = "Copy To Clipboard"
		  CopyButton.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetModID(ModID As Text)
		  Xojo.Core.Timer.CancelCall(AddressOf RestoreCopyButton)
		  Self.RestoreCopyButton()
		  
		  If ModID = "" Then
		    Panel.Value = Self.PageNoSelection
		    Self.ModID = ""
		    Return
		  End If
		  
		  Panel.Value = Self.PageLoading
		  Self.ModID = ModID
		  
		  Dim Request As New APIRequest("mod.php/" + ModID, "GET", AddressOf APICallback_ModLoad)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ModData As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ModID As Text
	#tag EndProperty


	#tag Constant, Name = PageEngrams, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLoading, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNeedsConfirmation, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CopyButton
	#tag Event
		Sub Action()
		  Dim C As New Clipboard
		  C.Text = ConfirmField.Text
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		  Xojo.Core.Timer.CallLater(3000, AddressOf RestoreCopyButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmButton
	#tag Event
		Sub Action()
		  Panel.Value = PageLoading
		  
		  Dim ConfirmURL As Text = Self.ModData.Value("confirm_url")
		  Dim Request As New APIRequest(ConfirmURL, "GET", AddressOf APICallback_ConfirmMod)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
