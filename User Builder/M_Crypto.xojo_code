#tag Module
Protected Module M_Crypto
	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub CopyStringToMutableMemoryBlock(s As MemoryBlock, mb As Xojo.Core.MutableMemoryBlock)
		  dim temp as new Xojo.Core.MemoryBlock( s, s.Size )
		  mb.Left( s.size ) = temp.Left( s.Size )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function GenerateUUID() As String
		  // Tries to use declares to let the native system functions handle this.
		  // Otherwise, falls back to manual creation.
		  
		  dim result as string
		  
		  dim useDeclares as boolean = true
		  
		  try
		    
		    #if TargetMacOS
		      
		      soft declare function NSClassFromString lib "Cocoa" ( clsName as cfstringref ) as ptr
		      soft declare function UUID lib "Cocoa" selector "UUID" ( clsRef as ptr ) as ptr
		      soft declare function UUIDString lib "Cocoa" selector "UUIDString" ( obj_id as ptr ) as cfstringref
		      
		      dim classPtr as Ptr = NSClassFromString( "NSUUID" ) 
		      if classPtr = nil then
		        useDeclares = false
		      else
		        dim NSUUID as ptr = UUID( classPtr )
		        
		        result = UUIDString( NSUUID )
		      end if
		      
		    #elseif TargetWindows
		      
		      const kLibName = "rpcrt4"
		      
		      if not System.IsFunctionAvailable( "UuidCreate", kLibName ) then
		        useDeclares = false
		      elseif not System.IsFunctionAvailable( "UuidToStringA", kLibName ) then
		        useDeclares = false
		      else
		        soft declare function UUIDCreate lib kLibName alias "UuidCreate" ( ByRef uuid as WindowsUUID ) as Integer
		        soft declare function UUIDToString lib kLibName alias "UuidToStringA" ( ByRef inUUID as WindowsUUID, ByRef outString as CString ) As Integer
		        
		        dim uuid as WindowsUUID
		        if UUIDCreate( uuid ) <> 0 then
		          useDeclares = false
		        else
		          dim out as CString
		          if UUIDToString( uuid, out ) <> 0 then
		            useDeclares = false
		          else
		            result = out
		            result = result.DefineEncoding( Encodings.UTF8 )
		            result = result.Uppercase
		          end if
		          
		        end if
		      end if
		      
		    #elseif TargetLinux
		      
		      const kLibName = "uuid"
		      
		      if not System.IsFunctionAvailable( "uuid_generate", kLibName ) then
		        useDeclares = false
		      elseif not System.IsFunctionAvailable( "uuid_unparse_upper", kLibName ) then
		        useDeclares = false
		      else
		        soft declare sub UUIDGenerate lib kLibName alias "uuid_generate" ( ByRef uuid as LinuxUUID )
		        soft declare sub UUIDUnparse lib kLibName alias "uuid_unparse_upper" ( ByRef uuid As LinuxUUID, ByRef out As LinuxUUIDString )
		        
		        dim uuid as LinuxUUID
		        UUIDGenerate( uuid )
		        
		        dim out as LinuxUUIDString
		        UUIDUnparse( uuid, out )
		        
		        result = out.Data
		        result = result.DefineEncoding( Encodings.UTF8 )
		      end if
		      
		    #else
		      useDeclares = false
		    #endif
		    
		  catch err as RuntimeException
		    useDeclares = false
		    if err IsA EndException or err IsA ThreadEndException then
		      raise err
		    end if
		  end try
		  
		  if not useDeclares then
		    //
		    // Fallback to manual creation
		    //
		    // From http://www.cryptosys.net/pki/uuid-rfc4122.html
		    //
		    // Generate 16 random bytes (=128 bits)
		    // Adjust certain bits according to RFC 4122 section 4.4 as follows:
		    // set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
		    // set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
		    // Convert the adjusted bytes to 32 hexadecimal digits
		    // Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
		    // Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
		    //
		    
		    #pragma BackgroundTasks False
		    #pragma BoundsChecking False
		    #pragma NilObjectChecking False
		    
		    System.DebugLog CurrentMethodName + ": Generating manually"
		    
		    dim randomBytes as MemoryBlock = Crypto.GenerateRandomBytes( 16 )
		    randomBytes.LittleEndian = false
		    dim p as Ptr = randomBytes
		    
		    //
		    // Adjust seventh byte
		    //
		    dim value as byte = p.Byte( 6 )
		    value = value and CType( &b00001111, Byte ) // Turn off the first four bits
		    value = value or CType( &b01000000, Byte ) // Turn on the second bit
		    p.Byte(6) = value
		    
		    //
		    // Adjust ninth byte
		    //
		    value = p.Byte( 8 )
		    value = value and CType( &b00111111, Byte ) // Turn off the first two bits
		    value = value or CType( &b10000000, Byte ) // Turn on the first bit
		    p.Byte( 8 ) = value
		    
		    result = EncodeHex( randomBytes )
		    result = result.LeftB( 8 ) + "-" + result.MidB( 9, 4 ) + "-" + result.MidB( 13, 4 ) + "-" + result.MidB( 17, 4 ) + _
		    "-" + result.RightB( 12 )
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function GetEncrypter(fromCode As String) As M_Crypto.Encrypter
		  dim result as M_Crypto.Encrypter
		  
		  dim rx as new RegEx
		  rx.SearchPattern = kRxEncryptCode
		  
		  dim match as RegExMatch = rx.Search( fromCode )
		  
		  if match isa object then
		    
		    select case match.SubExpressionString( 1 )
		    case "aes"
		      dim bits as integer = 128
		      if match.SubExpressionCount > 2 then
		        bits = match.SubExpressionString( 2 ).Val
		      end if
		      result = new AES_MTC( bits )
		      
		    case "bf", "blowfish"
		      result = new Blowfish_MTC
		      
		    end select
		    
		  end if
		  
		  if result is nil then
		    raise new InvalidCodeException
		  end if
		  
		  if match.SubExpressionCount = 4 then
		    select case match.SubExpressionString( 3 )
		    case "cbc"
		      result.UseFunction = Encrypter.Functions.CBC
		      
		    case "ecb"
		      result.UseFunction = Encrypter.Functions.ECB
		      
		    end select
		  end if
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Function MemoryBlockToString(mb As Xojo.Core.MemoryBlock) As String
		  if mb is nil or mb.Size = 0 then
		    return ""
		  end if
		  
		  dim temp as MemoryBlock = mb.Data
		  return temp.StringValue( 0, mb.Size )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Function StringToMutableMemoryBlock(s As MemoryBlock) As Xojo.Core.MutableMemoryBlock
		  dim temp as new Xojo.Core.MemoryBlock( s, s.Size )
		  dim mb as new Xojo.Core.MutableMemoryBlock( s.Size )
		  mb.Left( s.Size ) = temp.Left( s.Size )
		  return mb
		End Function
	#tag EndMethod


	#tag Constant, Name = kCodeAES128CBC, Type = String, Dynamic = False, Default = \"aes-128-cbc", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeAES128ECB, Type = String, Dynamic = False, Default = \"aes-128-ecb", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeAES192CBC, Type = String, Dynamic = False, Default = \"aes-192-cbc", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeAES192ECB, Type = String, Dynamic = False, Default = \"aes-192-ecb", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeAES256CBC, Type = String, Dynamic = False, Default = \"aes-256-cbc", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeAES256ECB, Type = String, Dynamic = False, Default = \"aes-256-ecb", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeBlowfishCBC, Type = String, Dynamic = False, Default = \"bf-cbc", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCodeBlowfishECB, Type = String, Dynamic = False, Default = \"bf-ecb", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kRxEncryptCode, Type = String, Dynamic = False, Default = \"(\?x)\n\\A\n(\?|\n  (aes) (\?:-\?(\?:(128|192|256)))\?\n  | (bf) \n  | (blowfish)\n)\n\\b \n(\?:-(cbc|ecb))\?\n\\z", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"2.4", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = LinuxUUID, Flags = &h21
		Bytes1 As String * 4
		  Bytes2 As String * 2
		  Bytes3 As String * 2
		  Bytes4 As String * 2
		Bytes5 As String * 6
	#tag EndStructure

	#tag Structure, Name = LinuxUUIDString, Flags = &h21
		Data As String * 36
		TrailingNull As String * 1
	#tag EndStructure

	#tag Structure, Name = WindowsUUID, Flags = &h21
		Data1 As UInt32
		  Data2 As UInt16
		  Data3 As UInt16
		Data4 As String * 8
	#tag EndStructure


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Module
#tag EndModule
