# JACKd Mitschnitt

Bei WeWeWe - Welle West Wetterau e.V. muss ein Mischnitt des Programmserstellt werden. Für unser Audioprocessing kommt eine spezielle Linux [Ubuntu Distribution][1] zum Einsatz. Die zentrale Komponente  ist "[JACK Audio Connection Kit][2]" und bietet ein sehr flexibles und leitungsfähig Audiosystem. Damit ist es möglich entlang des Prozesswegs das Audiosignal abzugreifen und mit dem Programm [jack_capture][3] zu speichern. Über die Systemzeit wird der Mitschnitt gesteuert und der Ablageort ermittelt.

Bei WeWeWe - Welle West Wetterau e.V. werden drei Mitschnitte erstellt.
* Line-In PGM - das Programm wie es aus dem Studio kommt. 
* PostProc - nach Audio Aufbereitung.
* Line-In Tuner - Rückempfang des UKW Signals (erfodert Soundkarte mit 2 Stereo Eingängen).

Für jeden Mitschnitt wird eine angepasste Version des Skripts aufgerufen.

Nach Ende der Aufnahme erhält die Datei noch einen Rudimentären id3-Tag.

Das Skript wird regelmäßig über cron aufgerufen.

# Konfiguration 

Die Mitschnitte sind überlappend angelegt, soll heißen ein Mitschnitt der Stunde von 10 bis 11 Uhr wird um 9:55 Uhr gestartet und endet um 11:05 Uhr. Hierfür muss die die 'Zeit' der nächsten Stunde bei Start des Skripts errechnet werden. Dies geschieht über die Anzahl der Sekunden seit 01.01.1970 (UTC) plus Shift-Sekunden. Ebenso wird auch die Dauer der Aufnahme angepasst.

wichtigsten Variablen:
`BASEDIR` Pfad unter dem der Mitschnitt gespeichert werden soll
`myPATH` Ablage Pfad der Aktuellen Aufnahme. Bsp: "$BASEDIR/$YEAR/PGM/$MON_LONG/$DAY_LONG" oder "$BASEDIR/$YEAR/Tuner/$MON_LONG/$DAY_LONG"
`myFILE` Dateiname des Mitschnitts. Bsp: "${DATE}_${FR}-${TO}_Uhr_${TZ}.mp3"
`BIN` Pfad zur ausführbaren Datei 'jack_capture'
`ARG` Optionen für [jack_capture][3] 

Über die Option `-p` oder `--port` kann der Punkt zum Abgriff im Audioweg von JACK angeben werden. Diese sind von der der benutzen Hardware und Software abhängig. Beispiele sind: 
* `-p "system:capture_1" -p "system:capture_2"` Abgriff des ersten Stereo Line-In der Soundkarte
* `-p "stereo_tool:out*"` Abgriff nach Audio Aufbereitung der Software [StereoTool][7]


`crontab` Eintrag:
```
55 * * * * [path]/mittschnitt-jack_capture.sh
```
Hinweis: Das Skript sollte als normaler User ausgeführt werden. Erforderliche Rechte sind vorrausgesetzt. Beim setzen des Dateinamen, sowie des Pfades, muss darauf geachtet werden, dass der Mitschnitt **keinen** Anderen überschreibt.

# Abhängigkeiten und hilfreiche Links

* Ubuntu Studio - [https://ubuntustudio.org/][1]
* jack_capture - [https://github.com/kmatheussen/jack_capture][3]
* JACK - [http://jackaudio.org/][2]
* id3v2 - [http://id3v2-chap-tool.sourceforge.net][5]
* crontab - [https://de.wikipedia.org/wiki/Cron][6]
* QjackCtl - [https://qjackctl.sourceforge.io][4]
* StereoTool - [https://www.stereotool.com][7]
* UTC - [https://de.wikipedia.org/wiki/Koordinierte_Weltzeit][8]

# Lizenz / License

Details in LICENSE


[1]: https://ubuntustudio.org/
[2]: http://jackaudio.org/
[3]: https://github.com/kmatheussen/jack_capture
[4]: https://qjackctl.sourceforge.io
[5]: http://id3v2-chap-tool.sourceforge.net
[6]: https://de.wikipedia.org/wiki/Cron
[7]: https://www.stereotool.com
[8]: https://de.wikipedia.org/wiki/Koordinierte_Weltzeit
