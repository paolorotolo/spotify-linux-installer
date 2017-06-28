#!/bin/bash
SPOTIFY_URL=http://repository.spotify.com/pool/non-free/s/spotify-client/
SPOTIFY_NAME=spotify-client_1.0.57.474.gca9c9538-30_amd64.deb

if [ `id -u` = 0 ] ; then
        echo "Please don't run this script as root."
        exit;
fi

function clean_up {
	rm -rf spotify-client/
}

trap clean_up SIGHUP SIGINT SIGTERM

if [ ! -d "spotify-client" ]; then
mkdir -p spotify-client
fi

cd spotify-client

echo "Downloading Spotify Client..."
wget $SPOTIFY_URL$SPOTIFY_NAME

if [ -f "/etc/debian_version" ]; then
    echo "Detected Debian based system"
    echo "Do you want to install .deb package instead?"
    select yn in "Yes" "No"; do
        case $yn in
	    Yes ) sudo dpkg -i $SPOTIFY_NAME; sudo apt-get -y -f install; cd ../; rm -rf spotify-client; echo "Done. To unistall, use 'apt purge spotify-client'"; exit;;
	    No ) break;;
	esac
    done 
fi

echo "Decompressing files..."
ar x $SPOTIFY_NAME
tar -xvzf data.tar.gz
echo "Copying files..."
mkdir -p $HOME/bin/
mkdir -p $HOME/.local/share/icons/hicolor/128x128/apps/
cp usr/share/spotify/icons/spotify-linux-128.png $HOME/.local/share/icons/hicolor/128x128/apps/spotify-client.png
cp -r usr/share/spotify/ $HOME/.local/share/
ln -s $HOME/.local/share/spotify/spotify $HOME/bin/

declare file_content=$( cat "$HOME/.bashrc" )
if [[ " $file_content " =~ "export PATH="$HOME/bin:$PATH"" ]]
    then
        echo "PATH already added in .bashrc."
    else
        echo "Adding patch in .bashrc."
        echo "export PATH="$HOME/bin:$PATH"" >> $HOME/.bashrc
fi

cd ../
update-desktop-database -q
cp spotify.desktop $HOME/.local/share/applications/
echo "Cleaning folder..."
clean_up
echo "Done."
