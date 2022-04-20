+++
title = "Lab One"
summary = "My answers for Lab One"
date = 2022-04-19
+++

1. N/A

2. `ConvertTo-Html`

3. `Out-File` for redirecting output into a file. Use the Pipe operator or the `InputObject` parameter for the input.
 `Out-Printer` is exactly the same as above, but is used for outputting to a printer.

4. 5 Cmdlets are available.
   
   `Get-Command -Noun Process` will show you these processes.

   To get the specific number, `(Get-Command -Noun Process).Count` is available, revealing 5 Process handling Cmdlets.

5. `Write-EventLog`

6. 5 commands are available.
   - `Export-Alias`
   - `Get-Alias`
   - `Import-Alias`
   - `New-Alias`
   - `Set-Alias`

7. `Start-Transcript` and `Stop-Transcript`

8. The `-Newest` parameter.

9. The `Get-Service` Cmdlet lets one retrieve a list of services and access remote computers via the `-ComputerName` parameter.

10. The `Get-Process` Cmdlet lets one retrieve a list of running processes on computers, including remote computers via the `-ComputerName` parameter.


11. The `-Width` parameter lets one resize it.

12. The `-NoClobber` parameter ensures that the `Out-File` Cmdlet will not overwrite any existing files.

13. The `Get-Alias` command.

14.  `ps -C Server1` is the shortest possible, using the `ps` alias and the `-ComputerName` parameter, which at shortest uses only 2 characters; the hyphen and the first character in the parameter's name, `C`.

15.  This can be counted quickly via `(gcm -Noun Object).Count` which yields **9**.

16.  The `about_Arrays` topic, accessible via `help about_Arrays`.