ConstantValue("App.MBSKey") = Trim(DoShellCommand("cat ""${PROJECT_PATH}/MBSKey.txt"""))
Call BuildApp(16, False)
