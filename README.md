# Spotify 1.0 installer for Linux
Automatically download and install **latest** Spotify version on Linux.
<br><br>
![](https://github.com/paolorotolo/spotify-linux-installer/blob/master/artwork/spotify-opensuse.jpg)
<br><br>

## How to install
1. Clone the repo or download the archive [here](https://github.com/paolorotolo/spotify-linux-installer/archive/master.zip).
2. Run `./install-spotify.sh`. <br> You may need to make the script executable first with `chmod +x install-spotify.sh`.
3. Enjoy the music! :)

## How to unistall
Just run `./unistall-spotify.sh`.

## Why this repo
Basically for the same reasons of [this repo](https://github.com/aspiers/opensuse-spotify-installer#why-is-this-script-here-on-github). If installing Spotify is very easy on Debian based distros, it can be tricky on other Linux systems like OpenSuse. In fact, projects like [opensuse-spotify-installer](https://github.com/aspiers/opensuse-spotify-installer) or [spotify-make](https://github.com/leamas/spotify-make) still uses a very old and now unstable version of Spotify that requires additional dependencies to work.

Using this script, you'll install latest Spotify available (1.0.\*). The script has been tested on a fresh OpenSuse installation and it **doesn't require** additional dependancies to make Spotify work. Please test it on other distros and let me know what doesn't work so we can build a list of dependencies together.

The script doesn't require root.

## Supported distros
|   | Dependanices  | Notes |
|---|---|---|
| OpenSuse | `binutils` | Works well on a fresh OpenSuse installation. Just requires `binutils` to extract the .deb file  |
| Ubuntu/Debian | `libasound2 libcurl3 libgconf-2-4 libglib2.0-0 libgtk2.0-0 libnss3 libssl1.0.0 libxss1 libxtst6 xdg-utils`  | Dependancies taken from Spotify's official `control` file|

Did you try the script on your distro? [Let us know](https://github.com/paolorotolo/spotify-linux-installer/issues/new) what works.

## Licence and Contributions
This work is shared under [MIT Licence](https://github.com/paolorotolo/spotify-opensuse-installer/blob/master/LICENSE) and doesn't include code from Spotify.<br>
<br>
Contributions are welcome, feel free to submit a pull :)<br>
