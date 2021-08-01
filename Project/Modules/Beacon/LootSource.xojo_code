#tag Interface
Protected Interface LootSource
Implements Beacon.DocumentItem,Beacon.NamedItem
	#tag Method, Flags = &h0
		Function AppendMode() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMode(Assigns Value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.LootSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EditSaveData(SaveData As Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Experimental() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOfficial() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemSets() As Beacon.ItemSetCollection
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ItemSets(Assigns Sets As Beacon.ItemSetCollection)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadSaveData(SaveData As Dictionary) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MandatoryItemSets() As Beacon.ItemSet()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItemSets() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItemSets(Assigns Value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItemSets() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItemSets(Assigns Value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multipliers() As Beacon.Range
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Notes() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventDuplicates() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventDuplicates(Assigns Value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredItemSetCount() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIColor() As Color
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
	#tag EndViewBehavior
End Interface
#tag EndInterface
