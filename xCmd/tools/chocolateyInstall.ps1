Install-ChocolateyZipPackage 'xCmd' 'http://feldkir.ch/xcmd/xcmd-1.12.exe.zip' "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 
mv "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\xcmd-1.12.exe" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\xcmd.exe"