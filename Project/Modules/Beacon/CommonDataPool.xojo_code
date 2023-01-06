#tag Class
Protected Class CommonDataPool
Inherits Beacon.DataSourcePool
	#tag Event
		Function NewInstance(Writeable As Boolean) As Beacon.DataSource
		  Return New Beacon.CommonData(Writeable)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Get(Writeable As Boolean) As Beacon.CommonData
		  Return Beacon.CommonData(Super.Get(Writeable))
		End Function
	#tag EndMethod


End Class
#tag EndClass
