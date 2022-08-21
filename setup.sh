#!/bin/bash

# Setup variables
REPOSITORY='https://github.com/frcalderon/dotfiles.git'
REPOSITORY_PATH="$HOME/.dotfiles"

# Install Git
sudo apt-get install -y git

# Clone repository
echo -e "💾 Cloning repository..."
git clone --recursive "$REPOSITORY" "$REPOSITORY_PATH"
echo -e "✅ Cloned into ${REPOSITORY_PATH}."

# Install packages
echo -e "🕵️‍♂️ Installing packages..."
xargs sudo apt-get install -y < "$REPOSITORY_PATH/apt.pkglist"
while IFS= read -r line; do sudo snap install $line; done < $REPOSITORY_PATH/snap.pkglist
echo -e "✅ Packages installed."

# Install shell configuration
echo -e "🕵️‍♂️ Seting up shell..."
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended
sudo snap install starship

ln -sf "$REPOSITORY_PATH/.oh-my-zsh" ~/.oh-my-zsh
ln -sf "$REPOSITORY_PATH/.zshrc" ~/.zshrc
echo -e "✅ Shell set up."

# Install fonts
sudo cp "$REPOSITORY_PATH/Fonts/*" /usr/share/fonts/

# Change shell
chsh -s $(which zsh)
