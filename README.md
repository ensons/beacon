# Ensons Beacon Dokumentation

"Ihr quelloffener dynamischer Ensons-DNS-updater."

"Mein... was?"

![Raspberry Pi overview](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/overview.jpg)

## 1. Einleitung

Mit Ihrem Mobiltelefon können Sie von Unterwegs Ihre Einbruchmeldeanlage fernsteuern. Dazu muss sich das Mobiltelefon über das Internet mit der Einbruchmeldeanlage in Ihrem zu Hause oder in Ihrer Firma verbinden.

Dies geschieht über den gewöhnlichen Internetanschluss (der z. B. von der Telekom, NetCologne, oder UnityMedia bereitgestellt wird). Von solchen Internetanbietern wird Ihrem zu Hause eine **IP-Adresse** zugewiesen, die mit dem Internet verbunden ist.

Kennt ihr Mobiltelefon diese IP-Adresse, dann kann es sich mit der Einbruchmeldeanlage in Ihrem zu Hause verbinden (vorausgesetzt Ihr Netzwerkrouter erlaubt die Anfrage, wir Helfen Ihnen bei der Konfiguration).

Die IP-Adresse ihres zu Hauses ändert sich nicht, sofern Sie eine so genannte **statische IP-Adresse** bei Ihrem Internetanbieter bestellt haben. Das ist jedoch nur selten der Fall. 

Die meisten Hausanschlüsse haben eine so genannte **dynamische IP-Adresse**. Das bedeutet, dass sie sich laufend ändert (z. B. jede Nacht). Jedoch kann Ihr Mobiltelefon dann nicht wissen wo Ihr zu Hause "gerade" ist und kann sich nicht mit Ihrer Anlage verbinden.

Wir stellen ein auf Wunsch ein kleines Gerät bei Ihnen zu Hause auf, dass regelmäßig eine Verbindung zu unserem `ensons.de` Server  herstellt.

![Beacon Network connector](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/network.jpg)

Unser Server identifiziert das Gerät und kennt dann die IP-Adresse von Ihrem zu Hause. Jetzt kann Ihr Mobiltelefon unseren Server nach der (aktuellen) IP-Adresse Ihres zu Hauses fragen und sich mit Ihrer Einbruchmeldeanlage verbinden.

