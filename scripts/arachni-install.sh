#!/bin/bash

# Arachni will be installed in $targetInstallationDirectory/$targetDirectoryName
targetInstallationDirectory="$HOME/Documents/Tools"
targetDirectoryName=arachni

# --- try not to modify anything below this line ---

echoAndExit() {
   echo "$1"
   exit -1
}

mkdir -p "$targetInstallationDirectory"
cd "$targetInstallationDirectory" || echoAndExit "Failed to cd into $targetInstallationDirectory"

if [ -d "$targetDirectoryName" ]; then
   echoAndExit "It seems that folder '$targetDirectoryName' already exists under $targetInstallationDirectory. Exiting..."
fi

# Get URL to the latest Arachni release through GitHub API
arachniTarUrl=$(curl -s https://api.github.com/repos/Arachni/arachni/releases/latest | tr ',' '\n' | grep browser_download_url | grep 'linux-x86_64.tar.gz\"' | cut -d\" -f4)

if [[ ! $arachniTarUrl =~ ^https://.*\.tar\.gz$ ]]; then
   echoAndExit "Could not obtain Arachni download link. This could indicate a problem with your internet connection or a change in the GitHub API. Exiting..."
fi

mkdir "$targetDirectoryName"
fileName="${arachniTarUrl##*/}"  # Extract file name from download URL
echo "Downloading Arachni from GitHub: $arachniTarUrl"
curl -L "$arachniTarUrl" -o "$fileName"
tar -xf "$fileName" -C "./$targetDirectoryName" --strip-components 1
rm -f "$fileName"

echo "Done. Arachni executables are located under $targetInstallationDirectory/$targetDirectoryName/bin"

# === Add Arachni to PATH ===
arachniBinPath="$targetInstallationDirectory/$targetDirectoryName/bin"

# Detect shell profile
if [[ "$SHELL" == */zsh ]]; then
    shellProfile="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
    shellProfile="$HOME/.bashrc"
else
    shellProfile="$HOME/.profile"
fi

# Add to shell profile if not already present
if ! grep -F "$arachniBinPath" "$shellProfile" > /dev/null 2>&1; then
    echo "" >> "$shellProfile"
    echo "# Add Arachni to PATH" >> "$shellProfile"
    echo "export PATH=\"$arachniBinPath:\$PATH\"" >> "$shellProfile"
    echo "Added $arachniBinPath to PATH in $shellProfile"
else
    echo "Arachni bin path is already in $shellProfile"
fi

echo "To use Arachni from any directory, either restart your terminal or run:"
echo "    source $shellProfile"

# === Optional: Create user for scanning ===
# read -p "Do you want to add arachni-scanner user to the system? (y/n) " -r
# if [[ $REPLY =~ ^[Yy]$ ]]; then
#     sudo adduser arachni-scanner
# fi

# === Optional: Enable SSH service ===
# read -p "Do you want to enable ssh? (y/n) " -r
# if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo systemctl enable ssh
    sudo service ssh start
# fi