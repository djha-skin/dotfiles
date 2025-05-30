REM https://stackoverflow.com/a/53478810/850326
REM VBScript can run a batch file in a hidden window
REM So this script should be used in the Task Scheduler
command = "cmd.exe /C ""C:\Users\bhw\Executables\sync-mail.bat"""
set shell = CreateObject("WScript.Shell")
shell.Run command,0