#/bin/bash
### Volatility semi-automated memory image processing, for Windows images
### bsk for dfirnotes.org, Copyleft MIT License : https://github.com/DFIRnotes/rules/blob/master/LICENSE
### Requirements: SIFT 3 or volatility 2.5.x ; pictures needs PIL and dot available
### Run volatility framework anlaysis plugins against a provided image in an opinionated order
### 	0) Quick pass to list processes and connections, 1)long run of many plugins with simple args, 
### 	2) long run of complex plugins; 3)make pictures
### Ref: FOR508, Art of Memory Forensics, Malware Analyst Cookbook

### Win7 and up version, set your profile appropriately

## always check the profile if things aren't working right!
VOLATILITY_PROFILE=Win7SP1x86
#define $VOLATILITY_FILEIN for your memory image via export or here
#VOLATILITY_FILEIN=xp-tdungan-memory-raw.001
#define VOLATILITY_LOCATION here or export, module -h for a hint
#VOLATILITY_LOCATION=file:///cases/xp-tdungan-memory/xp-tdungan-memory-raw.001
## redefine this to use another vol binary or include more plugins path
VOLATILITY_COMM=vol.py
## Redirect STDERR for the whole script, comment out to debug a thing
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
## WISHLIST: duplicate image file to run plugins in parallel for faster results / test this more
## WISHLIST: port to BAT for Windows or BETTER python for crossplatform
###

## Volatility banner only needed once per run :)
echo $STARS using Volatility Foundation Volatility Framework 2.5 + Community plugins on `uname`

## get some tables upfront to look for interesting processes
echo "$STARS 0) First, quick tables upfront to look for interesting processes"
for p in pstree malsysproc netscan imageinfo; do
echo -n "$p "
$VOLATILITY_COMM $p --output-file=$OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-$p.txt  ; done
echo; echo "$STARS 0)Quick tables completed. 1)Starting batch plugin processing ..."

## use imageinfo to get KDBG, add to our vol cmd for speedup
KDBG=$(grep KDBG *imageinfo* | awk -F':' '{print $2}' | sed -e 's/L//')
VOL_COMM="$VOL_COMM -g $KDBG"

## do the whole batch of data processing, simple arguments
for q in apihooks callbacks cmdline cmdscan clipboard consoles dlllist driverirp drivermodule driverscan getsids idt iehistory handles hivelist hivescan modscan modules prefetchparser psxview schtasks shellbags ssdt; do 

echo -n " $q, "
$VOLATILITY_COMM $q  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-$q.txt; done
echo; echo "$STARS 1) Batch processing, simple plugin arguments done"

echo "$STARS 2) Starting complex plugins: autoruns V T all Table, pstree -V greptext, ldrmodules V, pstotal DOT, svcscan V, malfind D, mutantscan N, mftparser BODY, and timeliner BODY"
$VOLATILITY_COMM autoruns -v -t all --output=table  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-autoruns.txt
$VOLATILITY_COMM pstree -v --output=greptext > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-pstreeV-grep.txt
$VOLATILITY_COMM ldrmodules -v  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-ldrmodulesv.txt
$VOLATILITY_COMM pstotal --output=dot  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-pstotal.dot
$VOLATILITY_COMM svcscan -v  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-svcscanv.txt
$VOLATILITY_COMM malfind -D $OUT_FOLDER  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-malfindD.txt
$VOLATILITY_COMM mutantscan -s  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-mutantsv.txt
$VOLATILITY_COMM mftparser --output=body  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-mftparser-body.txt 
$VOLATILITY_COMM timeliner --output=body  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-tl.body

echo "$STARS 3) Make pictures!"
dot -T png $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-pstotal.dot > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-pstotal.png
$VOLATILITY_COMM screenshot -D $OUT_FOLDER 

echo "$STARS Volatility batch run on $VOLATILITY_FILEIN completed!"

### and then something like this
#VOLATILITY_FILEIN=xp-tdungan-memory-raw.001 VOLATILITY_PROFILE=WinXPSP3x86 VOLATILITY_COMM=vol.py; for pid in 3296 11640 12244 ; do echo -n "PID $pid :"; for p in dlllist ldrmodules malfind handles; do echo -n "$p "; $VOLATILITY_COMM $p -p $pid > $VOLATILITY_FILEIN-vol25c-$pid-$p.txt 2>/dev/null; done; echo; done
###
