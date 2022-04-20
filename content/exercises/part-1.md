+++
title = "Part 1 Exercises"
summary = "All 10 exercises & my solutions in Part 1."
+++

### Exercise 1

Get all services where the display name begins with ‘Windows’.

```powershell
Get-Service -DisplayName Windows*
```


### Exercise 2 

Get a list of all classic event logs on your computer.

```powershell
Get-WinEvent -ListLog * | ? {$_.IsClassicLog}
```


### Exercise 3

Find and display all of the commands on your computer that start with ‘Remove’.

```powershell
gcm -Verb Remove
```

### Exercise 4

What PowerShell command would you use to reboot one or more remote computers?

```powershell
Restart-Computer <ComputerNames>
```

### Exercise 5

How would you display all available modules installed on your computer?

```powershell
Get-Module -ListAvailable
```

### Exercise 6

How would you restart the BITS service on your computer and see the result?

```powershell
Restart-Service BITS -PassThru
```

### Exercise 7

List all the files in the %TEMP% directory and all subdirectories.

```powershell
ls $env:TEMP -Recurse -File
```

### Exercise 8

Display the access control list (ACL) for Notepad.exe.

```powershell
Get-Acl (Get-Command notepad.exe).Path | Format-List
```

### Exercise 9

How could you learn more about regular expressions in PowerShell?

```powershell
help about_Regular_Expressions
```

### Exercise 10

Get the last 10 error entries from the System event log on your computer.

```powershell
Get-WinEvent -FilterHashtable @{Logname="System";Level=2} -MaxEvents 10
```

### Exercise 11

Show all of the ‘get’ commands in the PSReadline module.

```powershell
Get-Command -Verb Get -Module PSReadline
```

### Exercise 12

Display the installed version of PowerShell.

```powershell
$PSVersionTable.PSVersion
```


### Exercise 13

How would you start a new instance of Windows PowerShell without loading any profile scripts?

```powershell
PowerShell -NoProfile
```

### Exercise 14

How many aliases are defined in your current PowerShell session?

```powershell
(gal | Measure-Object).Count
```

### Exercise 15

List all processes on your computer that have a working set size greater than or equal to 50MB and
sort by working set size in descending order.

```powershell
ps | ? {$_.ws -gt 50mb} | sort ws -Descending
```

### Exercise 16

List all files in %TEMP% that were modified in the last 24 hours and display the full file name, its size,
and the time it was last modified. Write a PowerShell expression that doesn’t rely on hard-coded
values.

```powershell
Get-ChildItem $env:TEMP | ? {$_.LastWriteTime -gt ((Get-Date).AddDays(-1))} | select Name,Length,LastWriteTime
```

### Exercise 17

Get all files in your Documents folder that are at least 1MB in size and older than 90 days. Export
the full file name, size, creation date, and last modified date to a CSV file. You may have to adjust
the exercise based on files you have available.

```powershell
$minimumAge = (Get-Date).AddDays(0)
$files = $env:USERPROFILE + "\Documents\" | ls -Recurse -File | ? {($_.Length -gt 1MB) -and ($_.CreationTime -lt $minimumAge)}
$files | select Name,@{Name="Size"; Expression={"{0:f2} MB" -f ($_.Length / 1MB)}},CreationTime,LastWriteTime | Export-Csv "./document_list.csv" -NoType
```

### Exercise 18

Using files in your %TEMP% folder, display the total number of each files by their extension in
descending order

```powershell
ls $env:TEMP -Recurse -File | group Extension | sort Count -D | select Count, Name
```

The `select` at the end can also be done with `Group-Object`'s `-NoElement` command.

### Exercise 19

Create an XML file of all processes running under your credentials.

```powershell
$domain = "{0}\{1}" -f $env:USERDOMAIN,$env:USERNAME
ps -IncludeUserName | ? {$_.Username -eq $domain} | Export-Clixml .\user_processes.xml -Depth 1
```

Another way to get the current user's domain/credentials is the `whoami` command.
Runs for 29 seconds. Increase depth for increased object detail, but export time is increased tenfold.

### Exercise 20

Using the XML file, you created in the previous question, import the XML data into your PowerShell
session and produce a formatted table report with processes grouped by the associated company
name.

```powershell
Import-Clixml .\user_processes.xml | sort Company | Format-Table -GroupBy Company
```

### Exercise 21

Get 10 random numbers between 1 and 50 and multiply each number by itself.

```powershell
Get-Random -Count 10 -Minimum 1 -Maximum 50 | % {$_ * $_}
```

### Exercise 22

Get a list of event logs on the local computer and create an HTML file that includes ‘Computername’
as a heading. You can decide if you want to rename other headings to match the original cmdlet
output once you have a solution working.

```powershell
Get-WinEvent -ListLog * | select LogName, LogMode, RecordCount, @{Name="Max Size (MB)";Expression={[int] ($_.MaximumSizeInBytes / 1mb)}} | ConvertTo-Html -PreContent "<h1>$($env:COMPUTERNAME)</h1>" | Out-File event-log.html
```

### Exercise 23

Get modules in the PowerShell Gallery that are related to teaching

```powershell
Find-Module -Tag teaching -Repository PSGallery
```

Copied directly from the solution; couldn't figure this one out. Funny enough, the version is 4.2.0, and I'm writing this
on 4/20.

Also, it's quite apparent that this exercise is trying to promote the author's own module, _PSTeachingTools_ as the only module that
comes up is authored by him.

```powershell
> Find-Module -Tag teaching -Repository PSGallery | select Name,Version,Type,Description,Author | Format-List

Name        : PSTeachingTools
Version     : 4.2.0
Type        : Module
Description : A set of commands and tools for teaching PowerShell.
Author      : Jeff Hicks
```

I guess he won, because he got me to look at the module, as well as whoever reads this.

### Exercise 24

Get all running services on the local machine and export the data to a JSON file. Omit the required
and dependent services. Verify by re-importing the JSON file.

```powershell
gsv | ? {$_.Status -eq "Running"} | select * -Exclude *Services* | ConvertTo-Json -Compress | Out-File running_services.json
Get-Content .\running_services.json | ConvertFrom-Json
```

My solution had issues initially due to depth (required and dependent services are included, thus services would be referenced within services).

By simply adding a `select -Exclude` to remove those two properties, the output file size is reduced and warnings about JSON being
truncated go away.

### Exercise 25

Test the local computer to see if port 80 is open.

```powershell
(Get-NetTCPConnection -state Listen -LocalPort 80 | measure).Count -ge 1
(Test-NetConnection -ComputerName localhost -Port 80 -WarningAction SilentlyContinue).TcpTestSucceeded
```

The first line contains my personal solution, the second solution is one the book gave, but slightly tweaked. Both return a `True` or `False`.

The solution provided by the book seems sorta odd, but it does genuinely "test" the connection. Additionally, it uses
the `CommonTCPPort` parameter, which I can't find any information on.

Instead, given that we only need to know about open ports running on the local computer, we can simply gather all open listening
connections on the computer and see if Port `80` is among them. I tested it against port `4884` which is running my 
local Hugo instance, and it worked for both commands above.