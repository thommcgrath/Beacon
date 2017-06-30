#tag Module
Protected Module SQLiteExtensions
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Function UserVersion(Extends Source As iOSSQLiteDatabase) As Integer
		  Dim Results As iOSSQLiteRecordSet = Source.SQLSelect("PRAGMA user_version;")
		  Return Results.IdxField(1).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub UserVersion(Extends Source As iOSSQLiteDatabase, Assigns Value As Integer)
		  Source.SQLExecute("PRAGMA user_version = ?1;", Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function UserVersion(Extends Source As SQLiteDatabase) As Integer
		  Dim Results As RecordSet = Source.SQLSelect("PRAGMA user_version;")
		  Return Results.IdxField(1).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub UserVersion(Extends Source As SQLiteDatabase, Assigns Value As Integer)
		  Source.SQLExecute("PRAGMA user_version = " + Str(Value, "-0") + ";")
		End Sub
	#tag EndMethod


End Module
#tag EndModule
