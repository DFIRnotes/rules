#winxp vol:
PROFILE=WinXPSP3x86
#define $FILE
## redfine this to us another vol binary or include the plugins path
VOL_COMM=vol.py 
## create and define OUT_FOLDER to not use cwd

for p in apihooks autoruns callbacks connections connscan cmdline cmdscan clipboard consoles dlllist driverirp drivermodule driverscan iehistory handles hivelist hivescan imageinfo ldrmodules malfind malprocfind modscan modules netscan pslist psscan pstree psxview schtasks shellbags ; do 
echo -n "starting $p - "
$VOL_COMM --profile $PROFILE -f $FILE $p > $OUT_FOLDER/$FILE-vol25c-$p.txt; done
echo "$p done"

echo 'starting complex plugins: eventlogs svcscan V mutantscan N and timeliner'
$VOL_COMM --profile $PROFILE -f $FILE evtlogs -s -O $OUT_FOLDER/ > $OUT_FOLDER/$FILE-vol25c-evtlogs.txt
$VOL_COMM --profile $PROFILE -f $FILE svcscan -v > $OUT_FOLDER/$FILE-vol25c-svcscanv.txt
$VOL_COMM --profile $PROFILE -f $FILE mutantscan -s > $OUT_FOLDER/$FILE-vol25c-mutantsv.txt
$VOL_COMM --profile $PROFILE -f $FILE timeliner > $OUT_FOLDER/$FILE-vol25c-tl.txt
echo "Done!"

## wanted, the ss, bl
