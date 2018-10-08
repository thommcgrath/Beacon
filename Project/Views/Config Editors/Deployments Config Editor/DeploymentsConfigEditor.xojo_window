#tag Window
Begin ConfigEditor DeploymentsConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   506
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
   Width           =   856
   Begin BeaconListbox ServerList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   40
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   465
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   299
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   506
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   299
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin FadedSeparator FadedSeparator2
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   299
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Servers"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   "0"
      Scope           =   0
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   299
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  For I As Integer = 0 To Self.Document.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.Document.ServerProfile(I)
		    
		    Self.ServerList.AddRow(Profile.Name + EndOfLine + Profile.SecondaryName)
		    Self.ServerList.RowTag(Self.ServerList.LastIndex) = Profile
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Dim SelectedProfiles() As Beacon.ServerProfile
		  For I As Integer = 0 To Self.ServerList.RowCount - 1
		    If Self.ServerList.Selected(I) Then
		      SelectedProfiles.Append(Self.ServerList.RowTag(I))
		    End If
		  Next
		  
		  Self.ServerList.RowCount = Self.Document.ServerProfileCount
		  
		  For I As Integer = 0 To Self.Document.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.Document.ServerProfile(I)
		    
		    // Don't use IndexOf as it doesn't utilize Operator_Compare
		    Dim Selected As Boolean
		    For X As Integer = 0 To SelectedProfiles.Ubound
		      If SelectedProfiles(X) = Profile Then
		        Selected = True
		        SelectedProfiles.Remove(X)
		        Exit For X
		      End If
		    Next
		    
		    Self.ServerList.RowTag(I) = Profile
		    Self.ServerList.Cell(I, 0) = Profile.Name + EndOfLine + Profile.SecondaryName
		    Self.ServerList.Selected(I) = Selected
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  Self.mViews = New Xojo.Core.Dictionary
		  Super.Constructor(Controller)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_ContentsChanged(Sender As DeployContainer)
		  Self.ContentsChanged = Sender.ContentsChanged
		  
		  For I As Integer = 0 To Self.ServerList.ListCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.ServerList.RowTag(I)
		    Dim Status As String = Profile.Name + EndOfLine + Profile.SecondaryName
		    If Self.ServerList.Cell(I, 0) <> Status Then
		      Self.ServerList.Cell(I, 0) = Status
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentProfileID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentProfileID = Value Then
			    Return
			  End If
			  
			  If Self.mCurrentProfileID <> "" Then
			    Dim View As DeployContainer = Self.mViews.Value(Self.mCurrentProfileID)
			    View.Visible = False
			    Self.mCurrentProfileID = ""
			  End If
			  
			  If Not Self.mViews.HasKey(Value) Then
			    Return
			  End If
			  
			  Dim View As DeployContainer = Self.mViews.Value(Value)
			  View.Visible = True
			  Self.mCurrentProfileID = Value
			End Set
		#tag EndSetter
		CurrentProfileID As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViews.HasKey(Self.mCurrentProfileID) Then
			    Return DeployContainer(Self.mViews.Value(Self.mCurrentProfileID))
			  End If
			End Get
		#tag EndGetter
		CurrentView As DeployContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentProfileID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Xojo.Core.Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub Change()
		  If Me.ListIndex = -1 Then
		    Self.CurrentProfileID = ""
		    Return
		  End If
		  
		  Dim Profile As Beacon.ServerProfile = Me.RowTag(Me.ListIndex)
		  Dim ProfileID As Text = Profile.ProfileID
		  If Not Self.mViews.HasKey(ProfileID) Then
		    // Create the view
		    Dim View As DeployContainer
		    Select Case Profile
		    Case IsA Beacon.NitradoServerProfile
		      View = New NitradoDeploymentView(Self.Document, Profile)
		    Case IsA Beacon.FTPServerProfile
		      
		    Else
		      Self.CurrentProfileID = ""
		      Return
		    End Select
		    
		    View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		    AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		    Self.mViews.Value(ProfileID) = View
		  End If
		  Self.CurrentProfileID = ProfileID
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Dim SelCount As Integer = Me.SelCount
		  If SelCount = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Dim Subject As String = If(SelCount = 1, "server", "servers")
		    Dim DemonstrativeAdjective As String = If(SelCount = 1, "this", "these " + SelCount.ToText)
		    If Not Self.ShowConfirm("Are you sure you want to delete " + DemonstrativeAdjective + " " + Subject + "?", "The " + Subject + " can be added again later using the ""Import"" feature next to the ""Config Type"" menu.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.Selected(I) Then
		      Dim Profile As Beacon.ServerProfile = Me.RowTag(I)
		      If Self.mViews.HasKey(Profile.ProfileID) Then
		        If Self.CurrentProfileID = Profile.ProfileID Then
		          Self.CurrentProfileID = ""
		        End If
		        
		        Dim Panel As DeployContainer = Self.mViews.Value(Profile.ProfileID)
		        Panel.Close
		        Self.mViews.Remove(Profile.ProfileID)
		      End If
		      Self.Document.Remove(Profile)
		      Self.ContentsChanged = True
		      Me.RemoveRow(I)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentProfileID"
		Group="Behavior"
		Type="Text"
	#tag EndViewProperty
#tag EndViewBehavior
