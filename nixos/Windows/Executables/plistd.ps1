if (Test-Path -Path "$Env:WORKING_LOCATION_FILE") {
    python3 $Env:USERPROFILE\Executables\wdh.py -p $Env:WORKING_LOCATION_FILE list
}