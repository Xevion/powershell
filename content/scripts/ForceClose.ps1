param (
    [Int32]$targetPort = "8080",
    [string]$processName = "java"
)

function Pluralize($value)
{
    if ($value -eq 1)
    {
        return ""
    }

    return "s"
}

$connections = Get-NetTCPConnection -state Listen -LocalPort $targetPort -ErrorAction 'SilentlyContinue'

if ($connections.Length -eq 0)
{
    Write-Host "No ports were open and listening on ${targetPort}"
    return
} else
{
    $processes = $connections | % { Get-Process -Id $_.OwningProcess } | ? { $_.Name -like $processName }
    $processCount = $processes.Length
    Write-Host "Closing ${processCount} process${processCount | Pluralize} open on ${targetPort}..."

    $processes |
            Stop-Process -Force -PassThru |
            select -Property Name, ProcessName, StartTime, HasExited, ExitTime |
            Format-List
}