<#
    .Description
    This script checks if the given port has been placed in a excluded port range.
    This script utilizes the netsh command and only observes TCP exclusion ranges.
#>
param (
    [Parameter(Mandatory=$true)]
    [Int32]
    $targetPort
)

# Filters excluded port range output to just the ports
$rawPortRanges = netsh interface ipv4 show excludedportrange protocol=tcp | Select-String "\d+\s+\d+"
# Cleans the output to include just start/end port with a single space
$cleanPortRanges = $rawPortRanges -replace "\s+(\d+)\s+(\d+).*", '$1 $2'

$found = $false
$cleanPortRanges | % {
    # Break apart the port, intrepret as int
    $start, $end = $_.toString().split(' ')
    $start = $start -as [int]
    $end = $end -as [int]

    # Complete the check
    if ($targetPort -In $start..$end) {
        $found = $true
        Write-Host "${start} - ${end}"
        Write-Host "`tPort ${targetPort} is in an excluded port range."
        Break  # Assumption: Excluded port ranges do not overlap
    }
}

# Default output
if (!$found) {
    Write-Host "Port ${targetPort} is not in an excluded port range."
}