<#
.SYNOPSIS
    Microsoft.PowerShell_profile.ps1 - My PowerShell profile
.DESCRIPTION
    Microsoft.PowerShell_profile - Customizes the PowerShell console
.NOTES
    File Name   : Microsoft.PowerShell_profile.ps1
    Author      : Rajivkumar Ashokan
#>


# ahh yes... this would be so nice if it was a built in variable
$powershellprofiledir = Split-Path -Parent $MyInvocation.MyCommand.Path

# function loader
#
# if you want to add functions to your powershell profile 
# add scripts to functions directory or you can inline them
# in this file. Ignoring the dot source of any tests
Resolve-Path $powershellprofiledir\functions\*.ps1 | 
Where-Object { -not ($_.ProviderPath.Contains(".Tests.")) } |
ForEach-Object { . $_.ProviderPath }

# inline functions, aliases and variables
function which($name) { Get-Command $name | Select-Object Definition }
function rm-rf($item) { Remove-Item $item -Recurse -Force }
function touch($file) { "" | Out-File $file -Encoding ASCII }


$MyScriptDir = "$powershellprofiledir\scripts"

#$UserBinDir = "$($env:UserProfile)\bin"

# PATH update
#
# creates paths to every subdirectory of userprofile\bin
# adds script dir to path
$paths = @("$($env:Path)", $MyScriptDir)
#gci $UserBinDir | % { $paths += $_.FullName }
$env:Path = [String]::Join(";", $paths) 
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
