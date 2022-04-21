Function Start-WindowsTerminalAsAdmin {
    Start-Process wt -Verb runas -ArgumentList "-d ."
}

Set-Alias -Name wta -Value Start-WindowsTerminalAsAdmin -Description "Starts Windows Terminal as Administrator in the current directory"