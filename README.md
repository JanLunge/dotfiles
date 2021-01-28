
# Arch setup (currently Manjaro)

![screenshot](https://github.com/wlard/dotfiles/blob/master/screenshot.png?raw=true)

* herbstluftwm
* polybar
* rofi
* dunst
* lightdm

* redshift
* nitrogen

## Snippets
  `ln -s ~/dotfiles/.zshrc ~/.zshrc` for linking dotfiles to the right place


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
you can create hotkeys to change the sizes of the virtual monitors with `hc keybind $Mod-m set_monitors 1280x1440+0+1080 2560x1440+1280+1080 1280x1440+3840+1080
`
 for wider side monitors when needed

## fonts used
`yay -S ttf-fantasque-sans-git ttf-material-icons`
sudo pacman -S emacs adobe-source-code-pro-fonts
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

## maintainance
logfiles for terminal usage `sudo rm -rf /private/var/log/asl/*.asl`
zsh history `mv ~/.zsh_history ~/zsh_history_backup`
