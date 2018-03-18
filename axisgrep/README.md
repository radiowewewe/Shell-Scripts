# Speicher von Bildern einer Webcam
Mit diesem Skript werden Bilder einer Webcam abgefragt und nach Datum und Zeit abgelegt.
Die Bilder können mit einem Wasserzeichen versehen werden.
Die Bilder werden an einen FTP Server übertragen.
Das Skript sollte regelmäßig über bspw. cron aufgerufen werden.

# Konfiguration 
In der Funktion `_mygetpic` müssen am Ende User, Passwort und URL des FTP Servers eingetragen werden.

Um eine Webcam abzufragen genügen die folgenden Zeilen:
```
#Studio Cam
HOST=cam3.r3we.lan
CAM=studio
WGETURL="http://$HOST/studio.jpg"
WATERMARK="/mnt/Webcam/watermark.png"
_mygetpic "$HOST" "$CAM" "$WGETURL" "$WATERMARK"
```

* `$HOST` kann als IP Adresse oder DNS Name angeben sein.
* `$CAM` sollte ein sprechender Name sein und definiert den Dateinamen.
* `$WGETURL` ist Webcam spezifisch und muss auf das jeweilige Modell und Konfiguration ausgelegt sein.
* `$WATERMARK` Pfad und Datei für ein Wasserzeichen auf dem Webcambild. Bspw. ein Logo 

Datei: `crontab`
```
* * * * * /path/to/axisgrep.sh
```

# Abhängigkeiten
cURL - https://curl.haxx.se

WGET - https://www.gnu.org/software/wget/

ImageMagick - https://www.imagemagick.org


# Lizenz / License

Details in LICENSE