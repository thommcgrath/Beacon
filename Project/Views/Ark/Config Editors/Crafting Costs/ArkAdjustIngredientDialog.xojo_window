#tag DesktopWindow
Begin BeaconDialog ArkAdjustIngredientDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   371
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1233248255
   MenuBarVisible  =   True
   MinimumHeight   =   371
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "Adjust Crafting Costs"
   Type            =   8
   Visible         =   True
   Width           =   700
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Adjust Crafting Costs"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   660
   End
   Begin UITweaks.ResizedPushButton TargetChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   590
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "The ingredient to be replaced."
      Top             =   169
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel TargetLabel
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
      Text            =   "Target Ingredient:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "The ingredient to be replaced."
      Top             =   169
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin UITweaks.ResizedLabel ReplacementLabel
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
      Text            =   "Replacement Ingredient:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "The new ingredient to replace the target ingredient."
      Top             =   201
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin UITweaks.ResizedPushButton ReplacementChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   590
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "The new ingredient to replace the target ingredient."
      Top             =   201
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedTextField ReplacementMultiplierField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
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
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   "This multiplier will adjust the quantity of the replacement ingredient."
      Top             =   233
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel ReplacementMultiplierLabel
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Cost Multiplier:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "This multiplier will adjust the quantity of the replacement ingredient."
      Top             =   233
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   105
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This tool will allow you to change ingredient requirements for all recipes on your server. Use ""Target Ingredient"" to choose between changing all ingredients or just a specific ingredient. Use ""Replacement Ingredient"" to change the target ingredient to something else, or leave it as ""No Replacement"" to keep the ingredient the same. Use the ""Cost Multiplier"" option to change the quantities of ingredients. Use the ""Rounding"" option to decide how partial quantities should be handled. And if you want ingredients with no quantity to be removed from recipes, check the ""Remove 0-quantity ingredients"" option."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   660
   End
   Begin DesktopCheckBox RemoveIngredientsCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Remove 0-quantity ingredients"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "If the multiplier would reduce the replacement ingredient to 0 quantity, it would normally be removed from the recipe. With this option enabled, the quantity will never drop below 1."
      Top             =   299
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   487
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   600
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   508
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   331
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Thread ProcessorThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin UITweaks.ResizedPopupMenu RoundingMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "Round naturally (1.4 becomes 1 and 1.5 becomes 2)\nRound up (1.5 becomes 2)\nRound down (1.5 becomes 1)\nNo rounding"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   267
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedLabel RoundingLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Rounding:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "This multiplier will adjust the quantity of the replacement ingredient."
      Top             =   267
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopRadioGroup TargetIngredientGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Horizontal      =   True
      Index           =   -2147483648
      InitialValue    =   "All Ingredients\nSelect Ingredient"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedIndex   =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   169
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   385
   End
   Begin DesktopRadioGroup ReplacementIngredientGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Horizontal      =   True
      Index           =   -2147483648
      InitialValue    =   "No Replacement\nSelect Ingredient"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedIndex   =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   201
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   385
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  If (Self.mTarget Is Nil) = False Then
		    Self.TargetIngredientGroup.SelectedIndex = 1
		    Self.TargetIngredientGroup.ItemAt(1).Caption = Self.mTarget.Label
		    Self.TargetIngredientGroup.ItemAt(1).Italic = False
		    Self.TargetChooseButton.Enabled = True
		  End If
		  
		  If (Self.mReplacement Is Nil) = False Then
		    Self.ReplacementIngredientGroup.SelectedIndex = 1
		    Self.ReplacementIngredientGroup.ItemAt(1).Caption = Self.mReplacement.Label
		    Self.ReplacementIngredientGroup.ItemAt(1).Italic = False
		    Self.ReplacementChooseButton.Enabled = True
		  End If
		  
		  Self.ReplacementMultiplierField.Text = Self.mMultiplier.PrettyText(True)
		  Self.RoundingMenu.SelectedRowIndex = Self.mRoundingMode
		  Self.RemoveIngredientsCheck.Value = Self.mRemoveZeroQuantities
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Ark.Project, TargetIngredient As Ark.Engram = Nil, ReplacementIngredient As Ark.Engram = Nil, Multiplier As Double = 1.0, RoundingMode As Integer = 0, RemoveZeroQuantities As Boolean = False)
		  // Calling the overridden superclass constructor.
		  Self.mMultiplier = Multiplier
		  Self.mProject = Project
		  Self.mRemoveZeroQuantities = RemoveZeroQuantities
		  Self.mReplacement = ReplacementIngredient
		  Self.mRoundingMode = RoundingMode
		  Self.mTarget = TargetIngredient
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Ark.Project, TargetIngredient As Ark.Engram = Nil, ReplacementIngredient As Ark.Engram = Nil, Multiplier As Double = 1.0, RoundingMode As Integer = 0, RemoveZeroQuantities As Boolean = False) As Boolean
		  Var Win As New ArkAdjustIngredientDialog(Project, TargetIngredient, ReplacementIngredient, Multiplier, RoundingMode, RemoveZeroQuantities)
		  Win.ShowModal(Parent)
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Round(Value As Double, Mode As Integer) As Double
		  Select Case Mode
		  Case Self.RoundDisabled
		    Return Value
		  Case Self.RoundDown
		    Return Floor(Value)
		  Case Self.RoundNatural
		    Return Round(Value)
		  Case Self.RoundUp
		    Return Ceiling(Value)
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemoveZeroQuantities As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReplacement As Ark.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRoundingMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTarget As Ark.Engram
	#tag EndProperty


	#tag Constant, Name = RoundDisabled, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundDown, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundNatural, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundUp, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events TargetChooseButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Engram
		  Var Engrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mProject.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If (Engrams Is Nil) = False And Engrams.Count = 1 Then
		    Self.mTarget = Engrams(0)
		    Self.TargetIngredientGroup.ItemAt(1).Caption = Self.mTarget.Label
		    Self.TargetIngredientGroup.ItemAt(1).Italic = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementChooseButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Engram
		  Var Engrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mProject.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If (Engrams Is Nil) = False And Engrams.Count = 1 Then
		    Self.mReplacement = Engrams(0)
		    Self.ReplacementIngredientGroup.ItemAt(1).Caption = Self.mReplacement.Label
		    Self.ReplacementIngredientGroup.ItemAt(1).Italic = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.TargetIngredientGroup.SelectedIndex = 1 And Self.mTarget Is Nil Then
		    Self.ShowAlert("Select a target ingredient.", "You have not chosen an ingredient to change. If you want to change all ingredients, choose the ""All Ingredients"" option next to ""Target Ingredient.""")
		    Return
		  End If
		  
		  If Self.ReplacementIngredientGroup.SelectedIndex = 1 And Self.mReplacement Is Nil Then
		    Self.ShowAlert("Select a replacement ingredient.", "You have not chosen a replacement ingredient. Choose ""No Change"" if you do not want to replace ingredients.")
		    Return
		  End If
		  
		  Var Multiplier As Double
		  If IsNumeric(Self.ReplacementMultiplierField.Text) Then
		    Try
		      Multiplier = Double.FromString(Self.ReplacementMultiplierField.Text, Locale.Current)
		    Catch Err As RuntimeException
		      Self.ShowAlert("The replacement multiplier does not appear to be a number.", "Check the format of the multiplier and try again.")
		      Return
		    End Try
		  Else
		    Self.ShowAlert("The replacement multiplier does not appear to be a number.", "Check the format of the multiplier and try again.")
		    Return
		  End If
		  
		  If Multiplier < 0 Then
		    Self.ShowAlert("Negative multipliers don't make sense.", "There's no such thing as a negative crafting cost.")
		    Return
		  End If
		  
		  If Self.TargetIngredientGroup.SelectedIndex = 0 Then
		    Self.mTarget = Nil
		  End If
		  If Self.ReplacementIngredientGroup.SelectedIndex = 0 Then
		    Self.mReplacement = Nil
		  End If
		  Self.mMultiplier = Multiplier
		  Self.mRemoveZeroQuantities = Self.RemoveIngredientsCheck.Value
		  Self.mRoundingMode = Self.RoundingMenu.SelectedRowIndex
		  Self.mCancelled = False
		  
		  Me.Enabled = False
		  Self.CancelButton.Enabled = False
		  
		  Self.mProgress = New ProgressWindow("Processing crafting costs…", "Getting started…")
		  Self.mProgress.Show(Self)
		  Self.ProcessorThread.Start
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
#tag Events ProcessorThread
	#tag Event
		Sub Run()
		  #if DebugBuild
		    #Pragma Warning "This isn't ready yet: needs a tag picker"
		  #else
		    #Pragma Error "This isn't ready yet: needs a tag picker"
		  #endif
		  
		  Var OriginalConfig As Ark.ConfigGroup = Self.mProject.ConfigGroup(Ark.Configs.NameCraftingCosts)
		  Var WorkingConfig As Ark.Configs.CraftingCosts
		  If OriginalConfig Is Nil Then
		    WorkingConfig = New Ark.Configs.CraftingCosts
		  Else
		    WorkingConfig = Ark.Configs.CraftingCosts(Ark.Configs.CloneInstance(OriginalConfig))
		  End If
		  
		  Var Engrams() As Ark.Engram = WorkingConfig.Engrams
		  Var Filter As New Dictionary
		  For Each Engram As Ark.Engram In Engrams
		    Filter.Value(Engram.ObjectID) = True
		  Next
		  
		  Var ObjectIDs() As String = Ark.DataSource.Pool.Get(False).GetEngramUUIDsThatHaveCraftingCosts(Self.mProject.ContentPacks, Ark.Maps.UniversalMask)
		  For Each ObjectID As String In ObjectIDs
		    If Filter.HasKey(ObjectID) Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngramByUUID(ObjectID)
		    If (Engram Is Nil) = False Then
		      Engrams.Add(Engram)
		    End If
		  Next
		  
		  Var NumProcessed As Integer
		  Var TotalEngrams As Integer = Engrams.Count
		  Var IngredientIsChanging As Boolean = Self.mTarget <> Self.mReplacement
		  For Each Engram As Ark.Engram In Engrams
		    If Self.mProgress.CancelPressed Then
		      Self.mProgress.Close
		      Self.mProgress = Nil
		      
		      Var UIData As New Dictionary
		      UIData.Value("Finished") = True
		      UIData.Value("ShouldDismiss") = False
		      Me.AddUserInterfaceUpdate(UIData)
		      
		      Return
		    End If
		    
		    Var Temp As Ark.CraftingCost = WorkingConfig.Cost(Engram)
		    Var Cost As Ark.MutableCraftingCost
		    If Temp Is Nil Then
		      Cost = New Ark.MutableCraftingCost(Engram, True)
		    Else
		      Cost = New Ark.MutableCraftingCost(Temp)
		    End If
		    If Cost.Count = 0 Then
		      Continue
		    End If
		    
		    Var ReplacementIngredients As New Dictionary
		    Var Changed As Boolean
		    For IngredientIdx As Integer = Cost.LastIndex DownTo 0
		      Var Ingredient As Ark.CraftingCostIngredient = Cost.Ingredient(IngredientIdx)
		      If (Self.mTarget Is Nil) = False And Ingredient.Engram <> Self.mTarget Then
		        Continue
		      End If
		      
		      Var Replacement As Ark.Engram = If(Self.mReplacement Is Nil, Ingredient.Engram, Self.mReplacement)
		      If ReplacementIngredients.HasKey(Replacement.ObjectID) Then
		        Cost.Remove(IngredientIdx)
		        Changed = True
		        Continue
		      End If
		      ReplacementIngredients.Value(Replacement.ObjectID) = True
		      
		      Var OriginalQuantity As Double = Ingredient.Quantity
		      Var Quantity As Double = Round(OriginalQuantity * Self.mMultiplier, Self.mRoundingMode)
		      If OriginalQuantity = Quantity And IngredientIsChanging = False Then
		        Continue
		      End If
		      If Quantity = 0 And Self.mRemoveZeroQuantities = True Then
		        Cost.Remove(IngredientIdx)
		      Else
		        Cost.Ingredient(IngredientIdx) = New Ark.CraftingCostIngredient(Replacement, Quantity, Ingredient.RequireExact)
		      End If
		      
		      Changed = True
		    Next
		    
		    If Changed Then
		      Cost.Simplify()
		      WorkingConfig.Add(Cost)
		    End If
		    
		    NumProcessed = NumProcessed + 1
		    Self.mProgress.Progress = NumProcessed / TotalEngrams
		    Self.mProgress.Detail = "Updated " + NumProcessed.ToString(Locale.Current, "#,##0") + " of " + TotalEngrams.ToString(Locale.Current, "#,##0")
		  Next
		  
		  Self.mProject.AddConfigGroup(WorkingConfig)
		  
		  // Finished
		  Var UIData As New Dictionary
		  UIData.Value("Finished") = True
		  UIData.Value("ShouldDismiss") = True
		  Me.AddUserInterfaceUpdate(UIData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each UIDict As Dictionary In Data
		    Var Finished As Boolean = UIDict.Lookup("Finished", False).BooleanValue
		    If Finished Then
		      If (Self.mProgress Is Nil) = False Then
		        Self.mProgress.Close
		      End If
		      If UIDict.Lookup("ShouldDismiss", True) Then
		        Self.Hide
		      Else
		        Self.ActionButton.Enabled = True
		        Self.CancelButton.Enabled = True
		      End If
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TargetIngredientGroup
	#tag Event
		Sub SelectionChanged(button As DesktopRadioButton)
		  #Pragma Unused Button
		  
		  Self.TargetChooseButton.Enabled = (Me.SelectedIndex = 1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ItemAt(1).Italic = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementIngredientGroup
	#tag Event
		Sub SelectionChanged(button As DesktopRadioButton)
		  #Pragma Unused Button
		  
		  Self.ReplacementChooseButton.Enabled = (Me.SelectedIndex = 1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ItemAt(1).Italic = True
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
			"9 - Metal Window"
			"11 - Modeless Dialog"
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
