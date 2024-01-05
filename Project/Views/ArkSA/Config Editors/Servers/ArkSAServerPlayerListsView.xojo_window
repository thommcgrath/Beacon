#tag DesktopWindow
Begin BeaconContainer ArkSAServerPlayerListsView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   466
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
   Visible         =   True
   Width           =   644
   Begin UITweaks.ResizedComboBox URLFields
      AllowAutoComplete=   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Hint            =   ""
      Index           =   0
      InitialValue    =   ""
      Italic          =   False
      Left            =   189
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   435
   End
   Begin UITweaks.ResizedComboBox URLFields
      AllowAutoComplete=   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Hint            =   ""
      Index           =   1
      InitialValue    =   ""
      Italic          =   False
      Left            =   189
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   435
   End
   Begin UITweaks.ResizedLabel Labels
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
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
      Text            =   "Admin List URL:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin UITweaks.ResizedLabel Labels
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   1
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
      Text            =   "Ban List URL:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin SwitchControl Switches
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   0
      Left            =   137
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin SwitchControl Switches
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   1
      Left            =   137
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function Modified() As Boolean
		  For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		    If (Profile Is Nil) = False And Profile.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As ArkSA.ServerProfile
		  For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		    If (Profile Is Nil) = False Then
		      Return Profile
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Profile(Assigns Profile As ArkSA.ServerProfile)
		  Var Items(0) As ArkSA.ServerProfile
		  Items(0) = Profile
		  Self.Profiles = Items
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profiles() As ArkSA.ServerProfile()
		  Return Self.mProfiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Profiles(Assigns Items() As ArkSA.ServerProfile)
		  Self.mProfiles = Items
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Project() As ArkSA.Project
		  Return RaiseEvent GetProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshUI()
		  Var Profile As ArkSA.ServerProfile = Self.Profile
		  
		  If Self.SettingUp Or Profile Is Nil Then
		    Return
		  End If
		  
		  Self.mSettingUp = True
		  
		  Const MinIndex As Integer = Self.AdminListIndex
		  Const MaxIndex As Integer = Self.BanListIndex
		  
		  Var Arr() As DesktopLabel
		  For Idx As Integer = 0 To Arr.LastIndex
		    If Self.Labels(Idx).Visible Then
		      Arr.Add(Self.Labels(Idx))
		    End If
		  Next
		  If Arr.Count > 0 Then
		    BeaconUI.SizeToFit(Arr)
		  End If
		  
		  Var SwitchLeft As Integer = Self.Labels(Self.AdminListIndex).Right + 12
		  Var FieldLeft As Integer = SwitchLeft + Self.Switches(AdminListIndex).Width + 12
		  Var FieldWidth As Integer = Self.Width - (FieldLeft + 20)
		  Var Config As ArkSA.ConfigGroup = Self.Project.ConfigGroup(ArkSA.Configs.NamePlayerLists, Beacon.ConfigSet.BaseConfigSet, False)
		  Var Lists() As ArkSA.PlayerList
		  Var Names() As String
		  If (Config Is Nil) = False And Config IsA ArkSA.Configs.PlayerLists Then
		    Lists = ArkSA.Configs.PlayerLists(Config).Lists
		    Names = ArkSA.Configs.PlayerLists(Config).ListNames
		    Names.SortWith(Lists)
		  End If
		  
		  For Idx As Integer = MinIndex To MaxIndex
		    Self.Switches(Idx).Left = SwitchLeft
		    
		    Var Field As DesktopComboBox = Self.URLFields(Idx)
		    Field.Left = FieldLeft
		    Field.Width = FieldWidth
		    
		    Field.RemoveAllRows
		    For Each List As ArkSA.PlayerList In Lists
		      Field.AddRow(New DesktopMenuItem(List.Name, List.PlayerListId))
		    Next
		  Next
		  
		  Self.SetFieldValue(Self.AdminListIndex, Profile.AdminListUrl)
		  Self.SetFieldValue(Self.BanListIndex, Profile.BanListUrl)
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetFieldValue(Idx As Integer, Value As NullableString)
		  Var Field As DesktopComboBox = Self.URLFields(Idx)
		  Var Switch As SwitchControl = Self.Switches(Idx)
		  
		  Field.SelectedRowIndex = -1
		  
		  If Value Is Nil Then
		    Switch.Value(False) = False
		    Field.Enabled = False
		    Field.Text = ""
		    Return
		  End If
		  
		  Switch.Value(False) = True
		  Field.Enabled = True
		  
		  Var StringValue As String = Value.StringValue
		  For RowIdx As Integer = 0 To Field.LastRowIndex
		    If Field.RowTextAt(RowIdx) = StringValue Or Field.RowTagAt(RowIdx) = StringValue Then
		      Field.Text = Field.RowTextAt(RowIdx)
		      Return
		    End If
		  Next
		  
		  Field.Text = StringValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SettingUp() As Boolean
		  Return Self.mSettingUp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ValidateField(Idx As Integer, Silent As Boolean)
		  Var Field As DesktopComboBox = Self.URLFields(Idx)
		  Var Content As String = Field.Text
		  
		  If Content.IsEmpty Or Content.BeginsWith("http://") Or Content.BeginsWith("https://") Then
		    // Accept as-is
		    
		    Select Case Idx
		    Case Self.AdminListIndex
		      For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		        Profile.AdminListUrl = Content
		      Next
		    Case Self.BanListIndex
		      For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		        Profile.BanListUrl = Content
		      Next
		    End Select
		    
		    Self.Modified = Self.Modified
		    Return
		  End If
		  
		  Var ListId As String
		  For RowIdx As Integer = 0 To Field.LastRowIndex
		    If Field.RowTextAt(RowIdx) = Content Or Field.RowTagAt(RowIdx).StringValue = Content Then
		      ListId = Field.RowTagAt(RowIdx).StringValue
		      Exit For RowIdx
		    End If
		  Next
		  
		  If ListId.IsEmpty Then
		    If Not Silent Then
		      Self.ShowAlert("The value should be a url or the name of a player list.", "Please enter a value that begins with https:// or http://, or is the name of a player list in this project. The menu to the right of the field can help with choosing a player list.")
		      Field.SetFocus
		    End If
		    Return
		  End If
		  
		  Select Case Idx
		  Case Self.AdminListIndex
		    For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		      Profile.AdminListUrl = ListId
		    Next
		  Case Self.BanListIndex
		    For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		      Profile.BanListUrl = ListId
		    Next
		  End Select
		  
		  Self.Modified = Self.Modified
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetProject() As ArkSA.Project
	#tag EndHook


	#tag Property, Flags = &h21
		Private mProfiles() As ArkSA.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = AdminListIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BanListIndex, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events URLFields
	#tag Event
		Sub SelectionChanged(index as Integer, item As DesktopMenuItem)
		  #Pragma Unused Index
		  #Pragma Unused Item
		  
		  If Me.SelectedRowIndex <> -1 Then
		    Me.SelectedRowIndex = -1
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChanged(index as Integer)
		  If Self.SettingUp Or Self.Switches(Index).Enabled = False Then
		    Return
		  End If
		  
		  Self.ValidateField(Index, True)
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(index as Integer, key As String) As Boolean
		  If Key = Chr(10) Or Key = Chr(13) Then
		    Self.ValidateField(Index, False)
		    Return True
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Switches
	#tag Event
		Sub Pressed(index as Integer)
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.mSettingUp = True
		  
		  Var Value As NullableString
		  If Me.Value Then
		    Value = ""
		  End If
		  
		  Select Case Index
		  Case Self.AdminListIndex
		    For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		      Profile.AdminListUrl = Value
		    Next
		  Case Self.BanListIndex
		    For Each Profile As ArkSA.ServerProfile In Self.mProfiles
		      Profile.BanListUrl = Value
		    Next
		  End Select
		  Self.SetFieldValue(Index, Value)
		  Self.Modified = Self.Modified
		  
		  Self.mSettingUp = False
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
#tag EndViewBehavior
