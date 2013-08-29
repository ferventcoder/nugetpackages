$packageName = 'vim'
$fileType = 'exe'
$args = '/S'
$url = 'ftp://ftp.vim.org/pub/vim/pc/gvim74.exe'

Install-ChocolateyPackage $packageName $fileType $args $url

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Start-ChocolateyProcessAsAdmin (Join-Path $scriptDir 'chocolateyPostInstallUAC.ps1')
