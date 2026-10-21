' _gizli_baslat.vbs <calisma_dizini> <exe_yolu> [argumanlar...]
' Pencere acmadan arka planda surec baslatir.
Dim fso, sh, i, cmd
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")
sh.CurrentDirectory = WScript.Arguments(0)
cmd = """" & WScript.Arguments(1) & """"
For i = 2 To WScript.Arguments.Count - 1
  cmd = cmd & " """ & WScript.Arguments(i) & """"
Next
sh.Run cmd, 0, False
