#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin IDEScriptBuildStep UpdateInfoPlist , AppliesTo = 0
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("/usr/bin/defaults write " + App + "/Contents/Info ""CFBundleURLTypes"" ""( { CFBundleURLName = Beacon; CFBundleTypeRole = Editor; CFBundleURLSchemes = (" + ConstantValue("Beacon.URLScheme") + "); } )""")
				End
				Begin CopyFilesBuildStep ReplaceIcons
					AppliesTo = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vQXJ0d29yay9BcHAuaWNucw==
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25Eb2N1bWVudC5pY25z
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25JZGVudGl0eS5pY25z
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25QcmVzZXQuaWNucw==
				End
				Begin CopyFilesBuildStep CopyMigration
					AppliesTo = 2
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vSW5zdGFsbGVycy9NYWMvY29udGFpbmVyLW1pZ3JhdGlvbi5wbGlzdA==
				End
				Begin IDEScriptBuildStep DownloadClassesDebug , AppliesTo = 1
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("/usr/bin/curl https://workbench.beaconapp.cc/download/classes.php?version=" + PropertyValue("App.NonReleaseVersion") + " > " + App + "/Contents/Resources/Classes.json")
				End
				Begin IDEScriptBuildStep DownloadClassesBuild , AppliesTo = 2
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("/usr/bin/curl https://beaconapp.cc/download/classes.php?version=" + PropertyValue("App.NonReleaseVersion") + " > " + App + "/Contents/Resources/Classes.json")
				End
				Begin IDEScriptBuildStep Sign , AppliesTo = 0
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("xattr -clr " + App)
					Call DoShellCommand("codesign -f --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.dylib")
					Call DoShellCommand("codesign -f --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.framework")
					Call DoShellCommand("codesign -f --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App)
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
