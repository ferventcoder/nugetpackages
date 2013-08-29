$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Attention people from the future. This function will be built into chocolatey 0.9.8.21 or possibly 0.9.8.20
. (Join-Path $scriptDir '.\Invoke-GenerateBinFile.ps1')

$installDir = Split-Path -Parent (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4" UninstallString).UninstallString

$binDir = Join-Path (Split-Path -Parent $installDir) 'bin'

if (-not(Test-Path $bindir -PathType Container)) { mkdir $bindir }
Invoke-GenerateBinFile 'gvim' $installDir $binDir -UseStart
Invoke-GenerateBinFile 'vim' $installDir $binDir

# Being safe in case your session path is not the same as the path in your registry
$oldPath = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine)
if(-not ($oldPath.Split(';') -contains $binDir)) {
  Write-Host "Adding $($binDir) to your path in the registry"
  [Environment]::SetEnvironmentVariable('PATH', "$($oldPath);$binDir", [EnvironmentVariableTarget]::Machine)
}
