#/bin/bash
### Volatility semi-automated memory image processing, for WinXP images
### bsk for dfirnotes.org, Copyleft MIT License : https://github.com/DFIRnotes/rules/blob/master/LICENSE
### Requirements: SIFT 3 or volatility 2.5.x ; pictures needs PIL and dot available
### Run volatility framework anlaysis plugins against a provided image in an opinionated order
### 	0) Quick pass to list processes and connections, 1)long run of many plugins with simple args, 
### 	2) long run of complex plugins; 3)make pictures
### Ref: FOR508, Art of Memory Forensics, Malware Analyst Cookbook

### Win7 x64 (64bit) version

VOL_PROFILE=Win7SP1x64
#define $VOL_FILEIN for your memory image
## redefine this to use another vol binary or include more plugins path
VOL_COMM=vol.py 
## Volatility banner on stderr (FD 2)  only needed once per run :)
exec 2>/dev/null
## create and define OUT_FOLDER; . is fine
STARS="***Volatility batch***"

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

## Volatility banner only needed once per run :)
echo $STARS using Volatility Foundation Volatility Framework 2.5 + Community plugins on `uname`

## get some tables upfront to look for interesting processes
echo "$STARS 0) First, quick tables upfront to look for interesting processes"
for p in pstree malsysproc; do
echo -n "$p "
$VOL_COMM -f $VOL_FILEIN $p --output-file=$OUT_FOLDER/$VOL_FILEIN-vol25c-$p.txt  ; done
echo; echo "$STARS 0)Quick tables completed. 1)Starting batch plugin processing ..."

## do the whole batch of data processing, simple arguments
for q in apihooks autoruns callbacks cmdline cmdscan clipboard consoles dlllist driverirp drivermodule driverscan getsids iehistory handles hivelist hivescan imageinfo ldrmodules malfind malprocfind modscan modules psscan psxview schtasks shellbags ; do 

echo -n " $q, "
$VOL_COMM -f $VOL_FILEIN $q  > $OUT_FOLDER/$VOL_FILEIN-vol25c-$q.txt; done
echo "$STARS 1) Batch processing, simple plugin arguments done"

echo "$STARS 2) Starting complex plugins: pstotal DOT, svcscan V, mutantscan N, mftparser BODY, and timeliner"
$VOL_COMM -f $VOL_FILEIN pstotal --output=dot  > $OUT_FOLDER/$VOL_FILEIN-vol25c-pstotal.dot
$VOL_COMM -f $VOL_FILEIN svcscan -v  > $OUT_FOLDER/$VOL_FILEIN-vol25c-svcscanv.txt
$VOL_COMM -f $VOL_FILEIN mutantscan -s  > $OUT_FOLDER/$VOL_FILEIN-vol25c-mutantsv.txt
$VOL_COMM -f $VOL_FILEIN mftparser --output=body  > $OUT_FOLDER/$VOL_FILEIN-vol25c-mftparser-body.txt 
$VOL_COMM -f $VOL_FILEIN timeliner  > $OUT_FOLDER/$VOL_FILEIN-vol25c-tl.txt

echo "$STARS 3) Make pictures!"
dot -T png $OUT_FOLDER/$VOL_FILEIN-vol25c-pstotal.dot > $OUT_FOLDER/$VOL_FILEIN-vol25c-pstotal.png
$VOL_COMM -f $VOL_FILEIN screenshot -D $OUT_FOLDER 

echo "$STARS Volatility batch run on $VOL_FILEIN completed!"

### and then
for pid in $rogues; do for p in dlllist ldrmodules malfind handles; do echo -n "PID $pid"; $VOL_COMM -f $VOL_FILEIN --profile $VOL_PROFILE $p -p $pid > $VOL_FILEIN-vol25c-$pid-$p.txt; done
###