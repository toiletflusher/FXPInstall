@echo off
color 18
cls
title LantherNT
echo.
echo  LantherNT
echo ===========
echo.
echo    Setup is starting Windows
wpeinit
color 18
cls
goto mainmenu
:wrongkey
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Sorry, this setup answer does not exist.
echo. 
echo    Press any key to return to Setup.
pause >nul
goto mainmenu
:mainmenu
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Welcome to Setup.
echo.
echo    This portion of the setup program prepares Windows to
echo    run on your computer.
echo.
echo.
echo       - To set up Windows now, press Y.
echo.
echo       - To repair a Windows installation using Recovery
echo         Console, press R.
echo.
echo       - To quit setup without installing Windows, press
echo         N.
echo.
echo.
echo.
choice /n /c yrnc
SET M=%errorlevel%
IF "%M%"=="1" GOTO continue1
IF "%M%"=="2" GOTO recovery
IF "%M%"=="3" GOTO cancel
IF "%M%"=="4" GOTO credits
goto wrongkey
:cancel
cls
echo Quitting Setup...
exit
:credits
cls
echo,
echo  LantherNT
echo ===========
echo,
echo     Credits:
echo       - Windows XP Pro: original creator of LantherNT, makes some modifications, adds lots of features.
echo       - Toiletflusher: most of the code done by him.
echo       - pog5: original erase disk choice manager code
echo     Information:
echo       - Github: github.com/WindowsXPPro3/LantherNT
echo       - Website: www.lanthernt.ml
echo       - LantherNT Version 0.11
echo.
echo         Press any key to return to main screen.
pause >nul
goto mainmenu
:recovery
cls
echo @echo off >> "X:\recovery.bat"
echo echo. >> "X:\recovery.bat"
echo echo  LantherNT >> "X:\recovery.bat"
echo echo =========== >> "X:\recovery.bat"
echo echo. >> "X:\recovery.bat"
echo echo Welcome to Recovery. >> "X:\recovery.bat"
start cmd.exe /K "X:\recovery.bat"
goto mainmenu
:continue1w
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Sorry, this setup answer does not exist.
echo.
echo    Press any key to return to Setup.
echo. 
pause >nul
goto continue1
:continue1
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Would you like to do automatic or manual partitioning?
echo.
echo       - To do manual partitioning, press M.
echo.
echo       - To do automatic partitioning, press A.
echo.
echo       - To return to the previous screen, press C.
echo.
echo.
echo.
choice /n /c ma
SET M=%errorlevel%
IF "%M%"=="1" GOTO manual
IF "%M%"=="2" GOTO autopart
IF "%M%"=="3" GOTO mainmenu
goto continue1w
:manualw
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Sorry, this setup answer does not exist.
echo.
echo    Press any key to return to Setup.
echo. 
pause >nul
goto continue1
:manual
echo.
echo  LantherNT
echo ===========
echo.
echo    MAKE SURE TO MAKE THE DRIVE G:\
echo,
diskpart
echo.
echo    Have you done your partitioning?
echo.
echo    y or n?
choice /n
SET M=%errorlevel%
IF "%M%"=="1" GOTO imagex
IF "%M%"=="2" GOTO continue1
goto manualw
:autow
echo echo this setup answer does not exist.
echo,
goto continue1
:autopart
echo lis dis > disktmp.txt
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    The following list shows the existing disks on this
echo    computer.
echo.
echo    Type in the disk number to install Windows on.
echo    Type in "cancel" to return to the previous screen.
diskpart /s disktmp.txt
echo.
set /p diskn=
if "%diskn%"=="cancel" GOTO continue1
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    CAUTION: All data on your disk will be lost.
echo.
echo       - To format your disk, press Y.
echo.
echo       - To return to the previous screen without
echo         formatting your disk, press N.
choice /n
SET M=%errorlevel%
IF "%M%"=="2" GOTO autopart
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    Setup will format your disk.
echo.
echo    Press Q or F to select the file system you want.
echo.
echo       Format your disk using the NTFS file system ([Q]uick)
echo       [F]ormat your disk using the NTFS file system
echo.
choice /n /c QF
SET M=%errorlevel%
IF "%M%"=="1" GOTO quick
IF "%M%"=="2" GOTO format
:quick
echo sel dis %diskn% >> X:\diskpart.txt
echo clean >> X:\diskpart.txt
echo create partition primary >> X:\diskpart.txt
echo sel part 1 >> X:\diskpart.txt
echo format fs=ntfs quick >> X:\diskpart.txt
echo assign letter=g >> X:\diskpart.txt
echo active >> X:\diskpart.txt
echo exit >> X:\diskpart.txt
goto format2
:format2
echo    Formatting the disk...
diskpart /s "X:\diskpart.txt" > X:\diskpartlog.txt
goto formatdone
:format
echo sel dis %diskn% >> X:\diskpart.txt
echo clean >> X:\diskpart.txt
echo create partition primary >> X:\diskpart.txt
echo sel part 1 >> X:\diskpart.txt
echo format fs=ntfs >> X:\diskpart.txt
echo assign letter=g >> X:\diskpart.txt
echo active >> X:\diskpart.txt
echo exit >> X:\diskpart.txt
goto format2
:formatdone
cls
echo.
echo  LantherNT
echo ===========
echo.
echo    The disk has been formatted.
echo    It is recommended to check the format logs.
echo.
echo       - Press Y to check the format logs to make sure
echo         the formatting is done correctly. (recommended)
echo.
echo       - Press N to continue installing.
echo.
echo.
echo.
choice /n
SET M=%errorlevel%
IF "%M%"=="1" GOTO checklogs
IF "%M%"=="2" GOTO imagex
SET M=%errorlevel%
IF "%M%"=="1" GOTO imagex
IF "%M%"=="2" GOTO continue1
goto autow
:checklogs
notepad X:\diskpartlog.txt
cls
echo,
echo  LantherNT
echo ===========
echo,
echo    Did the formatting go correctly?
echo.
echo       - Press Y if the formatting went correctly and
echo         want to install Windows.
echo.
echo       - Press N if the formatting went incorrectly
echo         and want to try again.
echo.
echo.
echo.
choice /n
SET M=%errorlevel%
IF "%M%"=="1" GOTO imagex
IF "%M%"=="2" GOTO continue1
:imagex
for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do @if exist %%a:\sources set IMAGESDRIVE=%%a
goto cdcheck
:cdcheck
vol %IMAGESDRIVE%: | find "LantherNT" > nul
if %ERRORLEVEL% == 0 goto wimoresd
)
cls
echo,
echo  LantherNT
echo ===========
echo,
echo                      Please insert the correct disc
echo                   into your CD Drive and press any key
echo                               to continue.
pause >nul
goto cdcheck
:wimoresd
if exist %IMAGESDRIVE%:\sources\install.wim (
    set IMAGETYPE=.wim && goto indexselect
) else (
    goto esd
)
:esd
if exist %IMAGESDRIVE%:\sources\install.esd (
    set IMAGETYPE=.esd && goto indexselect
) else (
    cls
    echo,
    echo  LantherNT
    echo ===========
    echo,
    echo                      No image file found.
    echo                 Aborting, press any key to exit.
    pause >nul
    exit
)
:indexselect
cls
echo,
echo  LantherNT
echo ===========
echo,
echo
:install
cd X:\
cls
echo,
echo  LantherNT
echo ===========
echo,
echo                      Please wait while Setup copies files
echo                      to the Windows installation folders.
echo                  This might take several minutes to complete.
echo,
echo.
dism /Apply-Image /ImageFile:%IMAGESDRIVE%:\sources\install%IMAGETYPE% /Index:%indexselect% /ApplyDir:G:\
echo,
goto productkey
:productkey
cls
echo.
echo  LantherNT
echo ===========
echo,
echo     Please enter your product key for your version of Windows.
echo                         Type "none" to skip.
echo,
set /P productkey="     Product Key: "
if "%productkey%"=="none" goto bcd
dism /image:G:\ /Set-ProductKey:%productkey%> X:\productkey.log
type X:\productkey.log | find "The specified product key could not be validated." > nul
if %ERRORLEVEL == 0 goto invalidkey
)
goto bcd
:invalidkey
cls
echo.
echo  LantherNT
echo ===========
echo,
echo     The specified product key could not be validated.
echo               Press any key to go back...
pause >nul
goto productkey
:bcd
cls
echo,
echo  LantherNT
echo ===========
echo,
echo    Installing the bootloader...
echo,
bcdboot G:\Windows
goto dumplogs
:dumplogs
cls
echo,
echo  LantherNT
echo ===========
echo,
echo    Creating log files...
xcopy X:\diskpartlog.txt G:\Windows\Panther\LantherNT.log
goto setupdone
:setupdone
:: "X:\nircmd.exe" cdrom open %imagesdrive%
cls
echo,
echo  LantherNT
echo ===========
echo,
echo    Setup has completed successfully.
echo,
echo    If there are any removable drives, remove them.
echo.
echo    To restart your computer, press R.
echo    When your computer restarts, Windows will start up.
echo.
echo    Your computer will reboot in 15 seconds...
choice /C R /D R /T 15 /N
exit
