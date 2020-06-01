ConstantValue("App.MBSKey") = Trim(DoShellCommand("type ""%PROJECT_PATH%\MBSKey.txt"""))
PropertyValue("App.OptimizationLevel") = "4"
Call BuildApp(3, False)
Call BuildApp(19, False)
