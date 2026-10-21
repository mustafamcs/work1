' _gizli.vbs <betik.bat> [argumanlar...]
' Bir .bat betigini tamamen penceresiz calistirir.
' Cikti tools\script\log\<betik>.log dosyasina yazilir.
Dim fso, sh, dir, bat, ad, args, i
Set fso = CreateObject("Scripting.FileSystemObject")
dir = fso.GetParentFolderName(WScript.ScriptFullName)
If WScript.Arguments.Count < 1 Then
  MsgBox "Kullanim: _gizli.vbs <betik.bat> [argumanlar]", 48, "work1 script"
  WScript.Quit 1
End If
bat = WScript.Arguments(0)
ad  = fso.GetBaseName(bat)
args = ""
For i = 1 To WScript.Arguments.Count - 1
  args = args & " """ & WScript.Arguments(i) & """"
Next
If Not fso.FolderExists(dir & "\log") Then fso.CreateFolder dir & "\log"
Set sh = CreateObject("WScript.Shell")
sh.Run "cmd /c """"" & dir & "\" & bat & """" & args & " > """ & dir & "\log\" & ad & ".log"" 2>&1""", 0, False
