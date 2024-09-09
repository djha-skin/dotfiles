REM @echo off

set "remote=HomeOneDrive"

goto endusage
:usage
    echo Usage: %~nx0 [/raw] [/remote ^<remote^>] >&2
    goto %ret%
    goto :eof
:endusage

goto endmain
:main
    :argsloop
        if "%1" == "" goto outargsloop
        if "%1"=="/remote" (
            shift
            set "remote=%1"
            shift
        ) else (
            set "ret=main_argsloop_else"
            goto usage
            :main_argsloop_else
            goto :eof
        )
        goto argsloop
    :outargsloop

    set "fdir=%USERPROFILE%\Pictures\Screenshots"
    if not exist "%fdir%" (
        mkdir "%fdir%"
    )
    REM scoop install printf
    REM
    for /f "tokens=*" %%i in ('printf "%%04d-%%02d-%%02dT%%02d-%%02d-%%02d.png" "%date:~10%" "%date:~4,2%" "%date:~7,2%" "%time:~0,2%" "%time:~3,2%" "%time:~6,2%"') do ( set "fname=%%i" )
    REM set "fname=%date:~10%-%date:~4,2%-%date:~7,2%T%time:~0,2%-%time:~3,2%-%time:~6,2%.png"
    set "fpath=%fdir%\%fname%"
    rem REQUIRES ksnip for this to work.
    ksnip -r -p "%fpath%"
    set "fdest=%remote%:Screenshots/%fname%"
    rclone copyto -M "%fpath%" "%fdest%"
    for /f "tokens=*" %%i in ('rclone link %fdest%') do ( set "url=%%i" )
    if NOT "%raw%" == "true" (
        for /f "tokens=*" %%i in ('^
            printf "%url%" ^| ^
                sed -e "s/\/root\/content$//" ^
                    -e "s|^https://api\.onedrive\.com/v1\.0/shares/u!||" ^
                    -e "s|-|+|g" ^
                    -e "s|_|/|g" ^
                    -e "s|$|=|g" ^| ^
                 base64 -d ^
        ') do (
            set "url=%%i"
        )
    )

    printf "%%s" "%url%" | clip
    set scriptloc=%~dp0
    cscript "%scriptloc%message-box.vbs" "Screenshot uploaded, url in clipboard."
    REM powershell -c "[void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon;$objNotifyIcon.Icon = [System.Drawing.SystemIcons]::Information;$objNotifyIcon.BalloonTipIcon = 'Info';$objNotifyIcon.BalloonTipText = 'Screenshot Uploaded';$objNotifyIcon.BalloonTipTitle = 'URL in clipboard :)';$objNotifyIcon.Visible = $True;$objNotifyIcon.ShowBalloonTip(10000);Start-Sleep 5"
    goto :eof
:endmain

goto main
