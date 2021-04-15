#!/bin/zsh
if [ $1 ]
then
	echo $1 | cut -d' ' -f1 | read h; herbstclient bring ${h:0:10}
else
	# just removing the hostname from the output as i dont need it in rofi
	wmctrl -l | sed 's/wDesk //g'
fi
