cp /etc/resolv.conf /mnt/gentoo/etc/
mount -t proc proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --rbind /usr/portage /mnt/gentoo/usr/portage
mount --make-rslave /mnt/gentoo/usr/portage
