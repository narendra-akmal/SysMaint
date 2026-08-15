# SysMaint [Sistem Pemeliharaan Windows]   
---  
SysMaint adalah skrip PowerShell untuk pemeliharaan sistem Windows yang mengotomatisasi tugas rutin seperti pembersihan file sementara, optimasi disk, backup log, dan monitoring ruang disk. Dirancang untuk administrator sistem agar menjaga performa server dan workstation dengan mudah. 

## Fitur Utama

- Pembersihan file sampah, temporary files, dan Recycle Bin
- Optimasi disk dengan defragmentasi dan TRIM
- Backup log sistem dan event log penting
- Mode interaktif dan otomatis (Task Scheduler ready)


## Prasyarat Sistem

Skrip ini **fully self-contained** tanpa dependensi eksternal:


| Komponen | Persyaratan | Status |
| :-- | :-- | :-- |
| **OS** | Windows 10/11, Server 2016+ | Bawaan |
| **PowerShell** | Versi 5.1+ | Sudah terinstall |
| **Hak Akses** | Administrator | Wajib |
| **Modul** | Storage, Dism, FileSystem | Bawaan Windows |
| **Ruang Disk** | 100MB+ untuk log sementara | Direkomendasikan |

**Tidak ada instalasi tambahan** (pip, npm, atau modul eksternal) diperlukan.

## Instalasi \& Persiapan

#### 1. Download SysMaint.ps1
#### 2. Set Execution Policy (sekali saja)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
#### 3. Verifikasi prasyarat otomatis dijalankan saat eksekusi  


## Cara Penggunaan

### Mode Interaktif

```powershell
# Jalankan sebagai Administrator
.\SysMaint.ps1
```  

Bisa juga dilakukan dengan menjalankan program (.exe) yang dapat diperoleh dari tautan berikut:  

#### \[[Download](https://github.com/danish-akmal/SysMaint/releases/download/v1.0.0.0/SysMaint.exe)\]  

## Kontribusi

1. Fork repository
2. `git checkout -b feature/nama-fitur`
3. `git commit -m "feat: tambah fitur X"`
4. `git push origin feature/nama-fitur`
5. Buat **Pull Request**

## Troubleshooting

```
❌ Error "Access Denied": Jalankan sebagai Administrator
❌ Error "Execution Policy": Jalankan Set-ExecutionPolicy RemoteSigned
❌ Defrag gagal: Pastikan bahwa dijalankan sebagai SYSTEM
```


## Lisensi

[MIT License](LICENSE) - Gunakan, modifikasi, distribusikan bebas.

## Kontak

**Narendra Akmal** - [github.com/narendra-akmal](https://github.com/narendra-akmal)

```
Last Updated: August 2026
PowerShell 5.1+ | Windows 10/11 | Server 2016+
```


***  
