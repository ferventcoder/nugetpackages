function Insert-Script([ref]$originalScript, $script) {
    if(!($originalScript.Value -Contains $script)) { $originalScript.Value += $script }
}

try {
    $binRoot = join-path $env:systemdrive 'tools'

    ### Using an environment variable to to define the bin root until we implement YAML configuration ###
    if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
    $poshgitPath = join-path $binRoot 'poshgit'
    $poshGitInstall = if($env:poshGit -ne $null){ $env:poshGit } else {'https://github.com/dahlbyk/posh-git/zipball/v0.4'}
    Install-ChocolateyZipPackage 'poshgit' $poshGitInstall $poshgitPath
    $pgitDir = [Array](Dir "$poshgitPath\*posh-git*\" | Sort-Object -Property LastWriteTime)[-1]

    if(Test-Path $PROFILE) {
        $oldProfile = [string[]](Get-Content $PROFILE)
        $newProfile = @()
        $lib = "$env:chocolateyInstall\lib"
        #Clean out old profiles
        $pgitExample = "$pgitDir\profile.example.ps1"
        foreach($line in $oldProfile) {
            if($line.ToLower().Contains("$poshgitPath".ToLower())) { $line = ". '$pgitExample'" }
            if($line.Trim().Length -gt 0) {  $newProfile += $line }
        }
        #Save any previous Prompt logic
        Insert-Script ([REF]$newProfile) "if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}"
        Set-Content -path $profile -value $newProfile -Force
    }


    #------- ADDITIONAL SETUP -------#
    $installer = (Get-Item "$pgitDir\install.ps1")
    & $installer

    if($oldProfile) {
        $newProfile = [string[]](Get-Content $PROFILE)
        Insert-Script ([REF]$newProfile) "Rename-Item Function:\Prompt PoshGitPrompt -Force"
        Insert-Script ([REF]$newProfile) "function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){PrePoshGitPrompt}PoshGitPrompt}"
        Set-Content -path $profile  -value $newProfile -Force
    }

    Write-ChocolateySuccess 'poshgit'
} catch {
  try {
    if($oldProfile){ Set-Content -path $PROFILE -value $oldProfile -Force }
  }
  catch{}  
  Write-ChocolateyFailure 'poshgit' $($_.Exception.Message)
  throw
}
