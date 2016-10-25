# rules
*Rule files of some use to us, and perhaps some scripts*

In particular @thatguy31415 is working on a collection of rules to categorize files by capabilities, with inspiration from
michael.ligh@mnin.org's marvelous example in Chapter 4 of the *Malware Analyst Cookbook*, carried from Google Code into GitHub by @yararules, and shipped in @lennyzeltser's @REMnux (seriously, the MD5 hashes match).

## here
* some simple yara rules that hit on imported libraries and function calls (CAP_something)
* a batch processing Volatility script or two (eg for SIFT)
* other sample yara rules, such as for PE module
* a sed script for cleaning up VBA code syntax
* OpenIOC examples, such as for Trickbot patterns reported by @hasherazade

## todos
* [.] Win32 Inet CAP yara rule : string match works
	* [ ] needs ordinal detection, which will require yara++ and pe module
* [.] Win32 crypto CAP yara rule : string match works
	* [ ] needs ordinal detection, which will require yara++ and pe module
* [ ] Ransomware strings CAP yara rule 
	* cryptocurrency help sites?
* [ ] DotNet CAP yara rule
	* DotNet doesn't use PE header so much 	
* [.] OpenIOC sample rules, but see some [caveats](https://gist.github.com/adricnet/cb46d182200a40deb6d62c3906da59c9) 

Volatility batch scripts
===

Header explains
---

```
### Volatility semi-automated memory image processing, for WinXP images
### bsk for dfirnotes.org, Copyleft MIT License : https://github.com/DFIRnotes/rules/blob/master/LICENSE
### Requirements: SIFT 3 or volatility 2.5.x ; pictures needs PIL and dot available
### Run volatility framework anlaysis plugins against a provided image in an opinionated order
###     0) Quick pass to list processes and connections, 1)long run of many plugins with simple args, 
###     2) long run of complex plugins; 3)make pictures
### Ref: FOR508, Art of Memory Forensics, Malware Analyst Cookbook
```

TODOs
---

```
### TODO  
## BUGFIX: Set out location to . if env var not set
## FEATURE: document how to branch -2
## FEATURE: Pull volatility version rather than static string
## FEATURE: if file exists and is greater than sizeof(vol usage error), skip the plugin ?
## FEATURE: tidy malsysproc extra linefeeds ?
## WISHLIST: find a way to use the ssdeep, baseline community plugins 
## WISHLIST perf : Specify kdbg offset?
## WISHLIST: duplicate image file to run plugins in parallel for faster results / test this more
## WISHLIST: port to BAT for Windows or BETTER python for crossplatform
###
```

a sample run, XP
---

```
adric@marie:/cases/DFIRNETWARS/xp-tdungan-memory⟫ VOL_FILEIN=xp-tdungan-memory-raw.001 OUT_FOLDER=. bash vol-xp.sh                                                                        
***Volatility batch*** using Volatility Foundation Volatility Framework 2.5 + Community plugins on Linux
***Volatility batch*** 0) First, quick tables upfront to look for interesting processes: pstree malsysproc connections sockets 
***Volatility batch*** 0)Quick tables completed. 1)Starting batch plugin processing ...
 apihooks,  autoruns,  callbacks,  connections,  connscan,  cmdline,  cmdscan,  clipboard,  consoles,  dlllist,  driverirp,  drivermodule,  driverscan,  getsids,  iehistory,  handles,  hivelist,  hivescan,  imageinfo,  ldrmodules,  malfind,  malprocfind,  modscan,  modules,  psscan,  psxview,  schtasks, shellbags,  sockscan, 
***Volatility batch*** 1) Batch processing, simple plugin arguments done
***Volatility batch*** 2) Starting complex plugins: pstotal DOT, eventlogs, svcscan V, mutantscan N, mftparser BODY, and timeliner
3) Make pictures!
Wrote ./session_0.Service-0x0-3e5$.Default.png
Wrote ./session_0.SAWinSta.SADesktop.png
Wrote ./session_0.Service-0x0-3e7$.Default.png
Wrote ./session_0.Service-0x0-3e4$.Default.png
Wrote ./session_3.WinSta0.Default.png
Wrote ./session_3.WinSta0.Disconnect.png
Wrote ./session_3.WinSta0.Winlogon.png
Wrote ./session_0.WinSta0.Default.png
Wrote ./session_0.WinSta0.Disconnect.png
Wrote ./session_0.WinSta0.Winlogon.png
***Volatility batch*** Volatility batch run on xp-tdungan-memory-raw.001 completed!
```
