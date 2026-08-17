<h1 align="center">🛠️ SysMaint<br>[Sistem Pemeliharaan Windows]</h1>
<p align="center"><a href="https://microsoft.com/powershell"><img src="https://img.shields.io/badge/PowerShell-5.1%2B%20%7C%20Core%207%2B-blue.svg" alt="PowerShell Version"></a>
<a href="https://microsoft.com/windows"><img src="https://img.shields.io/badge/Windows-10%20%7C%2011%20%7C%20Server%202016%2B-0078D6.svg" alt="OS Compatibility"></a>
<a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-orange.svg" alt="License: MIT"></a>
<a href="https://github.com/narendra-akmal/SysMaint/releases"><img src="https://img.shields.io/badge/Release-v2.0.0--stable-green.svg" alt="Release"></a></p>
<p><strong>SysMaint (Sistem Pemeliharaan Windows)</strong> adalah <em>framework</em> skrip berbasis PowerShell yang dirancang untuk mengotomatisasi seluruh siklus pemeliharaan rutin pada sistem operasi Windows (Workstation &amp; Server). Skrip ini membantu Administrator Sistem, Engineer DevOps, dan Pengguna Daya (<em>Power Users</em>) dalam menjaga performa sistem tetap optimal, menghemat ruang penyimpanan, serta meminimalisasi potensi <em>downtime</em> akibat akumulasi file sampah atau log membesar.</p>
<hr>
<h2>📌 Daftar Isi</h2>
<ul>
<li><a href="#-latar-belakang--keunggulan">Latar Belakang &amp; Keunggulan</a></li>
<li><a href="#-fitur-utama">Fitur Utama</a></li>
<li><a href="#-prasyarat-sistem">Prasyarat Sistem</a></li>
<li><a href="#-panduan-instalasi--persiapan">Panduan Instalasi &amp; Persiapan</a></li>
<li><a href="#-panduan-penggunaan">Panduan Penggunaan</a><ul>
<li><a href="#1-mode-interaktif-tampilan-menu">1. Mode Interaktif (Tampilan Menu)</a></li>
<li><a href="#2-mode-otomatis--non-interaktif-unattended">2. Mode Otomatis / Non-Interaktif</a></li>
<li><a href="#3-eksekusi-file-biner-exe">3. Eksekusi File Biner (.exe)</a></li>
</ul>
</li>
<li><a href="#-automasi-dengan-task-scheduler">Automasi dengan Task Scheduler</a></li>
<li><a href="#-alur-kerja-skrip-workflow">Alur Kerja Skrip (Workflow)</a></li>
<li><a href="#-troubleshooting--pemecahan-masalah">Troubleshooting &amp; Pemecahan Masalah</a></li>
<li><a href="#-panduan-kontribusi">Panduan Kontribusi</a></li>
<li><a href="#-lisensi--kontak">Lisensi &amp; Kontak</a></li>
</ul>
<hr>
<h2>🌟 Latar Belakang &amp; Keunggulan</h2>
<p>Seiring berjalannya waktu, sistem operasi Windows menumpuk file sementara (<em>temporary files</em>), cache pembaruan sistem (<em>Windows Update</em>), file <em>prefetch</em>, dan log event yang dapat memperlambat kinerja disk serta menghabiskan kapasitas penyimpanan. Latihan pemeliharaan manual memerlukan waktu dan berisiko terjadi kelalaian.</p>
<p><strong>Mengapa Memilih SysMaint?</strong></p>
<ul>
<li><strong>Zero Dependencies:</strong> Berjalan langsung menggunakan modul bawaan Windows tanpa perlu menginstal <em>third-party software</em> atau modul external (<code>npm</code>, <code>pip</code>, <code>NuGet</code>).</li>
<li><strong>Safe &amp; Non-Destructive:</strong> Hanya menghapus file yang aman untuk dibersihkan tanpa mengganggu integritas file sistem utama.</li>
<li><strong>Smart Storage Awareness:</strong> Dapat membedakan jenis media penyimpanan (SSD vs. HDD) secara otomatis untuk menerapkan teknik optimasi yang tepat (TRIM vs. Defrag).</li>
<li><strong>Enterprise Ready:</strong> Siap diintegrasikan dengan Windows Task Scheduler, Group Policy Object (GPO), Microsoft Intune, atau Active Directory Logon/Logoff scripts.</li>
</ul>
<hr>
<h2>🚀 Fitur Utama</h2>
<h3>1. Pembersihan File Sampah &amp; System Cleanup</h3>
<ul>
<li>Menghapus seluruh direktori Temporary Files (<code>C:\Windows\Temp</code> dan <code>%TEMP%</code>).</li>
<li>Mengosongkan <strong>Recycle Bin</strong> seluruh <em>drive</em> atau <em>user profile</em>.</li>
<li>Membersihkan <strong>Windows Update Download Cache</strong> (<code>C:\Windows\SoftwareDistribution\Download</code>).</li>
<li>Membersihkan direktori <strong>Prefetch</strong> dan <strong>Windows Error Reporting (WER)</strong> logs.</li>
<li>Pembersihan Komponen Windows Image menggunakan <strong>DISM</strong> (<code>/Cleanup-Image /StartComponentCleanup</code>).</li>
</ul>
<h3>2. Optimasi &amp; Kesehatan Media Penyimpanan (Disk Optimization)</h3>
<ul>
<li>Deteksi otomatis jenis drive (Solid State Drive / Hard Disk Drive).</li>
<li>Eksekusi perintah <strong>TRIM / Retrim</strong> pada drive SSD untuk menjaga daya tahan dan kecepatan <em>write</em>.</li>
<li>Eksekusi <strong>Defragmentasi Terfragmentasi Terarah</strong> pada HDD konvensional.</li>
<li>Pemeriksaan integritas kesehatan disk dasar via PowerShell <code>Storage</code> API.</li>
</ul>
<h3>3. Backup &amp; Rotasi Log Sistem</h3>
<ul>
<li>Mengekspor Windows Event Logs penting (<em>System</em>, <em>Application</em>, <em>Security</em>) ke berkas archive <code>.evtx</code> atau <code>.zip</code>.</li>
<li>Melakukan rotasi dan pengarsipan log pemeliharaan otomatis berdasarkan batas usia hari (misal: hapus log &gt; 30 hari).</li>
<li>Menyimpan rekapikasi <em>health report</em> setelah skrip selesai dijalankan.</li>
</ul>
<h3>4. Monitoring Ruang Disk (Disk Space Alerting)</h3>
<ul>
<li>Memberikan laporan statistik kapasitas sebelum dan sesudah proses pemeliharaan.</li>
<li>Memberikan <em>warning</em> visual jika sisa kapasitas drive utama (<code>C:</code>) berada di bawah ambang batas aman (misal: &lt; 15%).</li>
</ul>
<hr>
<h2>📋 Prasyarat Sistem</h2>
<p>Skrip ini bersifat <strong>fully self-contained</strong> dan siap dijalankan secara native pada lingkungan Windows berikut:</p>
<table>
<thead>
<tr>
<th align="left">Komponen</th>
<th align="left">Persyaratan Minimum</th>
<th align="left">Rekomendasi</th>
<th align="left">Status Modul</th>
</tr>
</thead>
<tbody><tr>
<td align="left"><strong>Sistem Operasi</strong></td>
<td align="left">Windows 10 / Windows Server 2016</td>
<td align="left">Windows 11 / Windows Server 2022</td>
<td align="left">Built-in Native</td>
</tr>
<tr>
<td align="left"><strong>PowerShell</strong></td>
<td align="left">Versi 5.1</td>
<td align="left">PowerShell 7.x (Core)</td>
<td align="left">Terinstall bawaan</td>
</tr>
<tr>
<td align="left"><strong>Hak Akses</strong></td>
<td align="left">Administrator (<em>Elevated Prompt</em>)</td>
<td align="left">Administrator / Local System</td>
<td align="left">Wajib</td>
</tr>
<tr>
<td align="left"><strong>Modul Internal</strong></td>
<td align="left"><code>Storage</code>, <code>Dism</code>, <code>Microsoft.PowerShell.Archive</code></td>
<td align="left">Modul versi terbaru</td>
<td align="left">Bawaan OS</td>
</tr>
<tr>
<td align="left"><strong>Ruang Disk</strong></td>
<td align="left">Min. 100 MB ruang tersisa</td>
<td align="left">&gt; 1 GB untuk pemrosesan file temporary</td>
<td align="left">Direkomendasikan</td>
</tr>
</tbody></table>
<blockquote>
<p><strong>Catatan:</strong> Skrip ini <strong>tidak memerlukan</strong> <em>library</em> eksternal dari repositori publik saat dijalankan.</p>
</blockquote>
<hr>
<h2>⚙️ Panduan Instalasi &amp; Persiapan</h2>
<h3>Langkah 1: Pengunduhan Skrip</h3>
<p>Kloning repositori ini menggunakan Git atau unduh berkas zip secara langsung:</p>
<pre><code class="language-bash">git clone https://github.com/narendra-akmal/SysMaint.git
cd SysMaint
</code></pre>
<h3>Langkah 2: Konfigurasi PowerShell Execution Policy</h3>
<p>Secara <em>default</em>, Windows memblokir eksekusi skrip PowerShell yang belum terverifikasi. Izinkan eksekusi skrip untuk skop pengguna saat ini:</p>
<pre><code class="language-powershell"># Jalankan PowerShell sebagai Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
</code></pre>
<h3>Langkah 3: Verifikasi Hak Akses Administrator</h3>
<p>Pastikan Anda membuka PowerShell menggunakan opsi <strong>"Run as Administrator"</strong>. Jika dijalankan tanpa hak akses Administrator, beberapa fungsi seperti pembersihan <code>Windows\Temp</code> dan perintah DISM akan dilewati demi keamanan.</p>
<hr>
<h2>💻 Panduan Penggunaan</h2>
<h3>1. Mode Interaktif (Tampilan Menu)</h3>
<p>Mode ini sangat cocok untuk penggunaan harian oleh administrator secara manual melalui konsol.</p>
<pre><code class="language-powershell"># Jalankan skrip PowerShell
.\SysMaint.ps1
</code></pre>
<p><em>Skrip akan menampilkan GUI berbasis teks (CLI Menu) di mana Anda dapat memilih tugas pemeliharaan spesifik yang ingin dijalankan.</em></p>
<hr>
<h3>2. Mode Otomatis / Non-Interaktif (Unattended)</h3>
<p>Mode ini digunakan untuk otomatisasi skrip tanpa memerlukan interaksi input dari pengguna.</p>
<pre><code class="language-powershell"><h4># Menjalankan pemeliharaan penuh secara otomatis</h4>
.\SysMaint.ps1 -Auto -FullMaintenance -Verbose

