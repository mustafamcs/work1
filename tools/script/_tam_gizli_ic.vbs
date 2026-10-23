' _tam_gizli_ic.vbs - elevated wscript icinde calisir (wscript = GUI, konsol yok)
' 90_tam_cevrim.bat'i windowStyle=0 (tamamen gizli) calistirir.
Dim fso, sh, dir
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh = CreateObject("WScript.Shell")
dir = fso.GetParentFolderName(WScript.ScriptFullName)
sh.Run "cmd /c """ & dir & "\90_tam_cevrim.bat""", 0, True
