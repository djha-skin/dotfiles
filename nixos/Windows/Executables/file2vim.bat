<# : How does this
:: work
@echo off
setlocal
set "me=%~f0"


goto endimgprocessing
:imgprocessing
    for /f "tokens=4 delims= " %%G in ('magick identify "%origin%"') do (
        set widthheight=%%G
        REM Skip any remaining (blank) lines
        goto outimgidentify
    )
    :outimgidentify

    for /f "tokens=1-2 delims=x" %%G in ("%widthheight%") do (
      set width=%%G
      set height=%%H
    )

    set wwidth=720
    set /a wheight=%height%000/(%width%000/720)

    set "hheight=1280"
    set /a hwidth=%width%000/(%height%000/1280)

    if %width% leq %wwidth% (
        if %height% leq %hheight% (
            cp "%origin%" "%fpath%"
            goto endwidthheightimg
        )
    )

    if %width% gtr %height% (
        set width=%wwidth%
        set height=%wheight%
    ) else (
        set width=%hwidth%
        set height=%hheight%
    )

    magick -quiet "%origin%" -resize %width%x%height% "%fpath%"

    :endwidthheightimg
    echo ![](%fname%)
    goto %return%
:endimgprocessing

goto endmain
:main
    set "filepath=%~1"
    set "subdir=%~2"
    for /f "delims=" %%i in ("%filepath%") do set base_dir=%%~dpi

    for /f "delims=" %%I in ('powershell -noprofile "iex (${%me%} | out-string)"') do (
        set "origin=%%~I"
        set "fname=%subdir%\%%~nxI"
        set "fext=%%~xI"
        set "raw=true"

    )
    set dest=%base_dir%
    set "fpath=%dest%%fname%"
    if not exist "%dest%\%subdir%" (
        mkdir "%dest%\%subdir%"
    )

    set "img=false"

    if "%fext%" == ".png" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".jpg" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".jpeg" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".gif" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".gifv" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".mp4" (
        set "return=returnimgprocess"
        goto imgprocessing
    )
    if "%fext%" == ".webp" (
        set "return=returnimgprocess"
        goto imgprocessing
    )

    cp "%origin%" "%fpath%"
    echo [](%fname%)

    :returnimgprocess

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
