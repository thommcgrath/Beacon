ConstantValue("App.MBSKey") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/MBSKey.txt"""))
ConstantValue("GameServerApp.HostingProvider.GSAIDEncoded") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/GSAID.txt"""))
ConstantValue("Beacon.CurseForgeApiKeyEncoded") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/CurseForge.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(9, False)
