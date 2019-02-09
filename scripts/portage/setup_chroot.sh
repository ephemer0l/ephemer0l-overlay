#!/bin/bash
echo "Europe/Berlin" > /etc/timezone
emerge --config sys-libs/timezone-data
emerge world -vuNDt
#emerge vim git
mkdir /etc/portage/repos.conf
cp files/om.conf /etc/portage/repos.conf/
emaint sync -r om
eselect profile set 23
eselect profile list
