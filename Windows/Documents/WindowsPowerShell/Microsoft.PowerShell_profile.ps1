del alias:curl
Set-Alias -name ll -Value Get-ChildItem
Set-Alias -name vim -Value nvim-qt
Set-Alias -name which -Value Get-Command

function Out-UTF8 {
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $Content,
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )
    # Good grief
    # https://github.com/PowerShell/PowerShell/issues/10278
    $dest = [IO.Path]::GetFullPath([IO.Path]::Combine((Get-Location -PSProvider FileSystem).ProviderPath, $path))

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($dest, $Content, $Utf8NoBomEncoding)
}

$Env:WORKING_LOCATION_FILE="$Env:USERPROFILE\.wdh.txt"
pchanged
