@echo off

set "remote=HomeGoogleDrive"

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

    set "fname=%date:~10%-%date:~4,2%-%date:~7,2%T%time:~0,2%-%time:~3,2%-%time:~6,2%.png"
    set "fpath=%fdir%\%fname%"
    rem REQUIRES ksnip for this to work.
    ksnip -r -p "%fpath%" 
    set "fdest=%remote%:/Screenshots/%fname%"
    rclone copy "%fpath%" "%fdest%"
    for /f "tokens=*" %%i in ('rclone link "%fdest%"') do ( set "url=%%i" )

    REM if NOT "%raw%" == "true" (
    REM     for /f "tokens=2 delims==" %%i in ("%url%") do (
    REM         set "fid=%%i"
    REM         set "url=https://drive.google.com/uc?id=%fid%^^^&filename=%fname%"
    REM     )
    REM )

    echo %url% | clip

    start "" cmd /c "echo Copied `%fpath%` to `%fdest%`, link in clipboard.&echo(&pause"
    goto :eof
:endmain










goto main
