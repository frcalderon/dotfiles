#!/bin/bash

# Setup variables
REPOSITORY='https://github.com/frcalderon/dotfiles.git'
REPOSITORY_PATH="$HOME/.dotfiles"

# Install Git
sudo apt-get install git

# Clone repository
echo -e "💾 Cloning repository..."
git clone --recursive "$REPOSITORY" "$REPOSITORY_PATH"
echo -e "✅ Cloned into ${REPOSITORY_PATH}."

# Install packages
echo -e "🕵️‍♂️ Installing packages..."
xargs sudo apt-get install < "$REPOSITORY_PATH/apt.pkglist"
xargs -0 -n 1 sudo snap install < <(tr \\n \\0 <"$REPOSITORY_PATH/snap.pkglist")
echo -e "✅ Packages installed."

# Install shell configuration
echo -e "🕵️‍♂️ Seting up shell..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo snap install starship

ln -sf "$REPOSITORY_PATH/.oh-my-zsh" ~/.oh-my-zsh
ln -sf "$REPOSITORY_PATH/.zshrc" ~/.zshrc
echo -e "✅ Shell set up."

# Install fonts
sudo cp "$REPOSITORY_PATH/Fonts/*" /usr/share/fonts/