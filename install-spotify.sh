#!/bin/bash
SPOTIFY_URL=http://repository.spotify.com/pool/non-free/s/spotify-client/
SPOTIFY_NAME_URL=http://repository.spotify.com/pool/non-free/s/spotify-client/
SPOTIFY_NAME=""

if [ `id -u` = 0 ] ; then
        echo "Please don't run this script as root."
        exit;
fi

function clean_up {
	rm -rf spotify-client/
}

function get_spotify_name {
	wget $SPOTIFY_NAME_URL

	echo "Update version..."	

	mv index.html data.txt

	SPOTIFY_NAME=$(awk -F\" '/href=/{print $2}' data.txt | grep amd64 | sed '1 d')

	echo "Remove temporary file..."
	
	rm -rf data.txt

	echo "Version updated successful"
}

get_spotify_name

trap clean_up SIGHUP SIGINT SIGTERM

if [ ! -d "spotify-client" ]; then 
    echo "Creating Spotify Client folder..."
    mkdir -p spotify-client
fi

cd spotify-client

if [ -f $SPOTIFY_NAME ]; then
    echo "Spotify Client found..."
else
    echo "Downloading Spotify Client..."
    wget $SPOTIFY_URL$SPOTIFY_NAME
fi

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
echo "Done."
echo "Copying files..."

mkdir -p $HOME/bin/
mkdir -p $HOME/.local/share/icons/hicolor/128x128/apps/

cp usr/share/spotify/icons/spotify-linux-128.png $HOME/.local/share/icons/hicolor/128x128/apps/spotify-client.png
cp -r usr/share/spotify/ $HOME/.local/share/

ln -s $HOME/.local/share/spotify/spotify $HOME/bin/

echo "Backup .bashrc..."
cp $HOME/.bashrc $HOME/.bashrc.bak

declare file_content=$( cat "$HOME/.bashrc" )
if [[ " $file_content " =~ "export PATH="$HOME/bin:$PATH"" ]]
    then
        echo "PATH already added in .bashrc."
        echo "Done."
        echo "Adding patch in .bashrc."
        echo "export PATH="$HOME/bin:$PATH"" >> $HOME/.bashrc
fi

cd ../

cp -s /usr/share/icons/hicolor/index.theme $HOME/.local/share/icons/hicolor 
update-desktop-database -q

cp spotify.desktop $HOME/.local/share/applications/

echo "Remove Spotify Client folder? "
select yn in "Yes" "No"; do
        case $yn in
	    Yes ) echo "Cleaning Spotify Client folder..."; clean_up; break;;
	    No ) break;;
    esac
    done

echo "Done."
