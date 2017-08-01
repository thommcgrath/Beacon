#tag IOSView
Begin iosView DocumentListView
   BackButtonTitle =   ""
   Compatibility   =   ""
   Left            =   0
   NavigationBarVisible=   True
   TabIcon         =   ""
   TabTitle        =   ""
   Title           =   "Documents"
   Top             =   0
   Begin BeaconAPI.Socket APISocket
      Height          =   32
      Height          =   32
      Left            =   60
      Left            =   60
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Scope           =   2
      Top             =   60
      Top             =   60
      Width           =   32
      Width           =   32
   End
   Begin iOSTable DocsList
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   DocsList, 1, <Parent>, 1, False, +1.00, 1, 1, 0, 
      AutoLayout      =   DocsList, 2, <Parent>, 2, False, +1.00, 1, 1, -0, 
      AutoLayout      =   DocsList, 3, TopLayoutGuide, 3, False, +1.00, 1, 1, 0, 
      AutoLayout      =   DocsList, 4, BottomLayoutGuide, 4, False, +1.00, 1, 1, 0, 
      EditingEnabled  =   False
      EstimatedRowHeight=   -1
      Format          =   "0"
      Height          =   415.0
      Left            =   0
      LockedInPosition=   False
      Scope           =   2
      SectionCount    =   0
      Top             =   65
      Visible         =   True
      Width           =   320.0
   End
End
#tag EndIOSView

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.RightNavigationToolbar.Add(iOSToolButton.NewSystemItem(iOSToolButton.Types.SystemAdd))
		  
		  Dim Request As New BeaconAPI.Request("document.php", "GET", AddressOf APICallback_DocumentsReturned)
		  Request.Sign(App.Identity)
		  Self.APISocket.Start(Request)
		  
		  Dim DocsFolder As Xojo.IO.FolderItem = SpecialFolder.Documents
		  Dim Ext As Text = App.DocumentExtension
		  For Each File As Xojo.IO.FolderItem In DocsFolder.Children
		    If File.Name.Length > Ext.Length And File.Name.Right(Ext.Length) = Ext Then
		      Self.mDocuments.Append(File)
		    End If
		  Next
		  
		  Self.UpdateDocsList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ToolbarPressed(button As iOSToolButton)
		  Select Case Button.Type
		  Case iOSToolButton.Types.SystemAdd
		    
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentsReturned(Success As Boolean, Message As Text, Details As Auto)
		  If Not Success Then
		    Return
		  End If
		  
		  Dim Docs() As Auto = Details
		  For Each Dict As Xojo.Core.Dictionary In Docs
		    Self.mDocuments.Append(New BeaconAPI.Document(Dict))
		  Next
		  
		  Self.UpdateDocsList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDocsList()
		  Self.DocsList.RemoveAll
		  Self.DocsList.AddSection("")
		  
		  For Each Doc As Auto In Self.mDocuments
		    Dim DocName As Text
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Doc)
		    Select Case Info.FullName
		    Case "BeaconAPI.Document"
		      DocName = BeaconAPI.Document(Doc).Name
		    Case "Xojo.IO.FolderItem"
		      DocName = Xojo.IO.FolderItem(Doc).DisplayName
		    End Select
		    
		    Self.DocsList.AddRow(0, DocName)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocuments() As Auto
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="BackButtonTitle"
		Group="Behavior"
		Type="Text"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="NavigationBarVisible"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIcon"
		Group="Behavior"
		Type="iOSImage"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabTitle"
		Group="Behavior"
		Type="Text"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Group="Behavior"
		Type="Text"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
