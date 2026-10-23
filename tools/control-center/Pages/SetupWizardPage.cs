using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Work1ControlCenter.Pages
{
    internal sealed class SetupWizardPage : BufferedPanel
    {
        private readonly BackendService backend;
        private readonly Panel stepsPanel;
        private readonly Label lblStatusSummary;

        public SetupWizardPage(BackendService backend)
        {
            this.backend = backend;
            Dock = DockStyle.Fill;
            BackColor = Theme.BgMain;
            Padding = new Padding(8, 6, 8, 6);

            var topBar = new BufferedPanel
            {
                Dock = DockStyle.Top,
                Height = 46,
                BackColor = Theme.BgCard,
                DrawCardBorder = true,
                Padding = new Padding(8, 6, 8, 6)
            };

            var btnP99 = Theme.CreateButton("★ PROFİL 99", ButtonStyle.Secondary, 120, 30);
            btnP99.Location = new Point(8, 7);
            btnP99.Click += async (s, e) => await SetProfile("60_profil_99.bat", 99);

            var btnP105 = Theme.CreateButton("★ PROFİL 105", ButtonStyle.PrimaryGold, 130, 30);
            btnP105.Location = new Point(134, 7);
            btnP105.Click += async (s, e) => await SetProfile("61_profil_105.bat", 105);

            var btnP120 = Theme.CreateButton("★ PROFİL 120", ButtonStyle.PrimaryCrimson, 130, 30);
            btnP120.Location = new Point(270, 7);
            btnP120.Click += async (s, e) => await SetProfile("62_profil_120.bat", 120);

            var btnDataFix = Theme.CreateButton("🔧 DATA KUR + DÜZELT", ButtonStyle.Secondary, 175, 30);
            btnDataFix.Location = new Point(406, 7);
            btnDataFix.Click += async (s, e) =>
            {
                await backend.RunScriptAsync("Data Kurulumu", "94_data_kur.bat");
                await backend.RunScriptAsync("Data Onarımı", "95_data_duzelt.bat");
                RefreshChecklist();
            };

            var btnCheck = Theme.CreateButton("↻ DENETLE", ButtonStyle.Secondary, 95, 30);
            btnCheck.Location = new Point(587, 7);
            btnCheck.Click += (s, e) => RefreshChecklist();

            lblStatusSummary = new Label
            {
                Text = "-",
                Font = Theme.FontBodyBold,
                ForeColor = Theme.Emerald,
                Location = new Point(690, 13),
                Size = new Size(100, 20),
                TextAlign = ContentAlignment.MiddleRight
            };

            topBar.Controls.AddRange(new Control[] { btnP99, btnP105, btnP120, btnDataFix, btnCheck, lblStatusSummary });

            stepsPanel = new BufferedPanel
            {
                Dock = DockStyle.Fill,
                BackColor = Color.Transparent,
                Padding = new Padding(0, 4, 0, 0)
            };

            Controls.Add(stepsPanel);
            Controls.Add(topBar);

            RefreshChecklist();
        }

        private async Task SetProfile(string bat, int prof)
        {
            if (MessageBox.Show("Aktif profil " + prof + " olarak değiştirilecek. Sunucu yeniden başlatılır. Devam edilsin mi?",
                "Profil Değişimi", MessageBoxButtons.YesNo, MessageBoxIcon.Question) != DialogResult.Yes) return;
            await backend.RunScriptAsync("Profil " + prof + " Etkinleştiriliyor", bat);
            RefreshChecklist();
        }

        public void RefreshChecklist()
        {
            Task.Run(() =>
            {
                var steps = backend.InspectSetupSteps();
                if (IsDisposed) return;
                BeginInvoke(new Action(() => RenderSteps(steps)));
            });
        }

        private void RenderSteps(List<SetupStepState> steps)
        {
            stepsPanel.SuspendLayout();
            stepsPanel.Controls.Clear();

            int readyCount = 0;
            int y = 4;
            int w = Math.Max(780, stepsPanel.ClientSize.Width);

            foreach (var step in steps)
            {
                if (step.IsReady) readyCount++;

                var row = new BufferedPanel
                {
                    Location = new Point(0, y),
                    Size = new Size(w, 29),
                    BackColor = Theme.BgCard,
                    DrawCardBorder = true,
                    HighlightBorder = step.IsReady
                };

                var lblDot = new Label
                {
                    Text = step.IsReady ? "✓" : "!",
                    Location = new Point(6, 4),
                    Size = new Size(20, 20),
                    TextAlign = ContentAlignment.MiddleCenter,
                    Font = Theme.FontBodyBold,
                    ForeColor = step.IsReady ? Theme.Emerald : Theme.Amber,
                    BackColor = step.IsReady ? Theme.EmeraldBg : Theme.AmberBg
                };

                var lblTitle = new Label
                {
                    Text = step.Title,
                    Font = Theme.FontBodyBold,
                    ForeColor = step.IsReady ? Theme.GoldBright : Theme.TextMain,
                    Location = new Point(32, 5),
                    Size = new Size(375, 19),
                    AutoEllipsis = true
                };

                var lblDetail = new Label
                {
                    Text = step.StatusDetail,
                    Font = Theme.FontSmall,
                    ForeColor = step.IsReady ? Theme.Emerald : Theme.Amber,
                    Location = new Point(412, 6),
                    Size = new Size(265, 18),
                    TextAlign = ContentAlignment.MiddleRight,
                    AutoEllipsis = true
                };

                string btnTxt = step.IsReady ? "YENİLE" : "KUR";

                var btnStep = Theme.CreateButton(btnTxt,
                    step.IsReady ? ButtonStyle.Secondary : ButtonStyle.PrimaryGold, 105, 23);
                btnStep.Location = new Point(w - 112, 3);
                btnStep.Font = Theme.FontButtonSm;

                string sid = step.Id;
                string stitle = step.Title;
                btnStep.Click += async (s, e) =>
                {
                    await ExecuteSingleStep(sid, stitle);
                    RefreshChecklist();
                };

                row.Controls.AddRange(new Control[] { lblDot, lblTitle, lblDetail, btnStep });
                stepsPanel.Controls.Add(row);
                y += 31;
            }

            // Alt bilgi satırı
            var infoRow = new Label
            {
                Text = "Profil değişimi: active_profile + core MAP_ALLOW güncellenir, sunucu restartlanır. Şema importu sql\\schema.sql dosyasını mysql.exe ile içe alır.",
                Font = Theme.FontSmall,
                ForeColor = Theme.TextMuted,
                Location = new Point(2, y + 4),
                Size = new Size(w, 30),
                AutoEllipsis = true
            };
            stepsPanel.Controls.Add(infoRow);

            lblStatusSummary.Text = string.Format("{0} / {1} Hazır", readyCount, steps.Count);
            stepsPanel.ResumeLayout();
        }

        private async Task InstallMariaDbAsync()
        {
            string mariaDir = Path.Combine(backend.ProjectRoot, @"tools\mariadb");
            string pass = backend.Ayar("MYSQL_PASS");
            if (string.IsNullOrEmpty(pass)) pass = Guid.NewGuid().ToString("N");

            string ps = string.Format(@"
$ErrorActionPreference = 'Stop'
$mariaDir = '{0}'
$pass = '{1}'
New-Item -ItemType Directory -Force -Path $mariaDir | Out-Null
if (-not (Test-Path ""$mariaDir\bin\mariadbd.exe"")) {{
    $zip = Join-Path $env:TEMP 'mariadb-11.4.zip'
    Write-Host 'MariaDB 11.4 indiriliyor...'
    Invoke-WebRequest 'https://archive.mariadb.org/mariadb-11.4.8/winx64-packages/mariadb-11.4.8-winx64.zip' -OutFile $zip -UseBasicParsing
    Expand-Archive $zip ""$env:TEMP\mariadb-ex"" -Force
    $inner = Get-ChildItem ""$env:TEMP\mariadb-ex"" -Directory | Select-Object -First 1
    if ($inner) {{ Get-ChildItem $inner.FullName | Move-Item -Destination $mariaDir -Force }}
    Remove-Item $zip, ""$env:TEMP\mariadb-ex"" -Recurse -Force -ErrorAction SilentlyContinue
}}
if (-not (Test-Path ""$mariaDir\data\mysql"")) {{
    if (Test-Path ""$mariaDir\data"") {{ Remove-Item ""$mariaDir\data"" -Recurse -Force -ErrorAction SilentlyContinue }}
    Write-Host 'data dizini hazirlaniyor...'
    & ""$mariaDir\bin\mariadb-install-db.exe"" --datadir=""$mariaDir\data"" --password=""$pass""
    if ($LASTEXITCODE -ne 0) {{ throw ""mariadb-install-db hatasi: $LASTEXITCODE"" }}
}}
", mariaDir.Replace("'", "''"), pass);

            await backend.RunPowerShellInlineAsync("MariaDB Portable Kuruluyor", ps);

            // _ayar.bat MARIADB_* yollarini yeni kuruluma cevir
            string ayar = backend.AyarFilePath;
            var lines = File.ReadAllLines(ayar);
            var map = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "MARIADB_EXE", Path.Combine(mariaDir, @"bin\mariadbd.exe") },
                { "MARIADB_INI", Path.Combine(mariaDir, @"data\my.ini") },
                { "MYSQLADMIN",  Path.Combine(mariaDir, @"bin\mysqladmin.exe") },
                { "MYSQL_BIN",   Path.Combine(mariaDir, @"bin\mysql.exe") }
            };
            var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            for (int i = 0; i < lines.Length; i++)
            {
                var m = System.Text.RegularExpressions.Regex.Match(lines[i], @"^set\s+""([^=]+)=");
                if (m.Success && map.ContainsKey(m.Groups[1].Value.Trim()))
                {
                    lines[i] = "set \"" + m.Groups[1].Value.Trim() + "=" + map[m.Groups[1].Value.Trim()] + "\"";
                    seen.Add(m.Groups[1].Value.Trim());
                }
            }
            var outLines = new List<string>(lines);
            foreach (var kv in map)
                if (!seen.Contains(kv.Key))
                    outLines.Add("set \"" + kv.Key + "=" + kv.Value + "\"");
            File.WriteAllLines(ayar, outLines.ToArray());
            backend.ReloadAyar();

            await backend.RunScriptAsync("MariaDB Başlatılıyor", "10_mariadb_baslat.bat");
        }

        public async Task ExecuteSingleStep(string stepId, string title)
        {
            switch (stepId)
            {
                case "mariadb":
                    {
                        string mariaExe = backend.Ayar("MARIADB_EXE");
                        if (string.IsNullOrEmpty(mariaExe) || !File.Exists(mariaExe))
                            await InstallMariaDbAsync();
                        else
                            await backend.RunScriptAsync("MariaDB Başlatılıyor", "10_mariadb_baslat.bat");
                    }
                    break;
                case "database":
                    if (!BackendService.CheckTcpPort(3306))
                        await backend.RunScriptAsync("MariaDB Başlatılıyor", "10_mariadb_baslat.bat");
                    await backend.ImportSqlFileAsync("Veritabanı Şeması İçe Alınıyor",
                        Path.Combine(backend.ProjectRoot, @"sql\schema.sql"));
                    break;
                case "serverbin":
                case "client":
                    await backend.NinjaBuildAsync();
                    break;
                case "packs":
                    await backend.RunScriptAsync("Tüm Packler Üretiliyor", "80_hepsi_repack.bat");
                    break;
                case "profile":
                    await backend.RunScriptAsync("Profil 99 Etkinleştiriliyor", "60_profil_99.bat");
                    break;
                case "deps":
                default:
                    backend.EmitLog("[i] Bu adım elle kurulum gerektirir: VS2022 BuildTools (MSBuild).", true);
                    break;
            }
        }
    }
}
