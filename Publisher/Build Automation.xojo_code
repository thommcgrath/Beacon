#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyMacSignTool
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 4
					Subdirectory = Helpers
					FolderItem = Li4vLi4vU3BhcmtsZS9zaWduX3VwZGF0ZQ==
					FolderItem = Li4vLi4vU3BhcmtsZS9zaWduX3VwZGF0ZV9sZWdhY3k=
				End
				Begin IDEScriptBuildStep SignBuild , AppliesTo = 0, Architecture = 0, Target = 0
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("xattr -clr " + App)
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.dylib")
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.framework")
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App)
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
