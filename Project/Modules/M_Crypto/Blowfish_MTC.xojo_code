#tag Class
Class Blowfish_MTC
Inherits M_Crypto.Encrypter
Implements BcryptInterface
	#tag Event
		Sub CloneFrom(e As M_Crypto.Encrypter)
		  Var other as M_Crypto.Blowfish_MTC = M_Crypto.Blowfish_MTC( e )
		  
		  if other.P isa object then
		    P = new Xojo.Core.MutableMemoryBlock( other.P )
		    PPtr = P.Data
		  end if
		  
		  if other.S isa object then
		    S = new Xojo.Core.MutableMemoryBlock( other.S )
		    SPtr = S.Data
		  end if
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Decrypt(type As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
		  select case type
		  case Functions.Default
		    DecryptMb data
		    
		  case Functions.ECB
		    DecryptMbECB data 
		    
		  case Functions.CBC
		    DecryptMbCBC data, isFinalBlock
		    
		  case else
		    raise new M_Crypto.UnsupportedFunctionException
		    
		  end select
		  
		End Sub
	#tag EndEvent

	#tag Event , Description = 506572666F726D20612073656C662D74657374206F6E2074686520636C6173732E20496620636F646520697320696D706C656D656E7465642C206D7573742072657475726E20547275652E
		Function DoSelfTest(ByRef returnErrorMessage As String) As Boolean
		  const kKey as string = "password"
		  const kData as string = "1234567890ABCD"
		  
		  //
		  // Set up an initial state
		  //
		  Var initialVector as Xojo.Core.MutableMemoryBlock = self.InitialVector
		  self.InitialVector = nil
		  Var initialPadding as Padding = self.PaddingMethod
		  Constructor( Padding.PKCS )
		  
		  //
		  // Set up the keys
		  //
		  Var mbKey as Xojo.Core.MutableMemoryBlock = M_Crypto.StringToMutableMemoryBlock( kKey )
		  Var mbData as Xojo.Core.MutableMemoryBlock = M_Crypto.StringToMutableMemoryBlock( kData )
		  Var result as string
		  
		  //
		  // Test ExpandState
		  //
		  if returnErrorMessage = "" then
		    ExpandState mbData, mbKey
		    result = SelfTestMemoryBlockHash( P, 18 * 4 )
		    System.DebugLog "ExpandState P = " + result
		    if result <> "335546B718798929DB286BF431347578131297FB7C0DCF7FBED4200637ADEAED" then
		      returnErrorMessage = "P mismatch after ExpandState"
		    else
		      result = SelfTestMemoryBlockHash( S, 1024 * 4 )
		      System.DebugLog "ExpandState S = " + result
		      if result <> "1D7B1CE92B99533B95F9676756461EB8BEEFF07A7DDD60C5BE8EE62F47CF7952" then
		        returnErrorMessage = "S mismatch after ExpandState"
		      end if
		    end if
		  end if
		  
		  //
		  // Test Expand0State
		  //
		  if returnErrorMessage = "" then
		    Expand0State 1, mbData, mbKey
		    result = SelfTestMemoryBlockHash( P, 18 * 4 )
		    System.DebugLog "Expand0State P = " + result
		    if result <> "88D7DA0BA674E47208673DD308D731D3D299A1E3746D7D4A8AED88325B08E70C" then
		      returnErrorMessage = "P mismatch after ExpandState"
		    else
		      result = SelfTestMemoryBlockHash( S, 1024 * 4 )
		      System.DebugLog "Expand0State S = " + result
		      if result <> "0D8B54D47B7E0B0527060F749B9F15A17CF7207538B15287990F550ACB5F121E" then
		        returnErrorMessage = "S mismatch after ExpandState"
		      end if
		    end if
		  end if
		  
		  if returnErrorMessage = "" then
		    EncryptMb( mbData )
		    result = SelfTestMemoryBlockHash( mbData, mbData.Size )
		    System.DebugLog "Encrypt Data = " + result
		    if result <> "935FAE939D95AAEF2EF71C35C0D3187CC04957A450E80230AB46C8428B550BDF" then
		      returnErrorMessage = "Data mismatch after Encrypt"
		    end if
		  end if
		  
		  if returnErrorMessage = "" then
		    EncryptMbECB( mbData )
		    result = SelfTestMemoryBlockHash( mbData, mbData.Size )
		    System.DebugLog "EncryptECB Data = " + result
		    if result <> "F39CAB4DD928508085C4AD58A40F8C698C00A2502A1DBE503527FA519140A812" then
		      returnErrorMessage = "Data mismatch after EncryptECB"
		    end if
		  end if
		  
		  if returnErrorMessage = "" then
		    EncryptMbCBC( mbData )
		    result = SelfTestMemoryBlockHash( mbData, mbData.Size )
		    System.DebugLog "EncryptCBC Data = " + result
		    if result <> "3809E69D2EFC2B9C747640516C70E43999B9BEA77462FC31845EDD5BAD850107" then
		      returnErrorMessage = "Data mismatch after EncryptCBC"
		    end if
		  end if
		  
		  if returnErrorMessage = "" then
		    Var d0 as UInt32 = 1
		    Var d1 as UInt32 = 126
		    Encipher( d0, d1 )
		    if d0 <> CType( 1759095662, UInt32 ) or d1 <> CType( 231467629, UInt32 ) then
		      returnErrorMessage = "Encipher fail"
		    else
		      Decipher( d0, d1 )
		      if d0 <> 1 or d1 <> 126 then
		        returnErrorMessage = "Decipher fail"
		      end if
		    end if
		  end if
		  
		  //
		  // Finish
		  //
		  Constructor( "", initialPadding )
		  self.InitialVector = initialVector
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Encrypt(type As Functions, data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean)
		  select case type
		  case Functions.Default
		    EncryptMb data
		    
		  case Functions.ECB
		    EncryptMbECB data
		    
		  case Functions.CBC
		    EncryptMbCBC data, isFinalBlock
		    
		  case else
		    raise new M_Crypto.UnsupportedFunctionException
		    
		  end select
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub KeyChanged(key As String)
		  InitKeyValues
		  
		  Var temp as MemoryBlock = key
		  Var keyMB as new Xojo.Core.MutableMemoryBlock( temp, temp.Size )
		  Expand0State 1, keyMB
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(paddingMethod As Padding)
		  Constructor "", paddingMethod
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(key As String = "")
		  Constructor key, Padding.PKCS
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(key as String, paddingMethod as Padding)
		  SetBlockSize 8
		  self.PaddingMethod = paddingMethod
		  
		  // See if a key was provided
		  if key <> "" then
		    SetKey key
		  else
		    InitKeyValues
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Decipher(ByRef x0 As UInt32, ByRef x1 As UInt32)
		  // The main loop for processing Decipher
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var mySPtr as Ptr = SPtr
		  Var myPPtr as Ptr = PPtr
		  
		  const kFF as UInt32 = &hFF
		  const kShiftRight3 as UInt32 = 256 ^ 3
		  const kShiftRight2 as UInt32 = 256 ^ 2
		  const kShiftRight1 as UInt32 = 256
		  
		  Var xl as UInt32 = x0
		  Var xr as UInt32 = x1
		  
		  xl = xl Xor myPPtr.UInt32( 17 * 4 )
		  
		  Var a, b, c, d as integer
		  Var j as UInt32
		  for i as integer = 16 downto 2 step 2
		    j = xl
		    
		    a = ( j \ kShiftRight3 ) and kFF
		    b = ( j \ kShiftRight2 ) and kFF
		    c = ( j \ kShiftRight1 ) and kFF
		    d = j and kFF
		    
		    j = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		    Xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		    + mySPtr.UInt32( ( 768 + d ) * 4 )
		    
		    xr = xr Xor ( j Xor myPPtr.UInt32( i * 4 ) )
		    
		    j = xr
		    
		    a = ( j \ kShiftRight3 ) and kFF
		    b = ( j \ kShiftRight2 ) and kFF
		    c = ( j \ kShiftRight1 ) and kFF
		    d = j and kFF
		    
		    j = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		    Xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		    + mySPtr.UInt32( ( 768 + d ) * 4 )
		    
		    xl = xl Xor ( j Xor myPPtr.UInt32( ( i - 1 ) * 4 ) )
		  next i
		  
		  xr = xr Xor myPPtr.UInt32( 0 )
		  
		  x0 = xr
		  x1 = xl
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecryptMb(data As Xojo.Core.MutableMemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var dataPtr as Ptr = data.Data
		  Var blocks as integer = data.Size \ 8
		  Var byteIndex as integer
		  Var x0 as UInt32
		  Var x1 as UInt32
		  
		  for thisBlock as Integer = 1 to blocks
		    x0 = dataPtr.UInt32( byteIndex )
		    x1 = dataPtr.UInt32( byteIndex + 4 )
		    Decipher( x0, x1 )
		    dataPtr.UInt32( byteIndex ) = x0
		    dataPtr.UInt32( byteIndex + 4 ) = x1
		    
		    byteIndex = byteIndex + 8
		  next thisBlock
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecryptMbCBC(data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean = True)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var l, r as UInt32
		  Var blocks as integer = data.Size \ 8
		  Var byteIndex as integer = ( ( data.Size \ 8 ) * 8 ) - 8
		  
		  Var savedInitialVectorMB as new Xojo.Core.MutableMemoryBlock( 8 )
		  if zCurrentVector isa object then
		    savedInitialVectorMB.Left( 8 ) = zCurrentVector
		  elseif InitialVector isa object then
		    savedInitialVectorMB.Left( 8 ) = InitialVector
		  end if
		  
		  if not isFinalBlock then
		    if zCurrentVector is nil then
		      zCurrentVector = new Xojo.Core.MutableMemoryBlock( 8 )
		    end if
		    zCurrentVector.Left( 8 ) = data.Mid( byteIndex, 8 ) // For chain decrypting
		  end if
		  
		  Var dataPtr as ptr = data.Data
		  data.LittleEndian = false
		  
		  Var vectorMB as new Xojo.Core.MutableMemoryBlock( 8 )
		  Var vectorPtr as Ptr = vectorMB.Data
		  
		  for i as integer = blocks downto 1
		    if i = 1 then
		      vectorMB.Left( 8 ) = savedInitialVectorMB.Left( 8 )
		    else // i <> 1
		      vectorMB.Left( 8 ) = data.Mid( byteIndex - 8, 8 )
		    end if
		    
		    l = data.UInt32Value( byteIndex )
		    r = data.UInt32Value( byteIndex + 4 )
		    
		    Decipher( l, r )
		    
		    data.UInt32Value( byteIndex ) = l
		    data.UInt32Value( byteIndex + 4 ) = r
		    
		    dataPtr.UInt64( byteIndex ) = dataPtr.UInt64( byteIndex ) xor vectorPtr.UInt64( 0 )
		    
		    byteIndex = byteIndex - 8
		  next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecryptMbECB(data As Xojo.Core.MutableMemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var blocks as integer = data.Size \ 8
		  Var byteIndex as integer
		  Var l, r as UInt32
		  
		  data.LittleEndian = false
		  
		  const kFF as UInt32 = &hFF
		  
		  for i as integer = 1 to blocks
		    l = data.UInt32Value( byteIndex )
		    r = data.UInt32Value( byteIndex + 4 )
		    
		    Decipher( l, r )
		    
		    data.UInt32Value( byteIndex ) = l
		    data.UInt32Value( byteIndex + 4 ) = r
		    
		    byteIndex = byteIndex + 8
		  next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Encipher(ByRef x0 As UInt32, ByRef x1 As UInt32)
		  // The main loop for processing Encipher
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  const kFF as UInt32 = &hFF
		  const kShiftRight3 as UInt32 = 256 ^ 3
		  const kShiftRight2 as UInt32 = 256 ^ 2
		  const kShiftRight1 as UInt32 = 256
		  
		  Var mySPtr as Ptr = SPtr
		  Var myPPtr as Ptr = PPtr
		  
		  Var xl as UInt32 = x0
		  Var xr as Uint32 = x1
		  
		  xl = xl Xor myPPtr.UInt32( 0 )
		  
		  Var a, b, c, d as integer
		  Var j as UInt32
		  for i as integer = 1 to 16 step 2
		    j = xl
		    
		    a = ( j \ kShiftRight3 )
		    b = ( j \ kShiftRight2 ) and kFF
		    c = ( j \ kShiftRight1 ) and kFF
		    d = j and kFF
		    
		    j = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		    Xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		    + mySPtr.UInt32( ( 768 + d ) * 4 )
		    
		    xr = xr Xor ( j Xor myPPtr.UInt32( i * 4 ) )
		    
		    j = xr
		    
		    a = ( j \ kShiftRight3 ) 
		    b = ( j \ kShiftRight2 ) and kFF
		    c = ( j \ kShiftRight1 ) and kFF
		    d = j and kFF
		    
		    j = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		    Xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		    + mySPtr.UInt32( ( 768 + d ) * 4 )
		    
		    xl = xl Xor ( j Xor myPPtr.UInt32( ( i + 1 ) * 4 ) )
		  next i
		  
		  xr = xr Xor myPPtr.UInt32( 17 * 4 )
		  
		  x0 = xr
		  x1 = xl
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncryptMb(data As Xojo.Core.MutableMemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  const kShift3 as UInt32 = 256 ^ 3
		  const kShift2 as UInt32 = 256 ^ 2
		  const kShift1 as UInt32 = 256 ^ 1
		  
		  const kMask1 as UInt32 = &h00FF0000
		  const kMask2 as UInt32 = &h0000FF00
		  const kMask3 as UInt32 = &h000000FF
		  
		  const kPLastByte as integer = ( 18 * 4 ) - 1
		  const kPLastInnerByte as integer = kPLastByte - 7
		  
		  Var dataPtr as Ptr = data.Data
		  Var lastDataByte as integer = data.Size - 1
		  Var d0 as UInt32
		  Var d1 as UInt32
		  
		  Var a, b, c, d as integer // Used as indexes
		  Var pptrEncoderIndex as integer
		  Var xl as UInt32 
		  Var xr as UInt32 
		  Var j1 as UInt32
		  
		  Var myPPtr as ptr = PPtr
		  Var mySPtr as ptr = SPtr
		  
		  Var firstPPtrValue as UInt32 = myPPtr.UInt32( 0 )
		  for byteIndex as integer = 0 to lastDataByte step 8
		    d0 = dataPtr.UInt32( byteIndex )
		    d1 = dataPtr.UInt32( byteIndex + 4 )
		    
		    //
		    // Encipher is inlined here since this sub
		    // is used by bcrypt
		    //
		    'Encipher( x0, x1 )
		    
		    xl = d0
		    xr = d1
		    
		    xl = xl xor firstPPtrValue
		    
		    for pptrEncoderIndex = 4 to kPLastInnerByte step 8
		      j1 = xl
		      
		      a = ( j1 \ kShift3 )
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xr = xr xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex ) )
		      
		      j1 = xr
		      
		      a = ( j1 \ kShift3 ) 
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xl = xl xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex + 4 ) )
		    next pptrEncoderIndex
		    
		    xr = xr xor myPPtr.UInt32( kPLastByte - 3 )
		    
		    d0 = xr
		    d1 = xl
		    
		    
		    dataPtr.UInt32( byteIndex ) = d0
		    dataPtr.UInt32( byteIndex + 4 ) = d1
		  next byteIndex
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncryptMbCBC(data As Xojo.Core.MutableMemoryBlock, isFinalBlock As Boolean = True)
		  #pragma unused isFinalBlock
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var vectorMB as Xojo.Core.MutableMemoryBlock = zCurrentVector
		  if vectorMB is nil and InitialVector isa object then
		    vectorMB = new Xojo.Core.MutableMemoryBlock( InitialVector )
		    zCurrentVector = vectorMB
		  end if
		  
		  if vectorMB is nil then
		    vectorMB = new Xojo.Core.MutableMemoryBlock( 8 )
		    zCurrentVector = vectorMB
		  end if
		  Var vectorPtr as ptr = vectorMB.Data
		  
		  Var r, l as UInt32
		  Var dataPtr as Ptr = data.Data
		  Var blocks as integer = data.Size \ 8
		  Var byteIndex as integer
		  
		  data.LittleEndian = false
		  
		  for i as integer = 1 to blocks
		    dataPtr.UInt64( byteIndex ) = dataPtr.UInt64( byteIndex ) xor vectorPtr.UInt64( 0 )
		    
		    l = data.UInt32Value( byteIndex )
		    r = data.UInt32Value( byteIndex + 4 )
		    
		    Encipher( l, r )
		    
		    data.UInt32Value( byteIndex ) = l
		    data.UInt32Value( byteIndex + 4 ) = r
		    
		    vectorMB.Left( 8 ) = data.Mid( byteIndex, 8 )
		    byteIndex = byteIndex + 8
		  next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncryptMbECB(data As Xojo.Core.MutableMemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var blocks as integer = data.Size \ 8
		  Var byteIndex as integer
		  Var l, r as UInt32
		  
		  data.LittleEndian = false
		  
		  for i as integer = 1 to blocks
		    l = data.UInt32Value( byteIndex )
		    r = data.UInt32Value( byteIndex + 4 )
		    
		    Encipher( l, r )
		    
		    data.UInt32Value( byteIndex ) = l
		    data.UInt32Value( byteIndex + 4 ) = r
		    
		    byteIndex = byteIndex + 8
		  next i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Expand0State(repetitions As Integer, ParamArray keys() As Xojo.Core.MutableMemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  const kZero as UInt32 = 0
		  
		  const kShift3 as UInt32 = 256 ^ 3
		  const kShift2 as UInt32 = 256 ^ 2
		  const kShift1 as UInt32 = 256 ^ 1
		  
		  const kMask0 as UInt32 = &hFF000000
		  const kMask1 as UInt32 = &h00FF0000
		  const kMask2 as UInt32 = &h0000FF00
		  const kMask3 as UInt32 = &h000000FF
		  
		  const kSLastByte as integer = 4095
		  const kPLastByte as integer = ( 18 * 4 ) - 1
		  const kPLastInnerByte as integer = kPLastByte - 7
		  
		  Var myPPtr as ptr = PPtr
		  Var mySPtr as ptr = SPtr
		  
		  //
		  // Create the stream keys
		  //
		  const kStreamWordSize as integer = 8
		  
		  #if kDebug then
		    Var startMs, elapsedMs as Double
		    Var logPrefix as string = CurrentMethodName + ": "
		  #endif
		  
		  #if kDebug then
		    System.DebugLog logPrefix + "Rounds = " + format( repetitions, "#,0" )
		  #endif
		  
		  #if kDebug then
		    startMs = Microseconds
		  #endif
		  for keyIndex as integer = 0 to keys.LastRowIndex
		    Var key as Xojo.Core.MutableMemoryBlock = keys( keyIndex )
		    Var keySize as integer = key.Size
		    
		    if keySize = 0 then
		      RaiseErrorIf( true, kErrorKeyCannotBeEmpty )
		    end if
		    WasKeySet = true
		    
		    Var streamKey as Xojo.Core.MutableMemoryBlock
		    Var streamKeySize as integer = keySize
		    if ( keySize mod kStreamWordSize ) = 0 then
		      streamKey = new Xojo.Core.MutableMemoryBlock( keySize )
		      streamKey.Left( keySize ) = key
		    else
		      streamKeySize = streamKeySize * kStreamWordSize
		      
		      streamKey = new Xojo.Core.MutableMemoryBlock( streamKeySize )
		      Var lastByte as integer = streamKeySize - 1
		      for thisByte as integer = 0 to lastByte step keySize
		        streamKey.Mid( thisByte, keySize ) = key
		      next
		    end if
		    
		    #if TargetLittleEndian then
		      //
		      // Swap the bytes
		      //
		      Var streamKeyPtr as ptr = streamKey.Data
		      Var swapIndex as integer
		      while swapIndex < streamKeySize
		        Var temp as UInt32 = streamKeyPtr.UInt32( swapIndex )
		        streamKeyPtr.UInt32( swapIndex ) = _
		        ( temp \ kShift3 ) or _
		        ( ( temp and kMask1 ) \ kShift1 ) or _
		        ( ( temp and kMask2 ) * kShift1 ) or _
		        ( temp * kShift3 )
		        
		        swapIndex = swapIndex + 4
		      wend
		    #endif
		    
		    keys( keyIndex ) = streamKey
		  next
		  
		  #if kDebug then
		    elapsedMs = Microseconds - startMs
		    System.DebugLog logPrefix + "Stream keys took " + format( elapsedMs, "#,0.0##" ) + " µs"
		  #endif
		  
		  //
		  // Encoding starts here
		  //
		  
		  Var a, b, c, d as integer // Used as indexes
		  Var s1, s2, s3, s4 as UInt32
		  Var pValue1, pValue2 as UInt32
		  Var xl as UInt32 
		  Var xr as UInt32 
		  Var temp as UInt32
		  Var barrier as integer
		  Var pptrEncoderIndex as integer
		  
		  Var key as Xojo.Core.MutableMemoryBlock
		  Var keyPtr as ptr
		  Var keySize as integer
		  
		  Var streamIndex as integer
		  Var sByteIndex, pByteIndex as integer
		  Var keyIndex as integer
		  
		  for rep as integer = 1 to repetitions
		    
		    for keyIndex = 0 to keys.LastRowIndex
		      
		      #if kDebug then
		        startMs = Microseconds
		      #endif
		      
		      key = keys( keyIndex )
		      keyPtr = key.Data
		      keySize = key.Size
		      
		      barrier = keySize - kStreamWordSize
		      streamIndex = 0
		      for pByteIndex = 0 to kPLastByte step kStreamWordSize // Two words at a time
		        'temp = Stream2Word( key, streamIndex, streamBuffer, streamBufferPtr )
		        
		        myPPtr.UInt64( pByteIndex ) = myPPtr.UInt64( pByteIndex ) xor keyPtr.UInt64( streamIndex )
		        if streamIndex = barrier then
		          streamIndex = 0
		        else
		          streamIndex = streamIndex + kStreamWordSize
		        end if
		      next pByteIndex
		      
		      xl = kZero
		      xr = kZero
		      
		      //
		      // Update P
		      //
		      for pByteIndex = 0 to kPLastByte step 8
		        'self.Encipher( d0, d1 )
		        
		        temp = xl
		        xl = xr xor myPPtr.UInt32( 0 )
		        xr = temp
		        
		        for pptrEncoderIndex = 4 to kPLastInnerByte step 8
		          a = xl \ kShift3
		          b = ( xl and kMask1 ) \ kShift2
		          c = ( xl and kMask2 ) \ kShift1
		          d = xl and kMask3
		          
		          a = a * 4
		          b = ( 256 + b ) * 4
		          c = ( 512 + c ) * 4
		          d = ( 768 + d ) * 4
		          
		          s1 = mySPtr.UInt32( a )
		          s2 = mySPtr.UInt32( b )
		          s3 = mySPtr.UInt32( c )
		          s4 = mySPtr.UInt32( d )
		          temp = ( ( s1 + s2 ) xor s3 ) + s4 
		          
		          pValue1 = myPPtr.UInt32( pptrEncoderIndex )
		          xr = xr xor ( temp xor pValue1 )
		          
		          a = xr \ kShift3
		          b = ( xr and kMask1 ) \ kShift2
		          c = ( xr and kMask2 ) \ kShift1
		          d = xr and kMask3
		          
		          a = a * 4
		          b = ( 256 + b ) * 4
		          c = ( 512 + c ) * 4
		          d = ( 768 + d ) * 4
		          
		          s1 = mySPtr.UInt32( a )
		          s2 = mySPtr.UInt32( b )
		          s3 = mySPtr.UInt32( c )
		          s4 = mySPtr.UInt32( d )
		          temp = ( ( s1 + s2 ) xor s3 ) + s4 
		          
		          pValue2 = myPPtr.UInt32( pptrEncoderIndex + 4 )
		          xl = xl xor ( temp xor pValue2 )
		        next pptrEncoderIndex
		        
		        xr = xr xor myPPtr.UInt32( kPLastByte - 3 )
		        
		        
		        myPPtr.UInt32( pByteIndex ) = xr
		        myPPtr.UInt32( pByteIndex + 4 ) = xl
		      next pByteIndex
		      
		      //
		      // Update S
		      //
		      for sByteIndex = 0 to kSLastByte step 8
		        'self.Encipher( d0, d1 )
		        
		        temp = xl
		        xl = xr xor myPPtr.UInt32( 0 )
		        xr = temp
		        
		        for pptrEncoderIndex = 4 to kPLastInnerByte step 8
		          a = xl \ kShift3
		          b = ( xl and kMask1 ) \ kShift2
		          c = ( xl and kMask2 ) \ kShift1
		          d = xl and kMask3
		          
		          a = a * 4
		          b = ( 256 + b ) * 4
		          c = ( 512 + c ) * 4
		          d = ( 768 + d ) * 4
		          
		          s1 = mySPtr.UInt32( a )
		          s2 = mySPtr.UInt32( b )
		          s3 = mySPtr.UInt32( c )
		          s4 = mySPtr.UInt32( d )
		          temp = ( ( s1 + s2 ) xor s3 ) + s4 
		          
		          pValue1 = myPPtr.UInt32( pptrEncoderIndex )
		          xr = xr xor ( temp xor pValue1 )
		          
		          a = xr \ kShift3
		          b = ( xr and kMask1 ) \ kShift2
		          c = ( xr and kMask2 ) \ kShift1
		          d = xr and kMask3
		          
		          a = a * 4
		          b = ( 256 + b ) * 4
		          c = ( 512 + c ) * 4
		          d = ( 768 + d ) * 4
		          
		          s1 = mySPtr.UInt32( a )
		          s2 = mySPtr.UInt32( b )
		          s3 = mySPtr.UInt32( c )
		          s4 = mySPtr.UInt32( d )
		          temp = ( ( s1 + s2 ) xor s3 ) + s4 
		          
		          pValue2 = myPPtr.UInt32( pptrEncoderIndex + 4 )
		          xl = xl xor ( temp xor pValue2 )
		        next pptrEncoderIndex
		        
		        xr = xr xor myPPtr.UInt32( kPLastByte - 3 )
		        
		        
		        mySPtr.UInt32( sByteIndex ) = xr
		        mySPtr.UInt32( sByteIndex + 4 ) = xl
		        
		        #if DebugBuild then
		          sByteIndex = sByteIndex // A place to break
		        #endif
		      next sByteIndex
		      
		      #if kDebug then
		        elapsedMs = Microseconds - startMs
		        System.DebugLog logPrefix + "Key index " + str( keyIndex ) + " took " + format( elapsedMs, "#,0.0##" ) + " µs"
		      #endif
		    next keyIndex
		  next rep
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandState(data As Xojo.Core.MutableMemoryBlock, key As Xojo.Core.MutableMemoryBlock)
		  RaiseErrorIf( key.Size = 0, kErrorKeyCannotBeEmpty )
		  WasKeySet = true
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  const kShift3 as UInt32 = 256 ^ 3
		  const kShift2 as UInt32 = 256 ^ 2
		  const kShift1 as UInt32 = 256 ^ 1
		  
		  const kMask0 as UInt32 = &hFF000000
		  const kMask1 as UInt32 = &h00FF0000
		  const kMask2 as UInt32 = &h0000FF00
		  const kMask3 as UInt32 = &h000000FF
		  
		  const kSLastByte as integer = 4095
		  const kPLastByte as integer = ( 18 * 4 ) - 1
		  const kPLastInnerByte as integer = kPLastByte - 7
		  
		  Var streamIndex as integer
		  Var pByteIndex as integer
		  Var sByteIndex as integer
		  Var temp as UInt32
		  Var d0 as UInt32
		  Var d1 as UInt32
		  
		  Var myPPtr as ptr = PPtr
		  Var mySPtr as ptr = SPtr
		  
		  //
		  // Create the streams
		  //
		  const kStreamWordSize as integer = 8
		  
		  Var streamData as Xojo.Core.MutableMemoryBlock
		  Var dataSize as integer = data.Size
		  Var streamDataSize as integer = dataSize
		  
		  if ( streamDataSize mod kStreamWordSize ) = 0 then
		    streamData = new Xojo.Core.MutableMemoryBlock( streamDataSize )
		    streamData.Left( streamDataSize ) = data
		  else
		    streamDataSize = dataSize * kStreamWordSize
		    streamData = new Xojo.Core.MutableMemoryBlock( streamDataSize )
		    
		    Var lastByte as integer = streamDataSize - 1
		    for thisByte as integer = 0 to lastByte step dataSize
		      streamData.Mid( thisByte, dataSize ) = data
		    next
		  end if
		  
		  Var streamDataPtr as ptr = streamData.Data
		  
		  #if TargetLittleEndian then
		    Var copyIndex as integer
		    while copyIndex < streamDataSize
		      temp = streamDataPtr.UInt32( copyIndex )
		      streamDataPtr.UInt32( copyIndex ) = _
		      ( temp \ kShift3 ) or _
		      ( ( temp and kMask1 ) \ kShift1 ) or _
		      ( ( temp and kMask2 ) * kShift1 ) or _
		      ( temp * kShift3 )
		      
		      copyIndex = copyIndex + 4
		    wend
		  #endif
		  
		  Var streamKey as Xojo.Core.MutableMemoryBlock
		  Var keySize as integer = key.Size
		  Var streamKeySize as integer = keySize
		  
		  if ( streamKeySize mod kStreamWordSize ) = 0 then
		    streamKey = new Xojo.Core.MutableMemoryBlock( keySize )
		    streamKey.Left( keySize ) = key
		  else
		    streamKeySize = keySize * kStreamWordSize
		    streamKey = new Xojo.Core.MutableMemoryBlock( streamKeySize )
		    
		    Var lastByte as integer = streamKeySize - 1
		    for thisByte as integer = 0 to lastByte step keySize
		      streamKey.Mid( thisByte, keySize ) = key
		    next
		  end if
		  
		  Var streamKeyPtr as ptr = streamKey.Data
		  
		  #if TargetLittleEndian then
		    copyIndex = 0
		    while copyIndex < streamKeySize
		      temp = streamKeyPtr.UInt32( copyIndex )
		      streamKeyPtr.UInt32( copyIndex ) = _
		      ( temp \ kShift3 ) or _
		      ( ( temp and kMask1 ) \ kShift1 ) or _
		      ( ( temp and kMask2 ) * kShift1 ) or _
		      ( temp * kShift3 )
		      
		      copyIndex = copyIndex + 4
		    wend
		  #endif
		  
		  //
		  // Encoding starts here
		  //
		  
		  streamIndex = 0
		  Var barrier as integer = streamKeySize - kStreamWordSize
		  for pByteIndex = 0 to kPLastByte step kStreamWordSize // Two words at a time
		    'temp = Stream2Word( key, streamIndex, streamBuffer, streamBufferPtr )
		    
		    myPPtr.UInt64( pByteIndex ) = myPPtr.UInt64( pByteIndex ) xor streamKeyPtr.UInt64( streamIndex )
		    if streamIndex = barrier then
		      streamIndex = 0
		    else
		      streamIndex = streamIndex + kStreamWordSize
		    end if
		  next pByteIndex
		  
		  Var a, b, c, d as integer // Used as indexes
		  Var xl as UInt32 
		  Var xr as UInt32 
		  Var j1 as UInt32
		  Var pptrEncoderIndex as integer
		  
		  barrier = streamDataSize - 4
		  streamIndex = 0
		  for pByteIndex = 0 to kPLastByte step 8
		    'd0 = d0 Xor Stream2Word( data, streamIndex, streamBuffer, streamBufferPtr )
		    'd1 = d1 Xor Stream2Word( data, streamIndex, streamBuffer, streamBufferPtr )
		    
		    d0 = d0 xor streamDataPtr.UInt32( streamIndex )
		    if streamIndex = barrier then
		      streamIndex = 0
		    else
		      streamIndex = streamIndex + 4
		    end if
		    
		    d1 = d1 xor streamDataPtr.UInt32( streamIndex )
		    if streamIndex = barrier then
		      streamIndex = 0
		    else
		      streamIndex = streamIndex + 4
		    end if
		    
		    
		    'Encipher( d0, d1 )
		    
		    xl = d0
		    xr = d1
		    
		    xl = xl xor myPPtr.UInt32( 0 )
		    
		    for pptrEncoderIndex = 4 to kPLastInnerByte step 8
		      j1 = xl
		      
		      a = ( j1 \ kShift3 )
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xr = xr xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex ) )
		      
		      j1 = xr
		      
		      a = ( j1 \ kShift3 ) 
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xl = xl xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex + 4 ) )
		    next pptrEncoderIndex
		    
		    xr = xr xor myPPtr.UInt32( kPLastByte - 3 )
		    
		    d0 = xr
		    d1 = xl
		    
		    
		    myPPtr.UInt32( pByteIndex ) = d0
		    myPPtr.UInt32( pByteIndex + 4 ) = d1
		  next pByteIndex
		  
		  Var firstPPtr as UInt32 = myPPtr.UInt32( 0 )
		  for sByteIndex = 0 to kSLastByte step 8
		    'd0 = d0 Xor Stream2Word( data, streamIndex, streamBuffer, streamBufferPtr )
		    'd1 = d1 Xor Stream2Word( data, streamIndex, streamBuffer, streamBufferPtr )
		    
		    if streamIndex = streamDataSize then
		      streamIndex = 0
		    end if
		    d0 = d0 xor streamDataPtr.UInt32( streamIndex )
		    streamIndex = streamIndex + 4
		    
		    if streamIndex = streamDataSize then
		      streamIndex = 0
		    end if
		    d1 = d1 xor streamDataPtr.UInt32( streamIndex )
		    streamIndex = streamIndex + 4
		    
		    
		    'Encipher( d0, d1 )
		    
		    xl = d0
		    xr = d1
		    
		    xl = xl xor firstPPtr
		    
		    for pptrEncoderIndex = 4 to kPLastInnerByte step 8
		      j1 = xl
		      
		      a = ( j1 \ kShift3 )
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xr = xr xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex ) )
		      
		      j1 = xr
		      
		      a = ( j1 \ kShift3 ) 
		      b = ( j1 \ kShift2 ) and kMask3
		      c = ( j1 \ kShift1 ) and kMask3
		      d = j1 and kMask3
		      
		      j1 = ( ( mySPtr.UInt32( a * 4 ) + mySPtr.UInt32( ( 256 + b ) * 4 ) ) _
		      xor mySPtr.UInt32( ( 512 + c ) * 4 ) ) _
		      + mySPtr.UInt32( ( 768 + d ) * 4 )
		      
		      xl = xl xor ( j1 xor myPPtr.UInt32( pptrEncoderIndex + 4 ) )
		    next pptrEncoderIndex
		    
		    xr = xr xor myPPtr.UInt32( pptrEncoderIndex )
		    
		    d0 = xr
		    d1 = xl
		    
		    
		    mySPtr.UInt32( sByteIndex ) = d0
		    mySPtr.Uint32( sByteIndex + 4 ) = d1
		  next sByteIndex
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitKeyValues()
		  P = new Xojo.Core.MutableMemoryBlock( ( BLF_N + 2 ) * 4 )
		  PPtr = P.Data
		  S = new Xojo.Core.MutableMemoryBlock( 4 * 256 * 4 )
		  SPtr = S.Data
		  
		  static defaultS as Xojo.Core.MutableMemoryBlock
		  
		  if defaultS is nil then
		    
		    Var mySPtr as ptr = SPtr
		    
		    Var x as integer
		    for i as integer = 0 to 3
		      Var arr() as UInt32
		      select case i
		      case 0
		        arr = S0
		      case 1
		        arr = S1
		      case 2
		        arr = S2
		      case 3
		        arr = S3
		      end
		      
		      for i1 as Integer = 0 to arr.LastRowIndex
		        mySPtr.UInt32( x ) = arr( i1 )
		        x = x + 4
		      next i1
		    next i
		    
		    defaultS = new Xojo.Core.MutableMemoryBlock( S.Size )
		    defaultS.Left( S.Size ) = S
		    
		  else
		    S.Left( S.Size ) = defaultS
		    
		  end if
		  
		  static defaultP as Xojo.Core.MutableMemoryBlock
		  
		  if defaultP is nil then
		    Var myPPtr as ptr = PPtr
		    
		    Var vals() as UInt32 = UInt32Array( _
		    &h243f6a88, &h85a308d3, &h13198a2e, &h03707344, _
		    &ha4093822, &h299f31d0, &h082efa98, &hec4e6c89, _
		    &h452821e6, &h38d01377, &hbe5466cf, &h34e90c6c, _
		    &hc0ac29b7, &hc97c50dd, &h3f84d5b5, &hb5470917, _
		    &h9216d5d9, &h8979fb1b _
		    )
		    
		    for i as integer = 0 to vals.LastRowIndex
		      myPPtr.UInt32( i * 4 ) = vals( i )
		    next i
		    
		    defaultP = new Xojo.Core.MutableMemoryBlock( P.Size )
		    defaultP.Left( P.Size ) = P
		    
		  else
		    P.Left( P.Size ) = defaultP
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function S0() As UInt32()
		  return UInt32Array( _
		  &hd1310ba6, &h98dfb5ac, &h2ffd72db, &hd01adfb7, _
		  &hb8e1afed, &h6a267e96, &hba7c9045, &hf12c7f99, _
		  &h24a19947, &hb3916cf7, &h0801f2e2, &h858efc16, _
		  &h636920d8, &h71574e69, &ha458fea3, &hf4933d7e, _
		  &h0d95748f, &h728eb658, &h718bcd58, &h82154aee, _
		  &h7b54a41d, &hc25a59b5, &h9c30d539, &h2af26013, _
		  &hc5d1b023, &h286085f0, &hca417918, &hb8db38ef, _
		  &h8e79dcb0, &h603a180e, &h6c9e0e8b, &hb01e8a3e, _
		  &hd71577c1, &hbd314b27, &h78af2fda, &h55605c60, _
		  &he65525f3, &haa55ab94, &h57489862, &h63e81440, _
		  &h55ca396a, &h2aab10b6, &hb4cc5c34, &h1141e8ce, _
		  &ha15486af, &h7c72e993, &hb3ee1411, &h636fbc2a, _
		  &h2ba9c55d, &h741831f6, &hce5c3e16, &h9b87931e, _
		  &hafd6ba33, &h6c24cf5c, &h7a325381, &h28958677, _
		  &h3b8f4898, &h6b4bb9af, &hc4bfe81b, &h66282193, _
		  &h61d809cc, &hfb21a991, &h487cac60, &h5dec8032, _
		  &hef845d5d, &he98575b1, &hdc262302, &heb651b88, _
		  &h23893e81, &hd396acc5, &h0f6d6ff3, &h83f44239, _
		  &h2e0b4482, &ha4842004, &h69c8f04a, &h9e1f9b5e, _
		  &h21c66842, &hf6e96c9a, &h670c9c61, &habd388f0, _
		  &h6a51a0d2, &hd8542f68, &h960fa728, &hab5133a3, _
		  &h6eef0b6c, &h137a3be4, &hba3bf050, &h7efb2a98, _
		  &ha1f1651d, &h39af0176, &h66ca593e, &h82430e88, _
		  &h8cee8619, &h456f9fb4, &h7d84a5c3, &h3b8b5ebe, _
		  &he06f75d8, &h85c12073, &h401a449f, &h56c16aa6, _
		  &h4ed3aa62, &h363f7706, &h1bfedf72, &h429b023d, _
		  &h37d0d724, &hd00a1248, &hdb0fead3, &h49f1c09b, _
		  &h075372c9, &h80991b7b, &h25d479d8, &hf6e8def7, _
		  &he3fe501a, &hb6794c3b, &h976ce0bd, &h04c006ba, _
		  &hc1a94fb6, &h409f60c4, &h5e5c9ec2, &h196a2463, _
		  &h68fb6faf, &h3e6c53b5, &h1339b2eb, &h3b52ec6f, _
		  &h6dfc511f, &h9b30952c, &hcc814544, &haf5ebd09, _
		  &hbee3d004, &hde334afd, &h660f2807, &h192e4bb3, _
		  &hc0cba857, &h45c8740f, &hd20b5f39, &hb9d3fbdb, _
		  &h5579c0bd, &h1a60320a, &hd6a100c6, &h402c7279, _
		  &h679f25fe, &hfb1fa3cc, &h8ea5e9f8, &hdb3222f8, _
		  &h3c7516df, &hfd616b15, &h2f501ec8, &had0552ab, _
		  &h323db5fa, &hfd238760, &h53317b48, &h3e00df82, _
		  &h9e5c57bb, &hca6f8ca0, &h1a87562e, &hdf1769db, _
		  &hd542a8f6, &h287effc3, &hac6732c6, &h8c4f5573, _
		  &h695b27b0, &hbbca58c8, &he1ffa35d, &hb8f011a0, _
		  &h10fa3d98, &hfd2183b8, &h4afcb56c, &h2dd1d35b, _
		  &h9a53e479, &hb6f84565, &hd28e49bc, &h4bfb9790, _
		  &he1ddf2da, &ha4cb7e33, &h62fb1341, &hcee4c6e8, _
		  &hef20cada, &h36774c01, &hd07e9efe, &h2bf11fb4, _
		  &h95dbda4d, &hae909198, &heaad8e71, &h6b93d5a0, _
		  &hd08ed1d0, &hafc725e0, &h8e3c5b2f, &h8e7594b7, _
		  &h8ff6e2fb, &hf2122b64, &h8888b812, &h900df01c, _
		  &h4fad5ea0, &h688fc31c, &hd1cff191, &hb3a8c1ad, _
		  &h2f2f2218, &hbe0e1777, &hea752dfe, &h8b021fa1, _
		  &he5a0cc0f, &hb56f74e8, &h18acf3d6, &hce89e299, _
		  &hb4a84fe0, &hfd13e0b7, &h7cc43b81, &hd2ada8d9, _
		  &h165fa266, &h80957705, &h93cc7314, &h211a1477, _
		  &he6ad2065, &h77b5fa86, &hc75442f5, &hfb9d35cf, _
		  &hebcdaf0c, &h7b3e89a0, &hd6411bd3, &hae1e7e49, _
		  &h00250e2d, &h2071b35e, &h226800bb, &h57b8e0af, _
		  &h2464369b, &hf009b91e, &h5563911d, &h59dfa6aa, _
		  &h78c14389, &hd95a537f, &h207d5ba2, &h02e5b9c5, _
		  &h83260376, &h6295cfa9, &h11c81968, &h4e734a41, _
		  &hb3472dca, &h7b14a94a, &h1b510052, &h9a532915, _
		  &hd60f573f, &hbc9bc6e4, &h2b60a476, &h81e67400, _
		  &h08ba6fb5, &h571be91f, &hf296ec6b, &h2a0dd915, _
		  &hb6636521, &he7b9f9b6, &hff34052e, &hc5855664, _
		  &h53b02d5d, &ha99f8fa1, &h08ba4799, &h6e85076a _
		  )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function S1() As UInt32()
		  return UInt32Array( _
		  &h4b7a70e9, &hb5b32944, &hdb75092e, &hc4192623, _
		  &had6ea6b0, &h49a7df7d, &h9cee60b8, &h8fedb266, _
		  &hecaa8c71, &h699a17ff, &h5664526c, &hc2b19ee1, _
		  &h193602a5, &h75094c29, &ha0591340, &he4183a3e, _
		  &h3f54989a, &h5b429d65, &h6b8fe4d6, &h99f73fd6, _
		  &ha1d29c07, &hefe830f5, &h4d2d38e6, &hf0255dc1, _
		  &h4cdd2086, &h8470eb26, &h6382e9c6, &h021ecc5e, _
		  &h09686b3f, &h3ebaefc9, &h3c971814, &h6b6a70a1, _
		  &h687f3584, &h52a0e286, &hb79c5305, &haa500737, _
		  &h3e07841c, &h7fdeae5c, &h8e7d44ec, &h5716f2b8, _
		  &hb03ada37, &hf0500c0d, &hf01c1f04, &h0200b3ff, _
		  &hae0cf51a, &h3cb574b2, &h25837a58, &hdc0921bd, _
		  &hd19113f9, &h7ca92ff6, &h94324773, &h22f54701, _
		  &h3ae5e581, &h37c2dadc, &hc8b57634, &h9af3dda7, _
		  &ha9446146, &h0fd0030e, &hecc8c73e, &ha4751e41, _
		  &he238cd99, &h3bea0e2f, &h3280bba1, &h183eb331, _
		  &h4e548b38, &h4f6db908, &h6f420d03, &hf60a04bf, _
		  &h2cb81290, &h24977c79, &h5679b072, &hbcaf89af, _
		  &hde9a771f, &hd9930810, &hb38bae12, &hdccf3f2e, _
		  &h5512721f, &h2e6b7124, &h501adde6, &h9f84cd87, _
		  &h7a584718, &h7408da17, &hbc9f9abc, &he94b7d8c, _
		  &hec7aec3a, &hdb851dfa, &h63094366, &hc464c3d2, _
		  &hef1c1847, &h3215d908, &hdd433b37, &h24c2ba16, _
		  &h12a14d43, &h2a65c451, &h50940002, &h133ae4dd, _
		  &h71dff89e, &h10314e55, &h81ac77d6, &h5f11199b, _
		  &h043556f1, &hd7a3c76b, &h3c11183b, &h5924a509, _
		  &hf28fe6ed, &h97f1fbfa, &h9ebabf2c, &h1e153c6e, _
		  &h86e34570, &heae96fb1, &h860e5e0a, &h5a3e2ab3, _
		  &h771fe71c, &h4e3d06fa, &h2965dcb9, &h99e71d0f, _
		  &h803e89d6, &h5266c825, &h2e4cc978, &h9c10b36a, _
		  &hc6150eba, &h94e2ea78, &ha5fc3c53, &h1e0a2df4, _
		  &hf2f74ea7, &h361d2b3d, &h1939260f, &h19c27960, _
		  &h5223a708, &hf71312b6, &hebadfe6e, &heac31f66, _
		  &he3bc4595, &ha67bc883, &hb17f37d1, &h018cff28, _
		  &hc332ddef, &hbe6c5aa5, &h65582185, &h68ab9802, _
		  &heecea50f, &hdb2f953b, &h2aef7dad, &h5b6e2f84, _
		  &h1521b628, &h29076170, &hecdd4775, &h619f1510, _
		  &h13cca830, &heb61bd96, &h0334fe1e, &haa0363cf, _
		  &hb5735c90, &h4c70a239, &hd59e9e0b, &hcbaade14, _
		  &heecc86bc, &h60622ca7, &h9cab5cab, &hb2f3846e, _
		  &h648b1eaf, &h19bdf0ca, &ha02369b9, &h655abb50, _
		  &h40685a32, &h3c2ab4b3, &h319ee9d5, &hc021b8f7, _
		  &h9b540b19, &h875fa099, &h95f7997e, &h623d7da8, _
		  &hf837889a, &h97e32d77, &h11ed935f, &h16681281, _
		  &h0e358829, &hc7e61fd6, &h96dedfa1, &h7858ba99, _
		  &h57f584a5, &h1b227263, &h9b83c3ff, &h1ac24696, _
		  &hcdb30aeb, &h532e3054, &h8fd948e4, &h6dbc3128, _
		  &h58ebf2ef, &h34c6ffea, &hfe28ed61, &hee7c3c73, _
		  &h5d4a14d9, &he864b7e3, &h42105d14, &h203e13e0, _
		  &h45eee2b6, &ha3aaabea, &hdb6c4f15, &hfacb4fd0, _
		  &hc742f442, &hef6abbb5, &h654f3b1d, &h41cd2105, _
		  &hd81e799e, &h86854dc7, &he44b476a, &h3d816250, _
		  &hcf62a1f2, &h5b8d2646, &hfc8883a0, &hc1c7b6a3, _
		  &h7f1524c3, &h69cb7492, &h47848a0b, &h5692b285, _
		  &h095bbf00, &had19489d, &h1462b174, &h23820e00, _
		  &h58428d2a, &h0c55f5ea, &h1dadf43e, &h233f7061, _
		  &h3372f092, &h8d937e41, &hd65fecf1, &h6c223bdb, _
		  &h7cde3759, &hcbee7460, &h4085f2a7, &hce77326e, _
		  &ha6078084, &h19f8509e, &he8efd855, &h61d99735, _
		  &ha969a7aa, &hc50c06c2, &h5a04abfc, &h800bcadc, _
		  &h9e447a2e, &hc3453484, &hfdd56705, &h0e1e9ec9, _
		  &hdb73dbd3, &h105588cd, &h675fda79, &he3674340, _
		  &hc5c43465, &h713e38d8, &h3d28f89e, &hf16dff20, _
		  &h153e21e7, &h8fb03d4a, &he6e39f2b, &hdb83adf7 _
		  )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function S2() As UInt32()
		  return UInt32Array( _
		  &he93d5a68, &h948140f7, &hf64c261c, &h94692934, _
		  &h411520f7, &h7602d4f7, &hbcf46b2e, &hd4a20068, _
		  &hd4082471, &h3320f46a, &h43b7d4b7, &h500061af, _
		  &h1e39f62e, &h97244546, &h14214f74, &hbf8b8840, _
		  &h4d95fc1d, &h96b591af, &h70f4ddd3, &h66a02f45, _
		  &hbfbc09ec, &h03bd9785, &h7fac6dd0, &h31cb8504, _
		  &h96eb27b3, &h55fd3941, &hda2547e6, &habca0a9a, _
		  &h28507825, &h530429f4, &h0a2c86da, &he9b66dfb, _
		  &h68dc1462, &hd7486900, &h680ec0a4, &h27a18dee, _
		  &h4f3ffea2, &he887ad8c, &hb58ce006, &h7af4d6b6, _
		  &haace1e7c, &hd3375fec, &hce78a399, &h406b2a42, _
		  &h20fe9e35, &hd9f385b9, &hee39d7ab, &h3b124e8b, _
		  &h1dc9faf7, &h4b6d1856, &h26a36631, &heae397b2, _
		  &h3a6efa74, &hdd5b4332, &h6841e7f7, &hca7820fb, _
		  &hfb0af54e, &hd8feb397, &h454056ac, &hba489527, _
		  &h55533a3a, &h20838d87, &hfe6ba9b7, &hd096954b, _
		  &h55a867bc, &ha1159a58, &hcca92963, &h99e1db33, _
		  &ha62a4a56, &h3f3125f9, &h5ef47e1c, &h9029317c, _
		  &hfdf8e802, &h04272f70, &h80bb155c, &h05282ce3, _
		  &h95c11548, &he4c66d22, &h48c1133f, &hc70f86dc, _
		  &h07f9c9ee, &h41041f0f, &h404779a4, &h5d886e17, _
		  &h325f51eb, &hd59bc0d1, &hf2bcc18f, &h41113564, _
		  &h257b7834, &h602a9c60, &hdff8e8a3, &h1f636c1b, _
		  &h0e12b4c2, &h02e1329e, &haf664fd1, &hcad18115, _
		  &h6b2395e0, &h333e92e1, &h3b240b62, &heebeb922, _
		  &h85b2a20e, &he6ba0d99, &hde720c8c, &h2da2f728, _
		  &hd0127845, &h95b794fd, &h647d0862, &he7ccf5f0, _
		  &h5449a36f, &h877d48fa, &hc39dfd27, &hf33e8d1e, _
		  &h0a476341, &h992eff74, &h3a6f6eab, &hf4f8fd37, _
		  &ha812dc60, &ha1ebddf8, &h991be14c, &hdb6e6b0d, _
		  &hc67b5510, &h6d672c37, &h2765d43b, &hdcd0e804, _
		  &hf1290dc7, &hcc00ffa3, &hb5390f92, &h690fed0b, _
		  &h667b9ffb, &hcedb7d9c, &ha091cf0b, &hd9155ea3, _
		  &hbb132f88, &h515bad24, &h7b9479bf, &h763bd6eb, _
		  &h37392eb3, &hcc115979, &h8026e297, &hf42e312d, _
		  &h6842ada7, &hc66a2b3b, &h12754ccc, &h782ef11c, _
		  &h6a124237, &hb79251e7, &h06a1bbe6, &h4bfb6350, _
		  &h1a6b1018, &h11caedfa, &h3d25bdd8, &he2e1c3c9, _
		  &h44421659, &h0a121386, &hd90cec6e, &hd5abea2a, _
		  &h64af674e, &hda86a85f, &hbebfe988, &h64e4c3fe, _
		  &h9dbc8057, &hf0f7c086, &h60787bf8, &h6003604d, _
		  &hd1fd8346, &hf6381fb0, &h7745ae04, &hd736fccc, _
		  &h83426b33, &hf01eab71, &hb0804187, &h3c005e5f, _
		  &h77a057be, &hbde8ae24, &h55464299, &hbf582e61, _
		  &h4e58f48f, &hf2ddfda2, &hf474ef38, &h8789bdc2, _
		  &h5366f9c3, &hc8b38e74, &hb475f255, &h46fcd9b9, _
		  &h7aeb2661, &h8b1ddf84, &h846a0e79, &h915f95e2, _
		  &h466e598e, &h20b45770, &h8cd55591, &hc902de4c, _
		  &hb90bace1, &hbb8205d0, &h11a86248, &h7574a99e, _
		  &hb77f19b6, &he0a9dc09, &h662d09a1, &hc4324633, _
		  &he85a1f02, &h09f0be8c, &h4a99a025, &h1d6efe10, _
		  &h1ab93d1d, &h0ba5a4df, &ha186f20f, &h2868f169, _
		  &hdcb7da83, &h573906fe, &ha1e2ce9b, &h4fcd7f52, _
		  &h50115e01, &ha70683fa, &ha002b5c4, &h0de6d027, _
		  &h9af88c27, &h773f8641, &hc3604c06, &h61a806b5, _
		  &hf0177a28, &hc0f586e0, &h006058aa, &h30dc7d62, _
		  &h11e69ed7, &h2338ea63, &h53c2dd94, &hc2c21634, _
		  &hbbcbee56, &h90bcb6de, &hebfc7da1, &hce591d76, _
		  &h6f05e409, &h4b7c0188, &h39720a3d, &h7c927c24, _
		  &h86e3725f, &h724d9db9, &h1ac15bb4, &hd39eb8fc, _
		  &hed545578, &h08fca5b5, &hd83d7cd3, &h4dad0fc4, _
		  &h1e50ef5e, &hb161e6f8, &ha28514d9, &h6c51133c, _
		  &h6fd5c7e7, &h56e14ec4, &h362abfce, &hddc6c837, _
		  &hd79a3234, &h92638212, &h670efa8e, &h406000e0 _
		  )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function S3() As UInt32()
		  return UInt32Array( _
		  &h3a39ce37, &hd3faf5cf, &habc27737, &h5ac52d1b, _
		  &h5cb0679e, &h4fa33742, &hd3822740, &h99bc9bbe, _
		  &hd5118e9d, &hbf0f7315, &hd62d1c7e, &hc700c47b, _
		  &hb78c1b6b, &h21a19045, &hb26eb1be, &h6a366eb4, _
		  &h5748ab2f, &hbc946e79, &hc6a376d2, &h6549c2c8, _
		  &h530ff8ee, &h468dde7d, &hd5730a1d, &h4cd04dc6, _
		  &h2939bbdb, &ha9ba4650, &hac9526e8, &hbe5ee304, _
		  &ha1fad5f0, &h6a2d519a, &h63ef8ce2, &h9a86ee22, _
		  &hc089c2b8, &h43242ef6, &ha51e03aa, &h9cf2d0a4, _
		  &h83c061ba, &h9be96a4d, &h8fe51550, &hba645bd6, _
		  &h2826a2f9, &ha73a3ae1, &h4ba99586, &hef5562e9, _
		  &hc72fefd3, &hf752f7da, &h3f046f69, &h77fa0a59, _
		  &h80e4a915, &h87b08601, &h9b09e6ad, &h3b3ee593, _
		  &he990fd5a, &h9e34d797, &h2cf0b7d9, &h022b8b51, _
		  &h96d5ac3a, &h017da67d, &hd1cf3ed6, &h7c7d2d28, _
		  &h1f9f25cf, &hadf2b89b, &h5ad6b472, &h5a88f54c, _
		  &he029ac71, &he019a5e6, &h47b0acfd, &hed93fa9b, _
		  &he8d3c48d, &h283b57cc, &hf8d56629, &h79132e28, _
		  &h785f0191, &hed756055, &hf7960e44, &he3d35e8c, _
		  &h15056dd4, &h88f46dba, &h03a16125, &h0564f0bd, _
		  &hc3eb9e15, &h3c9057a2, &h97271aec, &ha93a072a, _
		  &h1b3f6d9b, &h1e6321f5, &hf59c66fb, &h26dcf319, _
		  &h7533d928, &hb155fdf5, &h03563482, &h8aba3cbb, _
		  &h28517711, &hc20ad9f8, &habcc5167, &hccad925f, _
		  &h4de81751, &h3830dc8e, &h379d5862, &h9320f991, _
		  &hea7a90c2, &hfb3e7bce, &h5121ce64, &h774fbe32, _
		  &ha8b6e37e, &hc3293d46, &h48de5369, &h6413e680, _
		  &ha2ae0810, &hdd6db224, &h69852dfd, &h09072166, _
		  &hb39a460a, &h6445c0dd, &h586cdecf, &h1c20c8ae, _
		  &h5bbef7dd, &h1b588d40, &hccd2017f, &h6bb4e3bb, _
		  &hdda26a7e, &h3a59ff45, &h3e350a44, &hbcb4cdd5, _
		  &h72eacea8, &hfa6484bb, &h8d6612ae, &hbf3c6f47, _
		  &hd29be463, &h542f5d9e, &haec2771b, &hf64e6370, _
		  &h740e0d8d, &he75b1357, &hf8721671, &haf537d5d, _
		  &h4040cb08, &h4eb4e2cc, &h34d2466a, &h0115af84, _
		  &he1b00428, &h95983a1d, &h06b89fb4, &hce6ea048, _
		  &h6f3f3b82, &h3520ab82, &h011a1d4b, &h277227f8, _
		  &h611560b1, &he7933fdc, &hbb3a792b, &h344525bd, _
		  &ha08839e1, &h51ce794b, &h2f32c9b7, &ha01fbac9, _
		  &he01cc87e, &hbcc7d1f6, &hcf0111c3, &ha1e8aac7, _
		  &h1a908749, &hd44fbd9a, &hd0dadecb, &hd50ada38, _
		  &h0339c32a, &hc6913667, &h8df9317c, &he0b12b4f, _
		  &hf79e59b7, &h43f5bb3a, &hf2d519ff, &h27d9459c, _
		  &hbf97222c, &h15e6fc2a, &h0f91fc71, &h9b941525, _
		  &hfae59361, &hceb69ceb, &hc2a86459, &h12baa8d1, _
		  &hb6c1075e, &he3056a0c, &h10d25065, &hcb03a442, _
		  &he0ec6e0e, &h1698db3b, &h4c98a0be, &h3278e964, _
		  &h9f1f9532, &he0d392df, &hd3a0342b, &h8971f21e, _
		  &h1b0a7441, &h4ba3348c, &hc5be7120, &hc37632d8, _
		  &hdf359f8d, &h9b992f2e, &he60b6f47, &h0fe3f11d, _
		  &he54cda54, &h1edad891, &hce6279cf, &hcd3e7e6f, _
		  &h1618b166, &hfd2c1d05, &h848fd2c5, &hf6fb2299, _
		  &hf523f357, &ha6327623, &h93a83531, &h56cccd02, _
		  &hacf08162, &h5a75ebb5, &h6e163697, &h88d273cc, _
		  &hde966292, &h81b949d0, &h4c50901b, &h71c65614, _
		  &he6c6c7bd, &h327a140a, &h45e1d006, &hc3f27b9a, _
		  &hc9aa53fd, &h62a80f00, &hbb25bfe2, &h35bdd2f6, _
		  &h71126905, &hb2040222, &hb6cbcf7c, &hcd769c2b, _
		  &h53113ec0, &h1640e3d3, &h38abbd60, &h2547adf0, _
		  &hba38209c, &hf746ce76, &h77afa1c5, &h20756060, _
		  &h85cbfe4e, &h8ae88dd8, &h7aaaf9b0, &h4cf9aa7e, _
		  &h1948c25c, &h02fb8a8c, &h01c36ae4, &hd6ebe1f9, _
		  &h90d4f869, &ha65cdea0, &h3f09252d, &hc208e69f, _
		  &hb74e6132, &hce77e25b, &h578fdfe3, &h3ac372e6 _
		  )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Attributes( Hidden ) Private Shared Function SelfTestMemoryBlockHash(mbIn As Xojo.Core.MutableMemoryBlock, expectedSize As Integer) As String
		  Var pIn as ptr = mbIn.Data
		  Var mbOut as new MemoryBlock( expectedSize )
		  Var pOut as ptr = mbOut
		  
		  Var mbWordSize as integer
		  select case true
		  case expectedSize = mbIn.Size
		    mbWordSize = 4
		  case ( expectedSize * 2 ) = mbIn.Size
		    mbWordSize = 8
		  case else
		    raise new RuntimeException
		  end select
		  
		  Var mbOutIndex as integer
		  Var mbInLastByte as integer = mbIn.Size - 1
		  for mbInIndex as integer = 0 to mbInLastByte step mbWordSize
		    if mbWordSize = 8 then
		      pOut.UInt32( mbOutIndex ) = pIn.UInt64( mbInIndex )
		    else
		      pOut.UInt32( mbOutIndex ) = pIn.UInt32( mbInIndex )
		    end if
		    mbOutIndex = mbOutIndex + 4
		  next
		  
		  return EncodeHex( Crypto.SHA256( mbOut ) )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = false
		Private Shared Function Stream2Word(data As Xojo.Core.MemoryBlock, ByRef current As Integer, buffer As Xojo.Core.MutableMemoryBlock, bufferPtr As Ptr) As UInt32
		  // ################################################################
		  // #                                                              #
		  // #                         Legacy code                          #
		  // #                                                              #
		  // #             This has been inlined wherever needed            #
		  // #                                                              #
		  // ################################################################
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    #pragma StackOverflowChecking False
		  #endif
		  
		  Var r as UInt32
		  
		  Var dataPtr as Ptr = data.Data
		  Var dataSize as Integer = data.Size
		  Var j as Integer = current
		  
		  if j = dataSize then 
		    j = 0 // Special case optimization
		  end if
		  
		  data.LittleEndian = false
		  buffer.LittleEndian = false
		  
		  if dataSize >= 4 and j <= ( dataSize - 4 ) then
		    
		    'r = dataPtr.UInt32( j ) // Can't use this because of endian issues
		    r = data.UInt32Value( j )
		    j = j + 4
		    
		  elseif dataSize >= 2 and j = ( dataSize - 2 ) then
		    
		    Var big as UInt32 = data.UInt16Value( j )
		    Var small as UInt32 = data.UInt16Value( 0 )
		    r = big * CType( 256 ^ 2, UInt32 ) + small
		    j = 2
		    
		  elseif dataSize > 2 then
		    
		    Var fromTheEnd as integer = dataSize - j
		    Var fromTheStart as integer = 4 - fromTheEnd
		    
		    buffer.Left( fromTheEnd ) = data.Right( fromTheEnd )
		    buffer.Right( fromTheStart ) = data.Left( fromTheStart )
		    j = fromTheStart
		    r = buffer.UInt32Value( 0 )
		    
		  elseif dataSize = 1 then
		    //
		    // j must be 0
		    //
		    Var b as UInt32 = dataPtr.Byte( 0 )
		    r = b * CType( 256 ^ 3, UInt32 ) + b * CType( 256 ^ 2, UInt32 ) + b * CType( 256, UInt32 ) + b
		    j = 0
		    
		  else
		    
		    for i as Integer = 0 to 3
		      if j >= dataSize then
		        j = 0
		      end if
		      'r = Bitwise.ShiftLeft( r, 8, 32 ) or dataPtr.Byte( j )
		      bufferPtr.Byte( i ) = dataPtr.Byte( j )
		      j = j + 1
		    next i
		    r = buffer.UInt32Value( 0 )
		    
		  end if
		  
		  current = j
		  return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function UInt32Array(ParamArray values() As UInt32) As UInt32()
		  return values
		End Function
	#tag EndMethod


	#tag Note, Name = Blowfish Notes
		Code found at:
		
		http://stuff.mit.edu/afs/sipb/project/postgres-8.2/src/postgresql-8.2.5/contrib/pgcrypto/blf.c
		
		For alternate, see here:
		
		http://www.di-mgt.com.au/src/blowfish.txt
		
		For header:
		
		http://stuff.mit.edu/afs/sipb/project/postgres-8.2/src/postgresql-8.2.5/contrib/pgcrypto/blf.h
	#tag EndNote

	#tag Note, Name = License
		
		This is an open-source project.
		
		This project is distributed AS-IS and no warranty of fitness for any particular purpose 
		is expressed or implied. You may freely use or modify this project or any part of 
		within as long as this notice or any other legal notice is left undisturbed.
		
		You may distribute a modified version of this project as long as all modifications 
		are clearly documented and accredited.
		
		This project was created by Kem Tekinay (ktekinay@mactechnologies.com) and
		is housed at:
		
		https://github.com/ktekinay/Blowfish
	#tag EndNote


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  static r as Integer = ( BLF_N - 2 ) * 4
			  return r
			  
			End Get
		#tag EndGetter
		Private BLF_MAXKEYLEN As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private P As Xojo.Core.MutableMemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PPtr As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private S As Xojo.Core.MutableMemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SPtr As Ptr
	#tag EndProperty


	#tag Constant, Name = BLF_N, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"2.5.2", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="BlockSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentVector"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PaddingMethod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Padding"
			EditorType="Enum"
			#tag EnumValues
				"0 - NullsOnly"
				"1 - NullsWithCount"
				"2 - PKCS"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFunction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Functions"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - ECB"
				"2 - CBC"
			#tag EndEnumValues
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
End Class
#tag EndClass
