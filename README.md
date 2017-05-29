# Ensons Beacon Dokumentation

![Raspberry Pi overview](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/overview.jpg)

## 1. Einleitung

Mit Ihrem Mobiltelefon können Sie von Unterwegs Ihre Einbruchmeldeanlage fernsteuern. Dazu muss sich Ihr Mobiltelefon über das Internet mit der Einbruchmeldeanlage in Ihrem zu Hause bzw. in Ihrer Firma verbinden.

Dies geschieht über den gewöhnlichen Internet-Hausanschluss (der z. B. von der Telekom, NetCologne, oder UnityMedia bereitgestellt wird). Von solchen Internetanbietern wird Ihrem zu Hause eine **IP-Adresse** zugewiesen, die mit dem Internet verbunden ist.

Kennt ihr Mobiltelefon diese IP-Adresse, dann kann es sich mit der Einbruchmeldeanlage in Ihrem zu Hause verbinden (vorausgesetzt Ihr Netzwerkrouter erlaubt die Anfrage, wir Helfen Ihnen bei der Konfiguration).

Die IP-Adresse ihres zu Hauses ändert sich nicht, sofern Sie eine so genannte **statische IP-Adresse** bei Ihrem Internetanbieter bestellt haben. Das ist jedoch nur selten der Fall.

Die meisten Hausanschlüsse haben eine so genannte **dynamische IP-Adresse**. Das bedeutet, dass sie die Adresse laufend ändert (z. B. jede Nacht). Jedoch kann Ihr Mobiltelefon dann nicht wissen wo Ihr zu Hause "gerade" ist und kann sich nicht mit Ihrer Anlage verbinden.

Wir stellen ein auf Wunsch ein kleines Gerät bei Ihnen zu Hause auf, dass regelmäßig eine Verbindung zu unserem `ensons.de` Server  herstellt.

![Beacon Network connector](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/network.jpg)

Unser Server identifiziert das Gerät und kennt dann die IP-Adresse von Ihrem zu Hause. Jetzt kann Ihr Mobiltelefon unseren Server nach der (aktuellen) IP-Adresse Ihres zu Hauses fragen und sich mit Ihrer Einbruchmeldeanlage verbinden.

