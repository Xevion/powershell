---
title: "Verb Counts"
summary: A simple script to count up all the verbs used by commands in PowerShell.
date: 2022-04-19
---

This script uses the `Get-Verb` command to sum and provide the percentage of each verb in the Powershell environment.
It prints a sorted table with both the individual verb's number of commands and what percentage it makes up.

{{< code language="powershell" title="CountedVerbs.ps1" >}}
$counts = @{}
$verbs = (Get-Verb).Verb
$Start = (Get-Date)

foreach ($verb in $verbs) { $counts[$verb] = (gcm -Verb $verb).Count }
$Sum = ($counts.Values | Measure-Object -Sum).Sum

$counts.GetEnumerator() | Sort-Object -Property Value
                        | Select-Object Key,Value,@{Name = 'Percentage'; Expression = {(($_.Value) / $Sum).ToString("P")}}
                        | Format-Table -AutoSize

$End = (Get-Date)
Write-Host "$($Sum) commands counted in $(($End - $Start).TotalMilliseconds) ms"
{{< /code >}}

Output, but modified to be in _Descending_ order.

{{< code language="plaintext" isCollapsed="true" title="Output" >}}
Key         Value Percentage
---         ----- ----------
Get           441 26.99%    
Set           230 14.08%    
Remove        141 8.63%     
New           108 6.61%     
Enable         83 5.08%     
Disable        80 4.90%     
Add            70 4.28%     
Export         26 1.59%     
Start          26 1.59%     
Update         26 1.59%     
Clear          22 1.35%     
Import         19 1.16%     
Rename         19 1.16%     
Stop           18 1.10%     
Reset          17 1.04%     
Invoke         16 0.98%     
Test           15 0.92%     
Register       15 0.92%     
Write          14 0.86%     
Unregister     12 0.73%     
Copy           11 0.67%     
Save            9 0.55%     
Find            9 0.55%     
Show            8 0.49%     
Debug           7 0.43%     
Optimize        7 0.43%     
Install         7 0.43%     
Resume          7 0.43%     
Repair          7 0.43%     
ConvertTo       7 0.43%     
ConvertFrom     7 0.43%     
Out             7 0.43%     
Format          7 0.43%     
Suspend         6 0.37%     
Mount           6 0.37%     
Publish         6 0.37%     
Move            6 0.37%     
Uninstall       6 0.37%     
Initialize      5 0.31%     
Restore         5 0.31%     
Restart         5 0.31%     
Wait            4 0.24%     
Unblock         4 0.24%     
Send            4 0.24%     
Disconnect      4 0.24%     
Connect         4 0.24%     
Dismount        4 0.24%     
Receive         3 0.18%     
Resize          3 0.18%     
Expand          3 0.18%     
Complete        3 0.18%     
Select          3 0.18%     
Measure         2 0.12%     
Sync            2 0.12%     
Grant           2 0.12%     
Exit            2 0.12%     
Revoke          2 0.12%     
Read            2 0.12%     
Enter           2 0.12%     
Assert          2 0.12%     
Use             2 0.12%     
Resolve         2 0.12%     
Split           2 0.12%     
Close           2 0.12%     
Convert         2 0.12%     
Block           2 0.12%     
Undo            2 0.12%     
Join            2 0.12%     
Unlock          1 0.06%     
Lock            1 0.06%     
Compare         1 0.06%     
Protect         1 0.06%     
Trace           1 0.06%     
Push            1 0.06%     
Group           1 0.06%     
Switch          1 0.06%     
Limit           1 0.06%     
Unprotect       1 0.06%     
Hide            1 0.06%     
Merge           1 0.06%     
Checkpoint      1 0.06%     
Backup          1 0.06%     
Unpublish       1 0.06%     
Open            1 0.06%     
Confirm         1 0.06%     
Pop             1 0.06%     
Compress        1 0.06%     
Edit            1 0.06%     
Search          0 0.00%     
Skip            0 0.00%     
Deny            0 0.00%     
Ping            0 0.00%     
Approve         0 0.00%     
Request         0 0.00%     
Step            0 0.00%     
Watch           0 0.00%     
Submit          0 0.00%     
Redo            0 0.00%

1634 commands counted in 1335.2045 ms
{{< /code >}}
