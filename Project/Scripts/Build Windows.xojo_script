ConstantValue("App.MBSKey") = Trim(DoShellCommand("type ""%PROJECT_PATH%\MBSKey.txt"""))
ConstantValue("Ark.GSAIntegrationEngine.GSAIDEncoded") = Trim(DoShellCommand("type ""%PROJECT_PATH%\GSAID.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(3, False)
Call BuildApp(19, False)
Call BuildApp(25, False)
