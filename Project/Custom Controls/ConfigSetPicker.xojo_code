#tag Class
Protected Class ConfigSetPicker
Inherits ControlCanvas
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) )
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Self.mMouseDown = False Then
		    Self.mMouseDown = True
		    Self.Refresh
		  End If
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var Pressed As Boolean = (X >= 0 And Y >= 0 And X <= Self.Width And Y <= Self.Height)
		  If Self.mMouseDown <> Pressed Then
		    Self.mMouseDown = Pressed
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Self.mMouseHover = False Then
		    Self.mMouseHover = True
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.mMouseHover = True Then
		    Self.mMouseHover = False
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Self.mMouseHover = False Then
		    Self.mMouseHover = True
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var Pressed As Boolean = (X >= 0 And Y >= 0 And X <= Self.Width And Y <= Self.Height)
		  If Pressed Then
		    Call CallLater.Schedule(10, WeakAddressOf HandleClick)
		  End If
		  If Self.mMouseDown = True Or Self.mMouseHover <> Pressed Then
		    Self.mMouseDown = False
		    Self.mMouseHover = Pressed
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused SafeArea
		  
		  Var Caption As String = "Config Set: " + Self.Project.ActiveConfigSet.Name
		  Var CaptionBaseline As Double = (G.Height / 2) + (G.CapHeight / 2)
		  Var CaptionLeft As Double = G.Height - CaptionBaseline
		  
		  Var DropdownLeft As Double = G.Width - (CaptionLeft + 8)
		  Var DropdownTop As Double = (G.Height - 4) / 2
		  
		  Var Path As New GraphicsPath
		  Path.MoveToPoint(NearestMultiple(DropdownLeft, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 2, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 4, G.ScaleX), NearestMultiple(DropdownTop + 2, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 6, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 8, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 4, G.ScaleX), NearestMultiple(DropdownTop + 4, G.ScaleY))
		  
		  If Self.mMouseHover And Highlighted Then
		    G.DrawingColor = SystemColors.ControlAccentColor
		  Else
		    G.DrawingColor = SystemColors.LabelColor
		  End If
		  
		  G.DrawText(Caption, NearestMultiple(CaptionLeft, G.ScaleX), NearestMultiple(CaptionBaseline, G.ScaleY), NearestMultiple(G.Width - ((CaptionLeft * 3) + 8), G.ScaleX), True)
		  G.FillPath(Path)
		  
		  If Self.mMouseDown Then
		    G.DrawingColor = &c000000A5
		    G.FillRectangle(0, 0, G.Width, G.Height)
		  End If
		  
		  Self.mMenuOrigin = New Point(CaptionLeft, CaptionBaseline)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleClick()
		  Var Menu As New DesktopMenuItem
		  Menu.AddMenu(New DesktopMenuItem("Create and switch to new config set…", "beacon:createandswitch"))
		  Menu.AddMenu(New DesktopMenuItem("Manage config sets…", "beacon:manage"))
		  Menu.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  Var Project As Beacon.Project = Self.Project
		  Var Sets() As Beacon.ConfigSet = Project.ConfigSets
		  Var SetsMap As New Dictionary
		  Var SetNames() As String
		  For Each Set As Beacon.ConfigSet In Sets
		    SetsMap.Value(Set.Name) = Set
		    SetNames.Add(Set.Name)
		  Next
		  SetNames.SortWith(Sets)
		  
		  For Each Set As Beacon.ConfigSet In Sets
		    Var Item As New DesktopMenuItem(Set.Name, Set)
		    Item.HasCheckMark = Set = Project.ActiveConfigSet
		    If Set.IsBase Then
		      Item.Shortcut = "B"
		    End If
		    Menu.AddMenu(Item)
		  Next
		  
		  Menu.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  Menu.AddMenu(New DesktopMenuItem("Learn more about config sets…", "beacon:help"))
		  
		  Var PickerOrigin As Point = Self.GlobalPosition
		  Var Origin As Point = New Point(PickerOrigin.X + Self.mMenuOrigin.X, PickerOrigin.Y + Self.mMenuOrigin.Y)
		  Var Choice As DesktopMenuItem = Menu.PopUp(Origin.X, Origin.Y)
		  If (Choice Is Nil) = False Then
		    If Choice.Tag.Type = Variant.TypeString And Choice.Tag.StringValue.BeginsWith("beacon:") Then
		      Var Tag As String = Choice.Tag.StringValue.Middle(7)
		      Select Case Tag
		      Case "manage"
		        RaiseEvent ManageConfigSets()
		        Self.Refresh
		      Case "help"
		        Var HelpURL As String = Beacon.HelpURL("config_sets")
		        If App.MainWindow Is Nil Then
		          // No logical way for this to happen.
		          System.GotoURL(HelpURL)
		          Return
		        End If
		        
		        Var Component As HelpComponent = App.MainWindow.Help(False)
		        If Component Is Nil Then
		          System.GotoURL(HelpURL)
		          Return
		        End If
		        
		        App.MainWindow.ShowHelp()
		        Component.LoadURL(HelpURL)
		      case "createandswitch"
		        RaiseEvent NewConfigSet()
		        Self.Refresh
		      End Select
		    ElseIf Choice.Tag.Type = Variant.TypeObject And Choice.Tag.ObjectValue IsA Beacon.ConfigSet Then
		      RaiseEvent Changed(Beacon.ConfigSet(Choice.Tag))
		      Self.Refresh
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Project() As Beacon.Project
		  Return RaiseEvent GetProject()
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed(Set As Beacon.ConfigSet)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetProject() As Beacon.Project
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ManageConfigSets()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewConfigSet()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mMenuOrigin As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseHover As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
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
			Name="LockLeft"
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
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
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
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollingEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
