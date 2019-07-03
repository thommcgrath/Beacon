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
					Call DoShellCommand("/usr/bin/defaults write " + App + "/Contents/Info ""ATSApplicationFontsPath"" ""Fonts/""")
					Call DoShellCommand("/usr/bin/defaults write " + App + "/Contents/Info ""LSMinimumSystemVersion"" ""10.11.0""")
				End
				Begin CopyFilesBuildStep CopyResourcesMac
					AppliesTo = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vQXJ0d29yay9BcHAuaWNucw==
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25Eb2N1bWVudC5pY25z
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25JZGVudGl0eS5pY25z
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25QcmVzZXQuaWNucw==
					FolderItem = Li4vLi4vRm9udHMv
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25BdXRoLmljbnM=
				End
				Begin CopyFilesBuildStep CopyMigration
					AppliesTo = 2
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vSW5zdGFsbGVycy9NYWMvY29udGFpbmVyLW1pZ3JhdGlvbi5wbGlzdA==
				End
				Begin IDEScriptBuildStep DownloadClassesDebugMac , AppliesTo = 1
					#if TargetMacOS
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("/usr/bin/curl https://workbench.beaconapp.cc/download/classes.php?version=" + PropertyValue("App.ShortVersion") + " > " + App + "/Contents/Resources/Classes.json")
					#endif
				End
				Begin IDEScriptBuildStep DownloadClassesBuildMac , AppliesTo = 2
					#if TargetMacOS
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("/usr/bin/curl https://beaconapp.cc/download/classes.php?version=" + PropertyValue("App.ShortVersion") + " > " + App + "/Contents/Resources/Classes.json")
					#endif
				End
				Begin IDEScriptBuildStep Sign , AppliesTo = 0
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
					Call DoShellCommand("xattr -clr " + App)
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.dylib")
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App + "/Contents/Frameworks/*.framework")
					Call DoShellCommand("codesign -f --options runtime --deep --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" -s 'Developer ID Application: Thom McGrath' " + App)
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyResourcesWindows
					AppliesTo = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vRm9udHMv
				End
				Begin IDEScriptBuildStep DownloadClassesDebugWin , AppliesTo = 1
					#if TargetWin32
					Dim AppName As String = Left(CurrentBuildAppName, Len(CurrentBuildAppName) - 4)
					Dim ResourcesPath As String = CurrentBuildLocationNative + "\" + AppName + " Resources"
					Call DoShellCommand("powershell -Command ""Invoke-WebRequest https://workbench.beaconapp.cc/download/classes.php?version=" + PropertyValue("App.ShortVersion") + " -OutFile '" + ResourcesPath + "\Classes.json'""")
					#endif
				End
				Begin IDEScriptBuildStep DownloadClassesBuildWin , AppliesTo = 2
					Dim AppName As String = Left(CurrentBuildAppName, Len(CurrentBuildAppName) - 4)
					#if TargetWin32
					Dim ResourcesPath As String = CurrentBuildLocationNative + "\" + AppName + " Resources"
					Call DoShellCommand("powershell -Command ""Invoke-WebRequest https://beaconapp.cc/download/classes.php?version=" + PropertyValue("App.ShortVersion") + " -OutFile '" + ResourcesPath + "\Classes.json'""")
					#elseif TargetMacOS
					Dim ResourcesPath As String = CurrentBuildLocationNative + "/" + AppName + " Resources"
					Call DoShellCommand("/usr/bin/curl https://beaconapp.cc/download/classes.php?version=" + PropertyValue("App.ShortVersion") + " > '" + ResourcesPath + "/Classes.json'")
					#endif
				End
			End
#tag EndBuildAutomation
