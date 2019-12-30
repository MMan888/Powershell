# Reference:
# https://www.red-gate.com/simple-talk/sysadmin/powershell/persistent-powershell-the-powershell-profile/

# Create new profile
# PS5 and PS6 paths are different
# New-Item -Path $Profile -Type File -Force

# Sets PS execution policy
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Write-Host "Execution Policy set to: " (Get-ExecutionPolicy) -ForegroundColor Red

# Console output
Write-Host "Today:" (Get-Date) -ForegroundColor Green
Write-Host 'Hostname='"$env:computername" -ForegroundColor Green
Write-Host "You are logged in as" "$env:username" "using PowerShell"($PSVersionTable.PSVersion.Major) -ForegroundColor Green

$host.ui.rawui.windowtitle="Change The Console Title"

Set-Location C:\Users\Michael\Documents\code
Get-ChildItem

######################################
# Functions
######################################

function h10	{Get-History -Count 10}
function md5    {Get-FileHash -Algorithm MD5 $args}
function sha1   {Get-FileHash -Algorithm SHA1 $args}
function sha256 {Get-FileHash -Algorithm SHA256 $args}

function touch ([string]$Name){
	New-Item $Name -ItemType file
}

function Console($Title){
        Clear-Host
        $console = $host.UI.RawUI
	$console.WindowTitle = $Title
	cls
}

function Tail($File,$Length){
	Get-Content $File -Tail $Length -Wait
}

function CheckIP{
 	$ip = (Invoke-WebRequest -Uri http://checkip.dyndns.com).content -replace '[^\d\.]'
 	Write-Host -NoNewLine "External IP is ";Write-Host -ForegroundColor Green "$ip"
}

######################################
# Aliases
######################################

Set-Alias -Name list -Value Get-ChildItem

# Get-Alias

######################################
# Git
######################################

function ga() {git add -A}
function gs() {git status}
function gp() {git pull}
function gcp($msg) {git commit -m "$msg"; git push}
