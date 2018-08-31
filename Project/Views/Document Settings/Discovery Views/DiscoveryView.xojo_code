#tag Class
Protected Class DiscoveryView
Inherits ContainerControl
	#tag Event
		Sub Resized()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin()
		  RaiseEvent Begin
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateDocumentFromImport(ParsedData As Xojo.Core.Dictionary, DiscoveredData As Xojo.Core.Dictionary) As Beacon.Document
		  Dim Document As New Beacon.Document
		  
		  If DiscoveredData <> Nil And DiscoveredData.HasKey("Maps") Then
		    Dim Maps() As Auto = DiscoveredData.Value("Maps")
		    Document.MapCompatibility = 0
		    For Each Map As Text In Maps
		      Select Case Map
		      Case "ScorchedEarth_P"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.ScorchedEarth.Mask
		      Case "Aberration_P"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.Aberration.Mask
		      Case "TheCenter"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.TheCenter.Mask
		      Case "Ragnarok"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.Ragnarok.Mask
		      Else
		        // Unofficial maps will be tagged as The Island
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.TheIsland.Mask
		      End Select
		    Next
		  End If
		  
		  If ParsedData.HasKey("SessionName") Then
		    Try
		      Document.Title = ParsedData.Value("SessionName")
		    Catch Err As TypeMismatchException
		    End Try
		  End If
		  
		  If DiscoveredData <> Nil And DiscoveredData.HasKey("Options") Then
		    Document.DinoLevelSteps = Self.OverrideOfficialDifficultyFromDict(DiscoveredData.Value("Options"), ParsedData)
		  Else
		    Document.DinoLevelSteps = Self.OverrideOfficialDifficultyFromDict(ParsedData)
		  End If
		  
		  Try
		    If ParsedData.HasKey("DifficultyOffset") Then
		      Document.MaxDinoLevel = Beacon.ComputeMaxDinoLevel(ParsedData.Value("DifficultyOffset"), Document.DinoLevelSteps)
		    End If
		  Catch Err As TypeMismatchException
		  End Try
		  
		  Dim Dicts() As Auto
		  Try
		    Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		  Catch Err As TypeMismatchException
		    Dicts.Append(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		  End Try
		  
		  For Each ConfigDict As Xojo.Core.Dictionary In Dicts
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, Document.DifficultyValue)
		    If Source <> Nil Then
		      Document.Add(Source)
		    End If
		  Next
		  
		  Return Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DesiredHeight() As Integer
		  Return Self.mDesiredHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DesiredHeight(Assigns Value As Integer)
		  If Value <> Self.mDesiredHeight Then
		    Self.mDesiredHeight = Value
		  End If  
		  RaiseEvent ShouldResize(Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OverrideOfficialDifficultyFromDict(ParamArray Dicts() As Xojo.Core.Dictionary) As Double
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    If Not Dict.HasKey("OverrideOfficialDifficulty") Then
		      Continue
		    End If
		    
		    Dim Value As Auto = Dict.Value("OverrideOfficialDifficulty")
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		    Try
		      Select Case Info.Name
		      Case "Text"
		        Return Double.FromText(Value)
		      Case "Int32", "Int64", "Double"
		        Return Value
		      End Select
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Return 4.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldCancel()
		  RaiseEvent ShouldCancel()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldFinish(Document As Beacon.Document)
		  RaiseEvent Finished(Document)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Begin()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished(Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCancel()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(NewHeight As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDesiredHeight As Integer = 64
	#tag EndProperty


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
End Class
#tag EndClass
