
# Arch setup (currently Manjaro)

![screenshot](https://github.com/wlard/dotfiles/blob/master/screenshot.png?raw=true)

* herbstluftwm
* polybar
* rofi
* dunst

## HLWM
| key | Action |
| --: | :----- |
| super + d | Rofi |
| super + y | Power menu in Rofi |
| super + [1-9] | switch to desktop |
| super + shift +[1-9] | move window to desktop |
| super + shift + arrow | move window in direction |
| super + f | fullscreen window |
| super + s | floating mode on current desktop |
| super + u | create frame under current frame |
| super + o | create frame right to current frame |
| super + r | remove frame |
| super + space | toggle between modes of tiling inside a frame (very useful) |
| super + tab | switch focus between windows in current desktop (very nice as this ony switches in the current desktop) |

creates 3 virtual desktops on startup left and right are used like seconday monitors the central monitor
either uses tiling or toggles to floating mode with `super + s`


## fonts used
`yay -S ttf-fantasque-sans-git ttf-material-icons`
sudo pacman -S emacs adobe-source-code-pro-fonts
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

## maintainance
logfiles for terminal usage `sudo rm -rf /private/var/log/asl/*.asl`
zsh history `mv ~/.zsh_history ~/zsh_history_backup`

## Snippets
  `ln -s ~/dotfiles/.zshrc ~/.zshrc` for linking dotfiles to the right place



## Arduino and Nodemcu (esp8266)
- driver https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers
- boards manager http://arduino.esp8266.com/stable/package_esp8266com_index.json
-most recent boards manager url https://github.com/esp8266/Arduino#installing-with-boards-manager