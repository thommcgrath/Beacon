#tag DesktopWindow
Begin BeaconContainer RCONCommandBuilder
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   400
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
   Width           =   600
   Begin UITweaks.ResizedPushButton InsertButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Insert"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel CommandLabel
      AllowAutoDeactivate=   True
      Bold            =   True
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Command"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel DescriptionLabel
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Description"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Or Self.mShouldMeasure Then
		    Self.CommandLabel.SizeToFit
		    Self.mCommandMinWidth = Self.CommandLabel.Width
		    Self.mShouldMeasure = False
		  End If
		  
		  Const Margin = RCONWindow.SidebarMargin
		  Const Spacing = RCONWindow.SidebarSpacing
		  
		  Var MinWidth As Integer = (Margin * 2) + Max(Self.mCommandMinWidth, Self.InsertButton.Width + Spacing + Self.CancelButton.Width)
		  
		  Self.CommandLabel.Left = Margin
		  Self.CommandLabel.Top = Margin
		  Self.CommandLabel.Width = Self.Width - (Margin * 2)
		  
		  Self.DescriptionLabel.Left = Margin
		  Self.DescriptionLabel.Top = Self.CommandLabel.Bottom + Spacing
		  Self.DescriptionLabel.Width = Self.CommandLabel.Width
		  Self.DescriptionLabel.Height = BeaconUI.IdealHeight(Self.DescriptionLabel)
		  
		  Self.InsertButton.Top = Self.Height - (Margin + Self.InsertButton.Height)
		  Self.InsertButton.Left = Self.Width - (Margin + Self.InsertButton.Width)
		  Self.CancelButton.Top = Self.InsertButton.Top
		  Self.CancelButton.Left = Self.InsertButton.Left - (Spacing + Self.CancelButton.Width)
		  
		  Var NextCellTop As Integer = Self.DescriptionLabel.Bottom
		  For Idx As Integer = 0 To Self.mCells.LastIndex
		    Var Cell As RCONParameterCell = Self.mCells(Idx)
		    Cell.Resize(True)
		    Cell.Top = NextCellTop
		    Cell.Left = 0
		    Cell.Width = Self.Width
		    Cell.Height = Cell.CellHeight
		    NextCellTop = NextCellTop + Cell.CellHeight
		    MinWidth = Max(MinWidth, Cell.MinimumWidth)
		  Next
		  
		  Self.mMinimumHeight = NextCellTop + Self.InsertButton.Height + Margin + Spacing
		  Self.mMinimumWidth = MinWidth
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function MinimumBounds() As Xojo.Size
		  Return New Xojo.Size(Self.mMinimumWidth, Self.mMinimumHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Command As Beacon.RCONCommand)
		  Self.mCommand = Command
		  Self.CommandLabel.Text = Command.Name
		  Self.DescriptionLabel.Text = Command.Description
		  
		  For Idx As Integer = Self.mCells.LastIndex DownTo 0
		    Self.mCells(Idx).Close
		    Self.mCells.RemoveAt(Idx)
		  Next
		  
		  For Each Param As Beacon.RCONParameter In Command
		    Var Cell As New RCONParameterCell(Param)
		    Self.mCells.Add(Cell)
		    Cell.EmbedWithin(Self, 0, 0, Self.Width, 30)
		  Next
		  
		  Self.mShouldMeasure = True
		  Self.Resize(True)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event InsertCommand(Command As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCells() As RCONParameterCell
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommand As Beacon.RCONCommand
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommandMinWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinimumHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinimumWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldMeasure As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events InsertButton
	#tag Event
		Sub Pressed()
		  Var Values() As String
		  For Each Cell As RCONParameterCell In Self.mCells
		    Var Value As String = Cell.Value
		    If Cell.Param.DataType = "Text" Then
		      Value = """" + Value + """"
		    End If
		    Values.Add(Value)
		  Next
		  
		  Var Command As String = Self.mCommand.Name + " " + String.FromArray(Values, " ")
		  Break
		  If RaiseEvent InsertCommand(Command) Then
		    RaiseEvent Finished()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  RaiseEvent Finished()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
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
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
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
#tag EndViewBehavior