<h4># Menjalankan hanya fungsi pembersihan file temporary</h4>
.\SysMaint.ps1 -CleanOnly

<h4># Menjalankan pembersihan dan optimasi disk tanpa backup log</h4>
.\SysMaint.ps1 -SkipLogBackup
</code></pre>
<hr>
<h3>3. Eksekusi File Biner (.exe)</h3>
<p>Bagi pengguna yang membutuhkan versi portabel tanpa perlu membuka konsol PowerShell, Anda dapat mengunduh versi kompilasi <code>.exe</code>:</p>
<h4>📥 <a href="https://github.com/narendra-akmal/SysMaint/releases/download/SysMaint-v2/SysMaint.exe">[Download SysMaint.exe]</a></h4>
<blockquote>
<p><strong>Cara Menggunakan .exe:</strong>
Klik kanan pada berkas <code>SysMaint.exe</code> ➡️ Pilih <strong>"Run as Administrator"</strong>.</p>
</blockquote>
<hr>
<h2>📅 Automasi dengan Task Scheduler</h2>
<p>Untuk menjaga performa server atau komputer desktop secara berkala, disarankan untuk mengonfigurasi skrip ini pada <strong>Windows Task Scheduler</strong>.</p>
<h3>Menggunakan PowerShell Command:</h3>
<p>Anda dapat merregistrasikan tugas terjadwal (misal: Setiap hari Minggu jam 02:00 pagi) menggunakan perintah berikut:</p>
<pre><code class="language-powershell">$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File 'C:\Path\To\SysMaint.ps1' -Auto -FullMaintenance"
$Trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 2am
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName "SysMaint_Weekly_Maintenance" -Action $Action -Trigger $Trigger -Principal $Principal
</code></pre>
<hr>
<h2>🔄 Alur Kerja Skrip (Workflow)</h2>
<pre><code class="language-text">[ Start Eksekusi ]
       │
       ▼
