ConstantValue("App.MBSKey") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/MBSKey.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(9, False)