Diese Technik nennt sich [DDNS](https://de.wikipedia.org/wiki/Dynamisches_DNS) (Dynamic Domain Name System).

## 2. Alternative Lösungen

Ihr vom Internetanbieter bereitgestellte Router unterstützt in der Regel DDNS. Mit anderen Worten, Ihre Fritz!Box oder Ihr NetCologne-Router kann sich regelmäßig mit dem Server eines Drittanbieters im Internet verbinden um Ihre (aktuelle) IP-Adresse bekannt zu geben.

Manche Router, z. B. von der Telekom, unterstützen jedoch nur eine kleine Auswahl, oft ausländischer und kostenpflichtiger, DynDNS-Dienste.

Die Fritz!Box unterstützt relativ viele Drittanbieter, benutzt aber teilweise unsichere Kommunikationsprotokolle (kein SSL/TLS). 

Darum bieten wir hier eine Lösung an, die losgelöst von Ihrem Router funktioniert. Das kostet keine Nutzungsgebühr, bindet Sie nicht an Drittanbieter und benutzt einen sicheren Kommunikationskanal.

## 3. Sicherheit und Philosophie

Sie erhalten also ein Gerät, dass in Ihrem Keller am Strom angeschlossen und mit Ihrem Netzwerk bzw. Internet verbunden ist.

Spätestens jetzt sollten in Ihrem Kopf rote Lampen aufleuchten:

* Woher weiß ich, was das Gerät eigentlich macht?
* Wie wird mein Datenschutz gewährleistet?
* Vieviel Strom verbraucht das?
* Kann ein Hacker das Gerät übernehmen?
* Kann das Gerät in meinem Netzwerk spionieren?
* Ist mein Internetanschluss vor Zweckentfremdung geschützt?
* Womöglich ist da ein Mikrofon eingebaut?

Diese Fragen lassen sich nach Technologie kategorisiert beantworten. **Hardware**, **Betriebssystem** und **Software**.

#### 3.1 Hardware

Das Gerät ist eine handelsübliche [Raspberry Pi](https://www.amazon.de/gp/offer-listing/B01CD5VC92) Platine (Version 3 Modell B), die den Sicherheits- und Gesundheitsanforderungen der Europäischen Union entspricht.

Das [Gehäuse](https://www.amazon.de/gp/offer-listing/B01CCPKCSK) und das [Netzteil](https://www.amazon.de/gp/offer-listing/B01DP8O5A4) werden als Originalzubehör bezogen. Die [Speicherkarte](https://www.amazon.de/gp/offer-listing/B010Q57SEE) wird vom renommierten Hersteller SanDisk bezogen.

Es handelt sich also nicht um eine unkonforme Speziallösung, sondern um ein Massenprodukt, das schon in vielen Haushalten und Büros Einzug gefunden hat. 

Mit ein wenig Recherche können Sie die genaue Hardwarespezifikation im Detail analysieren. Hier ist kein Mikrofon eingebaut, das Gerät verbraucht minimal Energie und fängt nicht einfach an zu brennen.

#### 3.2 Betriebssystem

Als Betriebssystem wird das vom Hersteller empfohlene Betriebssytem [Raspbian](https://www.raspberrypi.org/downloads/raspbian) (Jessie Lite) verwendet.

Wie genau wir das Betriebssystem installieren und anpassen, erfahren Sie auf unserer separaten [Dokumentationsseite](https://github.com/ensons/satellite). Zusammenfassend lässt sich sagen, dass wir die neuste Version verwenden, die Funkmodule (Wi-Fi/Bluetooth) deaktivieren und den Fernzugriff (SSH via Ethernet) deaktivieren.

Sie können jederzeit einen Bildschirm (HDMI) und eine Tastatur (USB) anschließen und sich mit dem Werkseingestellten Benutzernamen `pi` und dem dazugehörigen Passwort `raspberry` einloggen. Wir ändern die Zugangsdaten nicht, damit Sie das Gerät bei Bedarf immer selber überprüfen können.

#### 3.3 DDNS Software

Diese Dokumentation die Sie gerade lesen ist Teil der Software mit der der Raspberry Pi die DDNS Anfragen an den `ensons.de` Server schickt. Sie heißt "Beacon" (engl. "Signalfeuer").

Alle Bestandteile sind unter der Open-Source Lizenz [MIT](https://opensource.org/licenses/MIT) veröffentlicht. Die Programmiersprache ist [Ruby](https://www.ruby-lang.org/de/), die ebenfalls Quelloffen ist.

Es folgt ein Überblick über die generelle Funktionsweise. Technische Details entnehmen Sie bitte der [Code-Dokumentation](http://www.rubydoc.info/github/ensons/beacon/master) oder direkt den [Quelldateien](https://github.com/ensons/beacon).

## 4. Funktionsweise

Beim starten wird zuerst versucht den `ensons.de` Server anzusprechen um ihn über die aktuelle IP-Adresse zu informieren.

![Beacon State Diagram](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/states.svg)


### 4.1 LED Signale

Die grüne Aktvitäts-LED auf der Vorderseite des Raspberry Pi gibt spätestens alle 60 Sekunden ein Leuchtsignal ab.

![Beacon LEDs](https://s3.eu-central-1.amazonaws.com/ensons-production/media/beacon/leds.jpg)

#### 3 kurz, 3 lang, 3 kurz (SOS)

Es besteht keine Verbindung zum Internet. Stellen Sie in dem Fall sicher, dass das Netzwerkkabel eine IP-Adresse per DHCP vergibt und mit dem Internet verbunden ist.

#### 1 mal langes leuchten

Der `ensons.de` Server wurde erfolgreich erreicht und Ihre IP-Adresse erkannt. Alles ist richtig konfiguriert.

#### 2 mal aufleuchten

Es besteht zwar eine Internetverbindung, der `ensons.de` Server konnte aber nicht erfolgreich angesprochen werden. Entweder funktioniert der Server gerade nicht, oder der Raspberry Pi selbst ist fehlkonfiguriert.

#### X mal kurzes blinken

Der Raspberry Pi wartet x Minuten bis zur nächsten Aktivität. Z. B. 5 mal kurzes blinken bedeutet 5 Minuten Wartezeit.

## Code-Konventionen

* Ruby 2.1.3
* Github
* No gem dependencies
* Semantic Versioning (tagging)
* Rubocop
* Continuous Integration (circleci)

## Lizenz

* MIT
