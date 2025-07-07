REM Run this from a VS2017 console
REM Which is itself run from clink
set PATH "%SystemRoot%;%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0;%SYSTEMROOT%\System32\OpenSSH\;C:\ProgramData\chocolatey\bin;C:\Program Files\Microsoft VS Code\bin;C:\Program Files\dotnet;C:\Program Files\Docker\Docker\resources\bin;C:\Program Files\OpenJDK\jdk-19.0.1\bin;C:\HashiCorp\Vagrant\bin;C:\Program Files\Git\cmd;C:\Program Files\CLPM\0.4.2\bin\"

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" amd64
"C:\Program Files (x86)\ECL\ecl.exe" %*