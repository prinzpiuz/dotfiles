
APT += firefox-esr kdenlive kdeconnect
APT += fam qt5-qmltooling-plugins phonon4qt5-backend-gstreamer
APT += ibus
APT += clamav

# Package name overrides
PKG_firefox := firefox-esr
PKG_kdeconnect := kdeconnect

# Spotify, Obsidian, Mullvad — installed via .deb or custom scripts
# See custom targets in Makefile
