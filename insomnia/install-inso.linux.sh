#!/usr/bin/env sh
INSO_URL=$(curl -s https://api.github.com/repos/Kong/insomnia/releases/latest \
| grep browser_download_url \
| grep inso-linux \
| cut -d '"' -f 4)
curl -L -o inso.tar.xz "$INSO_URL"
if [ -f "inso.tar.xz" ]; then
    echo "Downloaded the latest inso.tar.xz package successfully."
    echo "Unpacking it now..."
    tar -xf inso.tar.xz
    sudo mv inso /usr/local/bin/
else
    echo "Failed to download the latest Insomnia .deb package."
fi


