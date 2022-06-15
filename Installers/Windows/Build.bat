@echo off
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "%~dp0\Setup.iss"
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" -Dx64 "%~dp0\Setup.iss"
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" -Dx86 "%~dp0\Setup.iss"
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" -Darm64 "%~dp0\Setup.iss"
pause