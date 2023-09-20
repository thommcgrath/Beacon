#tag Class
Protected Class MutableContentPack
Inherits Beacon.ContentPack
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  Self.mContentPackId = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameId(Assigns Value As String)
		  Self.mGameId = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.ContentPack
		  Return Self.ImmutableCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsConsoleSafe(Assigns Value As Boolean)
		  Self.mIsConsoleSafe = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsDefaultEnabled(Assigns Value As Boolean)
		  Self.mIsDefaultEnabled = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsLocal(Assigns Value As Boolean)
		  Self.mIsLocal = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  Self.mLastUpdate = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Marketplace(Assigns Value As String)
		  Self.mMarketplace = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MarketplaceId(Assigns Value As String)
		  Self.mMarketplaceId = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableContentPack
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  Self.mName = Value
		End Sub
	#tag EndMethod


End Class
#tag EndClass
