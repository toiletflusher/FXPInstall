@echo off
::This is not done yet, and LantherNT won't copy the oobe file and set it up yet. You also need to use IEXPRESS.
"C:\Windows\System32\SystemPropertiesComputerName.exe"
"C:\Windows\System32\netplwiz.exe"
"C:\Windows\System32\OptionalFeatures.exe"
"C:\Windows\System32\rundll32.exe" shell32.dll,Control_RunDLL timedate.cpl
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v explorer.exe /t REG_SZ /d explorer.exe /f
shutdown /l
