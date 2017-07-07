#tag Window
Begin Window DocumentSetupDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   330
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   330
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   2
   Resizeable      =   False
   Title           =   "Document Setup"
   Visible         =   True
   Width           =   600
   Begin DocumentSetupContainer Container
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   330
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
      Width           =   600
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Shared Sub ShowCreate()
		  Dim Win As New DocumentSetupDialog
		  Win.Container.Setup()
		  Win.Show()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowEdit(Doc As Beacon.Document)
		  Dim Win As New DocumentSetupDialog
		  Win.Container.Setup(Doc)
		  Win.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowImport(File As Global.FolderItem)
		  Dim Win As New DocumentSetupDialog
		  Win.Container.Setup(File)
		  Win.Show()
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Container
	#tag Event
		Sub ShouldClose()
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub TitleChanged(Title As String)
		  Self.Title = Title
		End Sub
	#tag EndEvent
#tag EndEvents
