if (Test-Path Alias:\curl) {
    del alias:curl
}

if (-not (Test-Path Alias:\ll)) {
    Set-Alias -name ll -Value Get-ChildItem
}
if (-not (Test-Path Alias:\vim)) {
    Set-Alias -name vim -Value nvim
}
if (-not (Test-Path Alias:which)) {
    Set-Alias -name which -Value Get-Command
}

function Out-UTF8-NoBom {
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [AllowEmptyString()]
        [string]
        $Content,
        [Parameter(Mandatory = $true, ValueFromPipeline = $false, Position = 1)]
        [string]
        $Path
    )

    begin {
        # Good grief
        # https://github.com/PowerShell/PowerShell/issues/10278
        $dest = [IO.Path]::GetFullPath([IO.Path]::Combine((Get-Location -PSProvider FileSystem).ProviderPath, $path))
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        $writer = [System.IO.StreamWriter]::new($Path, $Utf8NoBomEncoding)
    }
    process {
        $writer.WriteLine($_)
    }
    end {
        $writer.close()
    }
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

if (-not ($Env:PATH -match "C:\\Users\\bhw\\Executables")) {
    $Env:PATH = "$Env:PATH;C:\\Users\\bhw\\Executables"
}


function procmon {
    while (1) {
        cls
        Write-Host "Name`tId`tCPU`tMemory"
        ps | `
        sort -descending -property WS | `
        select-object -first 40 -property Name,CPU,WS,Id | `
        foreach-object { Write-Host "$($_.Name)`t$($_.Id)`t$($_.CPU)`t$($_.WS / 1048576.0)"  }
        sleep 4
    }
}
pchanged


