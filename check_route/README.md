# Check Route

Bei WeWeWe - Welle West Wetterau e.V. wird whärend des Sendebetriebs ein zweiter temporärer DSL-Anschluss (aka. Zeitanschluss) geschaltet und wird exklusiv für Audio Signale genutzt. Bei uns kam es (leider) schon vor, dass dieser sich nicht immer stabil verhält. Dieses Skript prüft, ob das Ziel über den Zeitanschluss (specialroute) erreichbar ist. Ist dies nicht der Fall wird die spezielle Route gelöscht und es gilt die default Route. Sollte der DSL-Anschluss wieder nutzbar sein, wird zu rückgwechselt.

Das Skript sollte regelmäßig über bspw. cron aufgerufen werden.

# Konfiguration 

Datei: `check_route.sh`
Variable:
* `altHOST=8.8.8.8` Host zum prüfen, ob Anschluss wieder  ist. Gooogle DNS ist i.d.R. *immer* erreichbar :)
* `SENDER=example.com` DNS Name des speziellen Ziels
* `spROUTE=4.3.2.1`  IPv4 Adresse des Routers der Pakete für $SENDER weiterleiten soll

Datei: `crontab`
```
* * * * * /root/bin/check_route.sh
```

Hinweis: für das setzten einer Route sind **root-Rechte erfoderlich**.

# ToDos
* Geneigte Leser werden feststellen, dass das Script auf IPv4 ausgelegt ist. Der Schwenk auf IPv6 muss noch durchdacht werden.

# Lizenz / License

Details in LICENSE