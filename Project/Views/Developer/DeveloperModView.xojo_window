#tag Window
Begin ContainerControl DeveloperModView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   564
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   419
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   3
      Visible         =   True
      Width           =   564
      Begin UITweaks.ResizedTextField ConfirmField
         AcceptTabs      =   False
         Alignment       =   2
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   380
      End
      Begin UITweaks.ResizedPushButton CopyButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Copy To Clipboard"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   131
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label ConfirmExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   86
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   92
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         Text            =   "You have not yet confirmed ownership of this mod. To so do, please copy the value below and insert it anywhere on the mod's Steam page. Then press the ""Confirm Ownership"" button below. Once confirmed, the text can be removed from your Steam page."
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   101
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   380
      End
      Begin UITweaks.ResizedPushButton ConfirmButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Confirm Ownership"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   288
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   233
         Underline       =   False
         Visible         =   True
         Width           =   145
      End
      Begin Label NoSelectionLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         Text            =   "No Mod Selected"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   199
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   524
      End
      Begin ProgressBar LoadingIndicator
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   112
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         Top             =   199
         Value           =   0
         Visible         =   True
         Width           =   340
      End
      Begin Listbox EngramList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   False
         ColumnCount     =   5
         ColumnsResizable=   False
         ColumnWidths    =   "*,*,100,75,75"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   394
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Class	Label	Blueprintable	Island	Scorched"
         Italic          =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   0
         Underline       =   False
         UseFocusRing    =   False
         Visible         =   True
         Width           =   564
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin FooterBar FooterBar1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   4
         TabStop         =   True
         Top             =   394
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   564
      End
   End
   Begin APISocket Socket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Resize()
		  Self.mEngramSets = New Xojo.Core.Dictionary
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_ConfirmMod(Success As Boolean, Message As Text, Details As Auto)
		  If Success Then
		    Self.CurrentMod.Constructor(Details)
		    If Self.CurrentMod.Confirmed Then
		      Panel.Value = PageEngrams
		      Self.ShowAlert("Mod ownership confirmed.", "You may now remove the confirmation code from your Steam page.")
		    Else
		      Panel.Value = PageNeedsConfirmation
		      Self.ShowAlert("Mod ownership has not been confirmed.", "The confirmation code was not found on mod's Steam page.")
		    End If
		  Else
		    Panel.Value = PageNeedsConfirmation
		    Self.ShowAlert("Mod ownership has not been confirmed.", Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_EngramsLoad(Success As Boolean, Message As Text, Details As Auto)
		  Self.mEngramSets.Value(Self.CurrentMod.ModID) = New APIEngramSet(Details)
		  Panel.Value = PageEngrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EngramSet() As APIEngramSet
		  If Self.mCurrentMod = Nil Then
		    Return Nil
		  End If
		  
		  Return Self.mEngramSets.Value(Self.mCurrentMod.ModID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  ConfirmField.Left = Panel.Left + ((Panel.Width - ConfirmField.Width) / 2)
		  ConfirmExplanation.Left = ConfirmField.Left
		  CopyButton.Left = Panel.Left + ((Panel.Width - (CopyButton.Width + 12 + ConfirmButton.Width)) / 2)
		  ConfirmButton.Left = CopyButton.Left + CopyButton.Width + 12
		  
		  ConfirmField.Top = Panel.Top + ((Panel.Height - ConfirmField.Height) / 2)
		  ConfirmExplanation.Top = ConfirmField.Top - (12 + ConfirmExplanation.Height)
		  CopyButton.Top = ConfirmField.Top + ConfirmField.Height + 12
		  ConfirmButton.Top = CopyButton.Top
		  
		  NoSelectionLabel.Top = Panel.Top + ((Panel.Height - NoSelectionLabel.Height) / 2)
		  
		  LoadingIndicator.Top = Panel.Top + ((Panel.Height - LoadingIndicator.Height) / 2)
		  LoadingIndicator.Left = Panel.Left + ((Panel.Width - LoadingIndicator.Width) / 2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RestoreCopyButton()
		  CopyButton.Caption = "Copy To Clipboard"
		  CopyButton.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCurrentEngrams()
		  EngramList.DeleteAllRows
		  
		  If Self.mCurrentMod = Nil Or Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) = False Then
		    Return
		  End If
		  
		  Dim EngramSet As APIEngramSet = Self.mEngramSets.Value(Self.mCurrentMod.ModID)
		  Dim Engrams() As APIEngram = EngramSet.ActiveEngrams
		  For Each Engram As APIEngram In Engrams
		    EngramList.AddRow("")
		    Self.ShowEngramInRow(EngramList.LastIndex, Engram)
		  Next
		  
		  FooterBar1.Button("PublishButton").Enabled = EngramSet.Modified
		  FooterBar1.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEngramInRow(Index As Integer, Engram As APIEngram)
		  EngramList.Cell(Index, 0) = Engram.ClassString
		  EngramList.Cell(Index, 1) = Engram.Label
		  EngramList.CellCheck(Index, 2) = Engram.CanBeBlueprint
		  EngramList.CellCheck(Index, 3) = Engram.AvailableTo(Beacon.LootSource.Packages.Island)
		  EngramList.CellCheck(Index, 4) = Engram.AvailableTo(Beacon.LootSource.Packages.Scorched)
		  
		  EngramList.CellHelpTag(Index, 0) = Engram.ClassString
		  EngramList.CellHelpTag(Index, 1) = Engram.Label
		  
		  EngramList.RowTag(Index) = Engram
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentMod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.mCurrentMod Then
			    Return
			  End If
			  
			  Xojo.Core.Timer.CancelCall(AddressOf RestoreCopyButton)
			  Self.RestoreCopyButton()
			  
			  Self.mCurrentMod = Value
			  
			  If Self.mCurrentMod = Nil Then
			    Panel.Value = Self.PageNoSelection
			    Return
			  End If
			  
			  If Not Self.mCurrentMod.Confirmed Then
			    ConfirmField.Text = Self.mCurrentMod.ConfirmationCode
			    Panel.Value = PageNeedsConfirmation
			    Return
			  End If
			  
			  If Self.mEngramSets.HasKey(Self.mCurrentMod.ModID) Then
			    Self.ShowCurrentEngrams()
			    Panel.Value = PageEngrams
			  Else
			    // Load engrams
			    Panel.Value = PageLoading
			    Dim Request As New APIRequest(Self.mCurrentMod.EngramsURL, "GET", AddressOf APICallback_EngramsLoad)
			    Self.Socket.Start(Request)
			  End If
			End Set
		#tag EndSetter
		CurrentMod As APIMod
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentMod As APIMod
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramSets As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Constant, Name = PageEngrams, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLoading, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNeedsConfirmation, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CopyButton
	#tag Event
		Sub Action()
		  Dim C As New Clipboard
		  C.Text = ConfirmField.Text
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		  Xojo.Core.Timer.CallLater(3000, AddressOf RestoreCopyButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmButton
	#tag Event
		Sub Action()
		  Panel.Value = PageLoading
		  
		  Dim Request As New APIRequest(Self.CurrentMod.ConfirmURL, "GET", AddressOf APICallback_ConfirmMod)
		  Request.Sign(App.Identity)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeEditableTextField
		  Me.ColumnType(1) = Listbox.TypeEditableTextField
		  Me.ColumnType(2) = Listbox.TypeCheckbox
		  Me.ColumnType(3) = Listbox.TypeCheckbox
		  Me.ColumnType(4) = Listbox.TypeCheckbox
		  
		  Me.ColumnAlignment(2) = Listbox.AlignCenter
		  Me.ColumnAlignment(3) = Listbox.AlignCenter
		  Me.ColumnAlignment(4) = Listbox.AlignCenter
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim Engram As APIEngram = Me.RowTag(Row)
		  
		  Select Case Column
		  Case 0
		    Engram.ClassString = Me.Cell(Row, Column).ToText
		    Me.Cell(Row, Column) = Engram.ClassString
		  Case 1
		    Engram.Label = Me.Cell(Row, Column).ToText
		  Case 2
		    Engram.CanBeBlueprint = Me.CellCheck(Row, Column)
		  Case 3
		    If Me.CellCheck(Row, Column) Then
		      Engram.AddEnvironment(Beacon.LootSource.Packages.Island)
		    Else
		      Engram.RemoveEnvironment(Beacon.LootSource.Packages.Island)
		    End If
		  Case 4
		    If Me.CellCheck(Row, Column) Then
		      Engram.AddEnvironment(Beacon.LootSource.Packages.Scorched)
		    Else
		      Engram.RemoveEnvironment(Beacon.LootSource.Packages.Scorched)
		    End If
		  End Select
		  
		  Self.EngramSet.Add(Engram)
		  FooterBar1.Button("PublishButton").Enabled = Self.EngramSet.Modified
		  FooterBar1.Invalidate
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  FooterBar1.Button("RemoveButton").Enabled = Me.ListIndex > -1
		  FooterBar1.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FooterBar1
	#tag Event
		Sub Open()
		  Me.Append(New FooterBarButton("AddButton", IconAddNormal, FooterBarButton.AlignLeft))
		  Me.Append(New FooterBarButton("RemoveButton", IconRemoveNormal, FooterBarButton.AlignLeft))
		  
		  Me.Append(New FooterBarButton("ImportButton", "Import", FooterBarButton.AlignCenter))
		  
		  Me.Append(New FooterBarButton("PublishButton", "Publish", FooterBarButton.AlignRight))
		  
		  Me.Button("RemoveButton").Enabled = False
		  Me.Button("PublishButton").Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Button As FooterBarButton)
		  Select Case Button.Name
		  Case "AddButton"
		    Dim Engram As New APIEngram
		    EngramList.AddRow("")
		    Self.ShowEngramInRow(EngramList.LastIndex, Engram)
		    EngramList.EditCell(EngramList.LastIndex, 0)
		    Self.EngramSet.Add(Engram)
		  Case "RemoveButton"
		    Dim Engram As APIEngram = EngramList.RowTag(EngramList.ListIndex)
		    Self.EngramSet.Remove(Engram)
		    EngramList.RemoveRow(EngramList.ListIndex)
		    FooterBar1.Button("PublishButton").Enabled = Self.EngramSet.Modified
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
