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
choice /n /c yrn
SET M=%errorlevel%
IF "%M%"=="1" GOTO continue1
IF "%M%"=="2" GOTO recovery
IF "%M%"=="3" GOTO cancel
goto wrongkey
:cancel
cls
echo Quitting Setup...
exit
:recovery
start cmd.exe
goto mainmenu
:continue1w
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
IF "%M%"=="2" GOTO auto
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
:auto
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
diskpart /s "X:\diskpart.txt" >diskpartlog.txt
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
notepad diskpartlog.txt
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
    set IMAGETYPE=.wim && goto install
) else (
    goto esd
)
:esd
if exist %IMAGESDRIVE%:\sources\install.esd (
    set IMAGETYPE=.esd && goto install
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
:install
cd X:\
cls
echo,
echo  LantherNT
echo ===========
echo,
echo                      Please wait while Setup copies files
echo                      to the LantherNT installation folders.
echo                  This might take several minutes to complete.
echo,
echo.
dism /Apply-Image /ImageFile:%IMAGESDRIVE%:\sources\install%IMAGETYPE% /Index:1 /ApplyDir:G:\
echo,
goto bcd
:bcd
cls
echo,
echo  LantherNT
echo ===========
echo,
echo    Installing the bootloader...
echo,
bcdboot G:\Windows
goto setupdone
:setupdone
:: "C:\path_to\nircmd.exe" cdrom open %imagesdrive%
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
