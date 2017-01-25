function Edit-HostsFile {
    Start-Process -FilePath code -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}