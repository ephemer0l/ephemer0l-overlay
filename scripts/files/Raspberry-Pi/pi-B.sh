#!/bin/bash
STAGE_DIR=/media/chroots/raspberry-pi/B
STAGE_DATE=20160220
TMP_DIR=/media/chroots/raspberry-pi/tmp/pi-B
MKERNEL_DIR=/media/chroots/raspberry-pi/kernel
KERNEL_DIR=/media/chroots/raspberry-pi/kernel/linux
ARCHIVE_DIR=/media/chroots/raspberry-pi/archive

echo "Creating working dirs"
#mkdir -p /media/chroots/raspberry-pi/{B,tmp,kernel,archive}
#mkdir -p /media/chroots/raspberry-pi/tmp/pi-B

echo "emergeing crossdev"
#emerge crossdev

echo "Setup crossdev Overlay"
#mkdir -p /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi/{profiles,metadata}
#echo "crossdev-armv6j-hardfloat-linux-gnueabi" >> /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi/profiles/repo_name
#echo "masters = gentoo" >> /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi/metadata/layout.conf
#echo "thin-manifests = true" >> /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi/metadata/layout.conf
#chown -R portage:portage /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi
# Tell portage the repo
#echo "[crossdev-armv6j-hardfloat-linux-gnueabi]" >> /etc/portage/repos.conf/crossdev-armv6j-hardfloat-linux-gnueabi.conf
#echo "location = /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi" >> /etc/portage/repos.conf/crossdev-armv6j-hardfloat-linux-gnueabi.conf
#echo "priority = 11" >> /etc/portage/repos.conf/crossdev-armv6j-hardfloat-linux-gnueabi.conf
#echo "masters = gentoo" >> /etc/portage/repos.conf/crossdev-armv6j-hardfloat-linux-gnueabi.conf
#echo "auto-sync = no" >> /etc/portage/repos.conf/crossdev-armv6j-hardfloat-linux-gnueabi.conf

echo "Building crossdev toolchain"
#crossdev -S -v -t armv6j-hardfloat-linux-gnueabi -oO /usr/local/crossdev-armv6j-hardfloat-linux-gnueabi

echo "Fetching and unpacking Stage3"
curl --progress-bar -o ${TMP_DIR}/stage3-armv6j_hardfp-${STAGE_DATE}.tar.bz2 http://distfiles.gentoo.org/releases/arm/autobuilds/current-stage3-armv6j_hardfp/stage3-armv6j_hardfp-${STAGE_DATE}.tar.bz2
# Unpack the stage3
tar xjf ${TMP_DIR}/stage3-armv6j_hardfp-${STAGE_DATE}.tar.bz2 -C ${STAGE_DIR}
echo "Fetching and unpacking Portage Snapshot"
curl --progress-bar -o ${TMP_DIR}/portage-latest.tar.bz2 http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2
# Unpack Portage snapshot
tar xjf ${TMP_DIR}/portage-latest.tar.bz2 -C ${STAGE_DIR}/usr/

echo "Fetching kernel sources"
cd ${MKERNEL_DIR}
#git clone --depth 1 git://github.com/raspberrypi/linux.git

# Update Kernel source
cd ${KERNEL_DIR}
git pull

echo "Configuring Kernel"
make clean
make ARCH=arm bcmrpi_defconfig
make ARCH=arm CROSS_COMPILE=/usr/bin/armv6j-hardfloat-linux-gnueabi- oldconfig
make ARCH=arm CROSS_COMPILE=/usr/bin/armv6j-hardfloat-linux-gnueabi- -j3
make ARCH=arm CROSS_COMPILE=/usr/bin/armv6j-hardfloat-linux-gnueabi- modules_install INSTALL_MOD_PATH=${STAGE_DIR}

echo "Configuring and building kernel"
cp ${KERNEL_DIR}/arch/arm/boot/zImage ${STAGE_DIR}/boot/kernel.img
cp ${KERNEL_DIR}/arch/arm/boot/dts/*.dtb ${STAGE_DIR}/boot/
mkdir ${STAGE_DIR}/boot/overlays/
cp ${KERNEL_DIR}/arch/arm/boot/dts/overlays/*.dtb* ${STAGE_DIR}/boot/overlays/
cp ${KERNEL_DIR}/arch/arm/boot/dts/overlays/README ${STAGE_DIR}/boot/overlays/

curl --progress-bar -o ${STAGE_DIR}/boot/config.txt https://raw.githubusercontent.com/OpenELEC/OpenELEC.tv/master/packages/tools/bcm2835-bootloader/files/3rdparty/bootloader/config.txt

echo "Creaing archive"
cd ${STAGE_DIR}
tar cJf ${ARCHIVE_DIR}/Gentoo-${STAGE_DATE}-Pi-2.tar.xz bin/ boot/ dev/ etc/ home/ lib/ media/ mnt/ opt/ proc/ root/ run/ sbin/ sys/ tmp/ usr/ var/

echo "Done..."
