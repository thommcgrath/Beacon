#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyDebugConfigMac
					AppliesTo = 1
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vLi4vLi4vLi4vLi4vLmZpbGUvaWQ9NjU3MTM2Ny40NDk2ODk0NQ==
				End
				Begin IDEScriptBuildStep Sign , AppliesTo = 0
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Dim Libs As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + " Libs"""
					Call DoShellCommand("xattr -clr " + App)
					Call DoShellCommand("codesign -f --options=runtime --deep --timestamp -s 'Developer ID Application: Thom McGrath' " + Libs + "/*.dylib")
					Call DoShellCommand("codesign -f --options=runtime --deep --timestamp -s 'Developer ID Application: Thom McGrath' " + Libs + "/*.framework")
					Call DoShellCommand("codesign -f --options=runtime --deep --timestamp -s 'Developer ID Application: Thom McGrath' " + App)
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
