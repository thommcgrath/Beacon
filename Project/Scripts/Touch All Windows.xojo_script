Module Toucher
Sub FindWindows(Path As String, Results() As String)
Var ProjectItemsString As String = SubLocations(Path)
Var ProjectItems() As String = ProjectItemsString.Split(ChrB(9))
For Each ItemName As String In ProjectItems
Var ItemPath As String = ItemName
If Not Path.IsEmpty Then
ItemPath = Path + "." + ItemPath
End If

If SelectProjectItem(ItemPath) Then
Var ItemType As String = TypeOfCurrentLocation
If ItemType = "Window" Then
Results.AddRow(Location)
End If
Else
// Folders are not project items, so it's safe to assume this is a folder.
FindWindows(ItemPath, Results)
End If
Next
End Sub
End Module

Var WindowList() As String
Toucher.FindWindows("Views", WindowList)

For Each WindowName As String In WindowList
Location = WindowName
Var HasBackgroundColor As String = PropertyValue(WindowName + ".HasBackgroundColor")
PropertyValue(WindowName + ".HasBackgroundColor") = If(HasBackgroundColor = "True", "False", "True")
DoCommand("SaveFile")
PropertyValue(WindowName + ".HasBackgroundColor") = HasBackgroundColor
Next
DoCommand("SaveFile")