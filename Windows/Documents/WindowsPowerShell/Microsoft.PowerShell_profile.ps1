# Requires posh-git: https://github.com/dahlbyk/posh-git
Import-Module posh-git
# Requires PSReadLine: # https://github.com/PowerShell/PSReadLine#usage
Set-PSReadLineOption -EditMode Vi

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

function conjureRepl {
    ros run --eval '(ql:quickload :swank)' --eval '(swank:create-server :dont-close t)'
}

if (-Not (Test-Path Alias:conjure-repl)) {

    Set-Alias -name conjure-repl -Value conjureRepl
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

function find-git {
    $lookIn = get-item $PWD

    while ($lookIn) {
        $gitDir = $lookIn.GetDirectories() | `
            where-object { $_.Name -eq ".git" }

        if ($gitDir) {
            return $lookIn
        }
        $lookIn = $lookIn.Parent
    }
    return $null
}

# Prompt stuff
$GitPromptSettings.PathStatusSeparator = ""
$GitPromptSettings.DefaultPromptPrefix = ""
$GitPromptSettings.DefaultPromptSuffix = ""
$GitPromptSettings.DefaultPromptPath = ""
$GitPromptSettings.BeforePath = ""
$GitPromptSettings.AfterPath = ""
function prompt {
    $esc = [char]27
    $startBright = "${esc}[1m"
    $endBright = "${esc}[22m"
    $startUnderline = "${esc}[4m"
    $endUnderline = "${esc}[24m"
    $startRed = "${esc}[31m"
    $startGreen = "${esc}[32m"
    $startYellow = "${esc}[33m"
    $startBlue = "${esc}[34m"
    $startCyan = "${esc}[36m"
    $startMagenta = "${esc}[35m"
    $startCyan = "${esc}[36m"
    $startWhite = "${esc}[37m"
    $endColor = "${esc}[39m"
    $savedExitCode = $LASTEXITCODE

    # https://stackoverflow.com/a/19592903
    $isAdmin = ([Security.Principal.WindowsPrincipal]`
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")
    $prompt = ""

    if ($isAdmin) {
        $prompt += "$startRed(admin) "
    }
    if ($savedExitCode) {
        if ($savedExitCode -eq 0) {
            $prompt += "$startGreen"
            $prompt += "$savedExitCode"
        } else {
            $prompt += "$startRed"
            $prompt += "$startUnderline"
            $prompt += "$savedExitCode"
            $prompt += "$endUnderline"
        }
        $prompt += " "
    }

    $time = Get-Date -Format 'HH:mm:ss'

    $pathPrelude = $PWD.Path `
        -Replace '^[A-Z]:', '' `
        -Replace '([^\\/])[^\\/]*[\\/]', '$1\' `
        -Replace '[\\/][^\\/]+$', ''
    $pathSuffix = $PWD.Path -Replace '[^\\/]+[\\/]', ''

    $prompt += "$startBright"
    $prompt += "$startBlue"
    $prompt += "$time"
    $prompt += " "

    $prompt += "$($PWD.Provider.Drives.Name):"

    $prompt += "$pathPrelude\"
    $prompt += "$startMagenta"
    $prompt += "$pathSuffix"

    #if (find-git) {
    #    $prompt += "$endBright "
    #    $branch = git branch --show-current
    #    $gitInfo = git status --porcelain=v2
    #    $prompt += "$startCyan"
    #    $prompt += "$branch"
    #    if ($gitInfo) {
    #        $prompt += "$startYellow"
    #        $prompt += "*"
    #    }
    #    $prompt += "$startBright"
    #}
    $prompt += "$startBlue"
    $prompt += ">"
    $prompt += "$endColor"
    $prompt += "$endBright"

    $global:LASTEXITCODE = $savedLastExitCode
    if ($prompt) {
        return "$prompt "
    } else {
        return " "
    }
    return $prompt
}

function dotdir {
    cd "$Env:USERPROFILE\Code\skin\dotfiles"
}

pchanged
