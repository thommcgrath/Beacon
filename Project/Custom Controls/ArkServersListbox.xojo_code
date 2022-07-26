#tag Class
Protected Class ArkServersListbox
Inherits BeaconListbox
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused Column
		  #Pragma Unused BackgroundColor
		  
		  If Row >= Me.RowCount Or Column <> Self.mMainColumn Then
		    Return
		  End If
		  
		  Var Profile As Ark.ServerProfile = Me.RowTagAt(Row)
		  If Profile.ProfileColor = Ark.ServerProfile.Colors.None Then
		    Return
		  End If
		  
		  Select Case Profile.ProfileColor
		  Case Ark.ServerProfile.Colors.Blue
		    G.DrawingColor = SystemColors.SystemBlueColor
		  Case Ark.ServerProfile.Colors.Brown
		    G.DrawingColor = SystemColors.SystemBrownColor
		  Case Ark.ServerProfile.Colors.Green
		    G.DrawingColor = SystemColors.SystemGreenColor
		  Case Ark.ServerProfile.Colors.Grey
		    G.DrawingColor = SystemColors.SystemGrayColor
		  Case Ark.ServerProfile.Colors.Indigo
		    G.DrawingColor = SystemColors.SystemIndigoColor
		  Case Ark.ServerProfile.Colors.Orange
		    G.DrawingColor = SystemColors.SystemOrangeColor
		  Case Ark.ServerProfile.Colors.Pink
		    G.DrawingColor = SystemColors.SystemPinkColor
		  Case Ark.ServerProfile.Colors.Purple
		    G.DrawingColor = SystemColors.SystemPurpleColor
		  Case Ark.ServerProfile.Colors.Red
		    G.DrawingColor = SystemColors.SystemRedColor
		  Case Ark.ServerProfile.Colors.Teal
		    G.DrawingColor = SystemColors.SystemTealColor
		  Case Ark.ServerProfile.Colors.Yellow
		    G.DrawingColor = SystemColors.SystemYellowColor
		  End Select
		  G.FillRectangle(G.Width - 3, 0, 3, G.Height)
		  
		  If Me.Selected(Row) And IsHighlighted Then
		    G.DrawingColor = TextColor
		    G.DrawLine(G.Width - 4, 0, G.Width - 4, G.Height)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> Self.mMainColumn Then
		    Return False
		  End If
		  
		  Var Sort1 As String = Me.CellTagAt(Row1, Column)
		  Var Sort2 As String = Me.CellTagAt(Row2, Column)
		  Result = Sort1.Compare(Sort2, ComparisonOptions.CaseInsensitive)
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ColumnTypeAt(Index As Integer, Assigns _value As CellTypes)
		  If Index = 0 And _value = Listbox.CellTypes.CheckBox Then
		    Self.mMainColumn = 1
		  Else
		    Self.mMainColumn = 0
		  End If
		  Super.ColumnTypeAt(Index) = _value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProfileNames() As Dictionary
		  Var Bound As Integer = Self.Project.ServerProfileCount - 1
		  Var Names() As String
		  Var Profiles() As Beacon.ServerProfile
		  Names.ResizeTo(Bound)
		  Profiles.ResizeTo(Bound)
		  For Idx As Integer = 0 To Bound
		    Var Profile As Beacon.ServerProfile = Self.Project.ServerProfile(Idx)
		    Names(Idx) = Profile.Name
		    Profiles(Idx) = Profile
		  Next Idx
		  If Preferences.ServersListNameStyle = Self.NamesAbbreviated Then
		    Names = Language.FilterServerNames(Names)
		  End If
		  
		  Var Lookup As New Dictionary
		  For Idx As Integer = 0 To Bound
		    Lookup.Value(Profiles(Idx).ProfileID) = If(Names(Idx).IsEmpty = False, Names(Idx), Profiles(Idx).Name)
		  Next Idx
		  Return Lookup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Project() As Ark.Project
		  Return RaiseEvent GetProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList()
		  // Updates the list, maintaining the current selection
		  
		  Var Profiles() As Ark.ServerProfile
		  For Idx As Integer = 0 To Self.LastRowIndex
		    If Self.Selected(Idx) = False Then
		      Continue
		    End If
		    
		    Profiles.Add(Self.RowTagAt(Idx))
		  Next
		  Self.UpdateList(Profiles, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList(SelectProfiles() As Ark.ServerProfile, WithChangeEvent As Boolean)
		  Var Profiles() As Beacon.ServerProfile = Self.Project.ServerProfiles(Self.mFilter)
		  
		  Self.SelectionChangeBlocked = True
		  Self.RowCount = Profiles.Count
		  
		  Var SelectIDs() As String
		  For Each Profile As Ark.ServerProfile In SelectProfiles
		    If Profile Is Nil Then
		      Continue
		    End If
		    SelectIDs.Add(Profile.ProfileID)
		  Next
		  
		  Var SortBy As String = Preferences.ServersListSortedValue
		  Var AddressMatcher As New Regex
		  AddressMatcher.SearchPattern = "^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3}):(\d{1,5})$"
		  
		  Var Names As Dictionary = Self.ProfileNames()
		  For Idx As Integer = Profiles.FirstIndex To Profiles.LastIndex
		    Var Profile As Beacon.ServerProfile = Profiles(Idx)
		    Var SortName As String = Names.Value(Profile.ProfileID)
		    Var Name As String = SortName + EndOfLine + If(Preferences.ServersListShowIds, Profile.ProfileID.Left(8) + "  ", "") + Profile.SecondaryName
		    Var Selected As Boolean = SelectIDs.IndexOf(Profile.ProfileID) > -1
		    
		    Select Case SortBy
		    Case Self.SortByAddress
		      SortName = If(Profile.SecondaryName.IsEmpty = False, Profile.SecondaryName, SortName)
		      Var Matches As RegexMatch = AddressMatcher.Search(SortName)
		      If (Matches Is Nil) = False Then
		        Var First As Integer = Matches.SubExpressionString(1).ToInteger
		        Var Second As Integer = Matches.SubExpressionString(2).ToInteger
		        Var Third As Integer = Matches.SubExpressionString(3).ToInteger
		        Var Fourth As Integer = Matches.SubExpressionString(4).ToInteger
		        Var Port As Integer = Matches.SubExpressionString(5).ToInteger
		        SortName = First.ToString(Locale.Raw, "000") + "." + Second.ToString(Locale.Raw, "000") + "." + Third.ToString(Locale.Raw, "000") + "." + Fourth.ToString(Locale.Raw, "000") + ":" + Port.ToString(Locale.Raw, "00000")
		      End If
		    Case Self.SortByColor
		      SortName = "color" + CType(Profile.ProfileColor, Integer).ToString(Locale.Raw, "00") + ":" + SortName
		    End Select
		    
		    If Self.CellValueAt(Idx, 0) <> Name Then
		      Self.CellValueAt(Idx, 0) = Name
		    End If
		    If Self.CellTagAt(Idx, 0) <> SortName Then
		      Self.CellTagAt(Idx, 0) = SortName
		    End If
		    If Self.RowTagAt(Idx) <> Profile Then
		      Self.RowTagAt(Idx) = Profile
		    End If
		    If Self.Selected(Idx) <> Selected Then
		      Self.Selected(Idx) = Selected
		    End If
		  Next
		  Self.Sort
		  Self.SelectionChangeBlocked(WithChangeEvent) = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateList(SelectProfile As Ark.ServerProfile, WithChangeEvent As Boolean)
		  // Updates the list, selecting the requested profile
		  
		  Var Profiles(0) As Ark.ServerProfile
		  Profiles(0) = SelectProfile
		  Self.UpdateList(Profiles, WithChangeEvent)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetProject() As Ark.Project
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFilter
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mFilter.Compare(Value, ComparisonOptions.CaseInsensitive, Locale.Current) <> 0 Then
			    Self.mFilter = Value
			    Self.UpdateList()
			  End If
			End Set
		#tag EndSetter
		Filter As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFilter As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainColumn As Integer
	#tag EndProperty


	#tag Constant, Name = NamesAbbreviated, Type = String, Dynamic = False, Default = \"abbreviated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NamesFull, Type = String, Dynamic = False, Default = \"full", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SortByAddress, Type = String, Dynamic = False, Default = \"address", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SortByColor, Type = String, Dynamic = False, Default = \"color", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SortByName, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant


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
			InitialValue="0"
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
			InitialValue="0"
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
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesVerticalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
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
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="26"
			Type="Integer"
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
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="VisibleRowCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeaheadColumn"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditCaption"
			Visible=true
			Group="Behavior"
			InitialValue="Edit"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PreferencesKey"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultSortDirection"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - A to Z"
				"-1 - Z to A"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultSortColumn"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowInfiniteScroll"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Filter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
