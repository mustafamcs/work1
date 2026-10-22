' _admin.vbs <betik.bat> [arg...]
' Verilen betigi yonetici yetkisiyle (UAC) PENCERESIZ calistirir.
' Shell.Application ShellExecute bu oturumda sessizce dustugu icin
' powershell Start-Process -Verb RunAs kullanir.
' Not: cmd /c icin tum komut ekstra tirnak icine alinir, aksi halde
' "bat" "arg" ayrismasi bozulur. Cikti log\<betik>.log'a yazilir.
Dim fso, sh, dir, q, ps, i, ts, ad
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh = CreateObject("WScript.Shell")
dir = fso.GetParentFolderName(WScript.ScriptFullName)
If Not fso.FolderExists(dir & "\log") Then fso.CreateFolder dir & "\log"
q = Chr(34)
ad = fso.GetBaseName(WScript.Arguments(0))
ps = "Start-Process -FilePath cmd.exe -Verb RunAs -WindowStyle Hidden -ArgumentList '/c " & q & q & WScript.Arguments(0) & q
For i = 1 To WScript.Arguments.Count - 1
  ps = ps & " " & q & WScript.Arguments(i) & q
Next
ps = ps & " > " & q & dir & "\log\" & ad & ".log" & q & " 2>&1" & q & "'" & vbCrLf
Set ts = fso.CreateTextFile(dir & "\log\_elev.ps1", True)
ts.Write ps
ts.Close
sh.Run "powershell -NoProfile -ExecutionPolicy Bypass -File " & q & dir & "\log\_elev.ps1" & q, 0, True
