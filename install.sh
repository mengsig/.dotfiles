#!/bin/bash

#first we make it an executable
if [ ! -x "$0" ]; then
    chmod +x "$0"
    echo "Created executable installation file."
    bash "$0"
    exit 0
fi

#first we install neovim, nodejs, packer to enable neovim

echo "Installing neovim from source..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "Finished installing neovim."


echo "Installing nodejs, packer and zsh..."
#nodejs
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22
# Verify the Node.js version:
node -v # Should print "v22.17.0".
nvm current # Should print "v22.17.0".
# Verify npm version:
npm -v # Should print "10.9.2".

#nvim-packer
yay -S nvim-packer-git

# zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -S zsh

echo "All dependencies installed."

echo "Making zsh default shell..."
chsh -s $(which zsh)
echo "Default shell set to zsh."

echo "Downloading oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Finished downloading oh-my-zsh"


echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Finished installing zsh autosuggestions."

echo "Installing zsh-autocomplete..."
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
echo "Finished installing zsh autocomplete."

echo "Clonining zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Finished cloning zsh-syntax-highlighting."

echo "Installing zsh-powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
echo "Finished installing zsh-powerlevel10k."

echo "Installing nerdfonts..."
declare -a fonts=(
#    BitstreamVeraSansMono
#    CodeNewRoman
#    DroidSansMono
    FiraCode
    FiraMono
#    Go-Mono
#    Hack
#    Hermit
#    JetBrainsMono
#    Meslo
#    Noto
#    Overpass
#    ProggyClean
#    RobotoMono
#    SourceCodePro
#    SpaceMono
#    Ubuntu
#    UbuntuMono
)

version='2.1.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv
echo "Finished installing nerdfonts."


echo "Transferring .dotfiles..."
cp ~/.dotfiles/.zshrc ~/.zshrc
cp -r ~/.dotfiles/.config/nvim ~/.config/nvim
#cp ~/.dotfiles/.bashrc ~/.bashrc
cp -r ~/.dotfiles/.config/zsh ~/.config/zsh
echo "Finished transferring .dotfiles."

source ~/.bashrc
zsh ~/.zshrc
#source ~/.config/nvim/init.lua
#source ~/.config/nvim/lua/gunnin/init.lua
#source ~/.config/nvim/lua/gunnin/packer.lua
#source ~/.config/nvim/lua/gunnin/set.lua
#source ~/.config/nvim/lua/gunnin/remap.lua


echo "To finalize vim installation. Navigate to ~/.config/nvim/
and simply :PackerInstall and :PackerSync inside nvim."
echo "and..."
echo "To finalize oh-my-zsh installation, change font to nerdfont (FiraMono), 
restart terminal, and proceed with following the instructions in the terminal."
