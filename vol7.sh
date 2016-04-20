#Win7 vol:
# define $FILE
PROFILE=Win7SP1x86
## redfine this to us another vol binary or include the plugins path
VOL_COMM=vol.py 
## create and define OUT_FOLDER to not use cwd
OUT_FOLDER=.
OUT=text

for p in apihooks autoruns callbacks cmdline cmdscan clipboard consoles dlllist driverirp drivermodule driverscan handles hivelist hivescan iehistory imageinfo ldrmodules malfind malprocfind modscan modules netscan pslist psscan pstree psxview schtasks shellbags ; do 
echo -n "starting $p - "
$VOL_COMM --profile $PROFILE -f $FILE --output=$OUT $p > $OUT_FOLDER/$FILE-vol25c-$p.$OUT; done
echo "$p done"

echo 'starting complex plugins: svcscan V mutantscan N and timeliner'
$VOL_COMM --profile $PROFILE -f $FILE svcscan -v > $OUT_FOLDER/$FILE-vol25c-svcscanv.txt
$VOL_COMM --profile $PROFILE -f $FILE mutantscan -n > $OUT_FOLDER/$FILE-vol25c-mutantsv.txt
$VOL_COMM --profile $PROFILE -f $FILE timeliner > $OUT_FOLDER/$FILE-vol25c-tl.txt
echo "Done!"

## wanted, the ss, bl
