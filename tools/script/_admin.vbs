' _admin.vbs <betik.bat> [arg...]
' Verilen betigi yonetici yetkisiyle (UAC) PENCERESIZ calistirir.
' Sadece UAC onay penceresi gorunur; cmd penceresi acilmaz.
Dim app, cmd, args, i
Set app = CreateObject("Shell.Application")
cmd = """" & WScript.Arguments(0) & """"
args = ""
For i = 1 To WScript.Arguments.Count - 1
  args = args & " """ & WScript.Arguments(i) & """"
Next
app.ShellExecute "cmd.exe", "/c " & cmd & args, "", "runas", 0
