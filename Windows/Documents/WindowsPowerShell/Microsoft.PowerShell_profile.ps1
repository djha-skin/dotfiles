if (Test-Path Alias:\curl) {
    del alias:curl
}

if (-not (Test-Path Alias:\ll)) {
    Set-Alias -name ll -Value Get-ChildItem
}
if (-not (Test-Path Alias:\vim)) {
    Set-Alias -name vim -Value nvim-qt
}
if (-not (Test-Path Alias:which)) {
    Set-Alias -name which -Value Get-Command
}

function Out-UTF8-NoBom {
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Path,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $Content
    )
    # Good grief
    # https://github.com/PowerShell/PowerShell/issues/10278
    $dest = [IO.Path]::GetFullPath([IO.Path]::Combine((Get-Location -PSProvider FileSystem).ProviderPath, $path))

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($dest, $Content, $Utf8NoBomEncoding)
}

$Env:WORKING_LOCATION_FILE="$Env:USERPROFILE\.wdh.txt"

function pchanged {
    if (Test-Path -Path "$Env:WORKING_LOCATION_FILE") {
        cd "$(python3 "${Env:USERPROFILE}/Executables/wdh.py" -p "${Env:WORKING_LOCATION_FILE}" peek)"
    } else {
        write-error "No directory on stack"
    }
}


function ppopd {
    if (Test-Path -Path "$Env:WORKING_LOCATION_FILE") {
        python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" pop
        cd "$(python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" peek)"
    } else {
        write-error "No directory on stack"
    }
}


function ppushd {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )
    python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" push "${Path}"
    cd "$(python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" peek)"
}

function psetd {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )
    python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" set "${Path}"
    cd "$(python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" peek)"
}

function plistd {
    if (Test-Path -Path "$Env:WORKING_LOCATION_FILE") {
        python3 "${Env:USERPROFILE}\Executables\wdh.py" -p "${Env:WORKING_LOCATION_FILE}" list
    } else {
        write-error "No directory on stack"
    }
}

pchanged
