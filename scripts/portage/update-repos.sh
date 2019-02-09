#!/bin/bash
layman -S >> /var/log/portage/auto-sync.log
eix-sync >> /var/log/portage/auto-sync.log
eix-remote update >> /dev/null