Diese Technik nennt sich [DDNS](https://de.wikipedia.org/wiki/Dynamisches_DNS) (Dynamic Domain Name System).

## 2. Alternative Lösungen

Ihr vom Internetanbieter bereitgestellte Router unterstützt in der Regel DDNS. Mit anderen Worten, Ihre Fritz!Box oder Ihr NetCologne-Router kann sich regelmäßig mit dem Server eines Drittanbieters im Internet verbinden um Ihre (aktuelle) IP-Adresse bekannt zu geben.

Manche Router, z. B. von der Telekom, unterstützen jedoch nur eine kleine Auswahl, oft ausländischer und kostenpflichtiger, DDNS-Dienste.

Die Fritz!Box unterstützt relativ viele Drittanbieter, benutzt aber teilweise unsichere Kommunikationsprotokolle (kein SSL/TLS).

Darum bieten wir hier eine Lösung an, die losgelöst von Ihrem Router funktioniert. Sie kostet **keine** Nutzungsgebühr, bindet Sie nicht an Drittanbieter und benutzt einen sicheren Kommunikationskanal.

## 3. Sicherheit und Philosophie

Sie erhalten also ein Gerät, dass in Ihrem Keller am Strom angeschlossen und mit Ihrem Netzwerk bzw. Internet verbunden ist.

Spätestens jetzt sollten Sie sich fragen:

* Woher weiß ich, was das Gerät eigentlich macht?
* Wie wird mein Datenschutz gewährleistet?
* Vieviel Strom verbraucht das?
* Kann ein Hacker das Gerät übernehmen?
* Kann das Gerät in meinem Netzwerk spionieren?
* Ist mein Internetanschluss vor Zweckentfremdung geschützt?
* Womöglich ist da ein Mikrofon eingebaut?

Diese Fragen beantworten wir gerne. Und zwar kategorisiert nach **Hardware**, **Betriebssystem** und **Software** in den folgenden Unterkapiteln.

#### 3.1 Hardware

Das Gerät ist eine handelsübliche [Raspberry Pi](https://www.amazon.de/gp/offer-listing/B01CD5VC92) Platine (Version 3 Modell B), die den Sicherheits- und Gesundheitsanforderungen der Europäischen Union entspricht.

Das [Gehäuse](https://www.amazon.de/gp/offer-listing/B01CCPKCSK) und das [Netzteil](https://www.amazon.de/gp/offer-listing/B01DP8O5A4) werden als Originalzubehör bezogen. Die [Speicherkarte](https://www.amazon.de/gp/offer-listing/B010Q57SEE) wird vom renommierten Hersteller SanDisk bezogen.

Es handelt sich also nicht um eine unkonforme Speziallösung, sondern um ein Massenprodukt, das schon in vielen Haushalten und Büros Einzug gefunden hat.

Mit ein wenig Recherche können Sie die genaue Hardwarespezifikation im Detail analysieren. Hier ist kein Mikrofon eingebaut und das Gerät verbraucht minimal Energie.

#### 3.2 Betriebssystem

Als Betriebssystem wird das vom Hersteller empfohlene Betriebssytem [Raspbian](https://www.raspberrypi.org/downloads/raspbian) in der Lite-Version verwendet.

Wie genau wir das Betriebssystem installieren und anpassen, erfahren Sie auf unserer separaten [Dokumentationsseite](https://github.com/ensons/satellite). Zusammenfassend lässt sich sagen, dass wir die neuste Version verwenden, sämtliche Funkmodule (Wi-Fi, Bluetooth) deaktivieren und den Fernzugriff (SSH via Ethernet) deaktivieren.

Sie können jederzeit einen Bildschirm (HDMI) und eine Tastatur (USB) anschließen und sich mit dem Werkseingestellten Benutzernamen `pi` und dem dazugehörigen Passwort `raspberry` einloggen. Wir ändern die Zugangsdaten nicht, damit Sie das Gerät bei Bedarf jederzeit selber überprüfen können.

#### 3.3 DDNS Software

Diese Dokumentation die Sie gerade lesen ist Teil der Software mit der der Raspberry Pi die DDNS Anfragen an den `ensons.de` Server schickt. Sie heißt "Beacon" (engl. "Signalfeuer").

Alle Bestandteile sind unter der Open-Source Lizenz [MIT](https://opensource.org/licenses/MIT) veröffentlicht. Die Programmiersprache ist [Ruby](https://www.ruby-lang.org/de/), die ebenfalls Quelloffen ist.

Es folgt ein Überblick über die generelle Funktionsweise. Technische Details entnehmen Sie bitte der [Code-Dokumentation](http://www.rubydoc.info/github/ensons/beacon/master) oder direkt den [Quelldateien](https://github.com/ensons/beacon).

## 4. Funktionsweise

Der Raspberry Pi hat zwei LEDs auf der Vorderseite. Die rote LED leuchtet immer (Stromzufuhr). Die grüne LED blinkt während des Hochfahrens des Gerätes beim lesen und schreiben auf der Speicherkarte. 

![Beacon LEDs](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/leds.jpg)

Sobald das Gerät dann bereit ist, signalisiert die grüne LED in welchem Zustand es sich befindet. Sie gibt spätestens alle 60 Sekunden ein Leuchtsignal ab.

Folgendes Zustandsdiagramm beschreibt die Funktionsweise dieser Software. Es beginnt mit dem Zustand `Start`.

![Beacon State Diagram](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/states.svg)

Folgender Abschnitt beschreibt die einzelnen Zustände und die jeweils dazugehörigen LED-Signale.

### 4.1 Status `Pinging server`

Zu Beginn wird versucht den `ensons.de` Server anzusprechen um ihn über die aktuelle IP-Adresse zu informieren. 

### 4.2 Status `Offline`

Wenn keine Verbindung zum Internet besteht (roter Pfeil auf dem Zustandsdiagramm), gibt die grüne Aktivitäts-LED ein S.O.S.-Signal ab (3 kurz, 3 lang, 3 kurz). 

Stellen Sie in diesem Zustand sicher, dass das Netzwerkkabel dem Raspberry Pi eine IP-Adresse per DHCP vergibt und mit dem Internet verbunden ist. Entfernen Sie ggf. die Stromzufuhr um das Gerät neu zu starten.

Alle 5 Sekunden wird erneut versucht eine Verbindung zum `ensons.de` Server aufzubauen.

### 4.3 Status `Ping success`

Wenn der `ensons.de` Server bestätigt hat, dass die Anfrage erfolgreich eingegangen ist (grüner Pfeil auf dem Zustandsdiagramm), dann leuchtet die grüne LED einmal 3 Sekunden lang auf.

Alles ist richtig konfiguriert und Ihre IP-Adresse wurde erkannt.

Nach diesem Zustand geht das Gerät in eine Warteschleife bis zum nächsten Versuch den Server anzusprechen.

### 4.4 Status `Error`

Sollte der `ensons.de` Server nicht erreichbar sein oder unerwartet reagieren, obwohl eine Internetverbindung besteht, leuchtet die grüne LED  zwei mal auf (2x eine halbe Sekunde).

Sollte dieser Status bestehen bleiben, kontaktieren Sie bitte unseren Kundendienst oder starten Sie den Raspberry Pi neu.

Das Gerät geht auch hier in eine Warteschleife bevor erneut eine Verbindung hergestellt wird (siehe Status `Ping success`).

### 4.5 Status `Wait x Intervals`

In der Warteschleife gibt die grüne LED durch 5 kurze Blinksignale eine Wartezeit von 5 Minuten an. 60 Sekunden später blinkt sie dann 4 mal, und so weiter. Eine Minute vor Ende der Warteschleife blinkt sie einmal.

Nach Ablauf von insgesamt 5 Minuten geht es weiter zum Ausgangszustand `Pinging server`.



## Code-Konventionen

* Ruby 2.1.3
* Github
* No gem dependencies
* Semantic Versioning (tagging)
* Rubocop
* Continuous Integration (circleci)

## Entwicklung

### Tests

```bash
gem install bundler
bundle install
bundle exec rspec
```

## Lizenz

* MIT
