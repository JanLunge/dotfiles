
# Arch setup

![screenshot](https://github.com/wlard/dotfiles/blob/master/screenshot.png?raw=true)
video walkthrough at [Youtube/JanLunge](https://youtu.be/MOHx2dXb-uk)

* herbstluftwm
* polybar
* rofi
* dunst
* lightdm

* redshift
* nitrogen

## Dependencies
`jq` is used for some json bash script parsing

## WIP
- there is a DISPLAY menu in polybar that is a simple menu with `xmenu` for toggling screens or the compositor on and off
- Many of my config settings are hardcoded specific to my setup so i can recommend to just copy what you like and adjust it to your needs 

## Snippets
  `ln -s ~/dotfiles/.zshrc ~/.zshrc` for linking dotfiles to the right place

## Wallpaper
the wallpaper in the screenshot and video is from martin adams on unsplash https://unsplash.com/photos/pTCcJSBOTxY and i did a orange tinted version of it which you can grab here https://mega.nz/file/JJNE3RxQ#hq8Nu0AS0gxRamExpBnZt9c85SyDJKN3BgETbXhGSOo

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
