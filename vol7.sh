#Win7 vol:
# define $FILE
PROFILE=Win7SP1x64
## redefine this to us another vol binary or include the plugins path
VOL_COMM=vol.py 
## create and define OUT_FOLDER to not use cwd
OUT=text

for p in apihooks autoruns callbacks cmdline cmdscan clipboard consoles dlllist driverirp drivermodule driverscan handles hivelist hivescan iehistory imageinfo ldrmodules malprocfind modscan modules netscan pslist psscan pstree psxview schtasks shellbags ; do 
echo -n "starting $p - "
$VOL_COMM --profile $PROFILE -f $FILE --output=$OUT $p > $OUT_FOLDER/$FILE-vol25c-$p.$OUT; done
echo "$p done"

echo 'starting complex plugins: svcscan V, malfind, mutantscan S, mftparser (body), and timeliner'
$VOL_COMM --profile $PROFILE -f $FILE svcscan -v > $OUT_FOLDER/$FILE-vol25c-svcscanv.txt
$VOL_COMM --profile $PROFILE -f $FILE malfind -v > $OUT_FOLDER/$FILE-vol25c-malfind.txt
$VOL_COMM --profile $PROFILE -f $FILE mutantscan -s > $OUT_FOLDER/$FILE-vol25c-mutants.txt
$VOL_COMM --profile $PROFILE -f $FILE mftparser --output=body > $OUT_FOLDER/$FILE-vol25c-mftparser-body.txt
$VOL_COMM --profile $PROFILE -f $FILE timeliner > $OUT_FOLDER/$FILE-vol25c-tl.txt
echo "Done!"

## wanted, the ss, bl
