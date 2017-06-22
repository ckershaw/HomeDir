#!/bin/sh
lock() {
    xautolock -locknow
}

case "$1" in
    lock)
        lock
        ;;
    screenoff)
        lock && sleep 1 && xset dpms force off;
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend
        ;;
    hibernate)
        lock && dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate
        ;;
    reboot)
        dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
        ;;
    shutdown)
        dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown|screenoff}"
        exit 2
esac

exit 0
