#!/bin/bash
APT_GET_CMD=$(which apt-get)
SPOTIFY_URL=http://repository.spotify.com/pool/non-free/s/spotify-client/
SPOTIFY_NAME=spotify-client_1.0.57.474.gca9c9538-30_amd64.deb

mkdir -p spotify-client
cd spotify-client

echo "Downloading Spotify Client..."
wget $SPOTIFY_URL$SPOTIFY_NAME

if [[ -z $APT_GET_CMD ]]; then
    echo "Detected Debian based system"
    echo "Do you want to install .deb package instead?"
    select yn in "Yes" "No"; do
        case $yn in
	    Yes ) sudo dpkg -i $SPOTIFY_NAME; sudo apt-get -y -f install; exit;;
	    No ) break;;
	esac
    done 
fi

echo "Decompressing files..."
ar x spotify-client_1.0.57.474.gca9c9538-30_amd64.deb
tar -xvzf data.tar.gz
echo "Copying files..."
mkdir -p $HOME/bin/
mkdir -p $HOME/.local/share/icons/hicolor/128x128/apps/
cp usr/share/spotify/icons/spotify-linux-128.png $HOME/.local/share/icons/hicolor/128x128/apps/spotify-client.png
cp -r usr/share/spotify/ $HOME/.local/share/
ln -s $HOME/.local/share/spotify/spotify $HOME/bin/
echo "export PATH="$HOME/bin:$PATH"" >> $HOME/.bashrc
cd ../
cp spotify.desktop $HOME/.local/share/applications/
echo "Cleaning folder..."
rm -rf spotify-client/
echo "Done."
