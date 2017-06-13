#tag Module
Protected Module SQLiteExtensions
	#tag Method, Flags = &h0
		Function UserVersion(Extends Source As SQLiteDatabase) As Integer
		  Dim Results As RecordSet = Source.SQLSelect("PRAGMA user_version;")
		  Return Results.IdxField(1).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserVersion(Extends Source As SQLiteDatabase, Assigns Value As Integer)
		  Source.SQLExecute("PRAGMA user_version = " + Str(Value, "-0") + ";")
		End Sub
	#tag EndMethod


End Module
#tag EndModule
