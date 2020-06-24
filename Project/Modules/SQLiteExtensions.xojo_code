#tag Module
Protected Module SQLiteExtensions
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Function UserVersion(Extends Source As iOSSQLiteDatabase) As Integer
		  Var Results As iOSSQLiteRecordSet = Source.SQLSelect("PRAGMA user_version;")
		  Return Results.IdxField(0).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub UserVersion(Extends Source As iOSSQLiteDatabase, Assigns Value As Integer)
		  Source.SQLExecute("PRAGMA user_version = ?1;", Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function UserVersion(Extends Source As SQLiteDatabase) As Integer
		  Var Results As RowSet = Source.SelectSQL("PRAGMA user_version;")
		  Return Results.ColumnAt(0).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub UserVersion(Extends Source As SQLiteDatabase, Assigns Value As Integer)
		  Source.ExecuteSQL("PRAGMA user_version = " + Str(Value, "-0") + ";")
		End Sub
	#tag EndMethod


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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
