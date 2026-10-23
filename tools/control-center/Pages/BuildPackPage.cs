using System;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Work1ControlCenter.Pages
{
    internal sealed class BuildPackPage : BufferedPanel
    {
        private readonly BackendService backend;
        private readonly DataGridView gridPacks;
        private readonly Label lblPacksHeader;

        public BuildPackPage(BackendService backend)
        {
            this.backend = backend;
            Dock = DockStyle.Fill;
            BackColor = Theme.BgMain;
            Padding = new Padding(8, 6, 8, 6);

            var split = new TableLayoutPanel
            {
                Dock = DockStyle.Fill,
                ColumnCount = 2,
                RowCount = 1,
                BackColor = Color.Transparent
            };
            split.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 310F));
            split.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100F));

            // Left Card: Build Buttons
            var buildCard = new BufferedPanel
            {
                Dock = DockStyle.Fill,
                BackColor = Theme.BgCard,
                DrawCardBorder = true,
                Margin = new Padding(0, 0, 4, 0),
                Padding = new Padding(10)
            };

            var lblBuildTitle = new Label
            {
                Text = "KAYNAK DERLEME (" + backend.CpuThreads + " THREAD)",
                Font = Theme.FontCardTitle,
                ForeColor = Theme.GoldBright,
                Location = new Point(10, 8),
                AutoSize = true
            };

            int y = 30;
            AddFullWidthBtn(buildCard, "★ TAM DERLEME (SERVER+CLIENT)", ButtonStyle.PrimaryCrimson, ref y, () =>
                backend.RunScriptAsync("Tam Derleme (84)", "84_tam_derleme.bat"));

            AddFullWidthBtn(buildCard, "⚡ HEPSİNİ DERLE (db+game+qc)", ButtonStyle.PrimaryGold, ref y, () =>
                backend.RunScriptAsync("Sunucu Derleme (43)", "43_build_hepsi.bat"));

            AddFullWidthBtn(buildCard, "🛡 DB + GAME DERLE", ButtonStyle.Secondary, ref y, async () =>
            {
                await backend.RunScriptAsync("DB Derleniyor", "40_build_db.bat");
                await backend.RunScriptAsync("Game Derleniyor", "41_build_game.bat");
            });

            AddFullWidthBtn(buildCard, "⚔ CLIENT DERLE (metin2client)", ButtonStyle.Secondary, ref y, () =>
                backend.RunScriptAsync("İstemci Derleniyor", "44_build_client.bat"));

            AddFullWidthBtn(buildCard, "📜 QUEST DERLE (qc.exe)", ButtonStyle.PrimaryGold, ref y, () =>
                backend.RunScriptAsync("Quest Derleme", "50_quest_derle.bat"));

            AddFullWidthBtn(buildCard, "QC.EXE DERLE", ButtonStyle.Secondary, ref y, () =>
                backend.RunScriptAsync("qc.exe Derleniyor", "42_build_qc.bat"));

            var btnVerify = Theme.CreateButton("DENETLE", ButtonStyle.Success, 140, 28);
            btnVerify.Location = new Point(10, y);
            btnVerify.Click += async (s, e) => await backend.RunScriptAsync("Proje Bütünlük Denetimi", "86_dogrula.bat");

            var btnClean = Theme.CreateButton("TEMİZLE", ButtonStyle.Danger, 140, 28);
            btnClean.Location = new Point(156, y);
            btnClean.Click += async (s, e) => await backend.RunScriptAsync("Proje Temizliği", "82_temizle.bat");

            buildCard.Controls.AddRange(new Control[] { lblBuildTitle, btnVerify, btnClean });

            // Right Card: Pack Studio
            var packCard = new BufferedPanel
            {
                Dock = DockStyle.Fill,
                BackColor = Theme.BgCard,
                DrawCardBorder = true,
                Margin = new Padding(4, 0, 0, 0),
                Padding = new Padding(10)
            };

            var packTop = new Panel { Dock = DockStyle.Top, Height = 56, BackColor = Color.Transparent };
            lblPacksHeader = new Label
            {
                Text = "PACKMAKERLITE STÜDYOSU (Çift tıklayarak tek pack üretin)",
                Font = Theme.FontCardTitle,
                ForeColor = Theme.GoldBright,
                Location = new Point(2, 2),
                AutoSize = true
            };

            var packFlow = new FlowLayoutPanel
            {
                Location = new Point(0, 23),
                Size = new Size(470, 32),
                BackColor = Color.Transparent,
                WrapContents = false
            };

            AddMiniPackBtn(packFlow, "SEÇİLİ ÜRET", ButtonStyle.PrimaryCrimson, 96, async () =>
            {
                if (gridPacks.SelectedRows.Count == 0) return;
                string name = Convert.ToString(gridPacks.SelectedRows[0].Cells["Name"].Value);
                await BuildPackArchive(name);
            });
            AddMiniPackBtn(packFlow, "root", ButtonStyle.PrimaryGold, 66, () => BuildPackArchive("root"));
            AddMiniPackBtn(packFlow, "locale", ButtonStyle.PrimaryGold, 72, () => BuildPackArchive("locale"));
            AddMiniPackBtn(packFlow, "TÜMÜ REPACK", ButtonStyle.Success, 110, async () =>
            {
                await backend.RunScriptAsync("Tüm Packler Üretiliyor", "80_hepsi_repack.bat");
                RefreshPacks();
            });
            AddMiniPackBtn(packFlow, "↻", ButtonStyle.Secondary, 34, () => { RefreshPacks(); return Task.CompletedTask; });

            packTop.Controls.AddRange(new Control[] { lblPacksHeader, packFlow });

            gridPacks = Theme.CreateGrid();
            gridPacks.Dock = DockStyle.Fill;
            gridPacks.Columns.Add("Name", "Pack");
            gridPacks.Columns.Add("PakFile", "Arşiv");
            gridPacks.Columns.Add("Size", "Boyut");
            gridPacks.Columns.Add("Modified", "Tarih");
            gridPacks.Columns.Add("Status", "Durum");
            gridPacks.Columns["Name"].FillWeight = 65;
            gridPacks.Columns["PakFile"].FillWeight = 75;
            gridPacks.Columns["Size"].FillWeight = 55;
            gridPacks.Columns["Status"].FillWeight = 55;
            gridPacks.CellDoubleClick += async (s, e) =>
            {
                if (e.RowIndex < 0) return;
                string name = Convert.ToString(gridPacks.Rows[e.RowIndex].Cells["Name"].Value);
                await BuildPackArchive(name);
            };

            packCard.Controls.Add(gridPacks);
            Theme.AttachGridScrollBar(gridPacks, packCard);
            packCard.Controls.Add(packTop);

            split.Controls.Add(buildCard, 0, 0);
            split.Controls.Add(packCard, 1, 0);
            Controls.Add(split);

            RefreshPacks();
        }

        private static void AddFullWidthBtn(Control parent, string text, ButtonStyle style, ref int y, Func<Task> action)
        {
            var btn = Theme.CreateButton(text, style, 286, 29);
            btn.Location = new Point(10, y);
            btn.Click += async (s, e) => await action();
            parent.Controls.Add(btn);
            y += 33;
        }

        private static void AddMiniPackBtn(FlowLayoutPanel flow, string text, ButtonStyle style, int width, Func<Task> action)
        {
            var btn = Theme.CreateButton(text, style, width, 26);
            btn.Margin = new Padding(0, 0, 4, 0);
            btn.Font = Theme.FontButtonSm;
            btn.Click += async (s, e) => await action();
            flow.Controls.Add(btn);
        }

        private async Task BuildPackArchive(string packName)
        {
            await backend.RunScriptAsync("Pack Üretiliyor: " + packName, "71_paket_repack.bat", packName);
            RefreshPacks();
        }

        public void RefreshPacks()
        {
            Task.Run(() =>
            {
                var packs = backend.GetPackEntries();
                if (IsDisposed) return;
                BeginInvoke(new Action(() =>
                {
                    gridPacks.Rows.Clear();
                    long totalBytes = 0;
                    int ready = 0;
                    foreach (var p in packs)
                    {
                        if (p.Exists) { ready++; totalBytes += p.SizeBytes; }
                        string sizeTxt = p.Exists ? (p.SizeBytes >= 1048576 ? (p.SizeBytes / 1048576.0).ToString("0.0") + " MB" : (p.SizeBytes / 1024.0).ToString("0") + " KB") : "-";
                        string dateTxt = p.Exists ? p.LastModified.ToString("HH:mm:ss") : "-";
                        gridPacks.Rows.Add(p.Name, p.Name + ".eix/.epk", sizeTxt, dateTxt, p.Exists ? "Hazır" : "Eksik");
                    }
                    lblPacksHeader.Text = string.Format("PACK STÜDYOSU ({0}/{1} Hazır • {2:0.0} MB • Çift tıkla üret)", ready, packs.Count, totalBytes / 1048576.0);
                }));
            });
        }
    }
}
