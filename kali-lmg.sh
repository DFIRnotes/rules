
## apt installs
sudo apt install volatility dwarfdump sleuthkit ipython lime-forensics-dkms ewf-tools gdb

## git clone volatility and profiles, lmg
git clone https://github.com/halpomeranz/lmg

cd lmg

wget https://github.com/microsoft/avml/releases/download/v0.2.0/avml ?

#rename avml , link our volatility dwarfdump into lmg with LMG expected names
ln -s /home/kali/volatility .
ln -s /usr/bin/dwarfdump dwarfdump-x86_64
mv avml avml-x86_64

## hardcode volatility, lime locations into lmg ?
## here's a patch, in a here doc, made with 
# diff -u lmg lmg-kali > patch.lmg 
## according to man patch, we could run patch against this script and it should work...

## patch it in
patch <<lmg-kali-hardcoded-locations-patch

*** lmg 2020-03-26 13:41:29.268837679 -0400
--- lmg-kali    2020-03-26 13:40:23.624032861 -0400
***************
*** 113,119 ****
  
  if [[ ! ( -r $CAPTUREDIR/$HOST-$TIMESTAMP-memory.$FORMAT ) ]]; then
      # Try to find a pre-built LiME module
!     LIMEMOD=$(find $DIRLIST -name lime-$KVER-$CPU.ko | head -1)
      # If not found, see if we should try to build one
      if [[ -z $LIMEMOD ]]; then
        if [[ $YESTOALL == 'n' ]]; then
--- 113,120 ----
  
  if [[ ! ( -r $CAPTUREDIR/$HOST-$TIMESTAMP-memory.$FORMAT ) ]]; then
      # Try to find a pre-built LiME module
! ##    LIMEMOD=$(find $DIRLIST -name lime-$KVER-$CPU.ko | head -1)
!     LIMEMOD="/var/lib/dkms/lime-forensics/1.9-2/5.4.0-kali4-amd64/x86_64/module/lime.ko"
      # If not found, see if we should try to build one
      if [[ -z $LIMEMOD ]]; then
        if [[ $YESTOALL == 'n' ]]; then
***************
*** 193,199 ****
  fi
  if [[ $YESTOALL == 'y' || $prof == 'y' || $prof = 'Y' ]]; then
  ##  VOLDIR=$(dirname $(find $BUILDDIR -name module.c) 2>/dev/null)
!     VOLDIR="/home/kali/lmg/volatility"
      if [[ -z $VOLDIR ]]; then
        echo "Didn't find volatility directory under $BUILDDIR"
        VOLDIR=$(dirname $(find $TOOLDIR -name module.c) 2>/dev/null)
--- 194,200 ----
  fi
  if [[ $YESTOALL == 'y' || $prof == 'y' || $prof = 'Y' ]]; then
  ##  VOLDIR=$(dirname $(find $BUILDDIR -name module.c) 2>/dev/null)
!     VOLDIR="/home/kali/lmg/volatility/tools/linux"
      if [[ -z $VOLDIR ]]; then
        echo "Didn't find volatility directory under $BUILDDIR"
        VOLDIR=$(dirname $(find $TOOLDIR -name module.c) 2>/dev/null)

lmg-kali-hardcoded-locations-patch
## /here-doc

