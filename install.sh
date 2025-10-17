echo 'Starting Kali Linux fresh install setup...'

sudo apt update && sudo apt upgrade -y
sudo apt install open-vm-tools-desktop -y

# Prep for script downloads
mkdir -p ./Downloads
mkdir -p $HOME/Documents/Tools

# Homescreen - TODO: Set desktop wallpaper automatically
mv ./files/z-kali-wallpaper.png $HOME/Pictures/z-kali-wallpaper.png
sudo ln -sf $HOME/Pictures/z-kali-wallpaper.png /usr/share/desktop-base/kali-theme/login/background # Not sure this works
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s false

# Set Up .bashrc
echo '' >> ~/.bashrc
sed -i "s|alias ll='ls -l'|alias ll='ls -lah'|" ~/.bashrc
echo '# Custom Aliases and Environment Variables' >> ~/.bashrc

# Golang
sudo apt install golang -y
echo '' >> ~/.bashrc
echo '# Golang setup' >> ~/.bashrc
echo 'export GOROOT=/usr/lib/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

# Python
sudo apt install python3 python3-pip -y
echo '' >> ~/.bashrc
echo '# Python setup' >> ~/.bashrc
echo 'export PYTHONPATH=$HOME/.local/lib/python3.x/site-packages:$PYTHONPATH' >> ~/.bashrc

# onehistory
wget https://github.com/1History/1History/releases/download/v0.3.4/1History_v0.3.4_x86_64-unknown-linux-musl.zip
unzip ./1History_v0.3.4_x86_64-unknown-linux-musl.zip -d $HOME/Documents/Tools/onehistory
rm 1History_v0.3.4_x86_64-unknown-linux-musl.zip
rm $HOME/Documents/Tools/onehistory/README.org
echo '' >> ~/.bashrc
echo '# onehistory setup' >> ~/.bashrc
echo 'export PATH="$HOME/Documents/Tools/onehistory:$PATH"' >> ~/.bashrc
echo 'export OH_DB_FILE=$HOME/Documents/Tools/onehistory/database.db' >> ~/.bashrc
echo 'export OH_EXPORT_CSV_FILE="$HOME/Documents/Tools/onehistory/export.csv"' >> ~/.bashrc

# gf
mkdir -p "$HOME/Documents/Tools/gf" 
mkdir -p "$HOME/Documents/Tools/gf/patterns" 
go install github.com/tomnomnom/gf@latest
git clone https://github.com/tomnomnom/gf.git
mv ./gf/examples/* "$HOME/Documents/Tools/gf/patterns/"
cp ./gf/gf-completion.bash "$HOME/Documents/Tools/gf/gf-completion.bash"
ln -s "$HOME/Documents/Tools/gf/patterns" ~/.gf
echo '' >> ~/.bashrc
echo '# gf setup' >> ~/.bashrc
echo 'export GF_PATH="$HOME/Documents/Tools/gf/patterns"' >> ~/.bashrc
echo 'source "$HOME/Documents/Tools/gf/gf-completion.bash"' >> ~/.bashrc
rm -rf ./gf # Cleanup

# ctfr
git clone https://github.com/UnaPibaGeek/ctfr.git
mv ./ctfr "$HOME/Documents/Tools/ctfr"
chmod +x $HOME/Documents/Tools/ctfr/ctfr.py
sudo ln -s $HOME/Documents/Tools/ctfr/ctfr.py /usr/bin/ctfr
rm -rf ./ctfr # Cleanup

# VS Code
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo apt install ./download?build=stable\&os=linux-deb-x64 -y
rm ~/Downloads/download?build=stable\&os=linux-deb-x64

# Go apps
go install github.com/tomnomnom/anew@latest
go install github.com/003random/getJS/v2@latest
go install github.com/lc/gau/v2/cmd/gau@latest

# BeEF
sudo apt install beef-xss -y

# Apply changes to .bashrc
source ~/.bashrc

# Finish script
echo ''
echo 'Setup complete! This script will now self destruct. Redownload it at https://github.com/zconlin/KaliFreshInstall.'
rm -rf ../KaliFreshInstall/
cd
echo 'Please restart your terminal or run "source ~/.bashrc" to apply changes.'
echo 'Remember to set your desktop wallpaper manually if it was not set automatically.'