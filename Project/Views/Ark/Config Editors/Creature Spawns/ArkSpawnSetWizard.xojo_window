#tag DesktopWindow
Begin BeaconDialog ArkSpawnSetWizard
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
   Height          =   266
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   206
   MaximumWidth    =   500
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   206
   MinimumWidth    =   500
   Resizeable      =   False
   Title           =   "Spawn Set Creation Wizard"
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
      Text            =   "Spawn Set Creation Wizard"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      Left            =   400
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   226
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
      Left            =   308
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
      Top             =   226
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel CreatureLabel
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin UITweaks.ResizedPushButton SelectCreatureButton
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
      Left            =   163
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel CreatureNameField
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   261
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Not Selected"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   219
   End
   Begin RangeField RadiusField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
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
      Left            =   163
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
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   92
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel RadiusLabel
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Radius:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   92
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin DesktopSlider RadiusSlider
      AllowAutoDeactivate=   True
      AllowLiveScrolling=   True
      Enabled         =   True
      Height          =   23
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   261
      LineStep        =   1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumValue    =   30000
      MinimumValue    =   0
      PageStep        =   50
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TickMarkStyle   =   0
      Tooltip         =   ""
      Top             =   92
      Transparent     =   False
      Value           =   3000
      Visible         =   True
      Width           =   219
   End
   Begin UITweaks.ResizedPopupMenu TemplateMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Average Spawn\nCommon Spawn (+50% of Average)\nRare Spawn (5% of Average)"
      Italic          =   False
      Left            =   163
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   317
   End
   Begin UITweaks.ResizedLabel TemplateLabel
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Template:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin UITweaks.ResizedLabel MinPackSizeLabel
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Minimum Pack Size:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin UITweaks.ResizedLabel MaxPackSizeLabel
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Maximum Pack Size:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin RangeField MinPackSizeField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
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
      Left            =   163
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   86
   End
   Begin RangeField MaxPackSizeField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
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
      Left            =   163
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   86
   End
   Begin DesktopLabel PackSizeRadiusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   56
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   261
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   True
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Pack size is limited to 1 when radius is less than 300."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   219
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.RadiusField.DoubleValue = Self.RadiusSlider.Value
		  Self.MinPackSizeField.DoubleValue = 1
		  Self.MaxPackSizeField.DoubleValue = 1
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function AverageSetWeight() As Double
		  Var Points() As Ark.MutableSpawnPoint = Self.mOrganizer.Points
		  If Points.Count = 0 Then
		    Return 0.5
		  End If
		  
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var Sum As Double
		  Var NumSets As Integer
		  For Each Point As Ark.MutableSpawnPoint In Points
		    If Point.Mode = Ark.SpawnPoint.ModeRemove Then
		      Continue
		    End If
		    
		    If Point.Mode = Ark.SpawnPoint.ModeAppend Then
		      Var Official As Ark.SpawnPoint = DataSource.GetSpawnPointByUUID(Point.ObjectID)
		      If (Official Is Nil) = False Then
		        Var OfficialMutable As Ark.MutableSpawnPoint = Official.MutableVersion
		        DataSource.LoadDefaults(OfficialMutable)
		        For Each Set As Ark.SpawnPointSet In OfficialMutable
		          Sum = Sum + Set.RawWeight
		        Next
		        NumSets = NumSets + OfficialMutable.Count
		      End If
		    End If
		    
		    For Each Set As Ark.SpawnPointSet In Point
		      Sum = Sum + Set.RawWeight
		    Next
		    NumSets = NumSets + Point.Count
		  Next
		  
		  If NumSets = 0 Then
		    Return 0.5
		  End If
		  
		  Return Sum / NumSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckRadius()
		  Var Radius As Double = Self.RadiusField.DoubleValue
		  If Radius < 300 Then
		    Self.MinPackSizeField.DoubleValue = 1
		    Self.MaxPackSizeField.DoubleValue = 1
		    If Self.MinPackSizeField.Enabled = True Then
		      Self.MinPackSizeField.Enabled = False
		    End If
		    If Self.MaxPackSizeField.Enabled = True Then
		      Self.MaxPackSizeField.Enabled = False
		    End If
		    If Self.PackSizeRadiusLabel.Visible = False Then
		      Self.PackSizeRadiusLabel.Visible = True
		    End If
		  Else
		    If Self.MinPackSizeField.Enabled = False Then
		      Self.MinPackSizeField.Enabled = True
		    End If
		    If Self.MaxPackSizeField.Enabled = False Then
		      Self.MaxPackSizeField.Enabled = True
		    End If
		    If Self.PackSizeRadiusLabel.Visible = True Then
		      Self.PackSizeRadiusLabel.Visible = False
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Organizer As Ark.SpawnSetOrganizer, Mods As Beacon.StringList)
		  Self.mOrganizer = Organizer
		  Self.mMods = Mods
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Organizer As Ark.SpawnSetOrganizer, Mods As Beacon.StringList) As Boolean
		  If Parent = Nil Or Organizer = Nil Then
		    Return False
		  End If
		  
		  Var Win As New ArkSpawnSetWizard(Organizer, Mods)
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
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrganizer As Ark.SpawnSetOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedCreature As Ark.Creature
	#tag EndProperty


	#tag Constant, Name = TemplateAverage, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TemplateCommon, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TemplateRare, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.mSelectedCreature = Nil Then
		    Self.ShowAlert("Please select a creature", "Use the ""Choose…"" button to select a target creature if you wish to continue.")
		    Return
		  End If
		  
		  Var Radius As Double = Self.RadiusField.DoubleValue
		  Var TemplateIdx As Integer = Self.TemplateMenu.SelectedRowIndex
		  Var Entries() As Ark.MutableSpawnPointSetEntry
		  Var Weight As Double = 0.5
		  Var Limit As Double = 0.05
		  Var OverrideLimit As Boolean = False
		  
		  Var MinPackSize As Integer = Self.MinPackSizeField.DoubleValue
		  Var MaxPackSize As Integer = Self.MaxPackSizeField.DoubleValue
		  If MinPackSize > MaxPackSize Then
		    Var Temp As Integer = MinPackSize
		    MinPackSize = MaxPackSize
		    MaxPackSize = Temp
		  End If
		  
		  If Radius = 0 Or (MinPackSize = 1 And MaxPackSize = 1) Then
		    // We only need one entry and no parameters
		    Entries.Add(New Ark.MutableSpawnPointSetEntry(Self.mSelectedCreature))
		  Else
		    // We'll create five entries to create a proper spread
		    
		    Var Randomizer As Random = System.Random
		    Randomizer.RandomizeSeed
		    Radius = Radius / 2
		    Var OffsetRadius As Double = Radius / 2 // For 1/4 of the original
		    
		    For PackNum As Integer = 1 To MaxPackSize
		      Var Entry As New Ark.MutableSpawnPointSetEntry(Self.mSelectedCreature)
		      If PackNum > MaxPackSize - MinPackSize Then
		        Entry.SpawnChance = 1.0
		      Else
		        Entry.SpawnChance = PackNum / ((MaxPackSize - MinPackSize) + 1)
		      End If
		      
		      Var Rad As Double = OffsetRadius * Sqrt(Randomizer.Number)
		      Var Theta As Double = Randomizer.Number * 2 * Beacon.Pi
		      Var OffsetX As Double = Rad * Cos(Theta)
		      Var OffsetY As Double = Rad * Sin(Theta)
		      Entry.Offset = New Beacon.Point3D(Round(OffsetX), Round(OffsetY), 0.0)
		      
		      Entries.Add(Entry)
		    Next
		  End If
		  
		  Select Case TemplateIdx
		  Case Self.TemplateAverage
		    Weight = Self.AverageSetWeight
		  Case Self.TemplateCommon
		    Weight = Self.AverageSetWeight * 1.50
		    Limit = 0.1
		  Case Self.TemplateRare
		    Weight = Self.AverageSetWeight * 0.05
		  End Select
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.mOrganizer.Template
		  Set.Label = Self.mOrganizer.FindUniqueSetLabel(Self.mSelectedCreature.Label)
		  Set.SpreadRadius = Radius
		  Set.Weight = Weight
		  For Each Entry As Ark.MutableSpawnPointSetEntry In Entries
		    Set.Append(Entry)
		  Next
		  Self.mOrganizer.SetLimit(Self.mSelectedCreature, Limit, OverrideLimit)
		  
		  Self.mOrganizer.Replicate
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
#tag Events SelectCreatureButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Creature
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If Creatures = Nil Or Creatures.LastIndex <> 0 Then
		    Return
		  End If
		  
		  Self.mSelectedCreature = Creatures(0)
		  Self.CreatureNameField.Text = Self.mSelectedCreature.Label
		  Self.CreatureNameField.Italic = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RadiusField
	#tag Event
		Sub ValueChanged()
		  If Self.RadiusSlider.Value <> Me.DoubleValue Then
		    Self.RadiusSlider.Value = Me.DoubleValue
		    Self.CheckRadius()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RadiusSlider
	#tag Event
		Sub ValueChanged()
		  If Self.RadiusField.DoubleValue <> Me.Value Then
		    Self.RadiusField.DoubleValue = Me.Value
		    Self.CheckRadius()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinPackSizeField
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 1
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxPackSizeField
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 1
		  MaxValue = 1000000
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
