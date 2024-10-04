#tag DesktopWindow
Begin BeaconDialog ArkSAModDiscoveryDialog
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
   Height          =   418
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   266
   MaximumWidth    =   600
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   266
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "Mod Discovery"
   Type            =   8
   Visible         =   True
   Width           =   600
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
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   378
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
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   378
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField ModsField
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   "#DesiredModIdsTooltip"
      Top             =   185
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   433
   End
   Begin UITweaks.ResizedLabel ModsLabel
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#DesiredModIdsCaption"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#DesiredModIdsTooltip"
      Top             =   184
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   54
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This feature will look at the manifest inside the mod archive to try to guess at contents. It will be wrong very frequently, but may help you get started."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
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
      Text            =   "Automatic Mod Discovery"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   376
   End
   Begin DesktopCheckBox AllowDeleteCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#DeleteContentCaption"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#DeleteContentTooltip"
      Top             =   251
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   433
   End
   Begin DesktopLabel BetaLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   380
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Beta"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
   End
   Begin DesktopCheckBox IgnoreBuiltInClassesCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#IgnoreBuiltInClassesCaption"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#IgnoreBuiltInClassesTooltip"
      Top             =   283
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   433
   End
   Begin RangeField ThresholdField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      DoubleValue     =   0.0
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   "#ThresholdTooltip"
      Top             =   315
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel ThresholdLabel
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#ThresholdCaption"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#ThresholdTooltip"
      Top             =   315
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedLabel ThresholdSuffixLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   239
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "%"
      TextAlignment   =   1
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   315
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin DesktopCheckBox UseNewDiscoveryCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#UseNewDiscoveryCaption"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#UseNewDiscoveryTooltip"
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   433
   End
   Begin UITweaks.ResizedTextField SteamPathField
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   "#SteamPathTooltip"
      Top             =   150
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   341
   End
   Begin UITweaks.ResizedLabel SteamPathLabel
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
      Text            =   "#SteamPathCaption"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#SteamPathTooltip"
      Top             =   150
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedPushButton SteamPathButton
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
      Left            =   500
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
      Top             =   150
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton InstallServerButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#InstallServerCaption"
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
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#InstallServerTooltip"
      Top             =   378
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   150
   End
   Begin DesktopCheckBox ReplaceBlueprintsCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#ReplaceBlueprintsCaption"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#ReplaceBlueprintsTooltip"
      Top             =   219
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   433
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SteamPathField.Text = Preferences.ArkSADedicatedPath
		  Self.BetaLabel.TextColor = SystemColors.SystemRedColor
		  
		  Self.SetupUI
		  
		  Var DefaultSettings As ArkSA.ModDiscoverySettings = Preferences.ArkSADiscoverySettings
		  
		  If Self.UseNewDiscoveryCheck.Visible Then
		    Try
		      Var SteamRoot As New FolderItem(Preferences.ArkSADedicatedPath, FolderItem.PathModes.Native)
		      If SteamRoot.Exists And SteamRoot.IsFolder Then
		        If DefaultSettings Is Nil Then
		          Self.UseNewDiscoveryCheck.Value = True
		        Else
		          Self.UseNewDiscoveryCheck.Value = DefaultSettings.UseNewDiscovery
		        End If
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Self.mForcedContentPacks.Count > 0 Then
		    Var ModIds() As String
		    For Each Pack As Beacon.ContentPack In Self.mForcedContentPacks
		      ModIds.Add(Pack.MarketplaceId)
		    Next
		    ModIds.Sort
		    Self.ModsField.Text = String.FromArray(ModIds, ",")
		    Self.ModsField.ReadOnly = True
		  End If
		  
		  If DefaultSettings Is Nil Then
		    Self.ReplaceBlueprintsCheck.Value = True
		    Self.AllowDeleteCheck.Value = True
		    Self.IgnoreBuiltInClassesCheck.Value = False
		    Self.ThresholdField.DoubleValue = 50
		  Else
		    Self.ReplaceBlueprintsCheck.Value = DefaultSettings.ReplaceBlueprints
		    Self.AllowDeleteCheck.Value = DefaultSettings.DeleteBlueprints
		    Self.IgnoreBuiltInClassesCheck.Value = DefaultSettings.IgnoreBuiltInClasses
		    Self.ThresholdField.DoubleValue = DefaultSettings.Threshold * 100
		  End If
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(ForcedContentPacks() As Beacon.ContentPack)
		  // Calling the overridden superclass constructor.
		  Self.mForcedContentPacks = ForcedContentPacks
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, ForceContentPacks() As Beacon.ContentPack) As ArkSA.ModDiscoverySettings
		  Var Win As New ArkSAModDiscoveryDialog(ForceContentPacks)
		  Win.ShowModal(Parent)
		  
		  Var Settings As ArkSA.ModDiscoverySettings = Win.mSettings
		  Win.Close
		  
		  Return Settings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, ParamArray ForceContentPacks() As Beacon.ContentPack) As ArkSA.ModDiscoverySettings
		  Return Present(Parent, ForceContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Self.UseNewDiscoveryCheck.Visible = ArkSA.ModDiscoveryEngine2.IsAvailable
		  Var UseNewDiscovery As Boolean = Self.UseNewDiscoveryCheck.Visible And Self.UseNewDiscoveryCheck.Value
		  
		  Self.IgnoreBuiltInClassesCheck.Visible = Not UseNewDiscovery
		  Self.ThresholdLabel.Visible = Not UseNewDiscovery
		  Self.ThresholdField.Visible = Not UseNewDiscovery
		  Self.ThresholdSuffixLabel.Visible = Not UseNewDiscovery
		  Self.SteamPathLabel.Visible = UseNewDiscovery
		  Self.SteamPathField.Visible = UseNewDiscovery
		  Self.SteamPathButton.Visible = UseNewDiscovery
		  Self.InstallServerButton.Visible = UseNewDiscovery
		  Self.ExplanationLabel.Text = If(UseNewDiscovery, Self.ExtractionExplanation, Self.ManifestExplanation)
		  Self.BetaLabel.Visible = Not UseNewDiscovery
		  
		  Var VisibleLabels() As DesktopLabel
		  VisibleLabels.Add(Self.ModsLabel)
		  If UseNewDiscovery Then
		    VisibleLabels.Add(Self.SteamPathLabel)
		  Else
		    VisibleLabels.Add(Self.ThresholdLabel)
		  End If
		  BeaconUI.SizeToFit(VisibleLabels)
		  Self.ExplanationLabel.Height = Self.ExplanationLabel.IdealHeight
		  
		  Var StartY As Integer
		  If Self.UseNewDiscoveryCheck.Visible Then
		    Self.UseNewDiscoveryCheck.Top = Self.ExplanationLabel.Bottom + 12
		    If Self.UseNewDiscoveryCheck.Value Then
		      Self.SteamPathField.Top = Self.UseNewDiscoveryCheck.Bottom + 12
		      Self.SteamPathLabel.Top = Self.SteamPathField.Top
		      Self.SteamPathLabel.Height = Self.SteamPathField.Height
		      Self.SteamPathButton.Top = Self.SteamPathField.Top
		      StartY = Self.SteamPathField.Bottom
		    Else
		      StartY = Self.UseNewDiscoveryCheck.Bottom
		    End If
		  Else
		    StartY = Self.ExplanationLabel.Bottom
		  End If
		  
		  Self.ModsField.Top = StartY + 12
		  Self.ModsLabel.Top = Self.ModsField.Top
		  Self.ModsLabel.Height = Self.ModsField.Height
		  Self.ReplaceBlueprintsCheck.Top = Self.ModsField.Bottom + 12
		  Self.AllowDeleteCheck.Top = Self.ReplaceBlueprintsCheck.Bottom + 12
		  If Self.IgnoreBuiltInClassesCheck.Visible Then
		    Self.IgnoreBuiltInClassesCheck.Top = Self.AllowDeleteCheck.Bottom + 12
		    StartY = Self.IgnoreBuiltInClassesCheck.Bottom
		  Else
		    StartY = Self.AllowDeleteCheck.Bottom
		  End If
		  If Self.ThresholdField.Visible Then
		    Self.ThresholdField.Top = Self.IgnoreBuiltInClassesCheck.Bottom + 12
		    Self.ThresholdLabel.Top = Self.ThresholdField.Top
		    Self.ThresholdLabel.Height = Self.ThresholdField.Height
		    Self.ThresholdSuffixLabel.Top = Self.ThresholdField.Top
		    Self.ThresholdSuffixLabel.Height = Self.ThresholdField.Height
		    StartY = Self.ThresholdField.Bottom
		  End If
		  Self.ActionButton.Top = StartY + 20
		  Self.CancelButton.Top = Self.ActionButton.Top
		  Self.InstallServerButton.Top = Self.ActionButton.Top
		  
		  Var IdealHeight As Integer = Self.ActionButton.Bottom + 20
		  Self.MinimumHeight = IdealHeight
		  Self.Height = IdealHeight
		  Self.MaximumHeight = IdealHeight
		  
		  Self.ModsField.Left = Self.ModsLabel.Left + Self.ModsLabel.Width + 12
		  Self.ModsField.Width = Self.Width - (20 + Self.ModsField.Left)
		  Self.ThresholdField.Left = Self.ModsField.Left
		  Self.ThresholdSuffixLabel.Left = Self.ThresholdField.Right + 6
		  Self.AllowDeleteCheck.Left = Self.ModsField.Left
		  Self.AllowDeleteCheck.Width = Self.ModsField.Width
		  Self.ReplaceBlueprintsCheck.Left = Self.ModsField.Left
		  Self.ReplaceBlueprintsCheck.Width = Self.ModsField.Width
		  Self.IgnoreBuiltInClassesCheck.Left = Self.ModsField.Left
		  Self.IgnoreBuiltInClassesCheck.Width = Self.ModsField.Width
		  Self.SteamPathField.Left = Self.ModsField.Left
		  Self.SteamPathField.Width = Self.ModsField.Width - (Self.SteamPathButton.Width + 12)
		  Self.UseNewDiscoveryCheck.Left = Self.ModsField.Left
		  Self.UseNewDiscoveryCheck.Width = Self.ModsField.Width
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mForcedContentPacks() As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettings As ArkSA.ModDiscoverySettings
	#tag EndProperty


	#tag Constant, Name = DeleteContentCaption, Type = String, Dynamic = True, Default = \"Delete Blueprints That Are Not Found by Discovery", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DeleteContentTooltip, Type = String, Dynamic = True, Default = \"If checked\x2C discovery will remove classes that have previously been discovered but are not found on this run.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DesiredModIdsCaption, Type = String, Dynamic = True, Default = \"Desired Mod Numbers:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DesiredModIdsTooltip, Type = String, Dynamic = True, Default = \"One or more mod numbers\x2C separated by commas. Mod numbers can be found on the mod\'s CurseForge page called \"Project ID\".", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ExtractionExplanation, Type = String, Dynamic = True, Default = \"This feature will use the Ark: Survival Ascended Dedicated Server files from Steam to assist mod discovery. These results are highly accurate. If you are using the dedicated server to host a server\x2C this process will not affect your server in any way and it is safe to leave it running.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IgnoreBuiltInClassesCaption, Type = String, Dynamic = True, Default = \"Ignore Official Classes", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IgnoreBuiltInClassesTooltip, Type = String, Dynamic = True, Default = \"If checked\x2C discovered classes that match official classes will be skipped.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = InstallServerCaption, Type = String, Dynamic = True, Default = \"Go to Steam Page", Scope = Private
	#tag EndConstant

	#tag Constant, Name = InstallServerTooltip, Type = String, Dynamic = True, Default = \"Will launch Steam\x2C if necessary\x2C and show the Ark: Survival Ascended Dedicated Server in your library.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ManifestExplanation, Type = String, Dynamic = True, Default = \"This feature will look at the manifest inside the mod archive to try to guess at contents. It will be wrong very frequently\x2C but may help you get started.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFinished, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageWorking, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ReplaceBlueprintsCaption, Type = String, Dynamic = True, Default = \"Replace Previously Discovered Blueprints", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ReplaceBlueprintsTooltip, Type = String, Dynamic = True, Default = \"For mods that were already discovered\x2C this option will replace any blueprint found by discovery. This can be useful for finding changes\x2C but if you made changes to manual blueprints (such as renaming things) those changes would be lost.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SteamPathCaption, Type = String, Dynamic = True, Default = \"Dedicated Server Path:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SteamPathTooltip, Type = String, Dynamic = True, Default = \"Beacon needs the Ark Survival Ascended Dedicated Server files from Steam to function correctly in this mode. The base game files will not work for this.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ThresholdCaption, Type = String, Dynamic = True, Default = \"Confidence Threshold:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ThresholdTooltip, Type = String, Dynamic = True, Default = \"When matching unlock strings to engrams\x2C discovery assigns a 0 to 100 confidence score to every combination. A lower threshold will discard fewer matches. This can help discover more unlock strings\x2C but may reduce the quality of matches.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UseNewDiscoveryCaption, Type = String, Dynamic = True, Default = \"Use Server-Assisted Discovery", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UseNewDiscoveryTooltip, Type = String, Dynamic = True, Default = \"By using the Ark Survival Ascended Dedicated Server files on Steam\x2C Beacon can extract dramatically more accurate information from mods.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var UploadToCommunity As Boolean = True
		  Var ContentPackIds As New Dictionary
		  If Self.mForcedContentPacks.Count > 0 Then
		    For Each Pack As Beacon.ContentPack In Self.mForcedContentPacks
		      ContentPackIds.Value(Pack.MarketplaceId) = Pack.ContentPackId
		      If Pack.IsLocal = False Then
		        UploadToCommunity = False
		      End If
		    Next
		  Else
		    Var Matcher As New Regex
		    Matcher.SearchPattern = "[^\d,]+"
		    Matcher.ReplacementPattern = ""
		    Matcher.Options.ReplaceAllMatches = True
		    
		    Var ModIds() As String = Matcher.Replace(Self.ModsField.Text).Split(",")
		    If ModIds.Count = 0 Then
		      Self.ShowAlert("Don't forget to include some mods", "This process doesn't make much sense without mod ids does it?")
		      Return
		    End If
		    
		    For Each ModId As String In ModIds
		      ContentPackIds.Value(ModId) = Beacon.ContentPack.GenerateLocalContentPackId(Beacon.MarketplaceCurseForge, ModId)
		    Next
		  End If
		  
		  Var UseNewDiscovery As Boolean = Self.UseNewDiscoveryCheck.Visible And Self.UseNewDiscoveryCheck.Value
		  Var SteamPath As String = Preferences.ArkSADedicatedPath
		  If UseNewDiscovery Then
		    Var ContentStoreFile As FolderItem
		    Try
		      SteamPath = Self.SteamPathField.Text
		      If SteamPath.EndsWith(Beacon.PathSeparator) Then
		        SteamPath = SteamPath.Left(SteamPath.Length - 1)
		      End If
		      Var ContentStorePath As String = SteamPath + Beacon.PathSeparator + "ShooterGame" + Beacon.PathSeparator + "Content" + Beacon.PathSeparator + "Paks" + Beacon.PathSeparator + "ShooterGame-WindowsServer.ucas"
		      ContentStoreFile = New FolderItem(ContentStorePath, FolderItem.PathModes.Native)
		    Catch Err As RuntimeException
		    End Try
		    If ContentStoreFile Is Nil Or ContentStoreFile.Exists = False Or ContentStoreFile.IsFolder = True Then
		      Self.ShowAlert("Incorrect Steam path", "The path to the Ark: Survival Ascended Dedicated Server files is incorrect. Please choose the correct path or turn off the """ + Self.UseNewDiscoveryCaption + """ option.")
		      Return
		    End If
		    Preferences.ArkSADedicatedPath = SteamPath
		  End If
		  
		  Var Options As Integer
		  If Self.AllowDeleteCheck.Value Then
		    Options = Options Or ArkSA.ModDiscoverySettings.OptionDeleteBlueprints
		  End If
		  If Self.ReplaceBlueprintsCheck.Value Then
		    Options = Options Or ArkSA.ModDiscoverySettings.OptionReplaceBlueprints
		  End If
		  If Self.UseNewDiscoveryCheck.Visible And Self.UseNewDiscoveryCheck.Value Then
		    Options = Options Or ArkSA.ModDiscoverySettings.OptionUseNewDiscovery
		  ElseIf Self.IgnoreBuiltInClassesCheck.Value Then
		    Options = Options Or ArkSA.ModDiscoverySettings.OptionIgnoreBuiltInClasses
		  End If
		  If UploadToCommunity Then
		    Options = Options Or ArkSA.ModDiscoverySettings.OptionUploadToCommunity
		  End If
		  
		  Var Threshold As Double = (100 - Self.ThresholdField.DoubleValue) / 100
		  Self.mSettings = New ArkSA.ModDiscoverySettings(ContentPackIds, Options, Threshold)
		  Preferences.ArkSADiscoverySettings = Self.mSettings
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mSettings = Nil
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ThresholdField
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 100
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UseNewDiscoveryCheck
	#tag Event
		Sub ValueChanged()
		  Self.SetupUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SteamPathButton
	#tag Event
		Sub Pressed()
		  Var InitialFolder As FolderItem
		  Try
		    InitialFolder = New FolderItem(Self.SteamPathField.Text, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.InitialFolder = InitialFolder
		  
		  Var SelectedFolder As FolderItem = Dialog.ShowModal(Self)
		  If SelectedFolder Is Nil Then
		    Return
		  End If
		  
		  Self.SteamPathField.Text = SelectedFolder.NativePath
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InstallServerButton
	#tag Event
		Sub Pressed()
		  Var Url As String = "steam://open/games/details/2430930"
		  #if TargetWindows
		    Var Sh As New Shell
		    Sh.Execute("start """" """ + Url + """")
		    If Sh.ExitCode = 0 Then
		      Return
		    End If
		  #elseif TargetMacOS
		    Var Sh As New Shell
		    Sh.Execute("open '" + Url + "'")
		    If Sh.ExitCode = 0 Then
		      Return
		    End If
		  #elseif TargetLinux
		    Var Sh As New Shell
		    Sh.Execute("steam '" + Url + "'")
		    If Sh.ExitCode = 0 Then
		      Return
		    End If
		  #endif
		  
		  System.GotoURL(Url)
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
