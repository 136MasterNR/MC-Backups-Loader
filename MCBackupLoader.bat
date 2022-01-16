::Created by HTS Studios - More info in the Read Me text file (Do not distribute)
::(Use "NotePad++" to view better this file)
::_______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______
::______//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//______ \
::     _    _   _______    _____      _____   _                 _   _                 | |
::    | |  | | |__   __|  / ____|    / ____| | |               | | (_)                | |
::    | |__| |    | |    | (___     | (___   | |_   _   _    __| |  _    ___    ___   | |
::    |  __  |    | |     \___ \     \___ \  | __| | | | |  / _` | | |  / _ \  / __|  | |
::    | |  | |    | |     ____) |    ____) | | |_  | |_| | | (_| | | | | (_) | \__ \  | |
::    |_|  |_|    |_|    |_____/    |_____/   \__|  \__,_|  \__,_| |_|  \___/  |___/  | |
::_______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______| |
::______//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//______ /
::
::This is totally safe. Don't be a nerd, bye.
::Do not complain if you don't know how to use Batch.
::
::Contact us at - Discord: https://discord.gg/Qst63njdBG
:STARTUP
@ECHO OFF
FOR /F "TOKENS=4-5 DELIMS= " %%I IN ('VER') DO SET WINVER=%%I
IF "%WINVER:~0,3%" == "6.1" GOTO WINCONF
IF "%WINVER:~0,3%" == "6.3" GOTO WINCONF
IF "%WINVER:~0,4%" == "10.0" GOTO WINCONF
ECHO.You are either using an old OS version or an unsupported OS Build. Update or Change your OS build to Windows 10 or 7!
ECHO.
POWERSHELL WRITE-HOST -fore Red ERROR_OLD_WIN_VERSION 0x47E
PAUSE>NUL&EXIT
:WINCONF
IF NOT EXIST "%~n0%~x0" (
	CLS
	ECHO.Unable to launch.
	ECHO.
	ECHO.Make sure the following:
	ECHO.The program isn't running in a zip file or any winrar format.
	ECHO.The program has permissions to add files on the current directory.
	ECHO.Don't launch it directly from any search bar since it breaks the directory.
	ECHO.If you are using a shortcut, make sure you added the correct directory.
	PAUSE>NUL
	EXIT /B
)
ECHO.A> VERIFY.txt
IF NOT EXIST "%CD%\VERIFY.txt" (
	CLS
	ECHO.Unable to launch.
	ECHO.
	ECHO.Make sure the following:
	ECHO.The program isn't running in a zip file or any winrar format.
	ECHO.The program has permissions to add files on the current directory.
	ECHO.Don't launch it directly from any search bar since it breaks the directory.
	ECHO.If you are using a shortcut, make sure you added the correct directory.
	PAUSE>NUL
	EXIT /B
) ELSE ( DEL VERIFY.txt )
SET HTS_DATA=%APPDATA%\HTS_DATA
SET DIRECTORY=%HTS_DATA%\MC-BACKUPS
SET SAVEFOLDER=MC-BACKUPS
SET SAVEIN=%CD%\%SAVEFOLDER%
SET SAVEINHTS=%DIRECTORY%\%SAVEFOLDER%
SET PROFILES=%SAVEIN%\PROFILES
SET LOGS=%CD%\info.log
SET IMGTITLE=MC Backup Loader (1.8.3)  -  [By HTS-Studios]
SET MAXPROFILES=27
SET ML=30
MODE CON:COLS=75 LINES=%ML%
:STARTUP
TITLE %IMGTITLE%
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
IF NOT EXIST %DIRECTORY% ECHO.                         Starting Backup Proccess...
IF NOT EXIST "%HTS_DATA%" (
	ECHO.INFO: Creating folder: "%HTS_DATA%" ... >> "%LOGS%"
	MD "%HTS_DATA%"
)
IF NOT EXIST "%DIRECTORY%" (
	ECHO.INFO: Creating directory: "%DIRECTORY%" ... >> "%LOGS%"
	MD "%DIRECTORY%"
)
IF NOT EXIST "%DIRECTORY%\MCDIRECTORY.txt" ECHO.%APPDATA%\.minecraft> "%DIRECTORY%\MCDIRECTORY.txt"
SET /p MCDIRECTORY=<"%DIRECTORY%\MCDIRECTORY.txt"
IF NOT EXIST "%MCDIRECTORY%" ( GOTO STARTUPMISSINGMINECRAFT )
IF NOT EXIST "%SAVEIN%" (
	ECHO.INFO: Creating folder "\%SAVEFOLDER%" >> "%LOGS%"
	MD "%SAVEIN%"
)
IF NOT EXIST "%PROFILES%" (
	MD "%PROFILES%"
)
IF NOT EXIST "%MCDIRECTORY%\options.txt" (
	IF EXIST "%SAVEIN%\options.txt" (
		XCOPY "%SAVEIN%\options.txt" "%MCDIRECTORY%\" >> "%LOGS%"
		SET FILESWEREMISSING=TRUE
	) ELSE GOTO ERROR-SAVEATSTART
) ELSE IF NOT EXIST "%SAVEIN%\options.txt" (
	ECHO.INFO: Copying file "%%APPDATA%%\.minecraft\options.txt" to "\%SAVEFOLDER%\" >> "%LOGS%"
	XCOPY "%MCDIRECTORY%\options.txt" "%SAVEIN%\" >> "%LOGS%"
	SET FILESBACKUPED=TRUE
)
IF NOT EXIST "%MCDIRECTORY%\optionsof.txt" (
	IF EXIST "%SAVEIN%\optionsof.txt" (
		ECHO.INFO: Copying file "\%SAVEFOLDER%\options.txt" to "%%APPDATA%%\.minecraft\" >> "%LOGS%"
		XCOPY "%SAVEIN%\optionsof.txt" "%MCDIRECTORY%\" >> "%LOGS%"
		SET FILESWEREMISSING=TRUE
	)
) ELSE IF NOT EXIST "%SAVEIN%\optionsof.txt" (
	ECHO.INFO: Copying file "%%APPDATA%%\.minecraft\optionsof.txt" to "\%SAVEFOLDER%" >> "%LOGS%"
	XCOPY "%MCDIRECTORY%\optionsof.txt" "%SAVEIN%\" >> "%LOGS%"
	SET FILESBACKUPED=TRUE
)
IF NOT EXIST "%MCDIRECTORY%\optionsshaders.txt" (
	IF EXIST "%SAVEIN%\optionsshaders.txt" (
		XCOPY "%SAVEIN%\optionsshaders.txt" "%MCDIRECTORY%\" >> "%LOGS%"
		SET FILESWEREMISSING=TRUE
	)
) ELSE IF NOT EXIST "%SAVEIN%\optionsshaders.txt" (
	ECHO.INFO: Copying file "%%APPDATA%%\.minecraft\optionsshaders.txt" to "\%SAVEFOLDER%" >> "%LOGS%"
	XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%SAVEIN%\" >> "%LOGS%"
	SET FILESBACKUPED=TRUE
)
:STARTUP-DONE
IF "%SWITCHEDDIRECTORY%"=="TRUE" ECHO.           Directory no longer exists, switched to ".minecraft"
SET SWITCHEDDIRECTORY=
IF "%FILESBACKUPED%"=="TRUE" ECHO.                              Backuped Files.
IF "%FILESWEREMISSING%"=="TRUE" ECHO.            Restored the missing files on the minecraft directory.
ECHO.                             Startup Finished.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:MENU
ECHO.
ECHO.Have you been losing your Minecraft Settings? When you switch minecraft
ECHO.versions, some times you will lose all your settings. So this program is
ECHO.the solution! You can save backups and load them any time from here!
ECHO.NOTE: YOU CANNOT LOAD A BACKUP IN A DIFFERENT MC VERSION!
IF EXIST "%SAVEIN%\optionsof.txt" ( ECHO.^(Optifine Settings will also be saved in the backup^))
ECHO.
ECHO. -   - -   - -   - -   - -   - -   GUIDE   - -   - -   - -   - -   - -   -
ECHO.Save as recent Backup: Type "Save" or "S"
ECHO.Load a recent Backup: Close Minecraft, Type "Load" or "L"
ECHO.
ECHO.Save ^& load multiple backups ^(Profiles^):
ECHO.-Create a Profile: Type "create profile" or "cp"
ECHO.-Save in a Profile: Type "save in" or "si"
ECHO.-Load a profile: Close Minecraft, Type "load profile" or "lp"
ECHO.-List all your Profiles: Type "profiles list" or "plist"
eCHO.-Delete a Profile: Type "delete profile", "dp" or "delete all profiles"
ECHO.Note: for faster, you can type the profile name at the end of a command.
ECHO.      Example: "create profile MyProfile", "save in MyProfile" etc.
ECHO.
ECHO.Save all Mod Configs: Type "Save Configs" or "SC"
ECHO.Restore all Mod Configs: Close Minecraft, Type "Load Configs" or "LC"
ECHO.
SET UDERFINE=
SET /P UDERFINE=Type: 
 IF NOT DEFINED UDERFINE CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                        Please type a valid Command.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
 IF /I "%UDERFINE%"=="HELP" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                    Use one of the commands as explained.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
 IF /I "%UDERFINE%"=="LOAD" GOTO LOAD
 IF /I "%UDERFINE%"=="L" GOTO LOAD
 IF /I "%UDERFINE%"=="SAVE" GOTO SAVE
 IF /I "%UDERFINE%"=="S" GOTO SAVE
 IF /I "%UDERFINE:~0,15%"=="CREATE PROFILE " CLS&GOTO CREATEPROFILE-INSTANT
 IF /I "%UDERFINE:~0,15%"=="PROFILE CREATE " CLS&GOTO CREATEPROFILE-INSTANT
 IF /I "%UDERFINE:~0,3%"=="CP " (
	SET UDERFINE=CREATE PROFILE %UDERFINE:~3,30%
	GOTO CREATEPROFILE-INSTANT
 )
 IF /I "%UDERFINE:~0,15%"=="DELETE PROFILE " CLS&GOTO DELETEPROFILE-INSTANT
 IF /I "%UDERFINE:~0,15%"=="PROFILE DELETE " CLS&GOTO DELETEPROFILE-INSTANT
 IF /I "%UDERFINE:~0,13%"=="LOAD PROFILE " CLS&GOTO LOADPROFILE-INSTANT
 IF /I "%UDERFINE:~0,13%"=="PROFILE LOAD " CLS&GOTO LOADPROFILE-INSTANT
 IF /I "%UDERFINE:~0,3%"=="LP " (
	SET UDERFINE=LOAD PROFILE %UDERFINE:~3,30%
	GOTO LOADPROFILE-INSTANT
 )
 IF /I "%UDERFINE:~0,8%"=="SAVE IN " CLS&GOTO SAVEINPROFILE-INSTANT
 IF /I "%UDERFINE:~0,8%"=="SAVE-IN " CLS&GOTO SAVEINPROFILE-INSTANT
 IF /I "%UDERFINE:~0,3%"=="SI " (
	SET UDERFINE=SAVE IN %UDERFINE:~3,30%
	GOTO SAVEINPROFILE-INSTANT
 )
 IF /I "%UDERFINE%"=="SI" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="CP" CLS&GOTO CREATEPROFILE
 IF /I "%UDERFINE%"=="CREATE PROFILE" CLS&GOTO CREATEPROFILE
 IF /I "%UDERFINE%"=="CREATE PROFILES" CLS&GOTO CREATEPROFILE
 IF /I "%UDERFINE%"=="CREATEPROFILE" CLS&GOTO CREATEPROFILE
 IF /I "%UDERFINE%"=="CREATEPROFILES" CLS&GOTO CREATEPROFILE
 IF /I "%UDERFINE%"=="SAVEIN" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="SAVE-IN" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="SAVE IN" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="SAVE IN PROFILE" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="SAVE PROFILE" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="SP" CLS&GOTO SAVEINPROFILE
 IF /I "%UDERFINE%"=="LOADPROFILE" CLS&GOTO LOADPROFILE
 IF /I "%UDERFINE%"=="LOAD PROFILE" CLS&GOTO LOADPROFILE
 IF /I "%UDERFINE%"=="LOAD FROM" CLS&GOTO LOADPROFILE
 IF /I "%UDERFINE%"=="LP" CLS&GOTO LOADPROFILE
 IF /I "%UDERFINE%"=="DELETE PROFILE" CLS&GOTO DELETEPROFILE
 IF /I "%UDERFINE%"=="DEL PROFILE" CLS&GOTO DELETEPROFILE
 IF /I "%UDERFINE:~0,3%"=="DP " (
	SET UDERFINE=CREATE PROFILE %UDERFINE:~3,30%
	GOTO DELETEPROFILE-INSTANT
 )
 IF /I "%UDERFINE%"=="DP" CLS&GOTO DELETEPROFILE
 IF /I "%UDERFINE%"=="DELETE ALL PROFILES" CLS&GOTO DELALLPROFILES
 IF /I "%UDERFINE%"=="DEL ALL PROFILES" CLS&GOTO DELALLPROFILES
 IF /I "%UDERFINE%"=="PLIST" GOTO PROFILESLIST
 IF /I "%UDERFINE%"=="LOAD CONFIGS" GOTO LOADCONFIGS
 IF /I "%UDERFINE%"=="LOAD CONFIG" GOTO LOADCONFIGS
 IF /I "%UDERFINE%"=="SAVE CONFIGS" GOTO SAVECONFIGS
 IF /I "%UDERFINE%"=="SAVE CONFIG" GOTO SAVECONFIGS
 IF /I "%UDERFINE%"=="LOADCONFIGS" GOTO LOADCONFIGS
 IF /I "%UDERFINE%"=="LOADCONFIG" GOTO LOADCONFIGS
 IF /I "%UDERFINE%"=="SAVECONFIGS" GOTO SAVECONFIGS
 IF /I "%UDERFINE%"=="SAVECONFIG" GOTO SAVECONFIGS
 IF /I "%UDERFINE%"=="LC" GOTO LOADCONFIGS
 IF /I "%UDERFINE%"=="SC" GOTO SAVECONFIGS
 IF /I "%UDERFINE%"=="FIX" CLS&MODE CON:COLS=75 LINES=%ML%&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -                                Fixed Layout                               - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
 IF /I "%UDERFINE%"=="CHANGE DIRECTORY" GOTO CHANGEDIRECTORY
 IF /I "%UDERFINE%"=="CHANGEDIRECTORY" GOTO CHANGEDIRECTORY
 IF /I "%UDERFINE%"=="CHOOSE DIRECTORY" GOTO CHANGEDIRECTORY
 IF /I "%UDERFINE%"=="CHOOSEDIRECTORY" GOTO CHANGEDIRECTORY
 IF /I "%UDERFINE%"=="CD" GOTO CHANGEDIRECTORY
 IF /I "%UDERFINE%"=="RESET DIRECTORY" GOTO RESETDIRECTORY
 IF /I "%UDERFINE%"=="RESETDIRECTORY" GOTO RESETDIRECTORY
 IF /I "%UDERFINE%"=="UNINSTALL" GOTO UNINSTALL
 IF /I "%UDERFINE%"=="EXIT" EXIT /B
 IF /I "%UDERFINE%"=="CLOSE" EXIT /B
 IF /I "%UDERFINE%"=="QUIT" EXIT /B
::Developer Commands
 IF /I "%UDERFINE%"=="OPEN LOGS" START "" "%LOGS%"
 IF /I "%UDERFINE%"=="OPEN PROFILES" START "" "%PROFILES%"
 IF /I "%UDERFINE%"=="OPEN DIRECTORY" START "" "%DIRECTORY%"
 IF /I "%UDERFINE%"=="OPEN MINECRAFT" START "" "%MCDIRECTORY%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                              Invalid Command.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:RESETDIRECTORY
ECHO.%APPDATA%\.minecraft> "%DIRECTORY%\MCDIRECTORY.txt"
GOTO STARTUP
:CHANGEDIRECTORY
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                     Select a folder to add as directory.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:CHANGEDIRECTORY-SKIP
SET CHOSEDIRECTORY=
SET "PSCOMMAND="(NEW-OBJECT -COM 'SHELL.APPLICATION')^
.BROWSEFORFOLDER(0,'Please choose your minecraft directory.',0,0).SELF.PATH""
FOR /F "USEBACKQ DELIMS=" %%I IN (`POWERSHELL %PSCOMMAND%`) DO SET "CHOSEDIRECTORY=%%I"
IF NOT DEFINED CHOSEDIRECTORY (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.                         Directory was not changed.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE IF NOT EXIST "%CHOSEDIRECTORY%\options.txt" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.              This directory doesn't include the required files.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO CHANGEDIRECTORY-SKIP
)
ECHO.%CHOSEDIRECTORY%> "%DIRECTORY%\MCDIRECTORY.txt"
GOTO STARTUP
:LOAD
TASKLIST /FI "IMAGENAME eq javaw.exe" 2>NUL | FIND /I /N "javaw.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                          Minecraft is running!
	ECHO.              Please close Minecraft before loading a backup.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF EXIST "%MCDIRECTORY%\options.txt" ( GOTO LOAD-ASK ) ELSE ( GOTO LOAD-SKIP )
:LOAD-ASK
IF NOT EXIST %MCDIRECTORY% GOTO STARTUP
CLS
ECHO.- - - - - - - - - - - - - - - - - CONFIRM - - - - - - - - - - - - - - - - -
ECHO.     Are you sure you want to load a backup and restore your settings?
ECHO.
ECHO.            Press Enter to continue or type "N" / "No" to cancel.
SET UDERFINE=
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ECHO.
SET /P UDERFINE=
 IF /I "%UDERFINE%"=="NO" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                            Backup was Cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
 IF /I "%UDERFINE%"=="N" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                            Backup was Cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
 IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                            Backup was Cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
:LOAD-SKIP
TASKLIST /FI "IMAGENAME eq javaw.exe" 2>NUL | find /I /N "javaw.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                          Minecraft is running!
	ECHO.              Please close Minecraft before loading a backup.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF EXIST "%SAVEIN%\options.txt" (
	DEL "%MCDIRECTORY%\options.txt"
	XCOPY "%SAVEIN%\options.txt" "%MCDIRECTORY%\" >> "%LOGS%"
) ELSE (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                           Backup load failed.
	ECHO.                        There is no backup saved!
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF EXIST "%SAVEIN%\optionsof.txt" (
	DEL "%MCDIRECTORY%\optionsof.txt"
	XCOPY "%SAVEIN%\optionsof.txt" "%MCDIRECTORY%\" >> "%LOGS%"
)
IF EXIST "%SAVEIN%\optionsshaders.txt" (
	DEL "%MCDIRECTORY%\optionsshaders.txt"
	XCOPY "%SAVEIN%\optionsshaders.txt" "%MCDIRECTORY%\" >> "%LOGS%"
)
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                             Backup was Loaded!
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:SAVE
IF NOT EXIST %MCDIRECTORY% GOTO STARTUP
IF NOT EXIST "%MCDIRECTORY%\options.txt" GOTO ERROR-1
IF EXIST "%SAVEIN%\options.old.txt" DEL "%SAVEIN%\options.old.txt" >NUL
IF EXIST "%SAVEIN%\optionsof.old.txt" DEL "%SAVEIN%\optionsof.old.txt" >NUL
IF EXIST "%SAVEIN%\optionsshaders.old.txt" DEL "%SAVEIN%\optionsshaders.old.txt" >NUL
IF EXIST "%SAVEIN%\options.txt" REN "%SAVEIN%\options.txt" "options.old.txt" >NUL
IF EXIST "%SAVEIN%\optionsof.txt" REN "%SAVEIN%\optionsof.txt" "optionsof.old.txt" >NUL
IF EXIST "%SAVEIN%\optionsshaders.txt" REN "%SAVEIN%\optionsshaders.txt" "optionsshaders.old.txt" >NUL
XCOPY "%MCDIRECTORY%\options.txt" "%SAVEIN%\" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsof.txt" XCOPY "%MCDIRECTORY%\optionsof.txt" "%SAVEIN%\" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsshaders.txt" XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%SAVEIN%\" >> "%LOGS%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                        Created new backuped files!
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:SAVECONFIGS
IF NOT EXIST %MCDIRECTORY% GOTO STARTUP
CLS
IF NOT EXIST "%MCDIRECTORY%\config" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                           Backup load failed.
	ECHO.            Unable to find the config folder in the directory.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
@RD /S /Q "%SAVEIN%\config"
MD "%SAVEIN%\config"
ECHO.Copying files from "%MCDIRECTORY%\config" to "%SAVEIN%\config" ... >> "%LOGS%"
ECHO.Creating backup ...
XCOPY /S "%MCDIRECTORY%\config" "%SAVEIN%\config" >> "%LOGS%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                         Mod Configs were backuped!
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:LOADCONFIGS
SET UDERFINE=
IF NOT EXIST "%SAVEIN%\config" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                           Backup load failed.
	ECHO.                        There is no backup saved.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
SET "FILESNUMBER=0"
FOR %%A IN ("%MCDIRECTORY%\config\*") DO SET/A FILESNUMBER+=1
IF EXIST "%MCDIRECTORY%\config" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - CONFIRM - - - - - - - - - - - - - - - - -
	ECHO.             Are you sure you want to restore %FILESNUMBER% files ^& folders?
	ECHO.       Everything in your config folder will be replaced with a backup.
	ECHO.
	ECHO.            Press enter to continue or type "N" / "No" to cancel.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	ECHO.
	SET /P UDERFINE=
)
	 IF /I "%UDERFINE%"=="NO" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                      Backup Config Load was Canelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
	 IF /I "%UDERFINE%"=="N" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                      Backup Config Load was Canelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
	 IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                      Backup Config Load was Canelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
CLS
IF EXIST "%MCDIRECTORY%\config" ( @RD /S /Q "%MCDIRECTORY%\config" )
MD "%MCDIRECTORY%\config"
ECHO.Copying files from "%SAVEIN%\config" to "%MCDIRECTORY%\config" ... >> "%LOGS%"
ECHO.Replacing configs ...
XCOPY /S "%SAVEIN%\config" "%MCDIRECTORY%\config" >> "%LOGS%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                   Mod Configs were restored with a backup!
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:CREATEPROFILE
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES% gtr %MAXPROFILES% (
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.          You have over reached the max profiles number! ^(%COUNTPROFILES%/%MAXPROFILES%^)
	ECHO.              Delete some profiles in the menu and try again.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE IF %COUNTPROFILES% equ %MAXPROFILES% (
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.             You have reached the max profiles number! ^(%COUNTPROFILES%/%MAXPROFILES%^)
	ECHO.              Delete some profiles in the menu and try again.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                        Type a name for the profile.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:CREATEPROFILE-NOCHECK
ECHO.
SET UDERFINE=
SET /P UDERFINE=Profile: 
IF NOT DEFINED UDERFINE CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="CANCEL" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="EXIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="QUIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="LEAVE" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
ECHO.%UDERFINE%| FINDSTR /R "[^a-zA-Z0-9._-]" >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.     Please do not use any spaces or special characters such as below
	ECHO.         , ^( ^) ^> ^< ^? ^/ ^& %% $ # @ ! ^* ^^ : ` ~ \ ^| / " ' ; + = [ ]
	ECHO.                         Type a valid profile name.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO CREATEPROFILE-NOCHECK
)
IF NOT "%UDERFINE:~29,1%"=="" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.                     Don't use more than 29 characters.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO CREATEPROFILE-NOCHECK
)
IF EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                     This profile name already exists!
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO CREATEPROFILE-NOCHECK
) ELSE MD "%PROFILES%\%UDERFINE%"
IF NOT EXIST "%MCDIRECTORY%\options.txt" GOTO ERROR-1
IF EXIST "%PROFILES%\%UDERFINE%\options.old.txt" DEL "%PROFILES%\%UDERFINE%\options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\options.txt" REN "%PROFILES%\%UDERFINE%\options.txt" "options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" REN "%PROFILES%\%UDERFINE%\optionsof.txt" "optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" REN "%PROFILES%\%UDERFINE%\optionsshaders.txt" "optionsshaders.old.txt" >NUL
XCOPY "%MCDIRECTORY%\options.txt" "%PROFILES%\%UDERFINE%" >NUL
IF EXIST "%MCDIRECTORY%\optionsof.txt" XCOPY "%MCDIRECTORY%\optionsof.txt" "%PROFILES%\%UDERFINE%" >NUL
IF EXIST "%MCDIRECTORY%\optionsshaders.txt" XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%PROFILES%\%UDERFINE%" >NUL
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                       Profile successfully created.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:PROFILESLIST
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
CLS
ECHO.- - List of your Profiles - -
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
DIR /A:D "%PROFILES%" /B
IF %COUNTPROFILES%==0 ( ECHO.^(EMPTY^)
) ELSE IF %COUNTPROFILES% lss %MAXPROFILES% (
	ECHO.- -                       - -
    SET /P "=Counted %COUNTPROFILES% profiles out of max %MAXPROFILES%." <NUL
) ELSE IF %COUNTPROFILES% gtr %MAXPROFILES% (
	ECHO.- -                       - -
    SET /P "=Warning! You have over reached the max profiles number! (%COUNTPROFILES%/%MAXPROFILES%)" <NUL
) ELSE IF %COUNTPROFILES% equ %MAXPROFILES% (
	ECHO.- -                       - -
    SET /P "=Warning! You have reached the max profiles number! (%COUNTPROFILES%/%MAXPROFILES%)" <NUL
)
PAUSE > NUL
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                            Listed all profiles.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:DELETEPROFILE
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                     There are no profiles to delete.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
:DELETEPROFILE-HALFSKIP
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.           Type the name of the profile which you want to delete.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:DELETEPROFILE-SKIP
ECHO.
SET UDERFINE=
SET /P UDERFINE=Profile: 
IF NOT DEFINED UDERFINE (
	CLS
	GOTO DELETEPROFILE-HALFSKIP
)
IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile delation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="CANCEL" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile delation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="EXIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile delation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="QUIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile delation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF EXIST "%PROFILES%\%UDERFINE%" (
	RD /S /Q "%PROFILES%\%UDERFINE%"
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.                       Profile was successfuly deleted.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO DELETEPROFILE-SKIP
)
CLS
GOTO DELETEPROFILE
:SAVEINPROFILE
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                    There are no profiles to save-in.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
:SAVEINPROFILE-HALFSKIP
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.           Type the name of the profile which you want to save-in.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:SAVEINPROFILE-SKIP
ECHO.
SET UDERFINE=
SET /P UDERFINE=Profile: 
IF NOT DEFINED UDERFINE  (CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU)
ECHO.%UDERFINE%| FINDSTR /R "[^a-zA-Z0-9._-]" >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.     Please do not use any spaces or special characters such as below
	ECHO.         , ^( ^) ^> ^< ^? ^/ ^& %% $ # @ ! ^* ^^ : ` ~ \ ^| / " ' ; + = [ ]
	ECHO.                         Type a valid profile name.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO SAVEINPROFILE-SKIP
)
IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="CANCEL" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="EXIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="QUIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="LEAVE" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU

