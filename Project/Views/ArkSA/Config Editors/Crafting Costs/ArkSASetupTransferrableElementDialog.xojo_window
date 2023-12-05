#tag DesktopWindow
Begin BeaconDialog ArkSASetupTransferrableElementDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   296
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   296
   MaximumWidth    =   600
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   296
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "#DialogTitle"
   Type            =   8
   Visible         =   True
   Width           =   600
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#DialogTitle"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   88
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Explanation"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton ChooseIntermediateButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Language.CommonChoose"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   191
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel IntermediateLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#LabelIntermediateIngredient"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   159
   End
   Begin DesktopRadioButton CraftIntoShardsRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#LabelIntermediateToShards"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   191
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   184
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   389
   End
   Begin DesktopRadioButton CraftIntoElementRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#LabelIntermediateToElement"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   191
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   216
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   389
   End
   Begin DesktopLabel IntermediateField
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
      Left            =   293
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Soap"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   287
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Language.CommonOk"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   256
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   256
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.ExplanationLabel.Height = Self.ExplanationLabel.IdealHeight
		  Self.IntermediateLabel.SizeToFit
		  
		  Self.ChooseIntermediateButton.Top = Self.ExplanationLabel.Bottom + 12
		  Self.IntermediateLabel.Top = Self.ChooseIntermediateButton.Top
		  Self.IntermediateLabel.Height = Self.ChooseIntermediateButton.Height
		  Self.IntermediateField.Top = Self.ChooseIntermediateButton.Top
		  Self.IntermediateField.Height = Self.ChooseIntermediateButton.Height
		  Self.ChooseIntermediateButton.Left = Self.IntermediateLabel.Right + 12
		  Self.IntermediateField.Left = Self.ChooseIntermediateButton.Right + 12
		  Self.IntermediateField.Width = Self.Width - (20 + Self.IntermediateField.Left)
		  
		  Self.CraftIntoShardsRadio.Top = Self.ChooseIntermediateButton.Bottom + 12
		  Self.CraftIntoShardsRadio.Left = Self.IntermediateLabel.Right + 12
		  Self.CraftIntoShardsRadio.Width = Self.Width - (20 + Self.CraftIntoShardsRadio.Left)
		  
		  Self.CraftIntoElementRadio.Top = Self.CraftIntoShardsRadio.Bottom + 12
		  Self.CraftIntoElementRadio.Left = Self.IntermediateLabel.Right + 12
		  Self.CraftIntoElementRadio.Width = Self.Width - (20 + Self.CraftIntoElementRadio.Left)
		  
		  Self.ActionButton.Top = Self.CraftIntoElementRadio.Bottom + 20
		  Self.CancelButton.Top = Self.ActionButton.Top
		  
		  Self.Height = Self.CancelButton.Bottom + 20
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Config As ArkSA.Configs.CraftingCosts, Mods As Beacon.StringList)
		  Self.mConfig = Config
		  Self.mMods = Mods
		  Self.mIntermediate = ArkSA.DataSource.Pool.Get(False).GetEngram("82d8bf54-08bc-5d9e-9f23-a63e24a1273f")
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Config As ArkSA.Configs.CraftingCosts, ContentPacks As Beacon.StringList) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Win As New ArkSASetupTransferrableElementDialog(Config, ContentPacks)
		  Win.ShowModal(Parent)
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  Return Not Cancelled
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As ArkSA.Configs.CraftingCosts
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIntermediate As ArkSA.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty


	#tag Constant, Name = ButtonRefreshNow, Type = String, Dynamic = True, Default = \"Rebuild Now", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DialogTitle, Type = String, Dynamic = True, Default = \"Setup Transferrable Element", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ErrorNoElementExplanation, Type = String, Dynamic = True, Default = \"Beacon could not find Element in its database. Would you like Beacon to rebuild its blueprints database\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ErrorNoElementMessage, Type = String, Dynamic = True, Default = \"Could not find element", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ErrorNoShardsExplanation, Type = String, Dynamic = True, Default = \"Beacon could not find Element Shards in its database. Would you like Beacon to rebuild its blueprints database\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ErrorNoShardsMessage, Type = String, Dynamic = True, Default = \"Could not find element shards", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Explanation, Type = String, Dynamic = True, Default = \"This tool will add or change the crafting costs necessary to make element transferrable. Most admins choose to use soap as the intermediate ingredient. This means 1 soap would require 1 element to craft. Then 100 shards would be crafted from 1 soap. And finally the normal 1 element is crafted from 100 shards. This allows the element to be transferred as soap without prohibiting shards being turned into element.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelIntermediateIngredient, Type = String, Dynamic = True, Default = \"Intermediate Ingredient:", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelIntermediateToElement, Type = String, Dynamic = True, Default = \"Intermediate crafts into 1 element", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelIntermediateToShards, Type = String, Dynamic = True, Default = \"Intermediate crafts into 100 shards", Scope = Protected
	#tag EndConstant


#tag EndWindowCode

#tag Events ChooseIntermediateButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As ArkSA.Engram
		  Var Engrams() As ArkSA.Engram = ArkSABlueprintSelectorDialog.Present(Self, "", Exclude, Self.mMods, ArkSABlueprintSelectorDialog.SelectModes.Single)
		  If Engrams <> Nil And Engrams.Count = 1 Then
		    Self.mIntermediate = Engrams(0)
		    Self.IntermediateField.Text = Self.mIntermediate.Label
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Element As ArkSA.Engram = ArkSA.DataSource.Pool.Get(False).GetEngram("1ca85b1a-41cd-5b93-ba08-872a5edcc376")
		  If Element Is Nil Then
		    If Self.ShowConfirm(Self.ErrorNoElementMessage, Self.ErrorNoElementExplanation, Self.ButtonRefreshNow, Language.CommonCancel) Then
		      App.SyncGamedata(False, True)
		    End If
		    Return
		  End If
		  
		  Var IntermediateCost As New ArkSA.MutableCraftingCost(Self.mIntermediate, False)
		  IntermediateCost.Add(Element, 1, True)
		  Self.mConfig.Add(IntermediateCost)
		  
		  If Self.CraftIntoShardsRadio.Value Then
		    Var Shards As ArkSA.Engram = ArkSA.DataSource.Pool.Get(False).GetEngram("a3cb0922-6c3e-5c3d-88ea-a47011f97d68")
		    If Shards Is Nil Then
		      If Self.ShowConfirm(Self.ErrorNoShardsMessage, Self.ErrorNoShardsExplanation, Self.ButtonRefreshNow, Language.CommonCancel) Then
		        App.SyncGamedata(False, True)
		      End If
		      Return
		    End If
		    
		    Var ShardsCost As New ArkSA.MutableCraftingCost(Shards, False)
		    ShardsCost.Add(Self.mIntermediate, 1, True)
		    Self.mConfig.Add(ShardsCost)
		    
		    Self.mConfig.Remove(Element)
		  Else
		    Var ElementCost As New ArkSA.MutableCraftingCost(Element, False)
		    ElementCost.Add(Self.mIntermediate, 1, True)
		    Self.mConfig.Add(ElementCost)
		  End If
		  
		  Self.mCancelled = False
		  Self.Hide
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
#tag ViewBehavior
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
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
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
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
