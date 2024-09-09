@echo off

set "filepath=%~1"
for /f "delims=" %%i in ("%filepath%") do set base_dir=%%~dpi
for /f "delims=" %%i in ("%filepath%") do set base=%%~ni

set dest=%base_dir%%~2

if not exist "%dest%" (
    mkdir "%dest%"
)

for /f "tokens=*" %%i in ("%date:~10%-%date:~4,2%-%date:~7,2%T%time:~0,2%-%time:~3,2%-%time:~6,2%") do set now=%%i

set fname=%base%_%now%.png

set fpath=%dest%\%fname%

ksnip -d 3 -r -p "%fpath%" >NUL
REM ksnip -e "%fpath%"

for /f "tokens=4-5 delims=x " %%G in ('magick identify "%fpath%"') do (
    set width=%%G
    set height=%%H
)

set wwidth=720
set /a wheight=%height%000/(%width%000/720)

set "hheight=1280"
set /a hwidth=%width%000/(%height%000/1280)

if %width% leq %wwidth% (
    if %height% leq %hheight% (
        goto :end
    )
)

if %width% gtr %height% (
    set width=%wwidth%
    set height=%wheight%
) else (
    set width=%hwidth%
    set height=%hheight%
)

magick -quiet %fpath% -resize %width%x%height% %fpath%

echo ![](%fpath%)

:end