IF EXIST "%PROFILES%\%UDERFINE%" (
	IF NOT EXIST "%MCDIRECTORY%\options.txt" GOTO ERROR-1
	IF EXIST "%PROFILES%\%UDERFINE%\options.old.txt" DEL "%PROFILES%\%UDERFINE%\options.old.txt" >NUL
	IF EXIST "%PROFILES%\%UDERFINE%\optionsof.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsof.old.txt" >NUL
	IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" >NUL
	IF EXIST "%PROFILES%\%UDERFINE%\options.txt" REN "%PROFILES%\%UDERFINE%\options.txt" "options.old.txt" >NUL
	IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" REN "%PROFILES%\%UDERFINE%\optionsof.txt" "optionsof.old.txt" >NUL
	IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" REN "%PROFILES%\%UDERFINE%\optionsshaders.txt" "optionsshaders.old.txt" >NUL
	XCOPY "%MCDIRECTORY%\options.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
	IF EXIST "%MCDIRECTORY%\optionsof.txt" XCOPY "%MCDIRECTORY%\optionsof.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
	IF EXIST "%MCDIRECTORY%\optionsshaders.txt" XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.               Settings were succcessfuly saved in the profile.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO SAVEINPROFILE-SKIP
)
CLS
GOTO SAVEINPROFILE
:LOADPROFILE
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
TASKLIST /FI "IMAGENAME eq javaw.exe" 2>NUL | FIND /I /N "javaw.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                          Minecraft is running!
	ECHO.       Please close Minecraft before loading a backup from a profile.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                      There are no profiles to load.   
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
:LOADPROFILE-HALFSKIP
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.            Type the name of the profile which you want to load.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:LOADPROFILE-SKIP
ECHO.
SET UDERFINE=
SET /P UDERFINE=Profile: 
IF NOT DEFINED UDERFINE  (CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile creation cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU)
IF /I "%UDERFINE%"=="LEAVE" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                       Profile save-in cancelleted.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="BACK" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                          Profile load cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="CANCEL" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                          Profile load cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="EXIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                          Profile load cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
IF /I "%UDERFINE%"=="QUIT" CLS&ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -&ECHO.                          Profile load cancelled.&ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -&GOTO MENU
)
IF NOT EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO LOADPROFILE-SKIP
)
SET /A PROFILEFILESMUM=0
IF NOT EXIST "%PROFILES%\%UDERFINE%\options.txt" SET /a PROFILEFILESMUM+=1
IF NOT EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" SET /a PROFILEFILESMUM+=1
IF NOT EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" SET /a PROFILEFILESMUM+=1
IF %PROFILEFILESMUM% GTR 2 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.               This profile has no expected content inside.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO LOADPROFILE-SKIP
)
IF EXIST "%PROFILES%\%UDERFINE%\options.txt" (
	DEL /Q "%MCDIRECTORY%\options.txt"
	XCOPY "%PROFILES%\%UDERFINE%\options.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" (
	DEL /Q "%MCDIRECTORY%\optionsof.txt"
	XCOPY "%PROFILES%\%UDERFINE%\optionsof.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" (
	DEL /Q "%MCDIRECTORY%\optionsshaders.txt"
	XCOPY "%PROFILES%\%UDERFINE%\optionsshaders.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.            Settings were succcessfuly loaded from the profile.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:UNINSTALL
SET UDERFINE=
CLS
ECHO.- - - - - - - - - - - - - - - - - CONFIRM - - - - - - - - - - - - - - - - -
ECHO.  Are you sure you want to delete all your backuped settings ^& profiles?
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ECHO.
SET /P UDERFINE=Yes/No: 
 IF /I "%UDERFINE%"=="YES" GOTO UNINSTALL-PROCC
 IF /I "%UDERFINE%"=="Y" GOTO UNINSTALL-PROCC
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                           Unistall was cancelled.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:UNINSTALL-PROCC
CLS
ECHO.Cleaning up...
IF EXIST "%SAVEFOLDER%" ( RD /S /Q "%SAVEFOLDER%" )
IF EXIST "%DIRECTORY%" ( RD /S /Q "%DIRECTORY%" )
IF EXIST "%LOGS%" ( DEL /Q "%LOGS%" )
ECHO.Success! Press any key to exit.
PAUSE>NUL
EXIT
:CREATEPROFILE-INSTANT
IF NOT "%UDERFINE:~44,1%"=="" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.                     Don't use more than 29 characters.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
SET UDERFINE=%UDERFINE:~15,29%
IF NOT DEFINED UDERFINE GOTO CREATEPROFILE
IF NOT EXIST "%PROFILES%" GOTO ERROR-2
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES% GTR %MAXPROFILES% (
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.          You have over reached the max profiles number! ^(%COUNTPROFILES%/%MAXPROFILES%^)
	ECHO.              Delete some profiles in the menu and try again.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE IF %COUNTPROFILES% EQU %MAXPROFILES% (
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.             You have reached the max profiles number! ^(%COUNTPROFILES%/%MAXPROFILES%^)
	ECHO.              Delete some profiles in the menu and try again.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
ECHO.%UDERFINE%| FINDSTR /R "[^a-zA-Z0-9._-]" >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.     Please do not use any spaces or special characters such as below
	ECHO.         , ^( ^) ^> ^< ^? ^/ ^& %% $ # @ ! ^* ^^ : ` ~ \ ^| / " ' ; + = [ ]
	ECHO.                         Type a valid profile name.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                     This profile name already exists!
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
) ELSE MD "%PROFILES%\%UDERFINE%"
IF NOT EXIST "%MCDIRECTORY%\options.txt" GOTO ERROR-1
IF EXIST "%PROFILES%\%UDERFINE%\options.old.txt" DEL "%PROFILES%\%UDERFINE%\options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\options.txt" REN "%PROFILES%\%UDERFINE%\options.txt" "options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" REN "%PROFILES%\%UDERFINE%\optionsof.txt" "optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" REN "%PROFILES%\%UDERFINE%\optionsshaders.txt" "optionsshaders.old.txt" >NUL
XCOPY "%MCDIRECTORY%\options.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsof.txt" XCOPY "%MCDIRECTORY%\optionsof.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsshaders.txt" XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                       Profile successfully created.
SETLOCAL ENABLEDELAYEDEXPANSION
SET STR=  "%UDERFINE%"
SET "CSIZE=75"
SET "LEN=0"
:STRLEN_LOOP_CREATE
IF NOT "!!STR:~%LEN%!!"=="" SET /A "LEN+=1" & GOTO :STRLEN_LOOP_CREATE
SET "CLINE=- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
SET "SPACES=                                                                                                   "
SET /A "PREF_LEN=%CSIZE%-%LEN%-2"
SET /A "PREF_LEN/=2"
SET /A "SUF_LEN=%CSIZE%-%LEN%-2-%PREF_LEN%"
CALL ECHO %%SPACES:~0,%PREF_LEN%%%%%STR%%%%SPACES:~0,%SUF_LEN%%%
CALL ECHO %%CLINE:~0,%CSIZE%%%
ENDLOCAL
GOTO MENU
:DELETEPROFILE-INSTANT
SET UDERFINE=%UDERFINE:~15,29%
IF NOT DEFINED UDERFINE GOTO DELETEPROFILE
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                     There are no profiles to delete.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF NOT EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
RD /S /Q "%PROFILES%\%UDERFINE%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                       Profile successfully deleted.
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET STR=  "%UDERFINE%"
SET "CSIZE=75"
SET "LEN=0"
:STRLEN_LOOP_DELETE
IF NOT "!!STR:~%LEN%!!"=="" SET /A "LEN+=1" & GOTO :STRLEN_LOOP_DELETE
SET "CLINE=- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
SET "SPACES=                                                                                                   "
SET /A "PREF_LEN=%CSIZE%-%LEN%-2"
SET /A "PREF_LEN/=2"
SET /A "SUF_LEN=%CSIZE%-%LEN%-2-%PREF_LEN%"
CALL ECHO %%SPACES:~0,%PREF_LEN%%%%%STR%%%%SPACES:~0,%SUF_LEN%%%
CALL ECHO %%CLINE:~0,%CSIZE%%%
ENDLOCAL
GOTO MENU
:LOADPROFILE-INSTANT
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                      There are no profiles to load.   
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
TASKLIST /FI "IMAGENAME eq javaw.exe" 2>NUL | FIND /I /N "javaw.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                          Minecraft is running!
	ECHO.       Please close Minecraft before loading a backup from a profile.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
SET UDERFINE=%UDERFINE:~13,27%
IF NOT DEFINED UDERFINE GOTO LOADPROFILE
IF NOT EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
SET /A PROFILEFILESMUM=0
IF NOT EXIST "%PROFILES%\%UDERFINE%\options.txt" SET /a PROFILEFILESMUM+=1
IF NOT EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" SET /a PROFILEFILESMUM+=1
IF NOT EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" SET /a PROFILEFILESMUM+=1
IF %PROFILEFILESMUM% GTR 2 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.               This profile has no expected content inside.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO LOADPROFILE-SKIP
)
IF EXIST "%PROFILES%\%UDERFINE%\options.txt" (
	DEL /Q "%MCDIRECTORY%\options.txt"
	XCOPY "%PROFILES%\%UDERFINE%\options.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" (
	DEL /Q "%MCDIRECTORY%\optionsof.txt"
	XCOPY "%PROFILES%\%UDERFINE%\optionsof.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" (
	DEL /Q "%MCDIRECTORY%\optionsshaders.txt"
	XCOPY "%PROFILES%\%UDERFINE%\optionsshaders.txt" "%MCDIRECTORY%" >> "%LOGS%"
)
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.            Settings were succcessfuly loaded from the profile.
SETLOCAL ENABLEDELAYEDEXPANSION
SET STR=  "%UDERFINE%"
SET "CSIZE=75"
SET "LEN=0"
:STRLEN_LOOP_DELETE
IF NOT "!!STR:~%LEN%!!"=="" SET /A "LEN+=1" & GOTO :STRLEN_LOOP_DELETE
SET "CLINE=- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
SET "SPACES=                                                                                                   "
SET /A "PREF_LEN=%CSIZE%-%LEN%-2"
SET /A "PREF_LEN/=2"
SET /A "SUF_LEN=%CSIZE%-%LEN%-2-%PREF_LEN%"
CALL ECHO %%SPACES:~0,%PREF_LEN%%%%%STR%%%%SPACES:~0,%SUF_LEN%%%
CALL ECHO %%CLINE:~0,%CSIZE%%%
ENDLOCAL
GOTO MENU
:SAVEINPROFILE-INSTANT
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                    There are no profiles to save-in.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
SET UDERFINE=%UDERFINE:~8,27%
IF NOT DEFINED UDERFINE GOTO SAVEINPROFILE
ECHO.%UDERFINE%| FINDSTR /R "[^a-zA-Z0-9._-]" >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - INVALID - - - - - - - - - - - - - - - - -
	ECHO.     Please do not use any spaces or special characters such as below
	ECHO.         , ^( ^) ^> ^< ^? ^/ ^& %% $ # @ ! ^* ^^ : ` ~ \ ^| / " ' ; + = [ ]
	ECHO.                          Use a valid profile name.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF NOT EXIST "%PROFILES%\%UDERFINE%" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                       This profile doesn't exist.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
IF NOT EXIST "%MCDIRECTORY%\options.txt" GOTO ERROR-1
IF EXIST "%PROFILES%\%UDERFINE%\options.old.txt" DEL "%PROFILES%\%UDERFINE%\options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" DEL "%PROFILES%\%UDERFINE%\optionsshaders.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\options.txt" REN "%PROFILES%\%UDERFINE%\options.txt" "options.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsof.txt" REN "%PROFILES%\%UDERFINE%\optionsof.txt" "optionsof.old.txt" >NUL
IF EXIST "%PROFILES%\%UDERFINE%\optionsshaders.txt" REN "%PROFILES%\%UDERFINE%\optionsshaders.txt" "optionsshaders.old.txt" >NUL
XCOPY "%MCDIRECTORY%\options.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsof.txt" XCOPY "%MCDIRECTORY%\optionsof.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
IF EXIST "%MCDIRECTORY%\optionsshaders.txt" XCOPY "%MCDIRECTORY%\optionsshaders.txt" "%PROFILES%\%UDERFINE%" >> "%LOGS%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.               Settings were succcessfuly saved in the profile.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:DELALLPROFILES
IF NOT EXIST "%PROFILES%" GOTO ERROR-PROFILES
FOR /F %%A IN ('DIR /B /S /AD "%PROFILES%"^|FIND /C /V "" ') DO SET COUNTPROFILES=%%A
IF %COUNTPROFILES%==0 (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
	ECHO.                          There are no profiles. 
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
)
CLS
ECHO.- - - - - - - - - - - - - - - - - CONFIRM - - - - - - - - - - - - - - - - -
ECHO.             Are you sure you want to delete all your profiles?
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ECHO.
SET UDERFINE=
SET /P UDERFINE=Yes/No: 
 IF /I NOT "%UDERFINE%"=="YES" IF /I NOT "%UDERFINE%"=="Y" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.                            No profiles deleted.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO MENU
 )
@RD /S /Q "%PROFILES%"
MD "%PROFILES%"
CLS
ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
ECHO.                    All profiles were successfuly deleted.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:STARTUPMISSINGMINECRAFT
IF EXIST "%APPDATA%\.minecraft" (
	ECHO.%APPDATA%\.minecraft> "%DIRECTORY%\MCDIRECTORY.txt"
	SET SWITCHEDDIRECTORY=TRUE
	GOTO STARTUP
)
CLS
ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
ECHO.    Minecraft directory was not found. Select your minecraft directory.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:STARTUPMISSINGMINECRAFT-SKIP
SET CHOSEDIRECTORY=
SET "PSCOMMAND="(NEW-OBJECT -COM 'SHELL.APPLICATION')^
.BROWSEFORFOLDER(0,'Please choose your minecraft directory.',0,0).SELF.PATH""
FOR /F "USEBACKQ DELIMS=" %%I IN (`POWERSHELL %PSCOMMAND%`) DO SET "CHOSEDIRECTORY=%%I"
IF NOT DEFINED CHOSEDIRECTORY (
	ECHO.
	ECHO.You cannot proceed until you choose your directory. Press any key to exit.
	PAUSE>NUL&EXIT
) ELSE IF NOT EXIST "%CHOSEDIRECTORY%\options.txt" (
	CLS
	ECHO.- - - - - - - - - - - - - - - - - - LOG - - - - - - - - - - - - - - - - - -
	ECHO.              This directory doesn't include the required files.
	ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	GOTO STARTUPMISSINGMINECRAFT-SKIP
)
ECHO.%CHOSEDIRECTORY%> "%DIRECTORY%\MCDIRECTORY.txt"
GOTO STARTUP
:ERROR-SAVEATSTART
CLS
ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
ECHO.                         Automatic Backup failed.
ECHO.                Options not found on the minecraft directory.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:ERROR-1
CLS
ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
ECHO.                              Backup failed.
ECHO.                Options not found on the minecraft directory.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:ERROR-2
CLS
ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
ECHO.                         Missing required content.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
:ERROR-PROFILES
CLS
ECHO.- - - - - - - - - - - - - - - - - ERROR - - - - - - - - - - - - - - - - - -
ECHO.                The profiles directory appears to be missing.
ECHO.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
GOTO MENU
ECHO.-EOF
PAUSE
EXIT