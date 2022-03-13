ConstantValue("App.MBSKey") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/MBSKey.txt"""))
ConstantValue("Ark.GSAIntegrationEngine.GSAIDEncoded") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/GSAID.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(9, False)
