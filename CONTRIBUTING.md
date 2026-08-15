# Contributing to SysMaint

Terima kasih telah tertarik berkontribusi pada **SysMaint** - alat maintenance sistem Windows otomatis!

## Cara Berkontribusi

### 1. **Report Bugs**
- Buka [Issues](https://github.com/danish-akmal/SysMaint/issues)
- Gunakan template bug report
- Sertakan: Output error, Windows version, langkah reproduksi

### 2. **Feature Requests** 
- Buka [Issues](https://github.com/danish-akmal/SysMaint/issues)
- Jelaskan fitur yang diinginkan
- Sertakan use case dan manfaat

### 3. **Code Contributions**

Fork repo → Buat branch → Commit → Pull Request


**Workflow:**
```bash
git clone https://github.com/YOUR-USERNAME/SysMaint.git
cd SysMaint
git checkout -b feature/nama-fitur
```
**Edit SysMaint.ps1**
```bash
git add .
git commit -m "Add [feature description]"
git push origin feature/nama-fitur
```


## Development Setup

1. **Clone repo:**
```powershell
git clone https://github.com/danish-akmal/SysMaint.git
cd SysMaint
```

2. **Test locally:**
```powershell
powershell.exe -ExecutionPolicy Bypass -File .\SysMaint.ps1
```

3. **Syntax check:**
```powershell
powershell -NoProfile -Command "Get-Content .\SysMaint.ps1 | Invoke-Expression"
```


## Coding Standards

- ✅ PowerShell v5.1+ compatible
- ✅ UTF-8 encoding
- ✅ 4-space indentation
- ✅ Verbose error handling
- ✅ `#Requires -Version 5.1` di header
- ❌ No external dependencies


## Pull Request Rules

1. **Match existing code style**
2. **Include tests/use cases**
3. **Single purpose** per PR
4. **Update documentation** jika perlu
5. **Pass syntax check** lokal

## Support

Pertanyaan? Buka [Discussion](https://github.com/danish-akmal/SysMaint/discussions) atau [Issues](https://github.com/danish-akmal/SysMaint/issues).

---

**Happy contributing!** 🚀

*Adopted from standard open-source templates*


## 🚀 **Cara Pakai:**  
```
1. Copy kode di atas
2. GitHub → SysMaint repo → "Add file" → "Create new file"
3. Nama file: `CONTRIBUTING.md` (huruf kapital semua)
4. Paste → Commit ke `main`
5. SELESAI! ✅
```

**Hasil**: Repo jadi **fully professional** dengan CoC + Contributing guide! 🎉

**User lain bisa langsung ikut develop SysMaint!**  
