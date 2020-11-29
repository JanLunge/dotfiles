# installation OSX

## fonts
`brew tap homebrew/cask-fonts && brew cask install font-source-code-pro;`

## Dock
`defaults write com.apple.Dock showhidden -bool true #set transparency`
`defaults write com.apple.dock autohide-delay -float 0;killall Dock #instant dock`
`defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock #faster animation`

## maintainance
logfiles for terminal usage `sudo rm -rf /private/var/log/asl/*.asl`
zsh history `mv ~/.zsh_history ~/zsh_history_backup`

## Snippets
  `ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc` for linking dotfiles to the right place

# Apps
* `brew cask install hamerspoon`
* `brew cask install karabiner-elements`

## Arduino and Nodemcu (esp8266)
- driver https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers
- boards manager http://arduino.esp8266.com/stable/package_esp8266com_index.json
-most recent boards manager url https://github.com/esp8266/Arduino#installing-with-boards-manager


# Arch setup
used archlabs with larbs installer
to get polybar https://github.com/adi1090x/polybar-themes
`yay -S polybar`
`yay -S ttf-fantasque-sans-git ttf-material-icons`
sudo pacman -S emacs adobe-source-code-pro-fonts
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d



# Other
selfhosting (owncloud, nextcloud, custom share with unraid and vpn)
