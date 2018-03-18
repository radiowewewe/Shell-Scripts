# IcecastStats.py

Das Webradio von WeWeWe - Welle West Wetterau e.V.  wird über [IceCast][1]  bereit gestellt. Für IceCast selbst kann ein Log konfiguriert werden und einen Status des IceCast Servers kann man auch einsehen. Will man einen Verlauf darüber haben wieviele 'concurrent listener' ist Eigeninitaivive gefragt. So gibt es bspw. das Monitoring Projekt [Monitorix][4]. Oder man speichert in regelmäßigen Abständen den Wert ab. Dies ist insbesondere Hilfreich wenn man keinen oder nur beschränkten Zugriff auf den [IceCast][1] Server selbst hat.

Ein möglicher Weg dies zu Tun ist mittels [Python][2]-Skript den [JSON][3] Status des Servers abzufragen, auszuwerten und in eine CSV Datei zu schreiben.

Das Skript sollte regelmäßig über bspw. cron aufgerufen werden.

# Konfiguration 

Datei: `IcecastStats.py`

Variable:
* `urls` Lite mit Stream-Adressen, welche geloggt werden sollen
* `logFile` Datei zum Speichern der Werte
* `jStats`  Hier die URl des JSON-Status anzupassen. Dies muss mit $urls harmonieren

Datei: `crontab`
```
* * * * * /root/bin/IcastStats.py
```

# Lizenz / License

Details in LICENSE

[1]: https://icecast.org
[2]: https://www.python.org
[3]: https://en.wikipedia.org/wiki/JSON
[4]: http://www.monitorix.org
