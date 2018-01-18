#tag Window
Begin Window DocumentSetupSheet
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   450
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   450
   MaximizeButton  =   False
   MaxWidth        =   511
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   450
   MinimizeButton  =   False
   MinWidth        =   511
   Placement       =   1
   Resizeable      =   False
   Title           =   "Document Setup"
   Visible         =   True
   Width           =   511
   Begin DocumentSetupContainer Container
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   450
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
      Width           =   511
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Shared Sub ShowCreate(Parent As Window)
		  Dim Win As New DocumentSetupSheet
		  Win.Container.Setup()
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowEdit(Parent As Window, Doc As Beacon.Document)
		  Dim Win As New DocumentSetupSheet
		  Win.Container.Setup(Doc)
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowImport(Parent As Window, File As Global.FolderItem)
		  Dim Win As New DocumentSetupSheet
		  Win.Container.Setup(File)
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Container
	#tag Event
		Sub TitleChanged(Title As String)
		  Self.Title = Title
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldClose()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
