#!/usr/bin/python

# Spotify-notify
#
# v0.6d (28th aug 11)
# by JonW (jon.neverwinter@gmail.com)
# patched 20110907 by Jansen Price (sumpygump@gmail.com)
# patched 20120729 by Jansen Price (sumpygump@gmail.com) and brandl.matthaeus
#
# Original by SveinT (sveint@gmail.com)
# up to v0.5.2 (27th jan 11)


import dbus
from dbus.mainloop.glib import DBusGMainLoop

import gobject, gtk, os, tempfile, sys, time, re, indicate, urllib2
from optparse import OptionParser
from subprocess import *

# The url to use when fetching spotify track information.
SPOTIFY_OPEN_URL = "http://open.spotify.com/track/"

# The path to this application's directory.
APPLICATION_DIR = sys.path[0] + "/"

# The file path to spotify. If empty, it will try to auto detect.
SPOTIFY_PROCESS_NAME = ''

if __name__ == "__main__":

    try:
        bus = dbus.Bus(dbus.Bus.TYPE_SESSION)

        spotify_bus = bus.get_object('org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2')
        spotify = dbus.Interface(spotify_bus, 'org.freedesktop.DBus.Properties')

        playback_status = spotify.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')
        meta = spotify.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

        # parse
        artist    = meta['xesam:artist'][0].encode('utf-8')
        album     = meta['xesam:album'].encode('utf-8')
        title     = meta['xesam:title'].encode('utf-8')
        year      = meta['xesam:contentCreated'].encode('utf-8')
        trackhash = meta['mpris:trackid'].encode('utf-8')
        arturl    = meta['mpris:artUrl'].encode('utf-8')

        if playback_status == "Playing":
            print "{0} | {1}".format(
                artist,
                title,
            )
        #print "{0} | {1} | {2} ({3})".format(
        #    artist,
        #    title,
        #    album,
        #    year
        #)
    except Exception, e:
        print ""
