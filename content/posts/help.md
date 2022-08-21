+++
title = "The Help System"
date = "2022-04-19T10:44:28-05:00"
author = "Xevion"
description = "Stuck? Lost? Not sure how to find anything out? The help system is an effective way to find out what you need to know."
+++

Information on acquiring information about Cmdlets and using the help system effectively.

---

To acquire information on a command or subject, use the `Get-Help [Cmdlet]` command. The `man` and `help` aliases are available, but note that
they automatically pipe to `More` for improved viewing.

You can use the `-online` flag to browse the help documentation online.

> In order to view documentation on commands, you will need to update documentation for powershell.
> This can easily be done using `Update-Help`, but you need to be running in administrator to do this.
> I personally recommend using `-Force` to 'assist' some modules into updating.

Note that there are options for updating help, take a look at `Save-Help` and `Update-Help -SourcePath` to do this.



### Finding Commands

In the search for a specific command, you can use _wildcards_ to make it easy. The wildcard character matches
searches for 0 or more characters; thus if you place `*` in front of `event` and search for it: `help *event`,
you'll find it matching anything that ends with `event` in the subject's name, regardless of what comes before it.

However, `Get-Help` searches for _help topics_, _modules_ that may or may not exist for every command (while they most likely do, it's not 100%).
Furthermore, your results could be polluted by topics you aren't interested in; if you strictly want commands, `Get-Command` is your friend.

Do note though: while `Get-Command` supports wildcard, you should use the `-Noun` and `-Verb` parameters to make sure
no external commands are returned (Only Cmdlets have _nouns_ or _verbs_). Another way is with the `-Type` parameter, (i.e. `-Type Cmdlet`).

### Potential Usages

```powershell
Get-Help [Subject]
help [Subject]
man [Subject]
Get-Help [Subject] | More
help [Subject] -online  # Open the help documentation online, in the browser   
[Cmdlet] -?
help *event*
help Get-Event -Full  # Include all information on the subject at once
help Get-Service -Examples  # Look at examples for the given command
help Get-Service -Parameter ComputerName  # Look at information on specific parameter
help gsv -ShowWindow  # Present the help information in a small window with search, selection and scrolling
Get-Command -Noun *event -Verb Get  # Find all Cmdlets that end with "Event" and use "Get" as their verbx
gcm -Noun *event* -Type Cmdlet  # Find all Cmdlets that end with "Event"
```
