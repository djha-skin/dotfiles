<# : How does this
:: even
:: work
setlocal
set "me=%~f0"

set "remote=HomeGoogleDrive"
set "raw=false"

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
        ) else if "%1"=="/raw" (
            set "raw=true"
            shift
        ) else (
            set "ret=main_argsloop_else"
            goto usage
            :main_argsloop_else
            goto :eof
        )
        goto argsloop
    :outargsloop


    rem REQUIRES ksnip for this to work.
    for /f "delims=" %%I in ('powershell -noprofile "iex (${%me%} | out-string)"') do (
        set "fpath=%%~I"
        set "fname=%%~nxI"
        set "fext=%%~xI"
        set "raw=true"

    )
    if "%fext%" == ".png" (
        set "raw=false"
    ) else if "%fext%" == ".jpg" (
        set "raw=false"
    ) else if "%fext%" == ".jpeg" (
        set "raw=false"
    ) else if "%fext%" == ".gif" (
        set "raw=false"
    ) else if "%fext%" == ".gifv" (
        set "raw=false"
    ) else if "%fext%" == ".mp4" (
        set "raw=false"
    ) else if "%fext%" == ".webp" (
        set "raw=false"
    ) else if "%fext%" == ".pdf" (
        set "raw=false"
    ) else if "%fext%" == ".doc" (
        set "raw=false"
    ) else if "%fext%" == ".docx" (
        set "raw=false"
    ) else if "%fext%" == ".html" (
        set "raw=false"
    ) else if "%fext%" == ".txt" (
        set "raw=false"
    )
    set "fdest=%remote%:/Files"
    rclone copy "%fpath%" "%fdest%"
    for /f "tokens=*" %%i in ('rclone link %fdest%/%fname%') do ( set "url=%%i" )

    if NOT "%raw%" == "true" (
        for /f "tokens=2 delims==" %%i in ("%url%") do (
            set "url=https://drive.google.com/uc?export=view^^^&id=%%i^^^&filename=%fname%"
        )
    )

    echo %url% | clip

    msg %USERNAME% " Copied `%fpath%` to `%fdest%`, link in clipboard."
    goto :eof
:endmain

goto main

#>
# https://stackoverflow.com/a/15885133
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
$f.Filter = "All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
