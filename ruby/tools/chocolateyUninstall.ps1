$arch = Get-WmiObject -Class Win32_OperatingSystem | Select-Object OSArchitecture

if ($arch.OSArchitecture -eq "64-bit") {
  $file = (Get-ItemProperty HKCU:Software\Microsoft\Windows\CurrentVersion\Uninstall\"{B5BD4615-7C8A-4E50-9179-71B593CA6B67}_is1" UninstallString).UninstallString;
} else {
  $file = (Get-ItemProperty HKCU:Software\Microsoft\Windows\CurrentVersion\Uninstall\"{ABAA9781-845A-43CC-BABA-76CB580FE35D}_is1" UninstallString).UninstallString;	
}

$package = 'ruby'
Uninstall-ChocolateyPackage $package 'EXE' -SilentArgs '/S' -file $file