#!/bin/sh

#functions
_mytest() {
    if [ $# -eq 1 -a ! -x $1 ]; then
        echo "$1 not found or executable"
        exit 1
    fi
}

_mygetpic() {
    # there must be at least 3 arguments: HOST CAMNAME WGETURL [WATERMARK]
    HOST=$1
    CAM=$2
    WGETURL=$3
    WATERMARK=$4
    $PING $PINGOPTS $HOST 1>/dev/null 2>&1
    if [ $? -eq 0 ]; then
        myPATH="$BASEDIR/$YEAR/$MONTH/$DAY/"
        OUTFILE="$myPATH/$CAM-`$DATE +%F_%H.%M.%S`.jpg"
        $MKDIR -p "$myPATH"
        $WGET $WGETOPTS $WGETURL -O $OUTFILE
        $CP $OUTFILE "$BASEDIR/$CAM.jpg"
        if [ -x $COMPOSITE -a -r $WATERMARK ]; then
            $COMPOSITE -gravity southeast -quality 100 -dissolve 70 "$WATERMARK" "$BASEDIR/$CAM.jpg" "$BASEDIR/$CAM.jpg"
        fi
        $CURL -u USER:PASSW --limit-rate 150K  -T "$BASEDIR/$CAM.jpg" ftp://example.com/path/to/file
    fi
}

#Binarys
PING='/sbin/ping'
WGET='/usr/local/bin/wget'
MKDIR='/bin/mkdir'
CP='/bin/cp'
DATE='/bin/date'
COMPOSITE='/usr/local/bin/composite'
CURL='/usr/local/bin/curl'

#test bins
_mytest $PING
_mytest $WGET
_mytest $MKDIR
_mytest $CP
_mytest $DATE
_mytest $RM

#Opts
WGETOPTS='-t 1'
PINGOPTS="-c 1 -t 1"
YEAR=`$DATE +%Y`
MONTH=`$DATE +%m_%B`
DAY=`$DATE +%d_%A`
HOUR=`$DATE +%H_Uhr`
BASEDIR="/mnt/Webcam/"

umask 0002

#Studio Cam
HOST=cam3.r3we.lan
CAM=studio
WGETURL="http://$HOST/studio.jpg"
WATERMARK="/mnt/Webcam/watermark.png"
_mygetpic "$HOST" "$CAM" "$WGETURL" "$WATERMARK"

#Mod Cam
HOST=cam4.r3we.lan
CAM=moderation
WGETURL="--auth-no-challenge --http-user=USER --http-password=PASSW http://$HOST/image/jpeg.cgi"
WATERMARK="/mnt/Webcam/watermark.png"
_mygetpic "$HOST" "$CAM" "$WGETURL" "$WATERMARK"


