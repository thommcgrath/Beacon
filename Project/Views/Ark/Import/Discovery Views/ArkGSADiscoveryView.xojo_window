#tag Window
Begin ArkDiscoveryView ArkGSADiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   402
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   576
   Begin PagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   402
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   576
      Begin Label UserTokenMessage
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabStop         =   True
         Text            =   "GameServerApp.com API Token"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   536
      End
      Begin Label UserTokenExplanation
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   54
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "On your GameServerApp.com dashboard you will find an ""API / Integrate"" option where you can issue a token for Beacon. Copy the token into the field below to continue. Remember to keep your token in a safe place in case you need it again."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   536
      End
      Begin UITweaks.ResizedPushButton UserTokenDashboardButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Take Me There"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   229
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   118
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   118
      End
      Begin CodeArea UserTokenArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   166
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   184
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   536
      End
      Begin UITweaks.ResizedPushButton UserTokenActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   476
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton UserTokenCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   384
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField UserTokenNameField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   149
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   150
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   407
      End
      Begin UITweaks.ResizedLabel UserTokenNameLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Name Your Token:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   150
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   117
      End
      Begin ProgressBar ListingIndicator
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   207
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   536
      End
      Begin Label ListingMessage
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         Text            =   "Finding config templates…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   175
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   536
      End
      Begin Label TemplatesMessage
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Your config templates"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   536
      End
      Begin UITweaks.ResizedPushButton TemplatesLinkAdditionalButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Link Another Account"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   160
      End
      Begin UITweaks.ResizedPushButton TemplatesCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   384
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton TemplatesActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   476
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox TemplatesList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "26,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   "#BeaconListbox.StandardRowHeight"
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   0
         GridLinesVerticalStyle=   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   298
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   " 	Name"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   536
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton ListingCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   476
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   362
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.TemplatesList.RemoveAllRows()
		  Self.CheckTemplatesActionEnabled()
		  Self.mPendingEngines.ResizeTo(-1)
		  Self.mActiveEngine = Nil
		  Self.mSuccess = False
		  
		  If Self.mAccounts.Count = 0 Then
		    Self.StartNewAccount()
		    Return
		  End If
		  
		  Var Accounts() As Beacon.ExternalAccount = Self.mAccounts.ForProvider(Beacon.ExternalAccount.ProviderGameServerApp)
		  For Each Account As Beacon.ExternalAccount In Accounts
		    Self.ListTemplatesForAccount(Account)
		  Next
		  
		  Self.Views.SelectedPanelIndex = Self.PageListingTemplates
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetValuesFromProject(Project As Beacon.Project)
		  Self.mAccounts.Import(Project.Accounts)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Var TopMargin As Integer = 20
		  Var BottomMargin As Integer = 40 + Self.ListingCancelButton.Height
		  Var IndicatorGroup As New ControlGroup(Self.ListingIndicator, Self.ListingMessage)
		  IndicatorGroup.Top = TopMargin + (((Self.Height - (TopMargin + BottomMargin)) - IndicatorGroup.Height) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AdvanceListQueue()
		  If Self.mPendingEngines.Count = 0 Then
		    // Finished
		    If Self.mSuccess Then
		      If Self.TemplatesList.RowCount > 0 Then
		        Self.Views.SelectedPanelIndex = Self.PageTemplateList
		      Else
		        Self.ShowAlert("No editable config templates found", "Beacon was unable to find any editable config templates in your account. Use the ""Config templates"" section of your GameServerApp.com dashboard to create a new editable config template.")
		        Self.ShouldCancel
		      End If
		    Else
		      Self.ShouldCancel
		    End If
		    Return
		  End If
		  
		  Var Engine As Ark.GSAIntegrationEngine = Self.mPendingEngines(0)
		  Self.mActiveEngine = Engine
		  Self.mPendingEngines.RemoveAt(0)
		  
		  AddHandler Engine.Discovered, WeakAddressOf Engine_Discovered
		  Engine.BeginDiscovery(Self.Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckTemplatesActionEnabled()
		  For Idx As Integer = 0 To Self.TemplatesList.LastRowIndex
		    If Self.TemplatesList.CellCheckBoxValueAt(Idx, 0) Then
		      Self.TemplatesActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.TemplatesActionButton.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckUserTokenActionButton()
		  Self.UserTokenActionButton.Enabled = Self.UserTokenNameField.Text.Trim.IsEmpty = False And Self.UserTokenArea.Text.Trim.IsEmpty = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAccounts = New Beacon.ExternalAccountManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Engine_Discovered(Sender As Ark.GSAIntegrationEngine, Data() As Beacon.DiscoveredData)
		  Self.mActiveEngine = Nil
		  
		  If Sender.Errored Then
		    Self.ShowAlert("Unable to retrieve server list from GameServerApp.com", "The error message provided was:" + EndOfLine + EndOfLine + Sender.ErrorMessage + EndOfLine + EndOfLine + "This error may be temporary, so try again in a few minutes. If the problem persists, make sure your antivirus or malware protection is not blocking Beacon from contacting GameServerApp.com's servers.")
		    Self.AdvanceListQueue()
		    Return
		  End If
		  
		  For Each Server As Beacon.DiscoveredData In Data
		    Self.TemplatesList.AddRow("", Server.Profile.Name)
		    Self.TemplatesList.RowTagAt(Self.TemplatesList.LastAddedRowIndex) = Server
		  Next
		  
		  Self.mSuccess = True
		  Self.AdvanceListQueue()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListTemplatesForAccount(Account As Beacon.ExternalAccount)
		  Self.mPendingEngines.Add(New Ark.GSAIntegrationEngine(Account))
		  
		  If (Self.mActiveEngine Is Nil) = False Then
		    Return
		  End If
		  
		  Self.AdvanceListQueue()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartNewAccount()
		  Self.UserTokenNameField.Text = ""
		  Self.UserTokenArea.Text = ""
		  Self.Views.SelectedPanelIndex = Self.PageUserToken
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActiveEngine As Ark.GSAIntegrationEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingEngines() As Ark.GSAIntegrationEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty


	#tag Constant, Name = PageListingTemplates, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageTemplateList, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageUserToken, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub Change()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageUserToken
		    Self.DesiredHeight = 400
		  Case Self.PageListingTemplates
		    Self.DesiredHeight = 200
		  Case Self.PageTemplateList
		    Self.DesiredHeight = 400
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserTokenDashboardButton
	#tag Event
		Sub Action()
		  System.GotoURL(Beacon.WebURL("/gsatoken"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserTokenArea
	#tag Event
		Sub TextChange()
		  Self.CheckUserTokenActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserTokenActionButton
	#tag Event
		Sub Action()
		  Var Account As New Beacon.ExternalAccount(v4UUID.Create, Self.UserTokenNameField.Text.Trim, Beacon.ExternalAccount.ProviderGameServerApp, Self.UserTokenArea.Text.Trim, "", New DateTime(2999, 12, 31, 0, 0, 0, 0, New TimeZone(0)))
		  Self.mAccounts.Add(Account)
		  Self.ListTemplatesForAccount(Account)
		  
		  Self.Views.SelectedPanelIndex = Self.PageListingTemplates
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserTokenCancelButton
	#tag Event
		Sub Action()
		  If Self.TemplatesList.RowCount = 0 Then
		    Self.ShouldCancel()
		  ElseIf Self.mPendingEngines.Count > 0 Then
		    Self.Views.SelectedPanelIndex = Self.PageListingTemplates
		  Else
		    Self.Views.SelectedPanelIndex = Self.PageTemplateList
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserTokenNameField
	#tag Event
		Sub TextChange()
		  Self.CheckUserTokenActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesLinkAdditionalButton
	#tag Event
		Sub Action()
		  Self.StartNewAccount()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesActionButton
	#tag Event
		Sub Action()
		  Var Data() As Beacon.DiscoveredData
		  For Idx As Integer = 0 To Self.TemplatesList.LastRowIndex
		    If Not Self.TemplatesList.CellCheckBoxValueAt(Idx, 0) Then
		      Continue
		    End If
		    
		    Var Template As Ark.GSADiscoveredData = Self.TemplatesList.RowTagAt(Idx)
		    Data.Add(Template)
		  Next
		  Self.ShouldFinish(Data, Self.mAccounts)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesList
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Self.CheckTemplatesActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListingCancelButton
	#tag Event
		Sub Action()
		  If (Self.mActiveEngine Is Nil) = False Then
		    RemoveHandler Self.mActiveEngine.Discovered, WeakAddressOf Engine_Discovered
		    Self.mActiveEngine.Cancel
		    Self.mActiveEngine = Nil
		  End If
		  Self.mPendingEngines.ResizeTo(-1)
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
