function Test-Port {
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true)]
        [string]$Target,
        [parameter(mandatory=$true)]
        [int32]$Port,
        [int32]$Timeout=2000
    )
    $outputobj=New-Object -TypeName PSobject
    $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostName -Value $Target
    if(Test-Connection -ComputerName $Target -Count 2) {
        $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "ONLINE"
    }
    else {
        $outputobj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "OFFLINE"
    }            
    $outputobj | Add-Member -MemberType NoteProperty -Name PortNumber -Value $Port
    $Socket=New-Object System.Net.Sockets.TCPClient
    $Connection=$Socket.BeginConnect($Target,$Port,$null,$null)
    $Connection.AsyncWaitHandle.WaitOne($timeout,$false) | Out-Null
    if($Socket.Connected -eq $true) {
        $outputobj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Success"
    }
    else {
        $outputobj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Failed"
    }            
    $Socket.Close | Out-Null
    $outputobj | Select TargetHostName, TargetHostStatus, PortNumber, Connectionstatus | Format-Table -AutoSize
}