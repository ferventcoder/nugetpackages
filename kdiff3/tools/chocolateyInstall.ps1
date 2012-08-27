try {
    Install-ChocolateyPackage 'kdiff3' 'exe' '/S' 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.97/KDiff3-32bit-Setup_0.9.97.exe' 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.97/KDiff3-64bit-Setup_0.9.97.exe'  -validExitCodes @(0)
    
  #------additional setup ----------------
  #add it to the path
  $programPath = "$env:SystemDrive\Program Files\kdiff3"
  if (![System.IO.Directory]::Exists($programPath)) {
    $programPath = "$env:SystemDrive\Program Files (x86)\kdiff3";
  }
  Install-ChocolateyPath $programPath
  
  Write-ChocolateySuccess 'kdiff3'
} catch {
  Write-ChocolateyFailure 'kdiff3' $($_.Exception.Message)
  throw 
}