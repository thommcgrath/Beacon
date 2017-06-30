#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList iOS
				Begin BuildProjectStep Build
				End
				Begin IDEScriptBuildStep DownloadClassesDebug , AppliesTo = 1
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("/usr/bin/curl https://workbench.beaconapp.cc/download/classes.php?version=" + ConstantValue("App.BuildNumber") + " > " + App + "/Classes.json")
				End
				Begin IDEScriptBuildStep DownloadClassesBuild , AppliesTo = 2
					Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + """"
					Call DoShellCommand("/usr/bin/curl https://beaconapp.cc/download/classes.php?version=" + ConstantValue("App.BuildNumber") + " > " + App + "/Classes.json")
				End
				Begin SignProjectStep Sign
				End
			End
#tag EndBuildAutomation
