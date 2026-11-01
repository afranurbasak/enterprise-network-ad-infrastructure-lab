# =========================================================
# LCW PROJESİ - NTFS VE DOSYA PAYLAŞIMI ÖRNEK SCRIPT
# Amaç: Departman klasörleri, paylaşım ve grup bazlı izinler
# =========================================================

$BasePath = "C:\Paylasimlar"

New-Item -ItemType Directory -Path $BasePath -Force

$Departments = @("Yonetim","IK","Muhasebe","Satis","ETicaret","Lojistik","IT")

foreach ($Dept in $Departments) {
    $Path = Join-Path $BasePath $Dept
    New-Item -ItemType Directory -Path $Path -Force

    # SMB paylaşım oluşturma
    New-SmbShare -Name $Dept -Path $Path -FullAccess "LCW\Administrators" -ChangeAccess "LCW\GG_$Dept"

    # NTFS izin örneği
    icacls $Path /inheritance:r
    icacls $Path /grant "LCW\GG_$Dept:(OI)(CI)M"
    icacls $Path /grant "LCW\Administrators:(OI)(CI)F"
}

# Özel örnek:
# C:\Paylasimlar\Muhasebe klasörü GG_Muhasebe grubuna atanmıştır.
