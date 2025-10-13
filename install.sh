sudo apt update && sudo apt upgrade -y
sudo apt install open-vm-tools-desktop -y

# Prep for script downloads
mkdir ./Downloads

# Wallpaper
mv ./files/z-kali-wallpaper.png $HOME/Pictures/z-kali-wallpaper.png
sudo ln -sf $HOME/Pictures/z-kali-wallpaper.png /usr/share/desktop-base/kali-theme/login/background

# gf
mkdir "$HOME/Documents/Tools/gf" 
mkdir "$HOME/Documents/Tools/gf/patterns" 
git clone https://github.com/tomnomnom/gf.git
mv ./gf/examples "$HOME/Documents/Tools/gf/patterns"
cp ./gf/gf-completion.bash "$HOME/Documents/Tools/gf/gf-completion.bash"
ln -s "$HOME/Documents/Tools/gf/patterns" ~/.gf

source ~/.bashrc