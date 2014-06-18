#! /bin/bash
#
# Install sublime text and add it the the Whiskers menu.
# From the steps described @
# http://www.itnota.com/how-to-install-sublime-text/
#
# raphigaziano <r.gaziano@gmail.com>
# Created: 04-08-2013
#
##############################################################################

# Check if user is root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Url and filename might change
tarname='Sublime Text 2.0.2 x64.tar.bz2'
wget http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2

tar -jxvf "$tarname"
rm "$tarname"

installdir="/opt/sublime"

mv "Sublime Text 2" $installdir
chown -R root:root $installdir
chmod -R +r $installdir

binname="/usr/bin/sublime_text"

touch $binname
chmod 777 $binname

echo '#!/bin/sh' >> $binname
echo 'export SUBLIME_HOME="/opt/sublime"' >> $binname
echo '$SUBLIME_HOME/sublime_text "$*"' >> $binname

chmod 755 $binname

# This wont work on all environments
desktopsettings="/usr/share/applications/sublime.desktop"
echo '[Desktop Entry]' >> $desktopsettings
echo 'Encoding=UTF-8' >> $desktopsettings
echo 'Name=Sublime Text 2' >> $desktopsettings
echo 'Comment=Edit text, code and markup' >> $desktopsettings
echo 'Exec=sublime_text' >> $desktopsettings
echo 'Icon=/opt/sublime/Icon/256x256/sublime_text.png' >> $desktopsettings
echo 'Terminal=false' >> $desktopsettings
echo 'Type=Application' >> $desktopsettings
echo 'Categories=GNOME;Utility;TextEditor;' >> $desktopsettings
echo 'StartupNotify=true' >> $desktopsettings


