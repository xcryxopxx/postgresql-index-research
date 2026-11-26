# Validierungsplan mit realen Daten

## 1. Zielsetzung

Ziel der Validierung ist es, zu überprüfen, inwieweit die anhand synthetischer Daten gewonnenen Erkenntnisse über Indexselektivität und Tabellenpartitionierung auf reale Daten übertragbar sind.

## 2. Auswahl des Datensatzes

Für die Validierung wird der öffentlich verfügbare Datensatz „NYC Yellow Taxi Trip Records“ der New York City Taxi and Limousine Commission (TLC) ausgewählt.

Der Datensatz enthält reale Taxifahrten mit zeitlichen, geografischen und finanziellen Attributen.

Besonders relevante Attribute sind:

- `tpep_pickup_datetime`: Startzeitpunkt der Fahrt
- `PULocationID`: Startzone der Fahrt
- `DOLocationID`: Zielzone der Fahrt
- `passenger_count`: Anzahl der Fahrgäste
- `trip_distance`: Fahrtdistanz
- `fare_amount`: Fahrpreis

Als Untersuchungszeitraum ist das Jahr 2025 vorgesehen.

## 3. Datenaufbereitung und Qualitätskontrolle

Die Daten werden im Parquet-Format heruntergeladen, mit Python verarbeitet und anschließend in PostgreSQL importiert.

Folgende Schritte sind vorgesehen:

- Überprüfung der Datentypen und fehlender Werte
- Identifikation potenzieller Duplikate
- Überprüfung unplausibler Zeitangaben
- Dokumentation auffälliger oder ungültiger Werte
- Analyse der zeitlichen und geografischen Datenverteilung
- Validierung der Anzahl importierter Datensätze

Die angewandten Bereinigungsregeln sowie die Anzahl ausgeschlossener Datensätze werden dokumentiert.

## 4. Experimentelles Vorgehen

Die Experimente werden unter vier Konfigurationen durchgeführt:

1. Nicht partitionierte Tabelle ohne zusätzliche Indizes
2. Nicht partitionierte Tabelle mit B-Tree-Indizes
3. Monatlich partitionierte Tabelle ohne zusätzliche Indizes
4. Monatlich partitionierte Tabelle mit B-Tree-Indizes

Die Partitionierung erfolgt anhand des Startzeitpunkts der Taxifahrten.

Durch Filter auf Zeitintervalle und geografische Zonen werden unterschiedliche Selektivitätsstufen untersucht. Dabei wird die tatsächliche Selektivität anhand der Anzahl übereinstimmender Datensätze bestimmt.

Zunächst wird eine reproduzierbare Teilmenge von einer Million Datensätzen untersucht. Eine Erweiterung auf größere Datenmengen erfolgt abhängig von den verfügbaren Hardware-Ressourcen.

## 5. Evaluationsmetriken

Für den Vergleich werden folgende Metriken erhoben:

- Tatsächliche Selektivität
- Ausführungszeit
- Planungszeit
- Gewählter Scan-Typ
- Geschätzte und tatsächliche Anzahl der Ergebniszeilen
- Buffer-Zugriffe
- Anzahl der tatsächlich gescannten Partitionen
- Speicherbedarf der Tabellen und Indizes

Die Messungen werden automatisiert und mehrfach wiederholt. Die Versuchsbedingungen werden möglichst konstant gehalten.

## 6. Vergleich mit synthetischen Daten

Die Ergebnisse werden mit den Experimenten auf synthetischen Daten bei vergleichbarer Datenmenge und tatsächlicher Selektivität verglichen.

Dabei wird insbesondere untersucht, ob reale Datenverteilungen das Verhalten des PostgreSQL-Optimierers und den Nutzen von Indizes beziehungsweise Partitionierung beeinflussen.

Abweichungen werden hinsichtlich Datenverteilung, Tabellenstruktur, Zeilenbreite und Zugriffskosten diskutiert.

## 7. Limitationen

Die Vollständigkeit und Genauigkeit der veröffentlichten Taxidaten wird vom Datenanbieter nicht garantiert.

Darüber hinaus unterscheiden sich reale Taxifahrten hinsichtlich ihrer Struktur und Verteilung von den synthetischen Transaktionen. Eine direkte Übertragbarkeit sämtlicher Ergebnisse kann daher nicht vorausgesetzt werden.

Die Validierung dient der Überprüfung der Robustheit der beobachteten Zusammenhänge und nicht dem Nachweis einer universell gültigen Selektivitätsgrenze.

## 8. Aktueller Status

Der Validierungsplan wurde erstellt. Der Download, die Datenaufbereitung und die experimentelle Validierung erfolgen in einer späteren Projektphase.

## 9. Quellen

- NYC Taxi and Limousine Commission: TLC Trip Record Data.
  https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

- NYC Taxi and Limousine Commission: Data Dictionary – Yellow Taxi Trip Records.
  https://www.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_yellow.pdf

Abrufdatum: 26.11.2026
