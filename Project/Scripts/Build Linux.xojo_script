ConstantValue("App.MBSKey") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/MBSKey.txt"""))
ConstantValue("GameServerApp.HostingProvider.GSAIDEncoded") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/GSAID.txt"""))
ConstantValue("Beacon.CurseForgeApiKeyEncoded") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/CurseForge.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(26, False) // 64-bit ARM
Call BuildApp(18, False) // 32-bit ARM
Call BuildApp(17, False) // 64-bit x86
Call BuildApp(4, False) // 32-bit x86
