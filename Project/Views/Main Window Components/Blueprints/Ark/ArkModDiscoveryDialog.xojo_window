#tag DesktopWindow
Begin BeaconDialog ArkModDiscoveryDialog
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
   Height          =   234
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   234
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "Mod Discovery"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   234
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton IntroActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton IntroCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel IntroMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   2
         TabPanelIndex   =   1
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
      Begin UITweaks.ResizedTextField IntroArkPathField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   147
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   118
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   341
      End
      Begin UITweaks.ResizedLabel IntroArkPathLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Ark Path:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   118
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   115
      End
      Begin UITweaks.ResizedPushButton IntroArkPathButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   119
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel IntroExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   54
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "This feature will use an installed copy of Ark from Steam to launch a dedicated server, collect mod info using the DataDumper mod, and end the server. Enter the mod ids of the desired mods below."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel IntroSteamLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Requires Ark on Steam"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   200
      End
      Begin UITweaks.ResizedTextField IntroModsField
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
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   152
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   433
      End
      Begin UITweaks.ResizedLabel IntroModsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Desired Mod IDs:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   151
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   115
      End
      Begin UITweaks.ResizedPushButton FinishedActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel WorkingStatus
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Starting Up…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar WorkingIndicator
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopLabel FinishedMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Automatic Mod Discovery Finished"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel FinishedExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   130
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel WorkingInstructionsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   130
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "The Ark server may appear stuck for minutes at a time. This is normal. Beacon will stop the server once it has collected the needed data. The Ark server will open three ports, which may trigger malware or firewall alerts. This is ok and should be allowed."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel IntroDisclaimerLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "This technique is not perfect and sometimes misses things!"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   376
      End
   End
   Begin Ark.ModDiscoveryEngine Engine
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  If (mSharedInstance Is Nil) = False And IsNull(mSharedInstance.Value) = False And mSharedInstance.Value = Self Then
		    mSharedInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.IntroArkPathField.Text = Preferences.ArkSteamPath
		  
		  Self.IntroSteamLabel.TextColor = SystemColors.SystemRedColor
		  
		  BeaconUI.SizeToFit(Self.IntroArkPathLabel, Self.IntroModsLabel)
		  
		  Self.IntroArkPathField.Left = Self.IntroArkPathLabel.Left + Self.IntroArkPathLabel.Width + 12
		  Self.IntroModsField.Left = Self.IntroArkPathField.Left
		  Self.IntroArkPathField.Width = Self.IntroArkPathButton.Left - (12 + Self.IntroArkPathField.Left)
		  Self.IntroModsField.Width = Self.Width - (20 + Self.IntroModsField.Left)
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function CheckModDelegate(WorkshopID As String) As Boolean
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub CompletedDelegate(DiscoveredMods() As Beacon . ContentPack)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub Constructor(CheckCallback As ArkModDiscoveryDialog.CheckModDelegate, CompleteCallback As ArkModDiscoveryDialog.CompletedDelegate)
		  // Calling the overridden superclass constructor.
		  Self.mCheckCallback = CheckCallback
		  Self.mCompletedCallback = CompleteCallback
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(CheckCallback As ArkModDiscoveryDialog.CheckModDelegate, CompleteCallback As ArkModDiscoveryDialog.CompletedDelegate) As ArkModDiscoveryDialog
		  If (mSharedInstance Is Nil) = False And IsNull(mSharedInstance.Value) = False Then
		    // Cannot create a new instance
		    Return Nil
		  End If
		  
		  #Pragma DisableBackgroundTasks True // Prevent context switching
		  
		  Var Instance As New ArkModDiscoveryDialog(CheckCallback, CompleteCallback)
		  mSharedInstance = New WeakRef(Instance)
		  Return Instance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance() As ArkModDiscoveryDialog
		  If mSharedInstance Is Nil Or IsNull(mSharedInstance.Value) Then
		    Return Nil
		  End If
		  
		  Return ArkModDiscoveryDialog(mSharedInstance.Value)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCheckCallback As ArkModDiscoveryDialog.CheckModDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompletedCallback As ArkModDiscoveryDialog.CompletedDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoveredMods() As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedMods As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumErrorBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumRemovedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSharedInstance As WeakRef
	#tag EndProperty


	#tag Constant, Name = PageFinished, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageWorking, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events IntroActionButton
	#tag Event
		Sub Pressed()
		  Var ArkFolder As FolderItem
		  Try
		    ArkFolder = New FolderItem(Self.IntroArkPathField.Text, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Ark path is not valid", "Beacon was able to resolve the entered path. Use the choose button to select the folder containing the ShooterGame folder.")
		    Return
		  End Try
		  
		  Var ModsString As String = Self.IntroModsField.Text.Trim
		  If ModsString.IsEmpty Then
		    Self.ShowAlert("Don't forget to include some mods", "This process doesn't make much sense without mod ids does it?")
		    Return
		  End If
		  
		  Var ModIds() As String = ModsString.Split(",")
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "[^\d,]+"
		  Matcher.ReplacementPattern = ""
		  Matcher.Options.ReplaceAllMatches = True
		  ModsString = Matcher.Replace(ModsString)
		  
		  Var OfficialModNames() As String
		  Var OfficialModIds() As String
		  For Each ModId As String In ModIds
		    If ModId = "2171967557" Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = DataSource.GetContentPackWithSteamId(ModId)
		    If (Pack Is Nil) = False And Pack.IsLocal = False Then
		      OfficialModNames.Add(Pack.Name + " (" + ModId + ")")
		      OfficialModIds.Add(ModID)
		    End If
		    
		    If (Beacon.SafeToInvoke(Self.mCheckCallback) And Self.mCheckCallback.Invoke(ModID)) = False Then
		      Self.ShowAlert("Close your mod editors to continue", "There is an editor open for mod " + ModID + " that needs to be closed first.")
		      Return
		    End If
		  Next
		  
		  If OfficialModNames.Count > 0 Then
		    Var RemainingMods As Integer = ModIds.Count - OfficialModNames.Count
		    Var SkipCaption As String = "Skip Them"
		    
		    Var Message As String = If(RemainingMods > 0, "Beacon already supports some of your mods", "Beacon already supports your mods")
		    Var Explanation As String
		    If OfficialModNames.Count > 8 Then
		      Explanation = OfficialModNames.Count.ToString(Locale.Current, "#,##0") + " mods are already built into Beacon and do not need to be discovered."
		    ElseIf OfficialModNames.Count > 1 Then
		      Explanation = "The mods " + Language.EnglishOxfordList(OfficialModNames) + " are already built into Beacon and do not need to be discovered."
		    Else
		      Message = If(RemainingMods > 0, "Beacon already supports one of your mods", "Beacon already supports your mod")
		      Explanation = "The mod " + OfficialModNames(0) + " is already built into Beacon and does not need to be discovered."
		      SkipCaption = "Skip It"
		    End If
		    
		    Var ShouldSkip As Boolean
		    Var Choice As BeaconUI.ConfirmResponses
		    If RemainingMods > 0 Then
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, SkipCaption, "Cancel Discovery", "Discover Anyway")
		      ShouldSkip = (Choice = BeaconUI.ConfirmResponses.Action)
		    Else
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, "Discover Anyway", "Cancel Discovery", "")
		    End If
		    If Choice = BeaconUI.ConfirmResponses.Cancel Then
		      Return
		    End If
		    
		    If ShouldSkip Then
		      For Idx As Integer = ModIDs.LastIndex DownTo 0
		        If OfficialModIds.IndexOf(ModIds(Idx)) > -1 Then
		          ModIDs.RemoveAt(Idx)
		        End If
		      Next
		    End If
		  End If
		  
		  If ModIds.IndexOf("2171967557") = -1 Then
		    ModIds.Add("2171967557")
		  End If
		  Preferences.ArkSteamPath = ArkFolder.NativePath
		  Try
		    Self.Engine.Start(ArkFolder, ModIds)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Beacon could not start mod discovery", Err.Message)
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroCancelButton
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroArkPathButton
	#tag Event
		Sub Pressed()
		  Var InitialFolder As FolderItem
		  Try
		    InitialFolder = New FolderItem(Self.IntroArkPathField.Text, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.InitialFolder = InitialFolder
		  
		  Var SelectedFolder As FolderItem = Dialog.ShowModal(Self)
		  If SelectedFolder Is Nil Then
		    Return
		  End If
		  
		  Self.IntroArkPathField.Text = SelectedFolder.NativePath
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinishedActionButton
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Engine
	#tag Event
		Sub Error(ErrorMessage As String)
		  Self.ShowAlert("There was an error with mod discovery", ErrorMessage)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished()
		  If Beacon.SafeToInvoke(Self.mCompletedCallback) Then
		    Self.mCompletedCallback.Invoke(Self.mDiscoveredMods)
		  End If
		  
		  If Not Me.WasSuccessful Then
		    Self.Close()
		    Return
		  End If
		  
		  Var Message As String = "Added " + Language.NounWithQuantity(Self.mNumAddedMods, "new mod", "new mods") + ", " + Language.NounWithQuantity(Self.mNumAddedBlueprints, "new blueprint", "new blueprints") + ", and removed " + Language.NounWithQuantity(Self.mNumRemovedBlueprints, "blueprint", "blueprints") + "."
		  If Self.mNumErrorBlueprints > 0 Then
		    Message = Message + " " + Language.NounWithQuantity(Self.mNumErrorBlueprints, "blueprint", "blueprints") + " had errors and could not be imported."
		  End If
		  
		  Self.ShowAlert("Mod discovery has finished", Message)
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub Import(LogContents As String)
		  Var Importer As Ark.BlueprintImporter = Ark.BlueprintImporter.ImportAsDataDumper(LogContents)
		  If Importer Is Nil Or Importer.BlueprintCount = 0 Then
		    Return
		  End If
		  
		  Var Database As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		  
		  // Always skip DataDumper
		  Var ForbiddenWorkshopIds As New Dictionary
		  ForbiddenWorkshopIds.Value("2171967557") = True
		  
		  Var TitleFinder As New Regex
		  TitleFinder.SearchPattern = "<div class=""workshopItemTitle"">(.+)</div>"
		  TitleFinder.Options.Greedy = False
		  
		  Var Packs As New Dictionary
		  Var ModIds() As String = Me.ModIds
		  Var ModsFilter As New Beacon.StringList()
		  For Each WorkshopId As String In ModIds
		    If WorkshopId = "2171967557" Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = Database.GetContentPackWithSteamId(WorkshopId, Beacon.ContentPack.Types.Custom)
		    If Pack Is Nil Then
		      Var PackName As String = Me.GetTagForModId(WorkshopId)
		      If PackName.IsEmpty Then
		        PackName = WorkshopId
		      End If
		      
		      Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		      Socket.RequestHeader("User-Agent") = App.UserAgent
		      Socket.Send("GET", "https://steamcommunity.com/sharedfiles/filedetails/?id=" + WorkshopId)
		      If Socket.LastHTTPStatus = 200 Then
		        Var TitleMatch As RegexMatch = TitleFinder.Search(Socket.LastContent)
		        If (TitleMatch Is Nil) = False Then
		          PackName = DecodingFromHTMLMBS(TitleMatch.SubExpressionString(1))
		        End If
		      End If
		      
		      Pack = Database.CreateLocalContentPack(PackName, WorkshopId)
		      Self.mNumAddedMods = Self.mNumAddedMods + 1
		    Else
		      ModsFilter.Append(Pack.ContentPackId)
		    End If
		    
		    Packs.Value(WorkshopId) = Pack
		  Next
		  
		  Var CurrentBlueprints() As Ark.Blueprint = Database.GetBlueprints("", ModsFilter, "")
		  Var CurrentBlueprintMap As New Dictionary
		  For Each Blueprint As Ark.Blueprint In CurrentBlueprints
		    CurrentBlueprintMap.Value(Blueprint.Path) = Blueprint
		  Next
		  
		  Var BlueprintsToSave() As Ark.Blueprint
		  Var Blueprints() As Ark.Blueprint = Importer.Blueprints
		  Var NewBlueprintIds As New Dictionary
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Try
		      Var Path As String = Blueprint.Path
		      Var OriginalBlueprint As Ark.Blueprint
		      If CurrentBlueprintMap.HasKey(Path) Then
		        OriginalBlueprint = CurrentBlueprintMap.Value(Path)
		        CurrentBlueprintMap.Remove(Path)
		      End If
		      
		      Var PathComponents() As String = Path.Split("/")
		      Var Tag As String = PathComponents(3)
		      Var WorkshopId As String = Me.GetModIdForTag(Tag)
		      If Packs.HasKey(WorkshopId) = False Or ForbiddenWorkshopIDs.HasKey(WorkshopId) Then
		        Continue
		      End If
		      
		      Var Pack As Beacon.ContentPack = Packs.Value(WorkshopId)
		      
		      Var Mutable As Ark.MutableBlueprint
		      If (OriginalBlueprint Is Nil) = False Then
		        Mutable = OriginalBlueprint.MutableVersion
		        Mutable.Label = Blueprint.Label
		        #Pragma Warning "Import more than just the name"
		      Else
		        Mutable = Blueprint.MutableVersion
		        Mutable.ContentPackName = Pack.Name
		        Mutable.ContentPackId = Pack.ContentPackId
		        Mutable.RegenerateBlueprintId()
		      End If
		      BlueprintsToSave.Add(Mutable)
		      NewBlueprintIds.Value(Blueprint.BlueprintId) = True
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Pairing blueprint to mod")
		    End Try
		  Next
		  
		  Var BlueprintsToDelete() As Ark.Blueprint
		  Var DeleteBlueprintIDs As New Dictionary
		  For Each Entry As DictionaryEntry In CurrentBlueprintMap
		    BlueprintsToDelete.Add(Ark.Blueprint(Entry.Value))
		    DeleteBlueprintIDs.Value(Ark.Blueprint(Entry.Value).BlueprintId) = True
		  Next
		  
		  Var Errors As New Dictionary
		  Call Database.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors)
		  Self.mNumErrorBlueprints = Errors.KeyCount
		  Self.mNumAddedBlueprints = BlueprintsToSave.Count
		  Self.mNumRemovedBlueprints = BlueprintsToDelete.Count
		  
		  For Each Entry As DictionaryEntry In Errors
		    App.Log(RuntimeException(Entry.Value), CurrentMethodName, "Automatic mod discovery")
		    
		    Var BlueprintId As String = Entry.Key
		    If NewBlueprintIds.HasKey(BlueprintId) Then
		      Self.mNumAddedBlueprints = Self.mNumAddedBlueprints - 1
		    ElseIf DeleteBlueprintIDs.HasKey(BlueprintId) Then
		      Self.mNumRemovedBlueprints = Self.mNumRemovedBlueprints - 1
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Packs
		    Var WorkshopId As String = Entry.Key
		    Var Pack As Beacon.ContentPack = Entry.Value
		    
		    If ForbiddenWorkshopIds.HasKey(WorkshopId) Then
		      Continue
		    End If
		    
		    Self.mDiscoveredMods.Add(Pack)
		    
		    If Preferences.OnlineEnabled = False Then
		      Continue
		    End If
		    
		    Try
		      Var Exported As MemoryBlock = Ark.BuildExport(Pack)
		      If Exported Is Nil Then
		        Continue
		      End If
		      
		      Var Request As New BeaconAPI.Request("discovery/" + Pack.ContentPackId, "PUT", Exported, "application/octet-stream")
		      Call BeaconAPI.SendSync(Request) // Response doesn't actually matter
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Uploading discovery results")
		    End Try
		  Next
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.WorkingStatus.Text = Me.StatusMessage
		  Self.Pages.SelectedPanelIndex = Self.PageWorking
		End Sub
	#tag EndEvent
	#tag Event
		Sub StatusUpdated()
		  Self.WorkingStatus.Text = Me.StatusMessage
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
