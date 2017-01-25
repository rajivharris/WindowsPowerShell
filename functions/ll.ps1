function ll
{
    param ($dir = ".", $all = $false)
 
    $origFg = $Host.UI.RawUI.ForegroundColor
    if ( $all ) { $toList = Get-ChildItem -force $dir }
    else { $toList = Get-ChildItem $dir }
 
    foreach ($Item in $toList)
    {
        Switch ($Item.Extension)
        {
            ".exe" {$Host.UI.RawUI.ForegroundColor="DarkYellow"}
            ".hta" {$Host.UI.RawUI.ForegroundColor="DarkYellow"}
            ".cmd" {$Host.UI.RawUI.ForegroundColor="DarkRed"}
            ".ps1" {$Host.UI.RawUI.ForegroundColor="DarkGreen"}
            ".html" {$Host.UI.RawUI.ForegroundColor="Cyan"}
            ".htm" {$Host.UI.RawUI.ForegroundColor="Cyan"}
            ".7z" {$Host.UI.RawUI.ForegroundColor="Magenta"}
            ".zip" {$Host.UI.RawUI.ForegroundColor="Magenta"}
            ".gz" {$Host.UI.RawUI.ForegroundColor="Magenta"}
            ".rar" {$Host.UI.RawUI.ForegroundColor="Magenta"}
            Default {$Host.UI.RawUI.ForegroundColor=$origFg}
        }
        if ($item.Mode.StartsWith("d")) {$Host.UI.RawUI.ForegroundColor="Gray"}
        $item
    }
    $Host.UI.RawUI.ForegroundColor = $origFg
}