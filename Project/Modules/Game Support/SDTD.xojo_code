#tag Module
Protected Module SDTD
	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return (Identity Is Nil) = False And Identity.IsOmniFlagged(SDTD.OmniFlag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit)) or  (TargetWeb and (Target32Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub SetupCodeEditor(Target As CodeEditor)
		  Const SCE_H_DEFAULT = 0 // Normal Text
		  Const SCE_H_TAG = 1 // Tags
		  Const SCE_H_ERRORTAGUNKNOWN = 2 // Unknown tags
		  Const SCE_H_ATTRIBUTE = 3 // Attributes
		  Const SCE_H_ATTRIBUTEUNKNOWN = 4 // Unknown attributes
		  Const SCE_H_NUMBER = 5 // Numbers
		  Const SCE_H_DOUBLESTRING = 6 // Strings
		  Const SCE_H_SINGLESTRING = 7 // Also strings
		  Const SCE_H_COMMENT = 9 // Comment
		  Const SCE_H_TAGEND = 11 // Closing tag, such as />
		  Const SCE_H_XMLSTART = 12 // Declaration opening, such as <?
		  Const SCE_H_XMLEND = 13 // Declaration closing, such as ?>
		  Const SCE_H_CDATA = 17
		  Const SCE_H_SGMLDEFAULT = 21
		  
		  Target.InitializeLexer("xml")
		  
		  If Color.IsDarkMode Then
		    Target.Style(SCE_H_ATTRIBUTE).ForeColor = &cB0FFE8
		    Target.Style(SCE_H_ATTRIBUTEUNKNOWN).ForeColor = &cC7FF88
		    Target.Style(SCE_H_CDATA).ForeColor = &cC88ABE
		    Target.Style(SCE_H_COMMENT).ForeColor = &c57A64A
		    Target.Style(SCE_H_DEFAULT).ForeColor = &cFEFFCA
		    Target.Style(SCE_H_DOUBLESTRING).ForeColor = &cFF9473
		    Target.Style(SCE_H_ERRORTAGUNKNOWN).ForeColor = &cC0C0C0
		    Target.Style(SCE_H_NUMBER).ForeColor = &c0FF47D
		    Target.Style(SCE_H_SGMLDEFAULT).ForeColor = &c808080
		    Target.Style(SCE_H_SINGLESTRING).ForeColor = &cFF947D
		    Target.Style(SCE_H_TAG).ForeColor = &c3CBEF0
		    Target.Style(SCE_H_TAGEND).ForeColor = &c3CBEF0
		    Target.Style(SCE_H_XMLEND).ForeColor = &cFFFFFF
		    Target.Style(SCE_H_XMLSTART).ForeColor = &cFFFFFF
		  Else
		    Target.Style(SCE_H_ATTRIBUTE).ForeColor = &cFF0000
		    Target.Style(SCE_H_ATTRIBUTEUNKNOWN).ForeColor = &cFF0000
		    Target.Style(SCE_H_CDATA).ForeColor = &c800000
		    Target.Style(SCE_H_COMMENT).ForeColor = &c008000
		    Target.Style(SCE_H_DEFAULT).ForeColor = &c000000
		    Target.Style(SCE_H_DOUBLESTRING).ForeColor = &c007BEF
		    Target.Style(SCE_H_ERRORTAGUNKNOWN).ForeColor = &c800000
		    Target.Style(SCE_H_NUMBER).ForeColor = &c0060BF
		    Target.Style(SCE_H_SGMLDEFAULT).ForeColor = &cFF8040
		    Target.Style(SCE_H_SINGLESTRING).ForeColor = &c007BEF
		    Target.Style(SCE_H_TAG).ForeColor = &c800000
		    Target.Style(SCE_H_TAGEND).ForeColor = &c800000
		    Target.Style(SCE_H_XMLEND).ForeColor = &cFF0000
		    Target.Style(SCE_H_XMLSTART).ForeColor = &cFF0000
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = ConfigFileServerAdminXml, Type = String, Dynamic = False, Default = \"serveradmin.xml", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileServerConfigXml, Type = String, Dynamic = False, Default = \"serverconfig.xml", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileWebPermissionsXml, Type = String, Dynamic = False, Default = \"webpermissions.xml", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"7 Days to Die", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"7DaysToDie", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniFlag, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackId, Type = String, Dynamic = False, Default = \"51740154-f9eb-49d3-aaab-1f5acdfbb31e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"User Content", Scope = Protected
	#tag EndConstant


End Module
#tag EndModule