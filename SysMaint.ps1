#Requires -Version 5.1
# SysMaint v1.0 - FIXED FUNCTIONS

function Test-AdminStatus {
    return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Start-SysMaint {
    if (-NOT (Test-AdminStatus)) {
        $args = @(
            '-NoProfile'
            '-ExecutionPolicy Bypass'
            '-NoExit'
            "-Command `"cd '$PWD'; . '$PSCommandPath'; Start-SysMaint`""
        )
        Start-Process PowerShell.exe -ArgumentList $args -Verb RunAs
        Write-Host "SysMaint dibuka sebagai Administrator..." -ForegroundColor Green
        return
    }

    Invoke-SysMaintenance
}

function Invoke-SysMaintenance {
    $logFile = "C:\SysMaint_$(Get-Date -f 'yyyyMMdd-HHmmss').txt"
    Start-Transcript -Path $logFile -Append
	   
    Write-Host "SysMaint v1.0 - Windows System Maintenance" -ForegroundColor Cyan
    Write-Host "Log: $logFile" -ForegroundColor Yellow
	
	Write-Host "===============================================================`n           SysMaint v1.0 - MAINTENANCE AKTIF`n===============================================================`n" -ForegroundColor Cyan
    
    Write-Host "PERINGATAN UNTUK PENGGUNA:`n" -ForegroundColor Red
    Write-Host "- JANGAN MENGGUNAKAN KOMPUTER selama proses berjalan" -ForegroundColor Red
    Write-Host "- Durasi: 10-30 menit tergantung kondisi sistem" -ForegroundColor Red
    Write-Host "`nStatus proses akan tampil real-time di bawah ini...`n" -ForegroundColor White

    # 1. SYSTEM INTEGRITY
    Write-Host "`n1. Memeriksa integritas sistem..."
    $sfcResult = sfc /verifyonly 2>&1
    if ($sfcResult | Select-String "found corrupt files") {
        Write-Host "  SFC /scannow dijalankan" -ForegroundColor Yellow
        sfc /scannow
    }

    $dismResult = DISM /Online /Cleanup-Image /ScanHealth 2>&1
    if ($dismResult | Select-String "repairable") {
        Write-Host "  DISM RestoreHealth dijalankan" -ForegroundColor Yellow
        DISM /Online /Cleanup-Image /RestoreHealth
        sfc /scannow
    }

    # 2. WINDOWS UPDATE RESET
    Write-Host "`n2. Reset Windows Update..."
    Stop-Service bits,wuauserv,cryptsvc,msiserver -Force -ErrorAction SilentlyContinue
    $ts = Get-Date -f "yyyyMMdd-HHmmss"
    Rename-Item "$env:SystemRoot\SoftwareDistribution" "SoftwareDistribution.$ts" -Force -ErrorAction SilentlyContinue
    Rename-Item "$env:SystemRoot\System32\catroot2" "catroot2.$ts" -Force -ErrorAction SilentlyContinue
    Start-Service wuauserv,cryptsvc,bits,msiserver -ErrorAction SilentlyContinue

    # 3. NETWORK RESET
    Write-Host "`n3. Reset jaringan..."
    ipconfig /flushdns | Out-Null
    netsh winsock reset | Out-Null
    netsh int ip reset | Out-Null
    ipconfig /registerdns | Out-Null

    # 4. CLEANUP
    Write-Host "`n4. Pembersihan sistem..."
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    DISM /Online /Cleanup-Image /StartComponentCleanup | Out-Null
    cmd /c "rd /s /q C:\`$Recycle.Bin" 2>$null

    # 5. DISK OPTIMIZATION
    Write-Host "`n5. Optimasi disk..."
    Get-PhysicalDisk | Where-Object MediaType -eq "SSD" | ForEach-Object {
        $vol = $_ | Get-Disk | Get-Partition | Get-Volume | Where-Object DriveLetter
        if ($vol) { Optimize-Volume -DriveLetter $vol.DriveLetter -ReTrim }
    }
    Get-PhysicalDisk | Where-Object MediaType -eq "HDD" | ForEach-Object {
        $vol = $_ | Get-Disk | Get-Partition | Get-Volume | Where-Object DriveLetter
        if ($vol) { Optimize-Volume -DriveLetter $vol.DriveLetter -Defrag }
    }

    # 6. CHKDSK
    Write-Host "`n6. Pemeriksaan disk C..."
    chkdsk C: /scan
    $code = $LASTEXITCODE
    if ($code -eq 0) { 
        Write-Host "  Disk bersih" -ForegroundColor Green 
    } elseif ($code -eq 1) { 
        Write-Host "  Perbaikan minor" -ForegroundColor Yellow
        chkdsk C: /spotfix 
    } elseif ($code -eq 3) { 
        Write-Host "  Perbaikan berat dijadwalkan" -ForegroundColor Red
        chkdsk C: /F /R 
    } else { 
        Write-Host "  Exit code: $code" -ForegroundColor Cyan 
    }

    # 7. MEMORY DIAGNOSTIC
    Write-Host "`n7. Memory Diagnostic dijadwalkan..."
    mdsched.exe /s

    # 8. COUNTDOWN
    Write-Host "`nMaintenance selesai! Restart dalam 30 detik..." -ForegroundColor Yellow
    Write-Host "Tekan A untuk membatalkan..."
    $counter = 30
    while ($counter -gt 0) {
        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true).Key
            if ($key -eq 65) {
                Write-Host "`nRestart dibatalkan!" -ForegroundColor Green
                break
            }
        }
        Start-Sleep 1
        $counter--
        Write-Host "`rMenunggu $counter detik..." -NoNewline
    }

    if ($counter -le 0) {
        Write-Host "`nRestarting now..." -ForegroundColor Red
        shutdown /r /f /t 5
    }

    Stop-Transcript
    Write-Host "`nSysMaint selesai! Log: $logFile" -ForegroundColor Green
	Write-Host "`Waktu selesai : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')]`n" -ForegroundColor Green
    Read-Host "Tekan Enter untuk keluar"
	exit 0
}

# JALANKAN

Start-SysMaint

