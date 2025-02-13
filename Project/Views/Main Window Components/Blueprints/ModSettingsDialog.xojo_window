#tag DesktopWindow
Begin DesktopWindow ModSettingsDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   160
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   160
   MaximumWidth    =   32000
   MenuBar         =   1233248255
   MenuBarVisible  =   False
   MinimumHeight   =   160
   MinimumWidth    =   500
   Resizeable      =   True
   Title           =   "#CaptionModSettings"
   Type            =   8
   Visible         =   True
   Width           =   500
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#CaptionModSettings"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   460
   End
   Begin UITweaks.ResizedTextField NameField
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
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   348
   End
   Begin UITweaks.ResizedTextField IdField
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
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   160
   End
   Begin UITweaks.ResizedLabel NameLabel
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
      Text            =   "#CaptionModName"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedLabel IdLabel
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#CaptionModId"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   86
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Language.CommonOK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   400
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "#Language.CommonCancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   308
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Beacon.Thread EditThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   ""
      Type            =   ""
   End
   Begin DesktopProgressWheel Spinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  BeaconUI.SizeToFit(Self.NameLabel, Self.IdLabel)
		  
		  Self.NameField.Left = Self.NameLabel.Right + 12
		  Self.NameField.Width = Self.Width - (Self.NameField.Left + 20)
		  Self.IdField.Left = Self.NameField.Left
		  
		  Self.NameField.Text = Self.mPack.Name
		  Self.IdField.Text = Self.mPack.MarketplaceId
		  
		  If Self.mPack.Type = Beacon.ContentPack.TypeLocal Then
		    Self.IdField.ReadOnly = False
		    Self.IdField.Tooltip = Self.TooltipModId
		  Else
		    Self.IdField.ReadOnly = True
		    Self.IdField.Tooltip = Self.TooltipModIdReadOnly
		  End If
		  Self.IdLabel.Tooltip = Self.IdField.Tooltip
		  
		  Self.EditThread.DebugIdentifier = "ModSettingsDialog.EditThread"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Pack As Beacon.ContentPack)
		  Self.mPack = Pack
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Pack As Beacon.ContentPack) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Win As New ModSettingsDialog(Pack)
		  Win.ShowModal(Parent.TrueWindow)
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  Return Not Cancelled
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPack As Beacon.ContentPack
	#tag EndProperty


	#tag Constant, Name = CaptionModId, Type = String, Dynamic = True, Default = \"Mod ID:", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CaptionModName, Type = String, Dynamic = True, Default = \"Mod Name:", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CaptionModSettings, Type = String, Dynamic = True, Default = \"Mod Settings", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorAlreadyExists, Type = String, Dynamic = True, Default = \"A mod with ID \?1 already exists.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TooltipModId, Type = String, Dynamic = True, Default = \"The CurseForge or Steam ID of the mod. Changing this value will generate a new UUID for your mod.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TooltipModIdReadOnly, Type = String, Dynamic = True, Default = \"The CurseForge or Steam ID of the mod. This ID cannot be edited after the mod has been registered.", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.mNewName = Self.NameField.Text.Trim
		  Self.mNewId = Self.IdField.Text.Trim
		  Self.EditThread.Start
		  Me.Enabled = False
		  Self.CancelButton.Enabled = False
		  Self.Spinner.Visible = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditThread
	#tag Event
		Sub Run()
		  Var NameEdited As Boolean = Self.mPack.Name.Compare(Self.mNewName, ComparisonOptions.CaseSensitive) <> 0
		  Var IdEdited As Boolean = Self.mPack.MarketplaceId.Compare(Self.mNewId, ComparisonOptions.CaseSensitive) <> 0
		  
		  If Self.mPack.Type = Beacon.ContentPack.TypeLocal Then
		    If NameEdited = False And IdEdited = False Then
		      // No changes to make
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": True))
		      Return
		    End If
		    
		    Var DataSource As Beacon.DataSource
		    Var Marketplace As String
		    Select Case Self.mPack.GameId
		    Case Ark.Identifier
		      DataSource = Ark.DataSource.Pool.Get(True)
		      Marketplace = Beacon.MarketplaceSteamWorkshop
		    Case ArkSA.Identifier
		      DataSource = ArkSA.DataSource.Pool.Get(True)
		      Marketplace = Beacon.MarketplaceCurseForge
		    End Select
		    
		    If (DataSource Is Nil) = False And DataSource.EditContentPack(Self.mPack, Self.mNewName, If(Self.mNewId.IsEmpty = False, Marketplace, ""), Self.mNewId) Then
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": True))
		    Else
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": False))
		    End If
		  Else
		    If NameEdited = False Then
		      // No changes to make
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": True))
		      Return
		    End If
		    
		    Var Fields As New JSONItem
		    Fields.Value("name") = Self.mNewName
		    
		    Var Request As New BeaconAPI.Request("/contentPacks/" + EncodeURLComponent(Self.mPack.ContentPackId), "PUT", Fields.ToString(False), "application/json")
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    If Response.Success Then
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": True))
		    Else
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": False, "Reason": Response.Message))
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var Finished As Boolean = Update.Lookup("Finished", False).BooleanValue
		    Var Success As Boolean = Update.Lookup("Success", False).BooleanValue
		    Var Reason As String = Update.Lookup("Reason", "No further information is available.").StringValue
		    
		    If Not Finished Then
		      Continue
		    End If
		    
		    If Success Then
		      Self.mCancelled = False
		      Self.Hide
		    Else
		      Self.ActionButton.Enabled = True
		      Self.CancelButton.Enabled = True
		      Self.Spinner.Visible = False
		      
		      Self.ShowAlert("Beacon was unable to save the changes.", Reason)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
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
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
