To add this *Unofficial* Gentoo overlay  
using the repos.conf file:  
'mkdir /var/db/repos/ephemer0l-overlay && chown portage:portage /var/db/repos/ephemer0l-overlay'  
  
And add the folowing file:  
/etc/portage/repos.conf/ephemer0l-overlay.conf  
  
With the following contents:  
  
[[ephemer0l-overlay]]  
location = /var/db/repos/ephemer0l-overlay  
sync-type = git  
sync-uri = https://github.com/ephemer0l/ephemer0l-overlay.git  
autosync = yes  
sync-user = portage:portage  

Packages in the overlay

[[app-editors/Komodo-Edit-bin]](http://www.activestate.com/products/komodo_edit) Freeware advanced editor for dynamic and Web languages 

[[app-editors/Komodo-IDE]](://www.activestate.com/komodo-ide) Freeware advanced IDE for dynamic and Web languages 

[[app-misc/XPL-SEARCH]](https://github.com/CoderPirata/XPL-SEARCH) Search exploits/vulnerabilities in multiple databases online! 

[[app-mobilephone/gsmlib]](http://www.pxh.de/fs/gsmlib/) Library and applications to access GSM mobile phones  

[[dev-java/oracle-jdk-bin]](http://www.oracle.com/technetwork/java/javase/) you know what this is... 

[[dev-lang/hunter]](https://cpp-pm-hunter.readthedocs.io/en/latest/overview.html) CMake driven cross-platform package manager for C/C++ 

[[dev-libs/keystone]](http://www.keystone-engine.org/) assembly/assembler framework + bindings 

[[dev-libs/serialDV]](https://github.com/f4exb/serialDV) Interface to (en|de)code audio with AMBE3000 devices over a serial link. 

[[dev-util/aptana]](https://github.com/ephemer0l/ephemer0l-overlay/tree/master/dev-util/aptana) The leading eclipse IDE for Ajax and today's web platforms  

[[dev-util/plasma]](https://github.com/ephemer0l/ephemer0l-overlay/tree/master/dev-util/plasma) An interactive disassembler for x86/ARM/MIPS  

[[games-simulation/ThePowderToy]](https://github.com/ephemer0l/ephemer0l-overlay/tree/master/games-simulation/ThePowderToy) The Powder Toy is a free physics sandbox  

[[games-util/kaiEngine]](https://github.com/ephemer0l/ephemer0l-overlay/tree/master/games-util/kaiEngine) Gaming network-bringing together XBox (360,XBox), Playstation (2,3,PSP) users  

[[media-fonts/b612]] Font family designed and tested to be used on aircraft cockpit screens  

[[media-fonts/open-dyslexic]] Opensource font for dyslexics and for high readability  

[[media-libs/codec2]]

[[mdia-libs/dsdcc]]

[[media-libs/hamlib]] 

[[media-libs/ilbc-freeswitch]]

[[media-libs/libhdhomerun]] 

[[media-libs/mbelib]] Dep of net-wireless/dsd

[[media-sound/freeswitch-sounds]]

[[media-sound/freeswitch-sounds-music]]

[[media-sound/teamspeak-client-bin]] 

[[media-tv/comchap]]

[[media-tv/comskip]] Free mpeg commercial detector

[[media-tv/hdhomerun_confing_gui]] SiliconDust HDHomeRun Configuration Utiltiy  

[[media-tv/plex-media-server]] A free media library that is intended for use with a plex client  

[[media-video/filebot]] File renamer 

[[media-video/plex-ffmpeg]] Plex Inc. version of ffmpeg 

[[net-dialup/capi4k-utils]]

[[net-dialup/misdnuser]]

[[net-ftp/pftp]] 

[[net-ftp/pftp-shit]] 

[[net-irc/Limnoria]] Python based extensible IRC infobot and channel bot

[[net-irc/quasselgrep]] Tool for searching quassel logs from the commandline

[[net-libs/ctb]]

[[net-libs/h323plus]]

[[net-libs/libdingaling]]

[[net-libs/libiaxclient]]

[[net-libs/libisdn]]

[[net-libs/libsng-isdn]]

[[net-libs/libsng-ss7]]

[[net-libs/libSquirrelFish]]

[[net-libs/libteletone]]

[[net-libs/osptoolkit]]

[[net-libs/ptlib]]

[[net-libs/sofia-sip]]

[[net-libs/stfu]]

[[net-misc/freetdm]]

[[net-misc/wanpipe]]

[[net-news/sabyenc]]

[[net-news/yencode]] 

[[net-news/yydecode]] 

[[net-voip/freeswitch]]

[[net-voip/freeswitch-mod_ssh]]

[[net-voip/gtkiaxyprov]]

[[net-voip/iaxyprov]]

[[net-wireless/dsd]] Digital Speach Decoder

[[net-wireless/gr-*]] GNU Radio modules

[[net-wireless/virtualradar-bin]] Open-source .NET application for ads-b mapping

[[sci-libs/amd-fftw]]

[[sci-libs/armadillo]]

[[sci-libs/libgeotiff]]

