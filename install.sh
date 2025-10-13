sudo apt update && sudo apt upgrade -y
sudo apt install open-vm-tools-desktop -y

# Prep for script downloads
mkdir -p ./Downloads
mkdir -p $HOME/Documents/Tools

# Wallpaper
mv ./files/z-kali-wallpaper.png $HOME/Pictures/z-kali-wallpaper.png
sudo ln -sf $HOME/Pictures/z-kali-wallpaper.png /usr/share/desktop-base/kali-theme/login/background

# Set Up .bashrc
echo '' >> ~/.bashrc
echo '# Custom Aliases and Environment Variables' >> ~/.bashrc

# Golang
sudo apt install golang -y
echo '' >> ~/.bashrc
echo '# Golang setup' >> ~/.bashrc
echo 'export GOROOT=/usr/lib/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

# gf
mkdir "$HOME/Documents/Tools/gf" 
mkdir "$HOME/Documents/Tools/gf/patterns" 
go install github.com/tomnomnom/gf@latest
git clone https://github.com/tomnomnom/gf.git
mv ./gf/examples/* "$HOME/Documents/Tools/gf/patterns"
cp ./gf/gf-completion.bash "$HOME/Documents/Tools/gf/gf-completion.bash"
ln -s "$HOME/Documents/Tools/gf/patterns" ~/.gf
echo '' >> ~/.bashrc
echo '# gf setup' >> ~/.bashrc
echo 'export GF_PATH="$HOME/Documents/Tools/gf/patterns"' >> ~/.bashrc
echo 'source "$HOME/Documents/Tools/gf/gf-completion.bash"' >> ~/.bashrc
rm -rf ./gf # Cleanup

# anew 
go install -v github.com/tomnomnom/anew@latest

# ctfr
git clone https://github.com/UnaPibaGeek/ctfr.git
mv ./ctfr "$HOME/Documents/Tools/ctfr"
chmod +x $HOME/Documents/Tools/ctfr/ctfr.py
sudo ln -s $HOME/Documents/Tools/ctfr/ctfr.py /usr/bin/ctfr
rm -rf ./ctfr # Cleanup

source ~/.bashrc