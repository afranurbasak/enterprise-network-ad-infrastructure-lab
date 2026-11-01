# =========================================================
# LCW PROJESİ - ACTIVE DIRECTORY ÖRNEK POWERSHELL SCRIPT
# Not: Bu script raporda yapılandırma kanıtı olarak verilebilir.
# Gerçek sistemde çalıştırılmadan önce yetkili PowerShell oturumu gerekir.
# =========================================================

Import-Module ActiveDirectory

# OU oluşturma
New-ADOrganizationalUnit -Name "Yonetim" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "IK" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "Muhasebe" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "Satis" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "ETicaret" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "Lojistik" -Path "DC=lcw,DC=local"
New-ADOrganizationalUnit -Name "IT" -Path "DC=lcw,DC=local"

# Güvenlik grupları oluşturma
New-ADGroup -Name "GG_Yonetim" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_IK" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_Muhasebe" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_Satis" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_ETicaret" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_Lojistik" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"
New-ADGroup -Name "GG_IT" -GroupScope Global -GroupCategory Security -Path "CN=Users,DC=lcw,DC=local"

# Örnek kullanıcı oluşturma
# Şifre koda yazılmaz; çalıştırma sırasında güvenli şekilde istenir.
$Password = Read-Host -AsSecureString "Ornek kullanici icin baslangic sifresi"

New-ADUser `
 -Name "Mehmet Demir" `
 -GivenName "Mehmet" `
 -Surname "Demir" `
 -SamAccountName "mehmet.demir" `
 -UserPrincipalName "mehmet.demir@lcw.local" `
 -Path "OU=Muhasebe,DC=lcw,DC=local" `
 -AccountPassword $Password `
 -Enabled $true `
 -ChangePasswordAtLogon $true

# Kullanıcıyı gruba ekleme
Add-ADGroupMember -Identity "GG_Muhasebe" -Members "mehmet.demir"
