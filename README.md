To add this *Unofficial* Gentoo overlay  
using the repos.conf file:  
'mkdir /var/lib/overlays/ephemer0l-overlay && chown portage:portage /var/lib/overlays/ephemer0l-overlay'  
  
And add the folowing file:  
/etc/portage/repos.conf/ephemer0l-overlay.conf  
  
With the following contents:  
  
[ephemer0l-overlay]  
location = /var/lib/overlays/ephemer0l-overlay  
sync-type = git  
sync-uri = https://github.com/ephemer0l/ephemer0l-overlay.git  
autosync = yes  
sync-user = portage:portage  
  
Or with layman:  
'layman -o https://github.com/ephemer0l/ephemer0l-overlay/blob/master/reposatories.xml -f -a ephemer0l-overlay'  


Packages in the overlay

[app-editors/Komodo-Edit-bin] Freeware advanced editor for dynamic and Web languages 

[app-editors/Komodo-IDE] Freeware advanced IDE for dynamic and Web languages 

[app-misc/XPL-SEARCH] 

[app-mobilephone/gsmlib]

[dev-java/oracle-jdk-bin] you know what this is... 

[dev-libs/keystone]

[dev-libs/serialDV]

[dev-util/aptana] 

[dev-util/plasma] 

[games-simulation/ThePowderToy]

[games-util/kaiEngine]

[mail-filter/libspf2]

[media-fonts/b612] Font family designed and tested to be used on aircraft cockpit screens  

[media-fonts/open-dyslexic] Opensource font for dyslexics and for high readability  

[media-libs/codec2]

[mdia-libs/dsdcc]

[media-libs/hamlib] 

[media-libs/ilbc-freeswitch]

[media-libs/libhdhomerun] 

[media-libs/mbelib] Dep of net-wireless/dsd

[media-sound/freeswitch-sounds]

[media-sound/freeswitch-sounds-music]

[media-sound/teamspeak-client-bin] 

[media-tv/comchap]

[media-tv/comskip] Free mpeg commercial detector

[media-tv/hdhomerun_confing_gui] SiliconDust HDHomeRun Configuration Utiltiy  

[media-tv/plex-media-server] A free media library that is intended for use with a plex client  

[media-video/filebot] File renamer 

[media-video/plex-ffmpeg] Plex Inc. version of ffmpeg 

[net-dialup/capi4k-utils]

[net-dialup/misdnuser]

[net-ftp/pftp] 

[net-ftp/pftp-shit] 

[net-irc/Limnoria] Python based extensible IRC infobot and channel bot

[net-irc/quasselgrep] Tool for searching quassel logs from the commandline

[net-libs/ctb]

[net-libs/h323plus]

[net-libs/libdingaling]

[net-libs/libiaxclient]

[net-libs/libisdn]

[net-libs/libsng-isdn]

[net-libs/libsng-ss7]

[net-libs/libSquirrelFish]

[net-libs/libteletone]

[net-libs/osptoolkit]

[net-libs/ptlib]

[net-libs/sofia-sip]

[net-libs/stfu]

[net-misc/freetdm]
[
net-misc/wanpipe]

[net-news/sabyenc]

[net-news/yencode] 

[net-news/yydecode] 

[net-voip/freeswitch]

[net-voip/freeswitch-mod_ssh]

[net-voip/gtkiaxyprov]

[net-voip/iaxyprov]

[net-wireless/dsd] Digital Speach Decoder

[net-wireless/gr-*] GNU Radio modules

[net-wireless/virtualradar-bin] Open-source .NET application for ads-b mapping

[sci-libs/amd-fftw]

[sci-libs/armadillo]

[sci-libs/libgeotiff]

