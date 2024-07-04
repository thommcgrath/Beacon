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
   Height          =   583
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1233248255
   MenuBarVisible  =   True
   MinimumHeight   =   583
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "Adjust Crafting Costs"
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
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton TargetIngredientChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
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
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   307
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel TargetIngredientLabel
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
      Text            =   "Target Ingredients:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipTargetIngredients"
      Top             =   275
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Replacement Ingredient:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipReplacementIngredient"
      Top             =   381
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
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   413
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedTextField MultiplierField
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
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipMultiplier"
      Top             =   445
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel MultiplierLabel
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
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Cost Multiplier:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipMultiplier"
      Top             =   445
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
      Text            =   "This tool allows quick changes to many crafting recipes. You can replace ingredients and change quantities."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#TooltipRemoveIngredients"
      Top             =   511
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   387
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
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   543
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
      Left            =   408
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   543
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Thread ProcessorThread
      DebugIdentifier =   ""
      Enabled         =   True
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
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#TooltipRounding"
      Top             =   479
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
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Rounding:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipRounding"
      Top             =   479
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin UITweaks.ResizedPopupMenu TargetIngredientMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "All ingredients\nSelected ingredients\nTagged ingredients"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#TooltipTargetIngredients"
      Top             =   275
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   220
   End
   Begin UITweaks.ResizedPopupMenu ReplacementMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "No replacement\nSelected ingredient"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#TooltipReplacementIngredient"
      Top             =   381
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   220
   End
   Begin DesktopLabel ReplacementIngredientField
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   True
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Nothing Selected"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   413
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   285
   End
   Begin DesktopLabel TargetIngredientField
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   True
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Nothing Selected"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   307
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   285
   End
   Begin TagPicker TargetIngredientTagPicker
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Border          =   15
      ContentHeight   =   0
      Enabled         =   True
      ExcludeTagCaption=   "Do not adjust ingredients that have the ""%%Tag%%"" tag"
      Height          =   30
      Index           =   -2147483648
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      NeutralTagCaption=   "Adjusted ingredients may or may not have the ""%%Tag%%"" tag"
      RequireTagCaption=   "Only adjust ingredients that have the ""%%Tag%%"" tag"
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      Spec            =   ""
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   339
      Transparent     =   True
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedLabel TargetRecipeLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Target Recipes:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#TooltipTargetRecipes"
      Top             =   169
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin UITweaks.ResizedPopupMenu TargetRecipeMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "All recipes\nSelected recipes\nTagged recipes\nEdited recipes"
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#TooltipTargetRecipes"
      Top             =   169
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   220
   End
   Begin UITweaks.ResizedPushButton TargetRecipeChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   201
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin DesktopLabel TargetRecipeField
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   True
      Left            =   295
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Nothing Selected"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   201
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   285
   End
   Begin TagPicker TargetRecipeTagPicker
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Border          =   15
      ContentHeight   =   0
      Enabled         =   True
      ExcludeTagCaption=   "Do not adjust recipes that have the ""%%Tag%%"" tag"
      Height          =   30
      Index           =   -2147483648
      Left            =   193
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      NeutralTagCaption=   "Adjusted recipes may or may not have the ""%%Tag%%"" tag"
      RequireTagCaption=   "Only adjust recipes that have the ""%%Tag%%"" tag"
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      Spec            =   ""
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   233
      Transparent     =   True
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedPushButton HelpButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Help"
      Default         =   False
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
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   543
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
		  Var EngramTags() As String = Ark.DataSource.Pool.Get(False).GetTags(Self.mProject.ContentPacks, Ark.CategoryEngrams)
		  Self.TargetIngredientTagPicker.Tags = EngramTags
		  Self.TargetRecipeTagPicker.Tags = EngramTags
		  
		  If Self.mTargetRecipes.Count > 0 Then
		    Self.TargetRecipeMenu.SelectedRowIndex = Self.TargetModeSelected
		    Self.TargetRecipeField.Text = Self.RecipesCaption(Self.mTargetRecipes)
		    Self.TargetRecipeField.Italic = Self.mTargetRecipes.Count = 0
		  ElseIf (Self.mTargetRecipeTags Is Nil) = False And Self.mTargetRecipeTags.IsEmpty = False Then
		    Self.TargetRecipeMenu.SelectedRowIndex = Self.TargetModeTagged
		    Self.TargetRecipeTagPicker.Spec = Self.mTargetRecipeTags
		  End If
		  
		  If Self.mTargetIngredients.Count > 0 Then
		    Self.TargetIngredientMenu.SelectedRowIndex = Self.TargetModeSelected
		    Self.TargetIngredientField.Text = Self.IngredientsCaption(Self.mTargetIngredients)
		    Self.TargetIngredientField.Italic = Self.mTargetIngredients.Count = 0
		  ElseIf (Self.mTargetIngredientTags Is Nil) = False And Self.mTargetIngredientTags.IsEmpty = False Then
		    Self.TargetIngredientMenu.SelectedRowIndex = Self.TargetModeTagged
		    Self.TargetIngredientTagPicker.Spec = Self.mTargetIngredientTags
		  End If
		  
		  If (Self.mReplacement Is Nil) = False Then
		    Self.ReplacementMenu.SelectedRowIndex = Self.ReplaceModeSelected
		    Self.ReplacementIngredientField.Text = Self.mReplacement.Label
		    Self.ReplacementIngredientField.Italic = Self.mReplacement Is Nil
		  End If
		  
		  Self.MultiplierField.Text = Self.mMultiplier.PrettyText(True)
		  Self.RoundingMenu.SelectedRowIndex = Self.mRoundingMode
		  Self.RemoveIngredientsCheck.Value = Self.mRemoveZeroQuantities
		  
		  Self.SetupUI
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Ark.Project, TargetRecipes() As Ark.Engram = Nil, TargetRecipeTags As Beacon.TagSpec = Nil, TargetIngredients() As Ark.Engram, TargetIngredientTags As Beacon.TagSpec, ReplacementIngredient As Ark.Engram, Multiplier As Double, RoundingMode As Integer, RemoveZeroQuantities As Boolean)
		  // Calling the overridden superclass constructor.
		  Self.mMultiplier = Multiplier
		  Self.mProject = Project
		  Self.mRemoveZeroQuantities = RemoveZeroQuantities
		  Self.mReplacement = ReplacementIngredient
		  Self.mRoundingMode = RoundingMode
		  If (TargetIngredients Is Nil) = False Then
		    Self.mTargetIngredients.ResizeTo(TargetIngredients.LastIndex)
		    For Idx As Integer = 0 To Self.mTargetIngredients.LastIndex
		      Self.mTargetIngredients(Idx) = TargetIngredients(Idx)
		    Next
		  End If
		  If (TargetRecipes Is Nil) = False Then
		    Self.mTargetRecipes.ResizeTo(TargetRecipes.LastIndex)
		    For Idx As Integer = 0 To Self.mTargetRecipes.LastIndex
		      Self.mTargetRecipes(Idx) = TargetRecipes(Idx)
		    Next
		  End If
		  If (TargetIngredientTags Is Nil) = False Then
		    Self.mTargetIngredientTags = New Beacon.TagSpec(TargetIngredientTags)
		  End If
		  If (TargetRecipeTags Is Nil) = False Then
		    Self.mTargetRecipeTags = New Beacon.TagSpec(TargetRecipeTags)
		  End If
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IngredientsCaption(Engrams() As Ark.Engram) As String
		  If Engrams Is Nil Or Engrams.Count = 0 Then
		    Return "No selection"
		  ElseIf Engrams.Count = 1 Then
		    Return Engrams(0).Label
		  Else
		    Return Language.NounWithQuantity(Engrams.Count, "engram", "engrams")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Ark.Project, TargetRecipes() As Ark.Engram = Nil, TargetRecipeTags As Beacon.TagSpec = Nil, TargetIngredients() As Ark.Engram = Nil, TargetIngredientTags As Beacon.TagSpec = Nil, ReplacementIngredient As Ark.Engram = Nil, Multiplier As Double = 1.0, RoundingMode As Integer = 0, RemoveZeroQuantities As Boolean = False) As Boolean
		  Var Win As New ArkAdjustIngredientDialog(Project, TargetRecipes, TargetRecipeTags, TargetIngredients, TargetIngredientTags, ReplacementIngredient, Multiplier, RoundingMode, RemoveZeroQuantities)
		  Win.ShowModal(Parent)
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RecipesCaption(Engrams() As Ark.Engram) As String
		  If Engrams Is Nil Or Engrams.Count = 0 Then
		    Return "No selection"
		  ElseIf Engrams.Count = 1 Then
		    Return Engrams(0).Label
		  Else
		    Return Language.NounWithQuantity(Engrams.Count, "recipe", "recipes")
		  End If
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

	#tag Method, Flags = &h21
		Private Sub SetupUI(Reduced As Boolean = False)
		  Self.ExplanationLabel.Height = Self.ExplanationLabel.IdealHeight
		  
		  Var NextTop As Integer = Self.ExplanationLabel.Bottom + 12
		  Self.TargetRecipeLabel.Top = NextTop
		  Self.TargetRecipeMenu.Top = NextTop
		  NextTop = TargetRecipeMenu.Bottom + 12
		  
		  Var TargetRecipeMode As Integer = Self.TargetRecipeMenu.SelectedRowIndex
		  Self.TargetRecipeField.Visible = (TargetRecipeMode = Self.TargetModeSelected)
		  Self.TargetRecipeChooseButton.Visible = (TargetRecipeMode = Self.TargetModeSelected)
		  Self.TargetRecipeTagPicker.Visible = (TargetRecipeMode = Self.TargetModeTagged)
		  Select Case TargetRecipeMode
		  Case Self.TargetModeSelected
		    Self.TargetRecipeField.Top = NextTop
		    Self.TargetRecipeChooseButton.Top = NextTop
		    NextTop = Self.TargetRecipeField.Bottom + 12
		  Case Self.TargetModeTagged
		    Self.TargetRecipeTagPicker.Top = NextTop
		    If Reduced = False Then
		      Self.TargetRecipeTagPicker.Height = Self.mTargetRecipeTagPickerHeight
		    End If
		    NextTop = Self.TargetRecipeTagPicker.Bottom + 12
		  End Select
		  
		  Self.TargetIngredientLabel.Top = NextTop
		  Self.TargetIngredientMenu.Top = NextTop
		  NextTop = TargetIngredientMenu.Bottom + 12
		  
		  Var TargetIngredientMode As Integer = Self.TargetIngredientMenu.SelectedRowIndex
		  Self.TargetIngredientField.Visible = (TargetIngredientMode = Self.TargetModeSelected)
		  Self.TargetIngredientChooseButton.Visible = (TargetIngredientMode = Self.TargetModeSelected)
		  Self.TargetIngredientTagPicker.Visible = (TargetIngredientMode = Self.TargetModeTagged)
		  Select Case TargetIngredientMode
		  Case Self.TargetModeSelected
		    Self.TargetIngredientField.Top = NextTop
		    Self.TargetIngredientChooseButton.Top = NextTop
		    NextTop = Self.TargetIngredientField.Bottom + 12
		  Case Self.TargetModeTagged
		    Self.TargetIngredientTagPicker.Top = NextTop
		    If Reduced = False Then
		      Self.TargetIngredientTagPicker.Height = Self.mTargetIngredientTagPickerHeight
		    End If
		    NextTop = Self.TargetIngredientTagPicker.Bottom + 12
		  End Select
		  
		  Self.ReplacementLabel.Top = NextTop
		  Self.ReplacementMenu.Top = NextTop
		  NextTop = Self.ReplacementMenu.Bottom + 12
		  
		  Var ReplaceMode As Integer = Self.ReplacementMenu.SelectedRowIndex
		  Self.ReplacementIngredientField.Visible = (ReplaceMode = Self.ReplaceModeSelected)
		  Self.ReplacementChooseButton.Visible = (ReplaceMode = Self.ReplaceModeSelected)
		  Select Case ReplaceMode
		  Case Self.ReplaceModeSelected
		    Self.ReplacementIngredientField.Top = NextTop
		    Self.ReplacementChooseButton.Top = NextTop
		    NextTop = Self.ReplacementIngredientField.Bottom + 12
		  End Select
		  
		  Self.MultiplierLabel.Top = NextTop
		  Self.MultiplierField.Top = NextTop
		  NextTop = Self.MultiplierField.Bottom + 12
		  
		  Self.RoundingLabel.Top = NextTop
		  Self.RoundingMenu.Top = NextTop
		  NextTop = Self.RoundingMenu.Bottom + 12
		  
		  Self.RemoveIngredientsCheck.Top = NextTop
		  NextTop = Self.RemoveIngredientsCheck.Bottom + 12
		  
		  Self.ActionButton.Top = NextTop
		  Self.CancelButton.Top = NextTop
		  Self.HelpButton.Top = NextTop
		  
		  Var TargetHeight As Integer = Self.ActionButton.Bottom + 20
		  Var Screen As DesktopDisplay = Self.IdealScreen
		  Var FrameHeight As Integer = Self.Bounds.Height - Self.Height
		  Var MaxContentHeight As Integer = Max(680, Screen.AvailableHeight - FrameHeight)
		  If Reduced = False And TargetHeight > MaxContentHeight Then
		    Var Delta As Integer = TargetHeight - MaxContentHeight
		    Reduced = True
		    If Self.TargetRecipeTagPicker.Visible And Self.TargetIngredientTagPicker.Visible Then
		      Self.TargetRecipeTagPicker.Height = Self.TargetRecipeTagPicker.Height - Floor(Delta / 2)
		      Self.TargetIngredientTagPicker.Height = Self.TargetIngredientTagPicker.Height - Floor(Delta / 2)
		    ElseIf TargetRecipeTagPicker.Visible Then
		      Self.TargetRecipeTagPicker.Height = Self.TargetRecipeTagPicker.Height - Delta
		    ElseIf TargetIngredientTagPicker.Visible Then
		      Self.TargetIngredientTagPicker.Height = Self.TargetIngredientTagPicker.Height - Delta
		    Else
		      Reduced = False
		    End If
		    If Reduced Then
		      Self.SetupUI(Reduced) // Start over
		      Return
		    End If
		  End If
		  
		  If Self.Height < TargetHeight Then
		    Self.MaximumHeight = TargetHeight
		    Self.Height = TargetHeight
		    Self.MinimumHeight = TargetHeight
		  ElseIf Self.Height > TargetHeight Then
		    Self.MinimumHeight = TargetHeight
		    Self.Height = TargetHeight
		    Self.MaximumHeight = TargetHeight
		  Else
		    Return
		  End If
		  
		  Var Bounds As Rect = Self.Bounds
		  If Bounds.Bottom > Screen.AvailableTop + Screen.AvailableHeight Then
		    // Move the window up
		    Bounds.Offset(0, (Screen.AvailableTop + Screen.AvailableHeight) - Bounds.Bottom)
		    Self.Bounds = Bounds
		  End If
		End Sub
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
		Private mTargetIngredients() As Ark.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetIngredientTagPickerHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetIngredientTags As Beacon.TagSpec
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetRecipes() As Ark.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetRecipeTagPickerHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetRecipeTags As Beacon.TagSpec
	#tag EndProperty


	#tag Constant, Name = ReplaceModeSelected, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ReplaceModeUnchanged, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundDisabled, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundDown, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundNatural, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoundUp, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TargetModeAll, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TargetModeEdited, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TargetModeSelected, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TargetModeTagged, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TooltipMultiplier, Type = String, Dynamic = False, Default = \"Allows changing the quantity of ingredients. 1 is unchanged\x2C less than one reduces quantities\x2C and greater than one increases quantities. A value of 0 means ingredients will always require 1 no matter the blueprint quality.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipRemoveIngredients, Type = String, Dynamic = False, Default = \"Turn on if you would like to remove ingredients that have 0 quantity.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipReplacementIngredient, Type = String, Dynamic = False, Default = \"Allows replacing targeted ingredients with another ingredient.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipRounding, Type = String, Dynamic = False, Default = \"Decide how quantities should be rounded\x2C if at all.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipTargetIngredients, Type = String, Dynamic = False, Default = \"Controls which ingredients (the engrams on the right side of the crafting editor) should be replaced and/or have their quantities changed.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipTargetRecipes, Type = String, Dynamic = False, Default = \"Controls which recipes (the engrams on the left column of the crafting editor) should be changed.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TargetIngredientChooseButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Engram
		  Exclude.ResizeTo(Self.mTargetIngredients.LastIndex)
		  For Idx As Integer = 0 To Exclude.LastIndex
		    Exclude(Idx) = Self.mTargetIngredients(Idx)
		  Next
		  
		  Var Engrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mProject.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultipleWithExcluded)
		  If (Engrams Is Nil) = False And Engrams.Count > 0 Then
		    Self.mTargetIngredients.ResizeTo(Engrams.LastIndex)
		    For Idx As Integer = 0 To Self.mTargetIngredients.LastIndex
		      Self.mTargetIngredients(Idx) = Engrams(Idx)
		    Next
		    Self.TargetIngredientField.Text = Self.IngredientsCaption(Engrams)
		    Self.TargetIngredientField.Italic = Engrams.Count = 0
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
		    Self.ReplacementIngredientField.Text = Self.mReplacement.Label
		    Self.ReplacementIngredientField.Italic = Engrams.Count = 0
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.TargetRecipeMenu.SelectedRowIndex = Self.TargetModeSelected And Self.mTargetRecipes.Count = 0 Then
		    Self.ShowAlert("Select a target recipe.", "You have not chosen a recipe to change. If you want to change all recipes, choose the ""All recipes"" option next to ""Target Recipe.""")
		    Return
		  End If
		  
		  If Self.TargetIngredientMenu.SelectedRowIndex = Self.TargetModeSelected And Self.mTargetIngredients.Count = 0 Then
		    Self.ShowAlert("Select a target ingredient.", "You have not chosen an ingredient to change. If you want to change all ingredients, choose the ""All ingredients"" option next to ""Target Ingredient.""")
		    Return
		  End If
		  
		  If Self.ReplacementMenu.SelectedRowIndex = Self.ReplaceModeSelected And Self.mReplacement Is Nil Then
		    Self.ShowAlert("Select a replacement ingredient.", "You have not chosen a replacement ingredient. Choose ""No Change"" if you do not want to replace ingredients.")
		    Return
		  End If
		  
		  Var Multiplier As Double
		  If IsNumeric(Self.MultiplierField.Text) Then
		    Try
		      Multiplier = Double.FromString(Self.MultiplierField.Text, Locale.Current)
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
		  
		  Select Case Self.TargetRecipeMenu.SelectedRowIndex
		  Case Self.TargetModeAll
		    Self.mTargetRecipes.ResizeTo(-1)
		    Self.mTargetRecipeTags = Nil
		  Case Self.TargetModeTagged
		    Self.mTargetRecipes.ResizeTo(-1)
		    Self.mTargetRecipeTags = Self.TargetRecipeTagPicker.Spec
		  Case Self.TargetModeSelected
		    Self.mTargetRecipeTags = Nil
		  Case Self.TargetModeEdited
		    Self.mTargetRecipes.ResizeTo(-1)
		    Self.mTargetRecipeTags = Nil
		    
		    Var Config As Ark.ConfigGroup = Self.mProject.ConfigGroup(Ark.Configs.NameCraftingCosts)
		    If Config IsA Ark.Configs.CraftingCosts Then
		      Self.mTargetRecipes = Ark.Configs.CraftingCosts(Config).Engrams
		    End If
		  End Select
		  Select Case Self.TargetIngredientMenu.SelectedRowIndex
		  Case Self.TargetModeAll
		    Self.mTargetIngredients.ResizeTo(-1)
		    Self.mTargetIngredientTags = Nil
		  Case Self.TargetModeTagged
		    Self.mTargetIngredients.ResizeTo(-1)
		    Self.mTargetIngredientTags = Self.TargetIngredientTagPicker.Spec
		  Case Self.TargetModeSelected
		    Self.mTargetIngredientTags = Nil
		  End Select
		  If Self.ReplacementMenu.SelectedRowIndex = Self.TargetModeAll Then
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
		    Filter.Value(Engram.EngramId) = True
		  Next
		  
		  Var ContentPacks As Beacon.StringList = Self.mProject.ContentPacks
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var EngramIds() As String = DataSource.GetRecipeEngramIds(ContentPacks, Ark.Maps.UniversalMask)
		  For Each EngramId As String In EngramIds
		    If Filter.HasKey(EngramId) Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = DataSource.GetEngram(EngramId)
		    If (Engram Is Nil) = False Then
		      Engrams.Add(Engram)
		    End If
		  Next
		  
		  Var TargetRecipes() As Ark.Engram
		  If Self.mTargetRecipes.Count > 0 Then
		    TargetRecipes = Self.mTargetRecipes
		  Else
		    TargetRecipes = DataSource.GetEngrams("", ContentPacks, Self.mTargetRecipeTags)
		  End If
		  Var TargetRecipeMap As New Dictionary
		  For Each Recipe As Ark.Engram In TargetRecipes
		    TargetRecipeMap.Value(Recipe.EngramId) = Recipe
		  Next
		  
		  Var TargetIngredients() As Ark.Engram
		  If Self.mTargetIngredients.Count > 0 Then
		    TargetIngredients = Self.mTargetIngredients
		  Else
		    TargetIngredients = DataSource.GetEngrams("", ContentPacks, Self.mTargetIngredientTags)
		  End If
		  Var TargetMap As New Dictionary
		  For Each Ingredient As Ark.Engram In TargetIngredients
		    TargetMap.Value(Ingredient.EngramId) = Ingredient
		  Next
		  
		  Var NumProcessed As Integer
		  Var TotalEngrams As Integer = Engrams.Count
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
		    
		    If TargetRecipeMap.HasKey(Engram.EngramId) = False Then
		      Continue
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
		      If TargetMap.HasKey(Ingredient.Engram.EngramId) = False Then
		        Continue
		      End If
		      Var IngredientIsChanging As Boolean = (Self.mReplacement Is Nil) = False And Ingredient.Engram.EngramId <> Self.mReplacement.EngramId
		      
		      Var Replacement As Ark.Engram = If(Self.mReplacement Is Nil, Ingredient.Engram, Self.mReplacement)
		      If ReplacementIngredients.HasKey(Replacement.EngramId) Then
		        Cost.Remove(IngredientIdx)
		        Changed = True
		        Continue
		      End If
		      ReplacementIngredients.Value(Replacement.EngramId) = True
		      
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
#tag Events TargetIngredientMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TargetIngredientTagPicker
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  Self.mTargetIngredientTagPickerHeight = Me.Height + Delta
		  Me.Height = Self.mTargetIngredientTagPickerHeight
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TargetRecipeMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TargetRecipeChooseButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Engram
		  Exclude.ResizeTo(Self.mTargetRecipes.LastIndex)
		  For Idx As Integer = 0 To Exclude.LastIndex
		    Exclude(Idx) = Self.mTargetRecipes(Idx)
		  Next
		  
		  Var Engrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mProject.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultipleWithExcluded)
		  If (Engrams Is Nil) = False And Engrams.Count > 0 Then
		    Self.mTargetRecipes.ResizeTo(Engrams.LastIndex)
		    For Idx As Integer = 0 To Self.mTargetRecipes.LastIndex
		      Self.mTargetRecipes(Idx) = Engrams(Idx)
		    Next
		    Self.TargetRecipeField.Text = Self.RecipesCaption(Engrams)
		    Self.TargetRecipeField.Italic = Engrams.Count = 0
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TargetRecipeTagPicker
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  Self.mTargetRecipeTagPickerHeight = Me.Height + Delta
		  Me.Height = Self.mTargetRecipeTagPickerHeight
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HelpButton
	#tag Event
		Sub Pressed()
		  System.GotoURL(Beacon.WebURL("/help/crafting_costs_editor#the-adjust-crafting-costs-tool"))
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
