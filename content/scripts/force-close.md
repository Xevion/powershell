+++
title = "Dangling Process Closer"
summary = "A simple script for Firebase Emulators to close dangling processes."
date = 2022-04-28
+++

This script was developed while building a Firebase app that had a local emulator run. Often, this emulator
would freeze up and not close properly, so opening up a Task Manager (I used _Process Hacker_ because it's easier) and
manually close the dangling `java.exe` process.

This became so common and disruptive that I created a little script to find and kill the process for me.

It's not that big of a deal, but I gotta add content to this site, so why not...

Raw file available at  {{% absolute_url "./scripts/ForceClose.ps1" %}}

```powershell
{{% file "/scripts/ForceClose.ps1" %}}
```