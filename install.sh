sudo apt update && sudo apt upgrade -y
sudo apt install open-vm-tools-desktop -y

# Wallpaper
mv ./files/z-kali-wallpaper.png $HOME/Pictures/z-kali-wallpaper.png
sudo ln -sf $HOME/Pictures/z-kali-wallpaper.png /usr/share/desktop-base/kali-theme/login/background

