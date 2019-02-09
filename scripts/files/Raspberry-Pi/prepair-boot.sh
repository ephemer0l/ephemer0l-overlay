#!/bin/bash
STAGE_DATE=20160220
BBOOT=/media/chroots/raspberry-pi/B/boot
KERNEL=/media/chroots/raspberry-pi/kernel/linux

#cd /media/chroots/raspberry-pi/B/
#wget http://distfiles.gentoo.org/releases/arm/autobuilds/current-stage3-armv6j_hardfp/stage3-armv6j_hardfp-${STAGE_DATE}.tar.bz2

#tar xjf stage3-arm6j-hardfp-*.tar.bz2 -C /media/chroots/raspberry-pi/B/

#cd ${KERNEL}
#git pull

#ARCH=arm genkernel --config=/media/chroots/raspberry-pi/kernel/genkernel-B.conf --kernel-config=${KERNEL}/arch/arm/configs/bcmrpi_defconfig kernel
#cd ${KERNEL}
#git pull
# Pi B
#make ARCH=arm bcmrpi_defconfig INSTALL_MOD_PATH=${BBOOT}
#make ARCH=arm CROSS_COMPILE=/usr/bin/armv6j-hardfloat-linux-gnueabi- -j3
#make ARCH=arm CROSS_COMPILE=/usr/bin/armv6j-hardfloat-linux-gnueabi- modules_install INSTALL_MOD_PATH=${BBOOT}



cp /media/chroots/raspberry-pi/firmware/boot/bootcode.bin ${BBOOT}
cp /media/chroots/raspberry-pi/firmware/boot/fixup.dat ${BBOOT}
cp /media/chroots/raspberry-pi/firmware/boot/start.elf ${BBOOT}
cp /media/chroots/raspberry-pi/firmware/boot/fixup_cd.dat ${BBOOT}
cp /media/chroots/raspberry-pi/firmware/boot/start_cd.elf ${BBOOT}
#mkdir ${BBOOT}/overlays
cp ${KERNEL}/arch/arm/boot/dts/*.dtb ${BBOOT}
cp ${KERNEL}/arch/arm/boot/dts/overlays/*.dtb* ${BBOOT}/overlays
cp ${KERNEL}/arch/arm/boot/dts/overlays/README  ${BBOOT}/overlays

#imagetool-uncompressed.py ${KERNEL}/arch/arm/boot/Image ${BBOOT}/kernel.img


# Create image to dd to sdcard
#dd if=/dev/zero of=/media/chroots/raspberry-pi/images/Gentoo-Pi-B-${STAGE_DATE}.img bs=1M count=4194304
#mkfs.ext4 -F /media/chroots/raspberry-pi/images/Gentoo-Pi-B-${STAGE_DATE}.img

#dd if=/dev/zero of=/media/chroots/raspberry-pi/images/Gentoo-Pi-B-${STAGE_DATE}-boot.img bs=1M count=128000
#mkfs.vfat -F /media/chroots/raspberry-pi/images/Gentoo-Pi-B-${STAGE_DATE}-boot.img

#mkdir /media/chroots/raspberry-pi/tmp/
#mount -o loop,rw,sync /media/chroots/raspberry-pi/images/Gentoo-Pi-B-${STAGE_DATE}.img /media/chroots/raspberry-pi/tmp/

