#tag Class
Protected Class Encrypter
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  //
		  // Subclasses should implement their own Constructors
		  //
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(cloneFrom As M_Crypto.Encrypter)
		  //
		  // Clone Constructor
		  //
		  
		  zBlockSize = cloneFrom.zBlockSize
		  WasKeySet = cloneFrom.WasKeySet
		  UseFunction = cloneFrom.UseFunction
		  PaddingMethod = cloneFrom.PaddingMethod
		  
		  if cloneFrom.InitialVector isa object then
		    InitialVector = new Xojo.Core.MutableMemoryBlock( cloneFrom.InitialVector )
		  end if
		  
		  RaiseEvent CloneFrom( cloneFrom )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Decrypt(f As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
		  RaiseErrorIf( not WasKeySet, kErrorNoKeySet )
		  
		  if data.Size = 0 then
		    return
		  end if
		  
		  select case f
		  case Functions.Default, Functions.CBC, Functions.ECB
		    if isFinalBlock then
		      RaiseErrorIf( ( data.Size mod BlockSize ) <> 0, kErrorDecryptionBlockSize )
		    else
		      RaiseErrorIf( ( data.Size mod BlockSize ) <> 0, kErrorIntermediateEncyptionBlockSize )
		    end if
		    
		    RaiseEvent Decrypt( f, data, isFinalBlock )
		    
		    if isFinalBlock then
		      DepadIfNeeded( data )
		      zCurrentVector = nil
		    end if
		    
		  case else
		    raise new M_Crypto.UnimplementedEnumException
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Decrypt( UseFunction, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DecryptCBC(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Decrypt( Functions.CBC, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DecryptECB(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Decrypt( Functions.ECB, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DepadIfNeeded(data As Xojo.Core.MutableMemoryBlock)
		  // See PadIfNeeded for a description of how padding works.
		  
		  if data is nil or data.Size = 0 then
		    return
		  end if
		  
		  dim originalSize as integer = data.Size
		  dim dataPtr as ptr = data.Data
		  
		  select case PaddingMethod
		  case Padding.PKCS
		    //
		    // A pad is expected so this will raise an exception if
		    // it's not present
		    //
		    
		    dim stripCount as integer = dataPtr.Byte( originalSize - 1 )
		    if stripCount = 0 or stripCount > BlockSize or stripCount > originalSize then
		      //
		      // These are impossible with PKCS
		      // (stripCount might equal original size if this was the last block in a chain)
		      // 
		      raise new M_Crypto.InvalidPaddingException
		    end if
		    
		    dim lastIndex as integer = originalSize - 2
		    dim firstIndex as integer = originalSize - stripCount
		    if firstIndex < 0 then
		      firstIndex = 0
		    end if
		    
		    for byteIndex as integer = firstIndex to lastIndex
		      if dataPtr.Byte( byteIndex ) <> stripCount then
		        //
		        // Something is wrong
		        //
		        raise new M_Crypto.InvalidPaddingException
		      end if
		    next
		    
		    data.Remove firstIndex, stripCount
		    
		  case Padding.NullsWithCount
		    // Counterpart to padding. Will remove nulls followed by the number of nulls
		    // from the end of the MemoryBlock.
		    //
		    // The original implementation would never add one just one byte, but rather would
		    // add BlockSize + 1. I've since discovered that the standard calls for padding to be
		    // added in all cases so a single byte can be added to the end. However, to keep
		    // compatible with the previous implementation, this will attempt to strip
		    // BlockSize + 1 if specified and if possible.
		    //
		    
		    dim stripCount as integer = dataPtr.Byte( data.Size - 1 )
		    if stripCount = 0 or stripCount > ( BlockSize + 1 ) or stripCount > data.Size then
		      raise new M_Crypto.InvalidPaddingException
		    end if
		    
		    dim lastIndex as integer = originalSize - 2
		    dim firstIndex as integer = originalSize - stripCount
		    if firstIndex < 0 then
		      firstIndex = 0
		    end if
		    
		    for byteIndex as integer = firstIndex to lastIndex
		      if dataPtr.Byte( byteIndex ) <> 0 then
		        //
		        // Something is wrong
		        //
		        raise new M_Crypto.InvalidPaddingException
		      end if
		    next
		    
		    data.Remove firstIndex, stripCount
		    
		  case Padding.NullsOnly
		    dim lastIndex as integer = originalSize - 1
		    dim firstIndex as integer = originalSize - BlockSize
		    if firstIndex < 0 then
		      firstIndex = 0
		    end if
		    for index as integer = lastIndex downto firstIndex
		      if dataPtr.Byte( index ) <> 0 then
		        dim newSize as integer = index + 1
		        if originalSize > newSize then
		          data.Remove newSize, originalSize - newSize
		        end if
		        exit
		      end if
		    next
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Encrypt(f As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
		  RaiseErrorIf( not WasKeySet, kErrorNoKeySet )
		  
		  if data.Size = 0 then
		    return
		  end if
		  
		  select case f
		  case Functions.Default, Functions.CBC, Functions.ECB
		    if isFinalBlock then
		      PadIfNeeded( data )
		    else
		      RaiseErrorIf( ( data.Size mod BlockSize ) <> 0, kErrorIntermediateEncyptionBlockSize )
		    end if
		    
		    RaiseEvent Encrypt( f, data, isfinalBlock )
		    
		    if isFinalBlock then
		      zCurrentVector = nil
		    end if
		    
		    return
		    
		  case else
		    raise new M_Crypto.UnimplementedEnumException
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Encrypt( UseFunction, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncryptCBC(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Encrypt( Functions.CBC, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncryptECB(data As String, isFinalBlock As Boolean = True) As String
		  dim mb as Xojo.Core.MutableMemoryBlock = StringToMutableMemoryBlock( data )
		  self.Encrypt( Functions.ECB, mb, isFinalBlock )
		  dim result as string = MemoryBlockToString( mb )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCurrentThreadId() As Integer
		  dim t as Thread = App.CurrentThread
		  if t is nil then
		    return 0
		  else
		    return t.ThreadID
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InterpretVector(vector As String) As String
		  if vector = "" then 
		    return vector
		  end if
		  
		  if vector.LenB = BlockSize then
		    return vector
		  end if
		  
		  dim newVector as string = DecodeHex( vector )
		  if newVector.LenB = BlockSize then
		    return newVector
		  else
		    return vector
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PadIfNeeded(data As Xojo.Core.MutableMemoryBlock)
		  if data is nil or data.Size = 0 then
		    return
		  end if
		  
		  dim originalSize as integer = data.Size
		  dim padToAdd as byte = BlockSize - ( originalSize mod BlockSize )
		  if padToAdd = BlockSize then
		    padToAdd = 0
		  end if
		  
		  select case PaddingMethod
		  case Padding.PKCS
		    // https://en.wikipedia.org/wiki/Padding_%28cryptography%29#PKCS7
		    
		    if padToAdd = 0 then
		      padToAdd = BlockSize
		    end if
		    
		    dim adder as new Xojo.Core.MemoryBlock( padToAdd )
		    dim adderLastIndex as integer = adder.Size - 1
		    dim adderPtr as ptr = adder.Data
		    
		    for i as integer = 0 to adderLastIndex
		      adderPtr.Byte( i ) = padToAdd
		    next
		    data.Append adder
		    
		  case Padding.NullsWithCount
		    //
		    // ANSI X.923 padding
		    //
		    // Pads the data to an exact multiple of BlockSize bytes by
		    // adding nulls plus the number of bytes added. For example, when
		    // BlockSize = 8 and the final block is 0x32 32 32 32, it will be padded
		    // to 0x32 32 32 32 00 00 00 04. A pad is always added even if the final
		    // block is already the right size.
		    //
		    
		    if padToAdd = 0 then
		      padToAdd = BlockSize
		    end if
		    dim adder as new Xojo.Core.MemoryBlock( padToAdd )
		    adder.Data.Byte( adder.Size - 1 ) = padToAdd
		    data.Append adder
		    
		  case Padding.NullsOnly
		    //
		    // Adds nulls to the end
		    //
		    if padToAdd <> 0 then
		      dim adder as new Xojo.Core.MemoryBlock( padToAdd )
		      data.Append adder
		    end if
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RaiseErrorIf(test As Boolean, msg As String)
		  if test then
		    dim err as new CryptoException
		    err.Message = msg
		    raise err
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetInitialVector()
		  SetInitialVector ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetBlockSize(size As Integer)
		  zBlockSize = size
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetInitialVector(vector As String)
		  if vector = "" then
		    InitialVector = nil
		    return
		  end if
		  
		  vector = InterpretVector( vector )
		  RaiseErrorIf vector.LenB <> BlockSize, kErrorVectorSize.ReplaceAll( "BLOCKSIZE", str( BlockSize ) )
		  
		  InitialVector = StringToMutableMemoryBlock( vector )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetKey(value As String)
		  RaiseErrorIf value = "", kErrorKeyCannotBeEmpty
		  
		  RaiseEvent KeyChanged( value )
		  WasKeySet = true
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CloneFrom(e As M_Crypto.Encrypter)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Decrypt(type As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Encrypt(type As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyChanged(key As String)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return zBlockSize
			End Get
		#tag EndGetter
		BlockSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return MemoryBlockToString( zCurrentVector )
			  
			End Get
		#tag EndGetter
		CurrentVector As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected InitialVector As Xojo.Core.MutableMemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		PaddingMethod As Padding
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5768656E207365742C20456E637279707420616E6420446563727970742077696C6C2075736520746865207370656369666965642066756E6374696F6E
		UseFunction As Functions
	#tag EndProperty

	#tag Property, Flags = &h21
		Private VectorDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected WasKeySet As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private zBlockSize As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  //
			  // If the same encrypter is used in different threads to
			  // process blocks, have to make sure one thread's vector doesn't clobber the other
			  //
			  
			  if VectorDict is nil then
			    VectorDict = new Dictionary
			    return nil // Can't be a vector yet
			  end if
			  
			  return VectorDict.Lookup( GetCurrentThreadId, nil )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if VectorDict is nil then
			    VectorDict = new Dictionary
			  end if
			  
			  VectorDict.Value( GetCurrentThreadId ) = value
			End Set
		#tag EndSetter
		Protected zCurrentVector As Xojo.Core.MutableMemoryBlock
	#tag EndComputedProperty


	#tag Constant, Name = kErrorDecryptionBlockSize, Type = String, Dynamic = False, Default = \"Data blocks must be an exact multiple of BlockSize", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kErrorIntermediateEncyptionBlockSize, Type = String, Dynamic = False, Default = \"Intermediate data blocks must be an exact multiple of BlockSize for encryption\n  ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kErrorKeyCannotBeEmpty, Type = String, Dynamic = False, Default = \"The key cannot be empty", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kErrorNoKeySet, Type = String, Dynamic = False, Default = \"A key must be specified during construction or within ExpandState or Expand0State before encrypting or decrypting.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kErrorVectorSize, Type = String, Dynamic = False, Default = \"Vector must be empty (will default to nulls)\x2C or exactly BLOCKSIZE bytes or hexadecimal characters representing BLOCKSIZE bytes", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Functions, Type = Integer, Flags = &h0
		Default
		  ECB
		CBC
	#tag EndEnum

	#tag Enum, Name = Padding, Type = Integer, Flags = &h0
		NullsOnly
		  NullsWithCount
		PKCS
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="BlockSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentVector"
			Group="Behavior"
			Type="String"
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
			Name="PaddingMethod"
			Group="Behavior"
			Type="Padding"
			EditorType="Enum"
			#tag EnumValues
				"0 - NullsOnly"
				"1 - NullsWithCount"
				"2 - PKCS"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFunction"
			Group="Behavior"
			Type="Functions"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - ECB"
				"2 - CBC"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
