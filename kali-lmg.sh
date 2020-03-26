#!/bin/bash
###  Mods to lmg for Kali use
### Install deps, checkout things, set up folders for success, baseed on https://github.com/halpomeranz/lmg
### uses volatility, avml, lmg

## apt installs
sudo apt install volatility dwarfdump sleuthkit ipython lime-forensics-dkms ewf-tools gdb

## git clone volatility and profiles, lmg
git clone https://github.com/halpomeranz/lmg
git clone https://github.com/volatilityfoundation/volatility
# git clone https://github.com/volatilityfoundation/profiles

cd lmg

wget https://github.com/microsoft/avml/releases/download/v0.2.0/avml

#rename avml , link our system dwarfdump into lmg with LMG expected names
# ln -s /home/kali/volatility .
ln -s /usr/bin/dwarfdump dwarfdump-x86_64
mv avml avml-x86_64

## hardcode volatility, lime locations into lmg ?
## here's a patch, in a here doc, made with 
# diff -u lmg lmg-kali > patch.lmg 
## according to man patch, we could run patch against this script and it should work...

## patch it in
patch lmg  <<lmg-kali-hardcoded-locations-patch

116c116
<     LIMEMOD=$(find $DIRLIST -name lime-$KVER-$CPU.ko | head -1)
---
>     LIMEMOD="/var/lib/dkms/lime-forensics/1.9-2/5.4.0-kali4-amd64/x86_64/module/lime.ko"
196c196
<     VOLDIR=$(dirname $(find $BUILDDIR -name module.c) 2>/dev/null)
---
>     VOLDIR="/home/kali/lmg/volatility/tools/linux"

lmg-kali-hardcoded-locations-patch
## /here-doc

