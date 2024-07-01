#!/usr/bin/env sh
API_URL="https://api.github.com/repos/Kong/insomnia/releases/latest"
DEB_URL=$(curl -s $API_URL | grep "browser_download_url.*\.deb" | cut -d '"' -f 4)
curl -L -o insomnia.deb $DEB_URL
if [ -f "insomnia.deb" ]; then
    echo "Downloaded the latest Insomnia .deb package successfully."
    sudo dpkg -i insomnia.deb
else
    echo "Failed to download the latest Insomnia .deb package."
fi
