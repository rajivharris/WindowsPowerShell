# prompt customization

#helper function
function Get-Time {
    return $(Get-Date | ForEach-Object {$_.ToLongTimeString()})
}

# This is function is called by convention in PowerShell
function prompt {
    Write-Host $(Get-Time) -n -f Green
Write-Host " " -n
#write-host (" "+[net.dns]::GetHostName() +" ") -n -f Green
Write-Host $($(Get-Location).Path) -f Cyan
Write-Host $($([char]0x03BB)) -n -f Gray   
return " "
}