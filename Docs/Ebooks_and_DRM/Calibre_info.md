# acsm file association
	
	cp digitaleditions.desktop /usr/share/applications

	[Desktop Entry]                                                           
	Encoding=UTF-8                                                            
	Name=digitaleditions                                                      
	Comment=PlayOnLinux                                                       
	Type=Application                                                          
	Exec=/usr/share/playonlinux/playonlinux --run "digitaleditions" %F        
	Icon=/home/alex/.PlayOnLinux//icones/full_size/digitaleditions            
	Name[fr_FR]=digitaleditions                                               
	StartupWMClass=digitaleditions.exe                                        
	Categories=                                                               

Associate with nautilus
open file with --> choose other and select DigitalEdition


# Calibre file convertion fail with

	This application failed to start because it could not find or load the Qt platform plugin "headless"
	in "/usr/lib64/calibre/calibre/plugins".

	Available platform plugins are: headless (from /usr/lib64/calibre/calibre/plugins), minimal, offscreen, xcb.

Probably you rebuild qt libraries and some dependencies is broken.
Try to rebuild Calibre

Calibre 2.78.0 works with dev-qt/qtgui-4.8.7

Trying calibre-3.15.0 with qt dev-qt/qtgui-5.9.4-r3 --> WORKS!
