#!/bin/bash

xset +fp /usr/share/fonts/local
xset fp rehash

eval `/usr/bin/ssh-agent`

if test -f /usr/lib/openssh/x11-ssh-askpass
then
	SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null
fi

if test -f /usr/lib/ssh/x11-ssh-askpass
then
	SSH_ASKPASS=lusr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &

xrdb -merge $HOME/.Xresources
xmodmap ~/.Xmodmap
setxkbmap dvorak

while true
do
	#VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
	TODAY=$(date +%Y-%m-%d)
	LOCALTIME=$(date +%Z\=%H:%M)
	CATIME=$(TZ=America/Los_Angeles date +%Z\=%H:%M)
	UTCTIME=$(TZ=UTC date +%Z\=%H:%M)
	CTTIME=$(TZ=America/Chicago date +%Z\=%H:%M)
	ETTIME=$(TZ=America/New_York date +%Z\=%H:%M)
	IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) 
	TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

	BAT="$(acpi -b | awk '{ print $4 }' | tr -d ',')"
	if [[ `acpi -a` == *"off-line"* ]]; then
		BATT="-[==$BAT]"
	else
		BATT="+[==$BAT]"
	fi
	xsetroot -name " <$IP> $BATT cpu:$TEMP -- $CATIME / $CTTIME / $ETTIME / $UTCTIME -- $LOCALTIME $TODAY "
	sleep 20s
done &

# set background image
exec /usr/local/bin/bgimgd -r &

exec xcompmgr &
exec dwm
