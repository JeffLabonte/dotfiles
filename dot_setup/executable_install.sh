#!/bin/bash
sudo apt install -y build-essential git curl tmux
curl -sS https://starship.rs/install.sh | sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

sudo cp -f hid_apple.conf /etc/modprobe.d/
sudo update-initramfs -u
