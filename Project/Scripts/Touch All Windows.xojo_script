Module Toucher
Sub TouchPath(Path As String)
Var ProjectItemsString As String = SubLocations(Path)
Var ProjectItems() As String = ProjectItemsString.Split(ChrB(9))
For Each ItemName As String In ProjectItems
Var ItemPath As String = ItemName
If Path <> "" Then
ItemPath = Path + "." + ItemPath
End If

If SelectProjectItem(ItemPath) Then
Var ItemType As String = TypeOfCurrentLocation
If ItemType = "Window" Then
Var HasBackgroundColor As String = PropertyValue("HasBackgroundColor")
PropertyValue("HasBackgroundColor") = If(HasBackgroundColor = "True", "False", "True")
PropertyValue("HasBackgroundColor") = HasBackgroundColor
End If
End If

TouchPath(ItemPath)
Next
End Sub
End Module

Toucher.TouchPath("")