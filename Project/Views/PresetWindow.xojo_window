#tag Window
Begin BeaconWindow PresetWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   558
   MinimizeButton  =   True
   MinWidth        =   732
   Placement       =   0
   Resizeable      =   True
   Title           =   "Preset"
   Visible         =   True
   Width           =   732
   Begin PresetEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   600
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   732
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #Pragma Unused appQuitting
		  
		  If Not Self.ContentsChanged Then
		    Return False
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Message = "Do you want to save changes to """ + Self.Title + """ before closing?"
		  Dialog.Explanation = "If you don't save, your changes will be lost."
		  Dialog.ActionButton.Caption = "Save"
		  Dialog.AlternateActionButton.Caption = "Don't Save"
		  Dialog.CancelButton.Visible = True
		  Dialog.AlternateActionButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  Select Case Choice
		  Case Dialog.ActionButton
		    If Self.Save() Then
		      Return False
		    Else
		      Return True
		    End If
		  Case Dialog.CancelButton
		    Return True
		  Case Dialog.AlternateActionButton
		    Return False
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSave.Enable
		  FileSaveAs.Enable
		  FileExport.Enable
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			#Pragma Warning "Export is not the same as save"
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			Call Self.Save()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Shared Sub Present()
		  Dim Win As New PresetWindow
		  Win.Editor.Preset = New Beacon.Preset
		  Win.Title = "Untitled Preset"
		  Win.SourceMode = PresetWindow.SourceModes.FromScratch
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Set As Beacon.ItemSet)
		  Dim Preset As Beacon.MutablePreset
		  If Set.SourcePresetID <> "" Then
		    Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		    For Each LoadedPreset As Beacon.Preset In Presets
		      If LoadedPreset.PresetID = Set.SourcePresetID Then
		        // Clone this one
		        Preset = New Beacon.MutablePreset(LoadedPreset)
		        Exit For LoadedPreset
		      End If
		    Next
		  Else
		    Preset = New Beacon.MutablePreset
		  End If
		  
		  Preset.Label = Set.Label
		  Preset.MinItems = Set.MinNumItems
		  Preset.MaxItems = Set.MaxNumItems
		  For I As Integer = UBound(Preset) DownTo 0
		    Preset.Remove(I)
		  Next
		  For Each Entry As Beacon.SetEntry In Set
		    Preset.Append(New Beacon.PresetEntry(Entry))
		  Next
		  
		  Dim Win As New PresetWindow
		  Win.Editor.Preset = Preset
		  Win.Title = Preset.Label
		  Win.SourceMode = PresetWindow.SourceModes.FromItemSet
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(File As FolderItem)
		  Dim Item As Xojo.IO.FolderItem = New Xojo.IO.FolderItem(File.NativePath.ToText)
		  
		  Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(Item)
		  If Preset = Nil Then
		    Return
		  End If
		  
		  Dim Win As New PresetWindow
		  Win.Editor.Preset = Preset
		  Win.Title = File.Name
		  Win.File = Item
		  Win.SourceMode = PresetWindow.SourceModes.FromFile
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As Boolean
		  Select Case Self.SourceMode
		  Case PresetWindow.SourceModes.FromScratch, PresetWindow.SourceModes.FromItemSet
		    Dim Dialog As New MessageDialog
		    Dialog.Message = "Save this preset to library?"
		    Dialog.Explanation = "Presets can be saved to your personal library for your own use, or saved to a file for sharing."
		    Dialog.ActionButton.Caption = "To Library"
		    Dialog.AlternateActionButton.Caption = "To File"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		    Select Case Choice
		    Case Dialog.ActionButton
		      Dim Preset As Beacon.Preset = Editor.Preset
		      
		      Beacon.Data.SavePreset(Preset)
		      If PresetManagerWindow.SharedWindow(False) <> Nil Then
		        PresetManagerWindow.SharedWindow.UpdatePresets()
		      End If
		      PresetManagerWindow.SharedWindow.ShowPreset(Preset)
		      
		      Self.Title = Preset.Label
		      Self.ContentsChanged = False
		      Self.Close
		      Return True
		    Case Dialog.CancelButton
		      Return False
		    Case Dialog.AlternateActionButton
		      If Self.SaveAs() Then
		        Self.SourceMode = PresetWindow.SourceModes.FromFile
		      Else
		        Return False
		      End If
		    End Select
		  Case PresetWindow.SourceModes.FromFile
		    If Self.File <> Nil Then
		      Self.SaveAs(Self.File)
		      Return True
		    Else
		      Return Self.SaveAs()
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveAs() As Boolean
		  Dim Dialog As New SaveAsDialog
		  Dialog.Filter = BeaconFileTypes.BeaconPreset
		  Dialog.SuggestedFileName = Editor.Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self)
		  If File <> Nil Then
		    Self.SaveAs(File)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As FolderItem)
		  Self.SaveAs(New Xojo.IO.FolderItem(File.NativePath.ToText))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(File As Xojo.IO.FolderItem)
		  Self.File = File
		  Self.Editor.Preset.ToFile(File)
		  Self.Title = File.Name
		  Self.ContentsChanged = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private File As Xojo.IO.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SourceMode As PresetWindow.SourceModes
	#tag EndProperty


	#tag Enum, Name = SourceModes, Type = Integer, Flags = &h21
		FromScratch
		  FromItemSet
		FromFile
	#tag EndEnum


#tag EndWindowCode

#tag Events Editor
	#tag Event
		Sub ContentsChanged()
		  Self.ContentsChanged = Me.ContentsChanged
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
