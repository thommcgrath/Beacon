#tag DesktopWindow
Begin DesktopContainer ModFilterView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   268
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
   Width           =   300
   Begin DesktopGroupBox TypesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#GroupCaptionTypes"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   140
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   260
      Begin DesktopCheckBox TypeLocalCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "#CheckboxLabelLocal"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "TypesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "#CheckboxTooltipLocal"
         Top             =   56
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   220
      End
      Begin DesktopCheckBox TypeLocalReadOnlyCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "#CheckboxLabelLocalReadOnly"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "TypesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "#CheckboxTooltipLocal"
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   220
      End
      Begin DesktopCheckBox TypeRemoteCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "#CheckboxLabelRemote"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "TypesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "#CheckboxTooltipRemote"
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   220
      End
   End
   Begin DesktopGroupBox GamesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "#GroupCaptionGames"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   76
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   172
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   260
      Begin DesktopCheckBox GameCheckboxes
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Untitled"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   0
         InitialParent   =   "GamesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   208
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   220
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var NextTop As Integer = Self.GameCheckboxes(0).Top
		  Var Games() As Beacon.Game = Beacon.Games
		  For Idx As Integer = 0 To Games.LastIndex
		    Var Check As DesktopCheckBox = Self.GameCheckboxes(Idx)
		    If Check Is Nil Then
		      Check = New GameCheckboxes
		    End If
		    Check.Caption = Games(Idx).Name
		    Check.Top = NextTop
		    Check.Height = 20
		    Check.Width = Self.Width - 80
		    Check.Left = 40
		    Check.Enabled = True
		    Check.Value = Self.mSettings.Enabled(Games(Idx))
		    NextTop = Check.Bottom + 12
		  Next
		  
		  Self.GamesGroup.Height = (Games.Count * 20) + ((Games.Count - 1) * 12) + 56
		  Self.Height = 52 + Self.TypesGroup.Height + Self.GamesGroup.Height
		  
		  Self.TypeLocalCheck.Value = Self.mSettings.Enabled(CType(ModsListView.ViewModes.Local, Integer))
		  Self.TypeLocalReadOnlyCheck.Value = Self.mSettings.Enabled(CType(ModsListView.ViewModes.LocalReadOnly, Integer))
		  Self.TypeRemoteCheck.Value = Self.mSettings.Enabled(CType(ModsListView.ViewModes.Remote, Integer))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Settings As ModFilterSettings)
		  Self.mSettings = Settings
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Settings() As ModFilterSettings
		  Var Types As Integer
		  If Self.TypeLocalCheck.Value Then
		    Types = Types Or CType(ModsListView.ViewModes.Local, Integer)
		  End If
		  If Self.TypeLocalReadOnlyCheck.Value Then
		    Types = Types Or CType(ModsListView.ViewModes.LocalReadOnly, Integer)
		  End If
		  If Self.TypeRemoteCheck.Value Then
		    Types = Types Or CType(ModsListView.ViewModes.Remote, Integer)
		  End If
		  
		  Var Games() As Beacon.Game = Beacon.Games
		  Var GameIds() As String
		  For Idx As Integer = 0 To Games.LastIndex
		    If Self.GameCheckboxes(Idx).Value Then
		      GameIds.Add(Games(Idx).Identifier)
		    End If
		  Next
		  
		  Return New ModFilterSettings(Types, GameIds)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSettings As ModFilterSettings
	#tag EndProperty


	#tag Constant, Name = CheckboxLabelLocal, Type = String, Dynamic = True, Default = \"Custom", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckboxLabelLocalReadOnly, Type = String, Dynamic = True, Default = \"Beacon-Supplied", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckboxLabelRemote, Type = String, Dynamic = True, Default = \"Registered", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckboxTooltipLocal, Type = String, Dynamic = True, Default = \"Mods you have added to your Beacon account\x2C such as through Mod Discovery\x2C the Community tab\x2C or the \"Add Mod\" button.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckboxTooltipLocalReadOnly, Type = String, Dynamic = True, Default = \"Mods included with Beacon that can be viewed\x2C but not edited.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckboxTooltipRemote, Type = String, Dynamic = True, Default = \"Mods you have created and added to Beacon\'s official data using the \"Register Mod\" button.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GroupCaptionGames, Type = String, Dynamic = True, Default = \"Games", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GroupCaptionTypes, Type = String, Dynamic = True, Default = \"Types", Scope = Private
	#tag EndConstant


#tag EndWindowCode

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
