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

[media-fonts/b612] Font family designed and tested to be used on aircraft cockpit screens  

[media-fonts/open-dyslexic] Opensource font for dyslexics and for high readability  

[media-tv/comskip] Free mpeg commercial detector

[media-tv/hdhomerun_confing_gui] SiliconDust HDHomeRun Configuration Utiltiy  

[media-tv/plex-media-server] A free media library that is intended for use with a plex client  

[net-analyzer/w3af] Web Application Attack and Audit Framework

[net-irc/quasselgrep] Tool for searching quassel logs from the commandline  

[net-wireless/gr-*] GNU Radio modules

[net-wireless/virtualradar-bin] Open-source .NET application for ads-b mapping

[www-apps/beef] Browser exploitation framework
