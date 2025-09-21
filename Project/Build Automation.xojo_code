#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyResourcesLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vRm9udHMv
				End
				Begin CopyFilesBuildStep CopyDebugResourcesLinux
					AppliesTo = 1
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vR1NBSUQudHh0
				End
				Begin IDEScriptBuildStep DownloadClassesDebugLinux , AppliesTo = 1, Architecture = 0, Target = 0
					Var AppName As String = CurrentBuildAppName
					If TargetMacOS Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "/" + AppName + " Resources"
					Call DoShellCommand("/usr/bin/curl https://local.usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " > '" + ResourcesPath + "/Complete.beacondata'")
					End If
				End
				Begin IDEScriptBuildStep DownloadClassesBuildLinux , AppliesTo = 2, Architecture = 0, Target = 0
					Var AppName As String = CurrentBuildAppName
					If TargetMacOS Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "/" + AppName + " Resources"
					Call DoShellCommand("/usr/bin/curl https://usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " > '" + ResourcesPath + "/Complete.beacondata'")
					End If
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin IDEScriptBuildStep UpdateInfoPlist , AppliesTo = 0, Architecture = 0, Target = 0
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + "/Contents/Info"""
					Call DoShellCommand("/usr/bin/defaults write " + App + " ""CFBundleURLTypes"" ""( { CFBundleURLName = Beacon; CFBundleTypeRole = Editor; CFBundleURLSchemes = (" + ConstantValue("Beacon.URLScheme") + "); } )""")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.0.UTTypeIcons -json '{""UTTypeIconBackgroundName"":""ProjectBackgroundFill"",""UTTypeIconBadgeName"":""ProjectCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.1.UTTypeIcons -json '{""UTTypeIconText"":""Identity"",""UTTypeIconBadgeName"":""GenericCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.2.UTTypeIcons -json '{""UTTypeIconText"":""Preset"",""UTTypeIconBadgeName"":""GenericCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.3.UTTypeIcons -json '{""UTTypeIconText"":""Auth"",""UTTypeIconBadgeName"":""GenericCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.4.UTTypeIcons -json '{""UTTypeIconText"":""Data"",""UTTypeIconBadgeName"":""GenericCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert UTExportedTypeDeclarations.5.UTTypeIcons -json '{""UTTypeIconText"":""Script"",""UTTypeIconBadgeName"":""GenericCenterIcon""}' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleDocumentTypes.0.CFBundleTypeIconSystemGenerated -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleDocumentTypes.2.CFBundleTypeIconSystemGenerated -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleDocumentTypes.3.CFBundleTypeIconSystemGenerated -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleDocumentTypes.7.CFBundleTypeIconSystemGenerated -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleDocumentTypes.8.CFBundleTypeIconSystemGenerated -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert NSAppAccentColorName -string 'BeaconBrand' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert ATSApplicationFontsPath -string 'Fonts/' " + App + ".plist")
					If DebugBuild = False Then
					Call DoShellCommand("/usr/bin/plutil -insert SUFeedURL -string 'https://api.usebeacon.app/sparkle.php' " + App + ".plist")
					Else
					Call DoShellCommand("/usr/bin/plutil -insert SUFeedURL -string 'https://local-api.usebeacon.app/sparkle.php' " + App + ".plist")
					End If
					Call DoShellCommand("/usr/bin/plutil -insert SUPublicEDKey -string 'E8nLS+ZV7vehv1LV7BOrGFpvVk6SKFdG7JxMvluk4FU=' " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert SUEnableInstallerLauncherService -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert SUEnableAutomaticChecks -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert SUScheduledCheckInterval -integer 14400 " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert SUAutomaticallyUpdate -bool YES " + App + ".plist")
					Call DoShellCommand("/usr/bin/plutil -insert CFBundleIconName -string 'App' " + App + ".plist")
				End
				Begin CopyFilesBuildStep CopyResourcesMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vRm9udHMv
				End
				Begin CopyFilesBuildStep CopyMacFrameworks
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 2
					Subdirectory = 
					FolderItem = Li4vLi4vU3BhcmtsZS9TcGFya2xlLmZyYW1ld29yay8=
				End
				Begin CopyFilesBuildStep CopyDebugResourcesMac
					AppliesTo = 1
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vR1NBSUQudHh0
					FolderItem = Li4vQ3Vyc2VGb3JnZS50eHQ=
				End
				Begin CopyFilesBuildStep CopyMigration
					AppliesTo = 2
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vSW5zdGFsbGVycy9NYWMvY29udGFpbmVyLW1pZ3JhdGlvbi5wbGlzdA==
				End
				Begin IDEScriptBuildStep BuildMacAssets , AppliesTo = 0, Architecture = 0, Target = 0
					If TargetMacOS Then
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("actool --compile " + App + "/Contents/Resources --platform macosx --minimum-deployment-target 10.14 --app-icon App --output-partial-info-plist /dev/null --enable-icon-stack-fallback-generation=disabled ""${PROJECT_PATH}/Assets.xcassets"" ""${PROJECT_PATH}/App.icon""")
					End If
				End
				Begin IDEScriptBuildStep DownloadClassesDebugMac , AppliesTo = 3, Architecture = 0, Target = 0
					If TargetMacOS Then
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("/usr/bin/curl -L 'https://local.usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + "' > " + App + "/Contents/Resources/Complete.beacondata")
					End If
				End
				Begin IDEScriptBuildStep DownloadClassesBuildMac , AppliesTo = 2, Architecture = 0, Target = 0
					If TargetMacOS Then
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("/usr/bin/curl -L 'https://usebeacon.app/download/complete?game=ark&version=" + ConstantValue("DataUpdater.Version") + "' > " + App + "/Contents/Resources/Complete.beacondata")
					End If
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				  macOSEntitlements={"App Sandbox":"False","Hardened Runtime":"False","Notarize":"False","UserEntitlements":""}
				End
				Begin IDEScriptBuildStep SignCorrectly , AppliesTo = 0, Architecture = 0, Target = 0
					Var App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("codesign --remove-signature " + App)
					Call DoShellCommand("xattr -clr " + App)
					Call DoShellCommand("mv " + App + "/Contents/Frameworks/Sparkle.framework " + App + "/Contents/Frameworks/Sparkle")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --options runtime --deep --force --timestamp " + App + "/Contents/Frameworks/*.dylib")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --options runtime --deep --force --timestamp " + App + "/Contents/Frameworks/*.framework")
					Call DoShellCommand("mv " + App + "/Contents/Frameworks/Sparkle " + App + "/Contents/Frameworks/Sparkle.framework")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --force --options runtime --timestamp " + App + "/Contents/Frameworks/Sparkle.framework/Versions/B/XPCServices/org.sparkle-project.InstallerLauncher.xpc")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --force --options runtime --timestamp --entitlements ""${PROJECT_PATH}/../Installers/Mac/org.sparkle-project.Downloader.entitlements"" " + App + "/Contents/Frameworks/Sparkle.framework/Versions/B/XPCServices/org.sparkle-project.Downloader.xpc")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --force --options runtime --timestamp " + App + "/Contents/Frameworks/Sparkle.framework/Versions/B/Autoupdate")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --force --options runtime --timestamp " + App + "/Contents/Frameworks/Sparkle.framework/Versions/B/Updater.app")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --force --options runtime --timestamp " + App + "/Contents/Frameworks/Sparkle.framework")
					Call DoShellCommand("codesign --sign 'Developer ID Application: Thom McGrath' --options runtime --timestamp --entitlements ""${PROJECT_PATH}/../Installers/Mac/entitlements.plist"" " + App)
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyResourcesWindows
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vRm9udHMv
					FolderItem = Li4vLi4vQXJ0d29yay9BcHAuaWNv
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25BdXRoLmljbw==
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25EYXRhLmljbw==
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25Eb2N1bWVudC5pY28=
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25JZGVudGl0eS5pY28=
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25QcmVzZXQuaWNv
					FolderItem = Li4vLi4vQXJ0d29yay9CZWFjb25TY3JpcHQuaWNv
				End
				Begin CopyFilesBuildStep CopyDebugResourcesWindows
					AppliesTo = 1
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vR1NBSUQudHh0
					FolderItem = Li4vQ3Vyc2VGb3JnZS50eHQ=
				End
				Begin IDEScriptBuildStep DownloadClassesDebugWin , AppliesTo = 3, Architecture = 0, Target = 0
					Var AppName As String = Left(CurrentBuildAppName, Len(CurrentBuildAppName) - 4)
					If TargetWindows Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "\" + AppName + " Resources"
					Call DoShellCommand("powershell -Command ""Invoke-WebRequest https://local.usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " -OutFile '" + ResourcesPath + "\Complete.beacondata'""")
					ElseIf TargetMacOS Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "/" + AppName + " Resources"
					Call DoShellCommand("/usr/bin/curl -L https://local.usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " > '" + ResourcesPath + "/Complete.beacondata'")
					End If
				End
				Begin IDEScriptBuildStep DownloadClassesBuildWin , AppliesTo = 2, Architecture = 0, Target = 0
					Var AppName As String = Left(CurrentBuildAppName, Len(CurrentBuildAppName) - 4)
					If TargetWindows Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "\" + AppName + " Resources"
					Call DoShellCommand("powershell -Command ""Invoke-WebRequest https://usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " -OutFile '" + ResourcesPath + "\Complete.beacondata'""")
					ElseIf TargetMacOS Then
					Var ResourcesPath As String = CurrentBuildLocationNative + "/" + AppName + " Resources"
					Call DoShellCommand("/usr/bin/curl -L https://usebeacon.app/download/complete?version=" + ConstantValue("DataUpdater.Version") + " > '" + ResourcesPath + "/Complete.beacondata'")
					End If
				End
			End
#tag EndBuildAutomation
