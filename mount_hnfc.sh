#!/bin/bash
## Grab the original HoneyNet challenge files from hn.org, extract and mount them.
## Needs sudo for mounting
## TODO: It would be good to check if the files exists before making with the downloading (again)

mkdir /cases/hnfc; cd /cases/hnfc

wget http://old.honeynet.org/misc/files/challenge-images.tar
tar xf challenge-images.tar
for i in *.gz; do gunzip $i; done

sudo mkdir -p /mnt/hnfc

sudo mount -o loop,ro /cases/hnfc/honeypot.hda8.dd /mnt/hnfc/
sudo mount -o loop,ro /cases/hnfc/honeypot.hda1.dd /mnt/hnfc/boot
sudo mount -o loop,ro /cases/hnfc/honeypot.hda6.dd /mnt/hnfc/home
sudo mount -o loop,ro /cases/hnfc/honeypot.hda5.dd /mnt/hnfc/usr
sudo mount -o loop,ro /cases/hnfc/honeypot.hda7.dd /mnt/hnfc/var

echo 'To chroot: sudo chroot /mnt/hnfc /bin/bash'
