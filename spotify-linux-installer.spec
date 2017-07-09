#
# spec file for package spotify-linux-installer
#

Name:       spotify-linux-installer
Summary:    Automatically downloads and installs the latest Spotify version on Linux.
Version:    1.0.1
Release:    1
#Requires:   binutils
BuildRoot:  %{_tmppath}/%{name}-%{version}-build
BuildArch:  noarch
License:    MIT
Group:      Productivity/Multimedia/Sound/Players
Source0:    https://github.com/paolorotolo/spotify-linux-installer/archive/master.zip
URL:        https://github.com/paolorotolo/spotify-linux-installer

%description
If installing Spotify is very easy on Debian based distros, it can be tricky on other Linux systems like OpenSuse. In fact, projects like opensuse-spotify-installer or spotify-make still uses a very old and now unstable version of Spotify that requires additional dependencies to work. Using this script, you'll install latest Spotify available (1.0.*). The script has been tested on a fresh OpenSuse installation and it doesn't require additional dependancies to make Spotify work.

%prep
%setup -q

%install
mkdir -p %{buildroot}/opt/spotify-linux-installer
cp -a artwork %{buildroot}/opt/spotify-linux-installer
cp -a install-spotify.sh %{buildroot}/opt/spotify-linux-installer
cp -a LICENSE %{buildroot}/opt/spotify-linux-installer
cp -a README.md %{buildroot}/opt/spotify-linux-installer
cp -a spotify.desktop %{buildroot}/opt/spotify-linux-installer
cp -a uninstall-spotify.sh %{buildroot}/opt/spotify-linux-installer

%post
/opt/spotify-linux-installer/install-spotify.sh

%preun
/opt/spotify-linux-installer/uninstall-spotify.sh

%files
%defattr(-,root,root)
%license /opt/spotify-linux-installer/LICENSE
%doc /opt/spotify-linux-installer/README.md
/opt/spotify-linux-installer/artwork
/opt/spotify-linux-installer/install-spotify.sh
/opt/spotify-linux-installer/LICENSE
/opt/spotify-linux-installer/README.md
/opt/spotify-linux-installer/spotify.desktop
/opt/spotify-linux-installer/uninstall-spotify.sh

%changelog
* Sun 09 Jul 2017 Jonathan Landrum <me@jonlandrum.com> - 1.0.1
- Initial version with RPM support