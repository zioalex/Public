# Software Version
Tested with calibre 2.78.0 on Gentoo
Tested with calibre 3.3.0 on Sabayon

Not working calibre 3.8.0 on Sabayon


# Why Do I need to remove it?
Because I want to read book legally borrowed from a library on the Amazon Kindle. Unfortunately it doesn't support ADE DRM content.

# Install Adobe Digital Edition
It requires wine
## Install wine and playonlinux and winetricks

    emerge -av playonlinux winetricks

After PlayOnLinux installation run it and through the gui install Adobe Digital Edition 4.5 (ADE)

With the standard wine version configured by playonlinux I had no internet connectivity!

I solved it using the system wine installation ( v1.8.3 )

Once installed you can start to use ADE. You need to create an account. Afterwards you will need to
extract the key that will be used by the DeDRM tool.

Follow the info here:
	https://github.com/apprenticeharper/DeDRM_tools/blob/master/DeDRM_calibre_plugin/DeDRM_plugin_ReadMe.txt

# Get the ADE key
I tried with the info in sourcecode:

    https://github.com/apprenticeharper/DeDRM_tools/blob/master/Other_Tools/DRM_Key_Scripts/Adobe_Digital_Editions/adobekey.pyw
    Windows users: Before running this program, you must first install Python.
    We recommend ActiveState Python 2.7.X for Windows (x86) from
    http://www.activestate.com/activepython/downloads.
    You must also install PyCrypto from
    http://www.voidspace.org.uk/python/modules.shtml#pycrypto
    (make certain to install the version for Python 2.7).
    Then save this script file as adobekey.pyw and double-click on it to run it.
    It will create a file named adobekey_1.der in in the same directory as the script.
    This is your Adobe Digital Editions user key.

But I had no luck with ActiveState Python ( ActivePython-2.7.13.2713-win32-x86-401787.exe ) and the I fall back to base python installation.

I downloaded python-2.7.13.msi from here https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi

Then I started a Windows Command Line from PlayOnLinux and tried to install pycrypto but I discovered
that it needs another library; the Microsoft Visual C++ Compiler for Python 2.7.

After downloaded

https://www.google.de/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjku8CX6NbSAhXLERQKHQocA4UQFggcMAA&url=https%3A%2F%2Fwww.microsoft.com%2Fen-us%2Fdownload%2Fdetails.aspx%3Fid%3D44266&usg=AFQjCNGcLCiv_suv67XLcfGWw-Wi2xFRKQ&sig2=xwm8wetGu-BhfEXvMb802g

You can download the VC for python from https://web.archive.org/web/20210106040224/https://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi


and installed I retried to install the pycrypto library:

    pip install pycrypto

This time I installed it with success; then I continued to follow the above instruction to get the .der file.

In the file https://raw.githubusercontent.com/apprenticeharper/DeDRM_tools/master/Other_Tools/DRM_Key_Scripts/Adobe_Digital_Editions/adobekey.pyw

I needed to change the winreg import as follow:

    import _winreg as winreg 
    
# Install linux ebook reader

    emerge -av calibre

# Install the DeDRM plugin
    Download it from https://github.com/apprenticeharper/DeDRM_tools/blob/master/DeDRM_calibre_plugin/DeDRM_plugin.zip
And install in calibre
 https://github.com/apprenticeharper/DeDRM_tools/blob/master/DeDRM_calibre_plugin/DeDRM_plugin_ReadMe.txt

After that you need to configure some data in it; I configured the kindle serial number ( not sure if it is needed ) and I imported the ADE key extracted before.

# Remove the DeDRM
Only at this point, when all the configuration had been done, you can import your file. If the plugins was well configured and the file has a supported file format you will get it DRM free.

**Attention** The DRM removal happen only when the file is loaded therefore if you change any config you need to remove the book and reload it.

# Troubleshooting
If the conversion fail for any reason you can start calibre in debug mode:

    calibre-debug -g
And get useful infos.

# Problems
It doesn't run properly on systems with multiple screens
    
    https://www.playonlinux.com/en/topic-15182.html
    http://stackoverflow.com/questions/43612595/adobe-digital-edition-4-5-on-multiple-screens

Playonlinux fail with 
	
	7f55c56c8000-7f55c56c9000 rw-p 00003000 08:08 434576                     /usr/lib64/libgmodule-2.0.so.0.5000.3/usr/share/playonlinux/bash/find_python: line 58:  3627 Aborted                 (core dumped) "$POL_PYTHON" "$POLDIR/python/check_python.py"
	failed tests
	Looking for python2.6... which: no python2.6 in (/usr/x86_64-pc-linux-gnu/gcc-bin/5.4.0:/usr/local/bin:/usr/bin:/bin:/opt/bin:/opt/nvidia-cg-toolkit/bin:/usr/games/bin)
	
	Looking for python2... 2.7.12 - wxversion(s): 3.0-gtk2, 2.8-gtk2-unicode
	*** Error in `/usr/lib/python-exec/python2.7/python2': double free or corruption (out): 0x00007ffd403d1950 ***

This can happen when you update gcc and not all the reverse dependencies had been update! Solve it with:

	revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc

# Links
  DeDRM_tools https://github.com/apprenticeharper/DeDRM_tools/tree/master/DeDRM_calibre_plugin

  Full Guide but OLD ( 2013 ) http://dikkiisdiatribe.blogspot.de/2013/01/how-to-get-round-drm-issues-with-e.html

  https://github.com/apprenticeharper/DeDRM_tools/blob/master/DeDRM_calibre_plugin/DeDRM_plugin_ReadMe.txt

  http://tech.kateva.org/2013/08/using-calibre-and-dedrm-plug-in-to.html



Install a new 32bit env - called ADE
Install msfont
Install .net 4.0 -  Failed no message
Install .net 4.5 -> start installation .net from 2.0
3.0 not found -> continuing with 3.1SP


install msfont
.net 3.0 -> will install .net 2.0 -> 2.0 SP1 -> 2.0 SP2
3.0 Failed to download -Download manually from filehippo and run manual installation

######### Install on the system wine
New clean startup
rm ~/.Playonlinux
rm ~/.local/share/wineprefix 

.net 3.0 -> will install .net 2.0 -> 2.0 SP1 -> 2.0 SP2
3.0 Failed to download -Download manually from filehippo and run manual installation -->Failed to install 
Try with winetricks

WINEPREFIX=~/.PlayOnLinux/wineprefix/ADE5/ winetricks

# tried removing lib file
# https://bbs.archlinux.org/viewtopic.php?pid=1700283#p1700283
rm -f ~/.PlayOnLinux/wine/linux*/*/lib*/libz*

USE Adobe Digital Edition 1.7
https://www.lehmanns.de/page/ebookadealt
