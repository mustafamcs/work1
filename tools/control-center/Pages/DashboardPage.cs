using System;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace Work1ControlCenter.Pages
{
    internal sealed class DashboardPage : BufferedPanel
    {
        private readonly BackendService backend;
        private readonly Action<int> navigateToPage;

        private readonly MiniServicePill pillMaria;
        private readonly MiniServicePill pillDbPeer;
        private readonly MiniServicePill pillAuth;
        private readonly MiniServicePill pillCh1C1;
        private readonly MiniServicePill pillCh99;
        private readonly MiniServicePill pillClient;

        private readonly Label lblInfoLine;

        public DashboardPage(BackendService backend, Action<int> navigateToPage)
        {
            this.backend = backend;
            this.navigateToPage = navigateToPage;
            Dock = DockStyle.Fill;
            BackColor = Theme.BgMain;
            Padding = new Padding(8, 6, 8, 6);

            // 1. Compact Status Strip Card
            var statusCard = new BufferedPanel
            {
                Dock = DockStyle.Top,
                Height = 86,
                BackColor = Theme.BgCard,
                DrawCardBorder = true,
                Padding = new Padding(8, 5, 8, 5)
            };

            lblInfoLine = new Label
            {
                Text = "CANLI SERVİSLER  •  Kontrol ediliyor...",
                Font = Theme.FontCardTitle,
                ForeColor = Theme.GoldBright,
                Location = new Point(8, 5),
                Size = new Size(780, 18),
                UseMnemonic = false
            };

            var pillFlow = new FlowLayoutPanel
            {
                Location = new Point(6, 25),
                Size = new Size(784, 56),
                BackColor = Color.Transparent,
                WrapContents = true
            };

            pillMaria    = new MiniServicePill("MariaDB (3306)");
            pillDbPeer   = new MiniServicePill("DB (30000)");
            pillAuth     = new MiniServicePill("Auth (30001)");
            pillCh1C1    = new MiniServicePill("CH1 Core1 (30003)");
            pillCh99     = new MiniServicePill("CH99 (30901)");
            pillClient   = new MiniServicePill("İstemci");

            pillFlow.Controls.AddRange(new Control[]
            {
                pillMaria, pillDbPeer, pillAuth, pillCh1C1, pillCh99, pillClient
            });
            statusCard.Controls.AddRange(new Control[] { lblInfoLine, pillFlow });

            // 2. Three Compact Action Columns
            var midTable = new TableLayoutPanel
            {
                Dock = DockStyle.Top,
                Height = 162,
                ColumnCount = 3,
                RowCount = 1,
                BackColor = Color.Transparent,
                Padding = new Padding(0, 6, 0, 6)
            };
            midTable.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 33.33F));
            midTable.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 33.33F));
            midTable.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 33.34F));

            // Col 1: Oyun Sunucusu
            var colGame = CreateGroupCard("🛡 OYUN SUNUCUSU", new Padding(0, 0, 4, 0));
            var btnGameStart = Theme.CreateButton("▶ SUNUCUYU BAŞLAT", ButtonStyle.Success, 240, 30);
            btnGameStart.Location = new Point(10, 28);
            btnGameStart.Click += async (s, e) => await backend.StartAllServersAsync(false);

            var btnGameRestart = Theme.CreateButton("↻ RESTART", ButtonStyle.PrimaryCrimson, 117, 28);
            btnGameRestart.Location = new Point(10, 62);
            btnGameRestart.Click += async (s, e) =>
            {
                await backend.StopAllServersAsync();
                await backend.StartAllServersAsync(false);
            };

            var btnGameStop = Theme.CreateButton("■ DURDUR", ButtonStyle.Danger, 117, 28);
            btnGameStop.Location = new Point(133, 62);
            btnGameStop.Click += async (s, e) => await backend.StopAllServersAsync();

            var btnStatus = Theme.CreateButton("◈ DURUM", ButtonStyle.Secondary, 117, 28);
            btnStatus.Location = new Point(10, 94);
            btnStatus.Click += (s, e) =>
            {
                var snap = backend.GetHealthSnapshot();
                backend.EmitLog(string.Format("== DURUM == profil:{0}  mariadb:{1}  db:{2}  auth:{3}  core1:{4}  ch99:{5}  istemci:{6}",
                    snap.ActiveProfile,
                    snap.MariaDbRunning ? "AÇIK" : "KAPALI",
                    snap.DbPeerOpen ? "AÇIK" : "KAPALI",
                    snap.AuthOpen ? "AÇIK" : "KAPALI",
                    snap.Ch1Core1Open ? "AÇIK" : "KAPALI",
                    snap.Ch99Open ? "AÇIK" : "KAPALI",
                    snap.ClientRunning ? "AÇIK" : "KAPALI"), false);
            };

            var btnCh99 = Theme.CreateButton("☁ CH99", ButtonStyle.Secondary, 117, 28);
            btnCh99.Location = new Point(133, 94);
            btnCh99.Click += async (s, e) => await backend.RunScriptAsync("CH99 Yeniden Başlatılıyor", "26_ch99_baslat.bat");

            colGame.Controls.AddRange(new Control[] { btnGameStart, btnGameRestart, btnGameStop, btnStatus, btnCh99 });

            // Col 2: MariaDB & Tekil Servisler
            var colStack = CreateGroupCard("🌐 MARIADB & SERVİSLER", new Padding(2, 0, 2, 0));
            var btnMariaStart = Theme.CreateButton("▶ MARIADB BAŞLAT", ButtonStyle.PrimaryGold, 240, 30);
            btnMariaStart.Location = new Point(10, 28);
            btnMariaStart.Click += async (s, e) => await backend.RunScriptAsync("MariaDB Başlatılıyor", "10_mariadb_baslat.bat");

            var btnMariaStop = Theme.CreateButton("■ MARIADB DURDUR", ButtonStyle.Danger, 117, 28);
            btnMariaStop.Location = new Point(10, 62);
            btnMariaStop.Click += async (s, e) => await backend.RunScriptAsync("MariaDB Durduruluyor", "11_mariadb_durdur.bat");

            var btnDbStart = Theme.CreateButton("DB", ButtonStyle.Secondary, 56, 28);
            btnDbStart.Location = new Point(133, 62);
            btnDbStart.Font = Theme.FontButtonSm;
            btnDbStart.Click += async (s, e) => await backend.RunScriptAsync("DB Başlatılıyor", "20_db_baslat.bat");

            var btnAuthStart = Theme.CreateButton("AUTH", ButtonStyle.Secondary, 56, 28);
            btnAuthStart.Location = new Point(194, 62);
            btnAuthStart.Font = Theme.FontButtonSm;
            btnAuthStart.Click += async (s, e) => await backend.RunScriptAsync("Auth Başlatılıyor", "22_auth_baslat.bat");

            var btnCore = Theme.CreateButton("CORE1", ButtonStyle.Secondary, 117, 28);
            btnCore.Location = new Point(10, 94);
            btnCore.Font = Theme.FontButtonSm;
            btnCore.Click += async (s, e) => await backend.RunScriptAsync("CH1 Core1 Başlatılıyor", "24_core_baslat.bat");

            var btnFlush = Theme.CreateButton("♥ DATA DÜZELT", ButtonStyle.Secondary, 117, 28);
            btnFlush.Location = new Point(133, 94);
            btnFlush.Font = Theme.FontButtonSm;
            btnFlush.Click += async (s, e) => await backend.RunScriptAsync("Data Onarımı", "95_data_duzelt.bat");

            colStack.Controls.AddRange(new Control[] { btnMariaStart, btnMariaStop, btnDbStart, btnAuthStart, btnCore, btnFlush });

            // Col 3: İstemci & Araçlar
            var colClient = CreateGroupCard("⚔ OYUN & ARAÇLAR", new Padding(4, 0, 0, 0));
            var btnPlay = Theme.CreateButton("⚔ OYUNU BAŞLAT (metin2client)", ButtonStyle.PrimaryCrimson, 240, 30);
            btnPlay.Location = new Point(10, 28);
            btnPlay.Click += (s, e) => LaunchExe(@"client\metin2client.exe", @"client");

            var btnPlaySrv = Theme.CreateButton("⚔ SUNUCU+İSTEMCİ", ButtonStyle.Secondary, 117, 28);
            btnPlaySrv.Location = new Point(10, 62);
            btnPlaySrv.Font = Theme.FontButtonSm;
            btnPlaySrv.Click += async (s, e) => await backend.StartAllServersAsync(true);

            var btnCfgExe = Theme.CreateButton("⚙ AYARLAR", ButtonStyle.Secondary, 117, 28);
            btnCfgExe.Location = new Point(133, 62);
            btnCfgExe.Click += (s, e) => LaunchExe(@"client\config.exe", @"client");

            var btnPacksDir = Theme.CreateButton("📦 PACKLER", ButtonStyle.Secondary, 117, 28);
            btnPacksDir.Location = new Point(10, 94);
            btnPacksDir.Font = Theme.FontButtonSm;
            btnPacksDir.Click += (s, e) => { try { Process.Start("explorer.exe", Path.Combine(backend.ProjectRoot, @"client\pack")); } catch { } };

            var btnFolder = Theme.CreateButton("📁 KLASÖR", ButtonStyle.Secondary, 117, 28);
            btnFolder.Location = new Point(133, 94);
            btnFolder.Click += (s, e) => { try { Process.Start("explorer.exe", backend.ProjectRoot); } catch { } };

            colClient.Controls.AddRange(new Control[] { btnPlay, btnPlaySrv, btnCfgExe, btnPacksDir, btnFolder });

            midTable.Controls.Add(colGame, 0, 0);
            midTable.Controls.Add(colStack, 1, 0);
            midTable.Controls.Add(colClient, 2, 0);

            // 3. Bottom Master Bar
            var bottomBar = new BufferedPanel
            {
                Dock = DockStyle.Fill,
                BackColor = Theme.BgCard,
                DrawCardBorder = true,
                Padding = new Padding(8, 5, 8, 5)
            };

            var btnFullCycle = Theme.CreateButton("★ TAM ÇEVRİM: KAPAT+TEMİZLE+DERLE+AÇ", ButtonStyle.PrimaryCrimson, 330, 32);
            btnFullCycle.Location = new Point(8, 6);
            btnFullCycle.Click += async (s, e) => await backend.FullCycleAsync(true);

            var btnAllStart = Theme.CreateButton("▶ BAŞLAT", ButtonStyle.Success, 150, 32);
            btnAllStart.Location = new Point(346, 6);
            btnAllStart.Click += async (s, e) => await backend.StartAllServersAsync(false);

            var btnAllStop = Theme.CreateButton("■ DURDUR", ButtonStyle.Danger, 150, 32);
            btnAllStop.Location = new Point(504, 6);
            btnAllStop.Click += async (s, e) => await backend.KillEverythingAsync();

            var btnGoSetup = Theme.CreateButton("★ SİSTEM", ButtonStyle.PrimaryGold, 120, 32);
            btnGoSetup.Location = new Point(662, 6);
            btnGoSetup.Click += (s, e) => this.navigateToPage(2);

            bottomBar.Controls.AddRange(new Control[] { btnFullCycle, btnAllStart, btnAllStop, btnGoSetup });

            Controls.Add(bottomBar);
            Controls.Add(midTable);
            Controls.Add(statusCard);
        }

        private static BufferedPanel CreateGroupCard(string title, Padding margin)
        {
            var card = new BufferedPanel
            {
                Dock = DockStyle.Fill,
                Margin = margin,
                BackColor = Theme.BgCard,
                DrawCardBorder = true
            };
            var lbl = new Label
            {
                Text = title,
                Font = Theme.FontCardTitle,
                ForeColor = Theme.GoldBright,
                Location = new Point(10, 7),
                AutoSize = true,
                UseMnemonic = false
            };
            card.Controls.Add(lbl);
            return card;
        }

        private void LaunchExe(string relExe, string relWorkDir)
        {
            string exePath = Path.Combine(backend.ProjectRoot, relExe);
            string workDir = Path.Combine(backend.ProjectRoot, relWorkDir);
            if (!File.Exists(exePath))
            {
                MessageBox.Show("Dosya bulunamadı:\n" + exePath, "work1", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            try { Process.Start(new ProcessStartInfo { FileName = exePath, WorkingDirectory = workDir, UseShellExecute = true }); }
            catch (Exception ex) { MessageBox.Show("Hata: " + ex.Message); }
        }

        public void ApplySnapshot(ServiceHealthSnapshot s)
        {
            if (IsDisposed) return;

            lblInfoLine.Text = string.Format(
                "CANLI DURUM  •  Oyun: {0}/4 Core  •  Hesap: {1} (GM: {2})  •  {3} @ {4}  •  Profil: {5}",
                s.RunningGameCoresCount,
                s.AccountCount, s.GmCount, s.ServerName, s.ServerIp,
                s.ActiveProfile > 0 ? s.ActiveProfile.ToString() : "-");

            pillMaria.UpdateState(s.MariaDbRunning);
            pillDbPeer.UpdateState(s.DbPeerOpen);
            pillAuth.UpdateState(s.AuthOpen);
            pillCh1C1.UpdateState(s.Ch1Core1Open);
            pillCh99.UpdateState(s.Ch99Open);
            pillClient.UpdateState(s.ClientRunning);
        }
    }
}
