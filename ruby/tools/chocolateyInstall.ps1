try {
  $binRoot = "$env:systemdrive\"

  ### Using an environment variable to to define the bin root until we implement YAML configuration ###
  if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}

  #$rubyFolder = '187'
  #$url = 'http://rubyforge.org/frs/download.php/76524/rubyinstaller-1.8.7-p371.exe'

  #$rubyFolder = '192'
  #$url = 'http://rubyforge.org/frs/download.php/75127/rubyinstaller-1.9.2-p290.exe'

  #$rubyFolder = '193'
  #$url = 'http://cdn.rubyinstaller.org/archives/1.9.3-p374/rubyinstaller-1.9.3-p374.exe'

  # choose 64-bit or 32-bit installer based on machine architecture
  $arch = Get-WmiObject -Class Win32_OperatingSystem | Select-Object OSArchitecture
  if ($arch.OSArchitecture -eq "64-bit") {
    $url = 'http://files.rubyforge.vm.bytemark.co.uk/rubyinstaller/rubyinstaller-2.0.0-p195-x64.exe'
  } else {
    $url = 'http://cdn.rubyinstaller.org/archives/2.0.0-p195/rubyinstaller-2.0.0-p195.exe'
  }

  $rubyPath = join-path $binRoot $('ruby' + "$rubyFolder")
  $silentArgs = "/verysilent /dir=`"$rubyPath`" /tasks=`"assocfiles,modpath`""

  Install-ChocolateyPackage 'ruby' 'exe' "$silentArgs" "$url"

  # # Install and configure pik
  # Write-Host "Now we are going to install pik and set up the folder - so Ruby is pointed to the correct version"
  $rubyBin = join-path $rubyPath 'bin'
  Write-Host "Adding `'$rubyBin`' to the local path"
  $env:Path = "$($env:Path);$rubyBin"
  
  # $nugetBin = join-path $env:ChocolateyInstall 'bin'
  # #$gem = 'gem.bat'
  # $pikInstall = 'pik_install.bat'
  # & gem install pik
  # & $pikInstall "$nugetBin"

  # & pik add $rubyBin
  # & pik use $rubyFolder

  Write-ChocolateySuccess 'ruby'
} catch {
  Write-ChocolateyFailure 'ruby' $($_.Exception.Message)
  throw
}
