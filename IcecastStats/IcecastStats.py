#!/usr/local/bin/python3
import json
import urllib.request
import datetime
import csv
#Streams you wanna log
urls = {"http://example.com:8000/mount1", "http://example.com:8000/mount2"}
#where to store the log
logFile = "/mnt/logs/"+datetime.datetime.now().strftime('%Y-%m')+"_IcecastStats.txt"
jStats = json.loads(urllib.request.urlopen('http://example.com:8000/status-json.xsl').read().decode('utf-8'))
ofile  = open(logFile, "a+")
for source in jStats["icestats"]["source"]:
	if source["listenurl"] in urls:
		#write logline and remove URL part from stream
		csv.writer(ofile, dialect="excel").writerow( (datetime.datetime.now().strftime('%Y-%m-%d %H:%M %z') , str(source['listenurl']).replace('http://example.com:8000/','') , str(source['listeners'])) )
ofile.close()