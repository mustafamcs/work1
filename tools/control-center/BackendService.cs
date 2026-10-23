using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace Work1ControlCenter
{
    internal sealed class ServiceHealthSnapshot
    {
        public bool MariaDbRunning;
        public bool DbPeerOpen;
        public bool AuthOpen;
        public bool Ch1Core1Open;
        public bool Ch99Open;
        public bool ClientRunning;

        public string ServerIp = "-";
        public string ServerName = "-";
        public int ActiveProfile = 0;
        public int AccountCount = 0;
        public int CharacterCount = 0;
        public int GmCount = 0;

        public int RunningGameCoresCount
        {
            get
            {
                int c = 0;
                if (DbPeerOpen) c++;
                if (AuthOpen) c++;
                if (Ch1Core1Open) c++;
                if (Ch99Open) c++;
                return c;
            }
        }
    }

    internal sealed class PackEntryInfo
    {
        public string Name;
        public string SourceDir;
        public string EixFile;
        public string EpkFile;
        public bool Exists;
        public long SizeBytes;
        public DateTime LastModified;
    }

    internal sealed class ProcessEntryInfo
    {
        public string Role;
        public string ProcessName;
        public int Pid;
        public double MemoryMb;
        public string WorkingDir;
        public string Status;
    }

    internal sealed class SetupStepState
    {
        public string Id;
        public string Title;
        public string Description;
        public bool IsReady;
        public string StatusDetail;
    }

    internal sealed class BackendService
    {
        public string ProjectRoot { get; private set; }
        public string ScriptsDir { get { return Path.Combine(ProjectRoot, @"tools\script"); } }
        public string ServerDir { get { return Path.Combine(ProjectRoot, "server"); } }
        public string ClientDir { get { return Path.Combine(ProjectRoot, "client"); } }
        public string SrcsPackDir { get { return Path.Combine(ProjectRoot, @"Srcs\Pack"); } }
        public string AyarFilePath { get { return Path.Combine(ScriptsDir, "_ayar.bat"); } }

        public string CpuName { get; private set; }
        public int CpuCores { get; private set; }
        public int CpuThreads { get; private set; }
        public double TotalRamGb { get; private set; }
        public string HardwareSummary { get; private set; }

        private Dictionary<string, string> ayarCache;

        private readonly List<Process> activeProcesses = new List<Process>();
        private readonly object procLock = new object();

        private int dbCountCacheAgeTick = 0;
        private int cachedAcc = 0, cachedChar = 0, cachedGm = 0;
        private const int DbCountCacheMs = 8000;

        public event Action<string, bool> OnOutputLine;
        public event Action<string, bool> OnTaskStateChanged;

        public bool IsBusy
        {
            get
            {
                lock (procLock)
                {
                    foreach (var p in activeProcesses)
                        if (p != null && !p.HasExited) return true;
                    return false;
                }
            }
        }

        public BackendService()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | (SecurityProtocolType)0x3000;
            ProjectRoot = ResolveProjectRoot();
            DetectHardwareProfile();
        }

        public Dictionary<string, string> LoadAyar()
        {
            if (ayarCache != null) return ayarCache;
            var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            if (File.Exists(AyarFilePath))
            {
                foreach (var raw in File.ReadAllLines(AyarFilePath))
                {
                    var m = Regex.Match(raw.Trim(), @"^set\s+""([^=]+)=([^""]*)""", RegexOptions.IgnoreCase);
                    if (m.Success) dict[m.Groups[1].Value.Trim()] = m.Groups[2].Value.Trim();
                }
            }
            ayarCache = dict;
            return dict;
        }

        public void ReloadAyar() { ayarCache = null; }

        public string Ayar(string key, string fallback = "")
        {
            var d = LoadAyar();
            return d.ContainsKey(key) ? d[key] : fallback;
        }

        public static List<string> GetLocalAdapterIps()
        {
            var list = new List<string>();
            try
            {
                foreach (var ni in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (ni.OperationalStatus != System.Net.NetworkInformation.OperationalStatus.Up) continue;
                    if (ni.NetworkInterfaceType == System.Net.NetworkInformation.NetworkInterfaceType.Loopback) continue;
                    var props = ni.GetIPProperties();
                    foreach (var ua in props.UnicastAddresses)
                    {
                        if (ua.Address.AddressFamily == AddressFamily.InterNetwork)
                        {
                            string ip = ua.Address.ToString();
                            if (!ip.StartsWith("127.") && !ip.StartsWith("169.254."))
                                list.Add(ip);
                        }
                    }
                }
            }
            catch { }
            return list;
        }

        public static HashSet<int> GetActiveListeningPorts()
        {
            var set = new HashSet<int>();
            try
            {
                var endpoints = System.Net.NetworkInformation.IPGlobalProperties.GetIPGlobalProperties().GetActiveTcpListeners();
                for (int i = 0; i < endpoints.Length; i++)
                    set.Add(endpoints[i].Port);
            }
            catch { }
            return set;
        }

        // iphlpapi ile port->PID eslemi (netstat'siz, anlik)
        [System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)]
        private struct MIB_TCPROW_OWNER_PID
        {
            public uint state;
            public uint localAddr;
            public uint localPort;
            public uint remoteAddr;
            public uint remotePort;
            public uint owningPid;
        }

        [System.Runtime.InteropServices.DllImport("iphlpapi.dll", SetLastError = true)]
        private static extern uint GetExtendedTcpTable(IntPtr pTcpTable, ref int dwOutBufLen, bool sort, int ipVersion, int tblClass, int reserved);

        public static Dictionary<int, int> GetListeningPortPids()
        {
            var map = new Dictionary<int, int>();
            int bufLen = 0;
            if (GetExtendedTcpTable(IntPtr.Zero, ref bufLen, true, 2 /*AF_INET*/, 5 /*OWNER_PID_LISTENER*/, 0) != 122 /*INSUFFICIENT_BUFFER*/ || bufLen <= 0)
                return map;
            IntPtr buf = System.Runtime.InteropServices.Marshal.AllocHGlobal(bufLen);
            try
            {
                if (GetExtendedTcpTable(buf, ref bufLen, true, 2, 5, 0) != 0) return map;
                int num = System.Runtime.InteropServices.Marshal.ReadInt32(buf);
                int rowSize = System.Runtime.InteropServices.Marshal.SizeOf(typeof(MIB_TCPROW_OWNER_PID));
                IntPtr rowPtr = new IntPtr(buf.ToInt64() + 4);
                for (int i = 0; i < num; i++)
                {
                    var row = (MIB_TCPROW_OWNER_PID)System.Runtime.InteropServices.Marshal.PtrToStructure(rowPtr, typeof(MIB_TCPROW_OWNER_PID));
                    int port = (int)(((row.localPort & 0xFFu) << 8) | ((row.localPort >> 8) & 0xFFu));
                    if (!map.ContainsKey(port)) map[port] = (int)row.owningPid;
                    rowPtr = new IntPtr(rowPtr.ToInt64() + rowSize);
                }
            }
            finally { System.Runtime.InteropServices.Marshal.FreeHGlobal(buf); }
            return map;
        }

        private static void KillPidFast(int pid)
        {
            try
            {
                var p = Process.GetProcessById(pid);
                p.Kill();
            }
            catch { }
        }

        private void StartHidden(string exePath, string args, string workDir)
        {
            // _gizli_baslat.vbs yolu: konsol handle'lari gecerli kalir (game.exe/stdin EOF crash'i onlenir)
            string vbs = Path.Combine(ScriptsDir, "_gizli_baslat.vbs");
            if (File.Exists(vbs))
            {
                string argStr = "\"" + vbs + "\" \"" + workDir + "\" \"" + exePath + "\"";
                if (!string.IsNullOrEmpty(args)) argStr += " " + args;
                var psiVbs = new ProcessStartInfo
                {
                    FileName = "cscript.exe",
                    Arguments = "//nologo " + argStr,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };
                Process.Start(psiVbs);
                return;
            }
            var psi = new ProcessStartInfo
            {
                FileName = exePath,
                Arguments = args ?? "",
                WorkingDirectory = workDir,
                UseShellExecute = false,
                CreateNoWindow = true,
                WindowStyle = ProcessWindowStyle.Hidden
            };
            Process.Start(psi);
        }

        private bool WaitPortOpen(int port, int maxMs)
        {
            int waited = 0;
            while (waited < maxMs)
            {
                if (GetActiveListeningPorts().Contains(port)) return true;
                Thread.Sleep(100);
                waited += 100;
            }
            return false;
        }

        public Task<int> StopAllServersAsync()
        {
            return Task.Run(() =>
            {
                var sw = Stopwatch.StartNew();
                EmitLog("======================================================================", false);
                EmitLog(string.Format("[{0:HH:mm:ss}] BAŞLATILDI: Tüm Sistem Durduruluyor", DateTime.Now), false);
                var handler = OnTaskStateChanged;
                if (handler != null) handler("Tüm Sistem Durduruluyor", true);
                try
                {
                    var pids = GetListeningPortPids();
                    int[] gamePorts = { 30901, 30003, 30001, 30000 };
                    var killers = new List<Task>();
                    foreach (int port in gamePorts)
                    {
                        int pid;
                        if (pids.TryGetValue(port, out pid))
                        {
                            int pidCopy = pid;
                            killers.Add(Task.Run(() => KillPidFast(pidCopy)));
                            EmitLog("  • port " + port + " -> PID " + pid + " sonlandırılıyor", false);
                        }
                    }
                    string admin = Ayar("MYSQLADMIN");
                    if (!string.IsNullOrEmpty(admin) && File.Exists(admin) && pids.ContainsKey(3306))
                    {
                        try
                        {
                            Process.Start(new ProcessStartInfo
                            {
                                FileName = admin,
                                Arguments = "-u " + Ayar("MYSQL_USER", "root") + " -p" + Ayar("MYSQL_PASS", "") + " --protocol=tcp shutdown",
                                UseShellExecute = false,
                                CreateNoWindow = true
                            });
                        }
                        catch { }
                        EmitLog("  • mariadb nazik kapatılıyor", false);
                    }
                    foreach (var k in killers) k.Wait(2000);

                    // kapanmayanlari yakala (kisa poll)
                    int[] all = { 30000, 30001, 30003, 30901, 3306 };
                    for (int i = 0; i < 15; i++)
                    {
                        var open = GetActiveListeningPorts();
                        bool any = false;
                        foreach (int p in all) if (open.Contains(p)) { any = true; break; }
                        if (!any) break;
                        Thread.Sleep(100);
                    }
                    var leftPids = GetListeningPortPids();
                    foreach (int p in all)
                    {
                        int pid;
                        if (leftPids.TryGetValue(p, out pid)) { KillPidFast(pid); EmitLog("  • port " + p + " zorla kapatıldı", false); }
                    }
                    sw.Stop();
                    EmitLog(string.Format("[{0:HH:mm:ss}] TAMAMLANDI: Tüm Sistem Durduruluyor ({1:0.0} sn)", DateTime.Now, sw.Elapsed.TotalSeconds), false);
                    return 0;
                }
                finally
                {
                    if (handler != null) handler("Tüm Sistem Durduruluyor", false);
                }
            });
        }

        public Task<int> StartAllServersAsync(bool startClient = false)
        {
            return Task.Run(() =>
            {
                var sw = Stopwatch.StartNew();
                string title = startClient ? "Sunucu + İstemci Başlatılıyor" : "Tüm Sistem Başlatılıyor";
                EmitLog("======================================================================", false);
                EmitLog(string.Format("[{0:HH:mm:ss}] BAŞLATILDI: {1}", DateTime.Now, title), false);
                var handler = OnTaskStateChanged;
                if (handler != null) handler(title, true);
                int exitCode = 0;
                try
                {
                    // mariadb
                    if (!GetActiveListeningPorts().Contains(3306))
                    {
                        string exe = Ayar("MARIADB_EXE");
                        string ini = Ayar("MARIADB_INI");
                        if (!File.Exists(exe)) { EmitLog("[HATA] mariadbd.exe yok: " + exe, true); return 1; }
                        StartHidden(exe, "--defaults-file=\"" + ini + "\"", Path.GetDirectoryName(exe));
                        EmitLog("  • mariadb başlatılıyor...", false);
                        if (!WaitPortOpen(3306, 20000)) { EmitLog("[HATA] mariadb 3306 açamadı", true); return 1; }
                    }
                    EmitLog("  • mariadb OK", false);

                    // db
                    if (!GetActiveListeningPorts().Contains(30000))
                    {
                        string dbExe = Path.Combine(ServerDir, @"db\db.exe");
                        if (!File.Exists(dbExe)) { EmitLog("[HATA] db.exe yok", true); return 1; }
                        StartHidden(dbExe, "", Path.Combine(ServerDir, "db"));
                        EmitLog("  • db başlatılıyor...", false);
                        WaitPortOpen(30000, 15000);
                    }
                    EmitLog("  • db OK", false);

                    // auth
                    if (!GetActiveListeningPorts().Contains(30001))
                    {
                        string gExe = Path.Combine(ServerDir, @"auth\game.exe");
                        StartHidden(gExe, "", Path.Combine(ServerDir, "auth"));
                        EmitLog("  • auth başlatılıyor...", false);
                        WaitPortOpen(30001, 15000);
                    }
                    EmitLog("  • auth OK", false);

                    // ch1 core1
                    if (!GetActiveListeningPorts().Contains(30003))
                    {
                        string gExe = Path.Combine(ServerDir, @"channel1\core1\game.exe");
                        StartHidden(gExe, "", Path.Combine(ServerDir, @"channel1\core1"));
                        EmitLog("  • ch1 core1 başlatılıyor...", false);
                        WaitPortOpen(30003, 15000);
                    }
                    EmitLog("  • ch1 core1 OK", false);

                    // ch99
                    if (!GetActiveListeningPorts().Contains(30901))
                    {
                        string gExe = Path.Combine(ServerDir, @"channel99\game.exe");
                        StartHidden(gExe, "", Path.Combine(ServerDir, "channel99"));
                        EmitLog("  • ch99 başlatılıyor...", false);
                        WaitPortOpen(30901, 15000);
                    }
                    EmitLog("  • ch99 OK", false);

                    if (startClient)
                    {
                        string cli = Path.Combine(ClientDir, "metin2client.exe");
                        if (File.Exists(cli))
                        {
                            Process.Start(new ProcessStartInfo { FileName = cli, WorkingDirectory = ClientDir, UseShellExecute = true });
                            EmitLog("  • metin2client başlatıldı", false);
                        }
                    }
                    sw.Stop();
                    EmitLog(string.Format("[{0:HH:mm:ss}] TAMAMLANDI: {1} ({2:0.0} sn)", DateTime.Now, title, sw.Elapsed.TotalSeconds), false);
                    return exitCode;
                }
                finally
                {
                    if (handler != null) handler(title, false);
                }
            });
        }

        public static string FetchExternalWanIp()
        {
            string[] urls = { "https://api.ipify.org", "https://ifconfig.me/ip", "https://icanhazip.com" };
            foreach (var url in urls)
            {
                try
                {
                    var req = (HttpWebRequest)WebRequest.Create(url);
                    req.Timeout = 2500;
                    req.UserAgent = "curl/8.0";
                    using (var resp = req.GetResponse())
                    using (var sr = new StreamReader(resp.GetResponseStream()))
                    {
                        string ip = sr.ReadToEnd().Trim();
                        if (Regex.IsMatch(ip, @"^\d{1,3}(\.\d{1,3}){3}$"))
                            return ip;
                    }
                }
                catch { }
            }
            return null;
        }

        public string DetectPublicIp()
        {
            var localIps = GetLocalAdapterIps();
            string extIp = FetchExternalWanIp();
            if (!string.IsNullOrEmpty(extIp) && localIps.Contains(extIp))
                return extIp;
            if (localIps.Count > 0)
                return localIps[0];
            return "127.0.0.1";
        }

        public string ReadServerInfoIp()
        {
            try
            {
                string f = Path.Combine(SrcsPackDir, @"root\serverinfo.py");
                if (!File.Exists(f)) return null;
                var m = Regex.Match(File.ReadAllText(f, Encoding.UTF8), @"""host""\s*:\s*""([^""]+)""");
                if (m.Success) return m.Groups[1].Value;
            }
            catch { }
            return null;
        }

        public string ReadServerInfoName()
        {
            try
            {
                string f = Path.Combine(SrcsPackDir, @"root\serverinfo.py");
                if (!File.Exists(f)) return null;
                var m = Regex.Match(File.ReadAllText(f, Encoding.UTF8), @"""name""\s*:\s*TextColor\(""([^""]+)""");
                if (m.Success) return m.Groups[1].Value;
            }
            catch { }
            return null;
        }

        public void WriteServerInfoIp(string ip)
        {
            string f = Path.Combine(SrcsPackDir, @"root\serverinfo.py");
            if (!File.Exists(f)) throw new FileNotFoundException("serverinfo.py yok: " + f);
            string txt = File.ReadAllText(f, Encoding.UTF8);
            string newTxt = Regex.Replace(txt, @"""host""\s*:\s*""[^""]+""", "\"host\":\"" + ip + "\"");
            if (newTxt != txt) File.WriteAllText(f, newTxt, new UTF8Encoding(false));
        }

        public static bool StripUtf8BomIfPresent(string path)
        {
            try
            {
                if (!File.Exists(path)) return false;
                byte[] bytes = File.ReadAllBytes(path);
                if (bytes.Length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF)
                {
                    byte[] clean = new byte[bytes.Length - 3];
                    Buffer.BlockCopy(bytes, 3, clean, 0, clean.Length);
                    File.WriteAllBytes(path, clean);
                    return true;
                }
            }
            catch { }
            return false;
        }

        public void RepairAllBomFiles()
        {
            try
            {
                string[] coreDirs = { "db", "auth", @"channel1\core1", "channel99" };
                string[] names = { "CONFIG", "conf.txt", "CMD", "VERSION", "syserr.txt" };
                foreach (var rel in coreDirs)
                {
                    string d = Path.Combine(ServerDir, rel);
                    if (!Directory.Exists(d)) continue;
                    foreach (var n in names)
                        StripUtf8BomIfPresent(Path.Combine(d, n));
                }
                StripUtf8BomIfPresent(Path.Combine(ClientDir, "locale.cfg"));
                StripUtf8BomIfPresent(Path.Combine(ClientDir, "loca.cfg"));
                StripUtf8BomIfPresent(Path.Combine(ClientDir, "locale_list.txt"));
                StripUtf8BomIfPresent(Path.Combine(ClientDir, "channel.inf"));
                StripUtf8BomIfPresent(Path.Combine(ProjectRoot, "active_profile"));
                StripUtf8BomIfPresent(AyarFilePath);
            }
            catch { }
        }

        private void DetectHardwareProfile()
        {
            CpuThreads = Math.Max(1, Environment.ProcessorCount);
            CpuCores = Math.Max(1, CpuThreads / 2);
            CpuName = "Multi-Core CPU";
            TotalRamGb = 16.0;
            try
            {
                using (var reg = Microsoft.Win32.Registry.LocalMachine.OpenSubKey(@"HARDWARE\DESCRIPTION\System\CentralProcessor\0"))
                {
                    if (reg != null)
                    {
                        var nameObj = reg.GetValue("ProcessorNameString");
                        if (nameObj != null) CpuName = nameObj.ToString().Trim();
                    }
                }
                var memStatus = new MEMORYSTATUSEX();
                if (GlobalMemoryStatusEx(memStatus))
                    TotalRamGb = Math.Round(memStatus.ullTotalPhys / (1024.0 * 1024.0 * 1024.0), 1);
            }
            catch { }
            HardwareSummary = string.Format("{0} ({1}C/{2}T • {3:0.0} GB RAM)", CpuName, CpuCores, CpuThreads, TotalRamGb);
        }

        [System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential, CharSet = System.Runtime.InteropServices.CharSet.Auto)]
        private class MEMORYSTATUSEX
        {
            public uint dwLength = (uint)System.Runtime.InteropServices.Marshal.SizeOf(typeof(MEMORYSTATUSEX));
            public uint dwMemoryLoad;
            public ulong ullTotalPhys;
            public ulong ullAvailPhys;
            public ulong ullTotalPageFile;
            public ulong ullAvailPageFile;
            public ulong ullTotalVirtual;
            public ulong ullAvailVirtual;
            public ulong ullAvailExtendedVirtual;
        }

        [System.Runtime.InteropServices.DllImport("kernel32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto, SetLastError = true)]
        private static extern bool GlobalMemoryStatusEx([System.Runtime.InteropServices.In, System.Runtime.InteropServices.Out] MEMORYSTATUSEX lpBuffer);

        private static string ResolveProjectRoot()
        {
            string baseDir = AppDomain.CurrentDomain.BaseDirectory;
            DirectoryInfo dir = new DirectoryInfo(baseDir);
            while (dir != null)
            {
                if (File.Exists(Path.Combine(dir.FullName, @"tools\script\_ayar.bat")))
                    return dir.FullName;
                dir = dir.Parent;
            }
            string cwd = Directory.GetCurrentDirectory();
            if (File.Exists(Path.Combine(cwd, @"tools\script\_ayar.bat")))
                return cwd;
            return baseDir.TrimEnd('\\', '/');
        }

        public static bool IsAdministrator()
        {
            try
            {
                var identity = WindowsIdentity.GetCurrent();
                var principal = new WindowsPrincipal(identity);
                return principal.IsInRole(WindowsBuiltInRole.Administrator);
            }
            catch { return false; }
        }

        public static bool CheckTcpPort(int port, int timeoutMs = 250)
        {
            return GetActiveListeningPorts().Contains(port);
        }

        public string FindMysqlExe()
        {
            string p = Ayar("MYSQL_BIN");
            if (!string.IsNullOrEmpty(p) && File.Exists(p)) return p;
            string mariaBin = Path.Combine(Path.GetDirectoryName(Ayar("MARIADB_EXE", @"x:\nonexist")) ?? "", "mysql.exe");
            if (File.Exists(mariaBin)) return mariaBin;
            string progFiles = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles);
            if (Directory.Exists(progFiles))
            {
                try
                {
                    foreach (var d in Directory.GetDirectories(progFiles, "MariaDB*"))
                    {
                        string c = Path.Combine(d, "bin", "mysql.exe");
                        if (File.Exists(c)) return c;
                    }
                }
                catch { }
            }
            return null;
        }

        public string RunSqlQuery(string sql, string database, out string error)
        {
            error = null;
            string mysqlExe = FindMysqlExe();
            if (string.IsNullOrEmpty(mysqlExe))
            {
                error = "mysql.exe bulunamadı (_ayar.bat MYSQL_BIN).";
                return "";
            }
            string user = Ayar("MYSQL_USER", "root");
            string pass = Ayar("MYSQL_PASS", "");

            var args = new StringBuilder();
            args.Append("--host=127.0.0.1 --port=3306 --batch --raw --default-character-set=utf8mb4 ");
            args.AppendFormat("--user={0} ", user);
            if (!string.IsNullOrEmpty(database))
                args.AppendFormat("\"{0}\" ", database);
            args.AppendFormat("-e \"{0}\"", sql.Replace("\"", "\\\""));

            try
            {
                var psi = new ProcessStartInfo
                {
                    FileName = mysqlExe,
                    Arguments = args.ToString(),
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    CreateNoWindow = true,
                    StandardOutputEncoding = Encoding.UTF8,
                    StandardErrorEncoding = Encoding.UTF8
                };
                psi.EnvironmentVariables["MYSQL_PWD"] = pass;
                using (var proc = Process.Start(psi))
                {
                    string stdout = proc.StandardOutput.ReadToEnd();
                    string stderr = proc.StandardError.ReadToEnd();
                    proc.WaitForExit(8000);
                    if (proc.ExitCode != 0)
                        error = string.IsNullOrWhiteSpace(stderr) ? ("SQL çıkış kodu: " + proc.ExitCode) : stderr.Trim();
                    return stdout;
                }
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return "";
            }
        }

        public Task<int> ImportSqlFileAsync(string title, string sqlFilePath)
        {
            string mysqlExe = FindMysqlExe();
            if (string.IsNullOrEmpty(mysqlExe))
            {
                EmitLog("[HATA] mysql.exe bulunamadı.", true);
                return Task.FromResult(-1);
            }
            string bat = Path.Combine(Path.GetTempPath(), "work1_sql_" + Guid.NewGuid().ToString("N") + ".bat");
            File.WriteAllText(bat, string.Format(
                "@echo off\r\nset \"MYSQL_PWD={0}\"\r\n\"{1}\" --host=127.0.0.1 --port=3306 --user={2} --default-character-set=utf8mb4 < \"{3}\"\r\nexit /b %errorlevel%\r\n",
                Ayar("MYSQL_PASS", ""), mysqlExe, Ayar("MYSQL_USER", "root"), sqlFilePath), Encoding.ASCII);
            return RunProcessAsync(title, "cmd.exe", "/c \"" + bat + "\"", ProjectRoot, () => { try { File.Delete(bat); } catch { } });
        }

        public int GetActiveProfile()
        {
            try
            {
                string f = Path.Combine(ProjectRoot, "active_profile");
                if (File.Exists(f))
                {
                    int v;
                    if (int.TryParse(File.ReadAllText(f).Trim(), out v)) return v;
                }
            }
            catch { }
            return 0;
        }

        public ServiceHealthSnapshot GetHealthSnapshot()
        {
            var snap = new ServiceHealthSnapshot();
            snap.ActiveProfile = GetActiveProfile();
            string ip = ReadServerInfoIp();
            if (!string.IsNullOrEmpty(ip)) snap.ServerIp = ip;
            string name = ReadServerInfoName();
            if (!string.IsNullOrEmpty(name)) snap.ServerName = name;

            var listening = GetActiveListeningPorts();
            snap.MariaDbRunning = listening.Contains(3306);
            snap.DbPeerOpen     = listening.Contains(30000);
            snap.AuthOpen       = listening.Contains(30001);
            snap.Ch1Core1Open   = listening.Contains(30003);
            snap.Ch99Open       = listening.Contains(30901);

            try { snap.ClientRunning = Process.GetProcessesByName("metin2client").Length > 0; } catch { }

            if (snap.MariaDbRunning)
            {
                bool stale = (Environment.TickCount - dbCountCacheAgeTick) > DbCountCacheMs;
                if (stale)
                {
                    string err;
                    string q = "SELECT " +
                               "(SELECT COUNT(*) FROM account.account) AS accs, " +
                               "(SELECT COUNT(*) FROM player.player) AS chars, " +
                               "(SELECT COUNT(*) FROM common.gmlist) AS gms;";
                    string res = RunSqlQuery(q, null, out err);
                    if (string.IsNullOrEmpty(err) && !string.IsNullOrWhiteSpace(res))
                    {
                        var lines = res.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                        if (lines.Length >= 2)
                        {
                            var cols = lines[1].Split('\t');
                            if (cols.Length >= 3)
                            {
                                int.TryParse(cols[0], out cachedAcc);
                                int.TryParse(cols[1], out cachedChar);
                                int.TryParse(cols[2], out cachedGm);
                                dbCountCacheAgeTick = Environment.TickCount;
                            }
                        }
                    }
                }
                snap.AccountCount = cachedAcc;
                snap.CharacterCount = cachedChar;
                snap.GmCount = cachedGm;
            }
            else
            {
                dbCountCacheAgeTick = 0;
                cachedAcc = cachedChar = cachedGm = 0;
            }
            return snap;
        }

        private static string RoleFromPath(string modulePath)
        {
            if (string.IsNullOrEmpty(modulePath)) return null;
            string p = modulePath.Replace('/', '\\');
            if (p.IndexOf(@"\server\db\", StringComparison.OrdinalIgnoreCase) >= 0) return "db";
            if (p.IndexOf(@"\server\auth\", StringComparison.OrdinalIgnoreCase) >= 0) return "auth";
            if (p.IndexOf(@"\server\channel1\", StringComparison.OrdinalIgnoreCase) >= 0) return "ch1-core1";
            if (p.IndexOf(@"\server\channel99\", StringComparison.OrdinalIgnoreCase) >= 0) return "ch99";
            if (p.IndexOf(@"\client\", StringComparison.OrdinalIgnoreCase) >= 0) return "istemci";
            return null;
        }

        public List<ProcessEntryInfo> GetManagedProcesses()
        {
            var list = new List<ProcessEntryInfo>();
            string[] names = { "mariadbd", "db", "game", "metin2client", "qc" };
            var seen = new HashSet<int>();
            foreach (var pName in names)
            {
                Process[] procs;
                try { procs = Process.GetProcessesByName(pName); }
                catch { continue; }
                foreach (var p in procs)
                {
                    if (seen.Contains(p.Id)) continue;
                    seen.Add(p.Id);
                    string role = pName;
                    string workDir = "-";
                    try
                    {
                        string mod = p.MainModule.FileName;
                        workDir = Path.GetDirectoryName(mod);
                        string r = RoleFromPath(mod);
                        if (r != null) role = r;
                    }
                    catch { }
                    double mb = 0;
                    try { mb = Math.Round(p.WorkingSet64 / 1048576.0, 1); } catch { }
                    list.Add(new ProcessEntryInfo
                    {
                        Role = role,
                        ProcessName = p.ProcessName + ".exe",
                        Pid = p.Id,
                        MemoryMb = mb,
                        WorkingDir = workDir,
                        Status = "Çalışıyor"
                    });
                }
            }
            return list.OrderBy(x => x.Role).ToList();
        }

        public List<SetupStepState> InspectSetupSteps()
        {
            var steps = new List<SetupStepState>();

            string msbuild = Ayar("MSBUILD");
            bool hasMsbuild = !string.IsNullOrEmpty(msbuild) && File.Exists(msbuild);
            steps.Add(new SetupStepState
            {
                Id = "deps",
                Title = "1. Derleme Araçları (VS2022 MSBuild)",
                Description = "MSBuild.exe yolu _ayar.bat üzerinden doğrulanır",
                IsReady = hasMsbuild,
                StatusDetail = hasMsbuild ? "MSBuild Hazır" : "MSBuild Bulunamadı"
            });

            string mariaExe = Ayar("MARIADB_EXE");
            bool mariaInstalled = !string.IsNullOrEmpty(mariaExe) && File.Exists(mariaExe);
            bool mariaPort = CheckTcpPort(3306, 150);
            steps.Add(new SetupStepState
            {
                Id = "mariadb",
                Title = "2. MariaDB (3306)",
                Description = "MariaDB süreci ve 3306 portu",
                IsReady = mariaInstalled && mariaPort,
                StatusDetail = mariaPort ? "Çalışıyor" : (mariaInstalled ? "Kurulu (Kapalı)" : "mariadbd.exe Yok")
            });

            bool dbReady = false;
            if (mariaPort)
            {
                string err;
                string res = RunSqlQuery("SHOW DATABASES LIKE 'player';", null, out err);
                dbReady = string.IsNullOrEmpty(err) && res.Contains("player");
            }
            steps.Add(new SetupStepState
            {
                Id = "database",
                Title = "3. Veritabanı Şemaları (schema.sql)",
                Description = "account, player, common, log, hotbackup şemaları",
                IsReady = dbReady,
                StatusDetail = dbReady ? "Şemalar Hazır" : (mariaPort ? "İçe Aktarım Gerekli" : "MariaDB Kapalı")
            });

            bool hasDbExe = File.Exists(Path.Combine(ServerDir, @"db\db.exe"));
            bool hasGameExe = File.Exists(Path.Combine(ServerDir, @"channel1\core1\game.exe"));
            steps.Add(new SetupStepState
            {
                Id = "serverbin",
                Title = "4. Sunucu Binary'leri (db.exe / game.exe)",
                Description = "server\\db ve server\\channel1\\core1 altında derlenmiş binary'ler",
                IsReady = hasDbExe && hasGameExe,
                StatusDetail = string.Format("db.exe:{0} | game.exe:{1}", hasDbExe ? "OK" : "Yok", hasGameExe ? "OK" : "Yok")
            });

            bool hasClient = File.Exists(Path.Combine(ClientDir, "metin2client.exe"));
            steps.Add(new SetupStepState
            {
                Id = "client",
                Title = "5. İstemci (metin2client.exe)",
                Description = "client dizininde çalıştırılabilir istemci",
                IsReady = hasClient,
                StatusDetail = hasClient ? "İstemci Hazır" : "Derleme Gerekli (44_build_client)"
            });

            var packs = GetPackEntries();
            int packReady = packs.Count(p => p.Exists);
            steps.Add(new SetupStepState
            {
                Id = "packs",
                Title = "6. Pack Dosyaları (eix/epk)",
                Description = "Srcs\\Pack klasörleri client\\pack içine paketlenmiş olmalı",
                IsReady = packs.Count > 0 && packReady == packs.Count,
                StatusDetail = string.Format("{0}/{1} pack hazır", packReady, packs.Count)
            });

            int prof = GetActiveProfile();
            steps.Add(new SetupStepState
            {
                Id = "profile",
                Title = "7. Aktif Profil (active_profile)",
                Description = "99 / 105 / 120 profil dosyası geçerli bir değer içermeli",
                IsReady = prof == 99 || prof == 105 || prof == 120,
                StatusDetail = prof > 0 ? ("Aktif: " + prof) : "Geçersiz"
            });

            return steps;
        }

        public List<PackEntryInfo> GetPackEntries()
        {
            var result = new List<PackEntryInfo>();
            string packOut = Path.Combine(ClientDir, "pack");
            if (!Directory.Exists(SrcsPackDir)) return result;
            foreach (var d in Directory.GetDirectories(SrcsPackDir).OrderBy(x => x))
            {
                string name = Path.GetFileName(d);
                string eix = Path.Combine(packOut, name + ".eix");
                string epk = Path.Combine(packOut, name + ".epk");
                bool eixE = File.Exists(eix), epkE = File.Exists(epk);
                long size = 0;
                DateTime mod = DateTime.MinValue;
                if (eixE) { var fi = new FileInfo(eix); size += fi.Length; if (fi.LastWriteTime > mod) mod = fi.LastWriteTime; }
                if (epkE) { var fi = new FileInfo(epk); size += fi.Length; if (fi.LastWriteTime > mod) mod = fi.LastWriteTime; }
                result.Add(new PackEntryInfo
                {
                    Name = name,
                    SourceDir = d,
                    EixFile = eix,
                    EpkFile = epk,
                    Exists = eixE && epkE,
                    SizeBytes = size,
                    LastModified = mod
                });
            }
            return result;
        }

        public void EmitLog(string text, bool isError = false)
        {
            var handler = OnOutputLine;
            if (handler != null) handler(text, isError);
        }

        public void StopActiveCommand()
        {
            Process[] snapshot;
            lock (procLock) { snapshot = activeProcesses.ToArray(); }
            bool any = false;
            foreach (var p in snapshot)
            {
                if (p == null) continue;
                try
                {
                    if (!p.HasExited)
                    {
                        any = true;
                        Process.Start(new ProcessStartInfo
                        {
                            FileName = "taskkill.exe",
                            Arguments = "/F /T /PID " + p.Id,
                            CreateNoWindow = true,
                            UseShellExecute = false
                        }).WaitForExit(3000);
                    }
                }
                catch { }
            }
            if (any) EmitLog("[!] Çalışan işlemler kullanıcı tarafından durduruldu.", true);
        }

        public Task<int> RunScriptAsync(string taskTitle, string batFileName, string arguments = "")
        {
            string scriptPath = Path.Combine(ScriptsDir, batFileName);
            if (!File.Exists(scriptPath))
            {
                EmitLog("[HATA] Betik bulunamadı: " + scriptPath, true);
                return Task.FromResult(-1);
            }
            return RunProcessAsync(taskTitle, "cmd.exe",
                "/c \"\"" + scriptPath + "\" " + arguments + "\"", ScriptsDir);
        }

        public Task<int> RunPowerShellInlineAsync(string taskTitle, string psCommand)
        {
            string tempScript = Path.Combine(Path.GetTempPath(), "work1_task_" + Guid.NewGuid().ToString("N") + ".ps1");
            string header = "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8\r\n$OutputEncoding = [System.Text.Encoding]::UTF8\r\n$ErrorActionPreference = 'Stop'\r\n";
            File.WriteAllText(tempScript, header + psCommand, new UTF8Encoding(true));
            string psArgs = string.Format("-NoProfile -NonInteractive -ExecutionPolicy Bypass -File \"{0}\"", tempScript);
            return RunProcessAsync(taskTitle, "powershell.exe", psArgs, ProjectRoot, () =>
            {
                try { File.Delete(tempScript); } catch { }
            });
        }

        public Task<int> RunProcessAsync(string taskTitle, string fileName, string arguments, string workingDir = null, Action cleanup = null)
        {
            return Task.Run(() =>
            {
                var stateHandler = OnTaskStateChanged;
                if (stateHandler != null) stateHandler(taskTitle, true);

                var sw = Stopwatch.StartNew();
                EmitLog("======================================================================", false);
                EmitLog(string.Format("[{0:HH:mm:ss}] BAŞLATILDI: {1}", DateTime.Now, taskTitle), false);
                EmitLog("----------------------------------------------------------------------", false);

                int exitCode = -1;
                try
                {
                    var psi = new ProcessStartInfo
                    {
                        FileName = fileName,
                        Arguments = arguments,
                        WorkingDirectory = string.IsNullOrEmpty(workingDir) ? ProjectRoot : workingDir,
                        UseShellExecute = false,
                        RedirectStandardInput = true,
                        RedirectStandardOutput = true,
                        RedirectStandardError = true,
                        CreateNoWindow = true,
                        StandardOutputEncoding = Encoding.UTF8,
                        StandardErrorEncoding = Encoding.UTF8
                    };

                    var proc = new Process { StartInfo = psi, EnableRaisingEvents = true };
                    proc.OutputDataReceived += (s, e) => { if (e.Data != null) EmitLog(e.Data, false); };
                    proc.ErrorDataReceived += (s, e) => { if (e.Data != null) EmitLog(e.Data, true); };

                    lock (procLock) { activeProcesses.Add(proc); }
                    proc.Start();
                    try { proc.StandardInput.Close(); } catch { }
                    proc.BeginOutputReadLine();
                    proc.BeginErrorReadLine();
                    proc.WaitForExit();
                    exitCode = proc.ExitCode;
                }
                catch (Exception ex)
                {
                    EmitLog("[HATA] " + ex.Message, true);
                }
                finally
                {
                    bool stillRunning;
                    lock (procLock) { activeProcesses.RemoveAll(p => p == null || p.HasExited); stillRunning = activeProcesses.Count > 0; }
                    if (cleanup != null) cleanup();
                    sw.Stop();
                    if (exitCode == 0)
                        EmitLog(string.Format("[{0:HH:mm:ss}] TAMAMLANDI: {1} ({2:0.0} sn)", DateTime.Now, taskTitle, sw.Elapsed.TotalSeconds), false);
                    else
                        EmitLog(string.Format("[{0:HH:mm:ss}] SONUÇLANDI (Kod: {1}): {2} ({3:0.0} sn)", DateTime.Now, exitCode, taskTitle, sw.Elapsed.TotalSeconds), true);

                    if (stateHandler != null) stateHandler(taskTitle, stillRunning);
                }
                return exitCode;
            });
        }
    }
}
