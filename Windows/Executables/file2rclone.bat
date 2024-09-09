<# : How does this
:: work
setlocal
set "me=%~f0"

set "raw=false"
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
    set "fdest=%remote%:Files/%fname%"
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
    cscript "%scriptloc%message-box.vbs" "File uploaded, url in clipboard."
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