[ Validasi Admin Rights ] ──(Gagal)──► [ Tampilkan Warning &amp; Terminate ]
       │ (Sukses)
       ▼
[ Cek Ruang Disk Awal ]
       │
       ▼
[ Backup &amp; Kompresi Log ] ──► [ Simpan ke Archive Folder ]
       │
       ▼
[ Pembersihan File Temp ] ──► [ System Temp, Prefetch, Recycle Bin, DISM Cache ]
       │
       ▼
[ Deteksi Tipe Drive ]
       ├── (Jika SSD) ───────► [ Jalankan TRIM / Optimize-Volume ]
       └── (Jika HDD) ───────► [ Jalankan Defragmentasi ]
       │
       ▼
[ Cek Ruang Disk Akhir ] ──► [ Hitung Total Kapasitas Dirilis ]
       │
       ▼
[ Buat Log Pemeliharaan ]
       │
       ▼
[ Selesai / Exit ]
</code></pre>
<hr>
<h2>❓ Troubleshooting &amp; Pemecahan Masalah</h2>
<table>
<thead>
<tr>
<th align="left">Masalah / Error Message</th>
<th align="left">Kemungkinan Penyebab</th>
<th align="left">Solusi Pemecahan</th>
</tr>
</thead>
<tbody><tr>
<td align="left"><strong>❌ Access Denied / Permission Error</strong></td>
<td align="left">Skrip dijalankan tanpa hak akses elevasi (<em>Elevated Privileges</em>).</td>
<td align="left">Klik kanan pada PowerShell / <code>SysMaint.exe</code> lalu pilih <strong>Run as Administrator</strong>.</td>
</tr>
<tr>
<td align="left"><strong>❌ File cannot be loaded because running scripts is disabled</strong></td>
<td align="left">Kebijakan <em>Execution Policy</em> Windows masih dalam kondisi pembatasan <em>Restricted</em>.</td>
<td align="left">Jalankan perintah <code>Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser</code>.</td>
</tr>
<tr>
<td align="left"><strong>❌ Defragmentation / TRIM Failed</strong></td>
<td align="left">Perintah optimasi dijalankan pada Virtual Disk, Storage Spaces, atau butuh akses akun <code>SYSTEM</code>.</td>
<td align="left">Akses defrag pada Mesin Virtual (VM) ditangani oleh Hypervisor. Untuk OS Fisik, pastikan dipanggil via Task Scheduler akun <code>SYSTEM</code>.</td>
</tr>
<tr>
<td align="left"><strong>❌ Locked Files / File in Use</strong></td>
<td align="left">File temporary sedang digunakan oleh program yang sedang berjalan aktif.</td>
<td align="left">Skrip secara otomatis akan melompati (<em>skip</em>) file yang terkunci tanpa menghentikan seluruh proses.</td>
</tr>
</tbody></table>
<hr>
<h2>🤝 Panduan Kontribusi</h2>
<p>Kami sangat menyambut kontribusi dari komunitas untuk meningkatkan fungsionalitas SysMaint!</p>
<ol>
<li><strong>Fork</strong> repositori ini.</li>
<li>Buat <em>feature branch</em> baru:<pre><code class="language-bash">git checkout -b feature/FiturBaruKeren
</code></pre>
</li>
<li>Lakukan commit pada perubahan Anda (gunakan format commit yang jelas):<pre><code class="language-bash">git commit -m "feat: Menambahkan modul pembersihan log IIS"
</code></pre>
</li>
<li>Push branch Anda ke remote repository:<pre><code class="language-bash">git push origin feature/FiturBaruKeren
</code></pre>
</li>
<li>Buka <strong>Pull Request (PR)</strong> baru pada cabang <code>main</code> repositori ini.</li>
</ol>
<hr>
<h2>📄 Lisensi</h2>
<p>Proyek ini didistribusikan di bawah lisensi <strong>MIT License</strong>. Anda bebas menggunakan, memodifikasi, mendistribusikan, dan memanfaatkannya secara komersial maupun pribadi tanpa batasan. Lihat berkas <a href="LICENSE">LICENSE</a> untuk informasi lebih lanjut.</p>
<hr>
<h2>📞 Kontak &amp; Pengembang</h2>
<ul>
<li><strong>Developer:</strong> Narendra Akmal</li>
<li><strong>GitHub Repositori:</strong> <a href="https://github.com/narendra-akmal/SysMaint">github.com/narendra-akmal/SysMaint</a></li>
<li><strong>Pelaporan Bug &amp; Masalah:</strong> <a href="https://github.com/narendra-akmal/SysMaint/issues">GitHub Issues</a></li>
</ul>
<pre><code class="language-text">─────────────────────────────────────────────────────────────────────────────
SysMaint Framework | Built with PowerShell
Tested on: Windows 10, Windows 11, Windows Server 2016/2019/2022
Last Documentation Update: August 2026
─────────────────────────────────────────────────────────────────────────────
</code></pre>
