' _tam_gizli.vbs - 90_tam_cevrim'i YONETICI + TAMAMEN GIZLI baslatir.
' wscript.exe GUI alt sistemi oldugu icin RunAs altinda bile konsol penceresi acmaz;
' elevated wscript da cmd'yi windowStyle=0 ile calistirir. Tek gorunen sey UAC onayidir.
Dim fso, sh, dir, q
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh = CreateObject("WScript.Shell")
dir = fso.GetParentFolderName(WScript.ScriptFullName)
q = Chr(34)
If fso.FileExists(dir & "\log\90_tam_cevrim.durum") Then fso.DeleteFile dir & "\log\90_tam_cevrim.durum", True
sh.Run "powershell -NoProfile -ExecutionPolicy Bypass -Command ""Start-Process wscript.exe -Verb RunAs -ArgumentList '" & q & dir & "\_tam_gizli_ic.vbs" & q & "'""", 0, False
