#!/bin/bash
### Implements triage technique from
## 			http://volatility-labs.blogspot.com/2016/08/automating-detection-of-known-malware.html
##			retweeted by @gleeda from @volatility
##	with much of the code from vol batch scripts: https://github.com/dfirnotes/rules
##  "Is any of the code in this memory image detectable by AV as known malware?"
### bsk for dfirnotes.org, Copyleft MIT License : https://github.com/DFIRnotes/rules/blob/master/LICENSE

### For best effect export these variables or edit script to set here

## always check the profile if things aren't working right!
VOLATILITY_PROFILE=Win7SP1x86
#define $VOLATILITY_FILEIN for your memory image via export or here
#VOLATILITY_FILEIN=xp-tdungan-memory-raw.001
#define VOLATILITY_LOCATION here or export, module -h for a hint
#VOLATILITY_LOCATION=file:///cases/xp-tdungan-memory/xp-tdungan-memory-raw.001
## redefine this to use another vol binary or include more plugins path
VOLATILITY_COMM=vol.py
## create and define OUT_FOLDER; . is fine
CLAMSCAN_COMM="clamscan -i -o"

## Redirect STDERR for the whole script, comment out to debug a thing
exec 2>/dev/null

## Formated output is nice
STARS="***Gleeda's Vol ClamAV Triage***"

echo "$STARS Starting  plugins: dlldump memory D, malfind D, moddump"

$VOLATILITY_COMM dlldump -memory -D $OUT_FOLDER  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-dllddumpMD.txt
$VOLATILITY_COMM malfind -D $OUT_FOLDER  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-malfindD.txt
$VOLATILITY_COMM moddump -memory -D $OUT_FOLDER  > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-moddumpMD.txt

echo "$STARS Plugins done; starting ClamAV scan: "

$CLAMSCAN_COMM $OUT_FOLDER > $OUT_FOLDER/$VOLATILITY_FILEIN-vol25c-clamscan.txt

echo "$STARS completed"

