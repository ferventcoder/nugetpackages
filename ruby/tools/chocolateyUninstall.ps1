$package = 'ruby'
$file = (Get-ItemProperty HKCU:Software\Microsoft\Windows\CurrentVersion\Uninstall\"{B5BD4615-7C8A-4E50-9179-71B593CA6B67}_is1" UninstallString).UninstallString;
Uninstall-ChocolateyPackage $package 'EXE' -SilentArgs '/S' -file $file