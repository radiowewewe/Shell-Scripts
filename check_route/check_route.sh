#!/bin/sh
altHOST=8.8.8.8
SENDER= example.com #DNS of traget host 
spROUTE= 4.3.2.1 # router gateway (IPv4) which should beused instead of default route for $SENDER
spSENDERip=`/usr/bin/host -4 $SENDER | /usr/bin/cut -f 4 -d' '`
if [ ! `/sbin/route -n | /bin/grep $altHOST | wc -l` -eq 1 ] ; then
  /sbin/route add -host $altHOST gw $spROUTE ;
fi
if [ `/sbin/route -n | /bin/grep $spSENDERip | wc -l` -eq 1 ] ; then
  if ! /bin/ping -q -c1 $SENDER 1>/dev/null ; then
	# $SENDER not reachable via special route, fallback to default gw by deleting special route
    /sbin/route del -host $SENDER gw $spROUTE ;
  fi
else
  if /bin/ping -q -c1 $altHOST 1>/dev/null ; then
	# alternative HOST is reachable via special route, set special route for $SENDER 
    /sbin/route add -host $SENDER gw $spROUTE ;
  fi
fi