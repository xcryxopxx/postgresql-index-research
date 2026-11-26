# Forschungstagebuch

## Phase 1 – Vorbereitung der Entwicklungsumgebung

### Schritt 1 – PostgreSQL und pgAdmin
- PostgreSQL 19.0 unter Windows installiert.
- Verbindung mit pgAdmin erfolgreich getestet.

### Schritt 2 – Visual Studio Code
- Entwicklungsumgebung eingerichtet.

### Schritt 3 – Python
- Python 3.12.10 überprüft.
- Python-Aufruf über den Windows-Launcher (py).
- Virtuelle Umgebung (.venv) erfolgreich erstellt.

### Schritt 4 – Git
- Git-Installation überprüft.

### Schritt 5 – GitHub
- Privates Repository erstellt.
- Repository lokal geklont.
- Git-Verbindung erfolgreich getestet.

## Phase 2 – Implementierung

### Schritt 6 – Projektstruktur
- Verzeichnisse für SQL-Skripte, Experimente
  und Ergebnisse erstellt.
- Python-Abhängigkeiten installiert.
- Bibliotheksversionen gespeichert.
- README und .gitignore konfiguriert.

### Schritt 7 – Datenbank
- Datenbank index_research erstellt.
- Tabelle transactions_normal erstellt.
- Python-Datenbankverbindung implementiert.
- Zugangsdaten lokal in .env gespeichert.

### Schritt 8 – Datengenerierung
- 1.000.000 synthetische Transaktionen generiert.
- Annähernd gleichmäßige Verteilung verwendet.
- Zufallsgenerator mit setseed(0.42) initialisiert.
- Datenintegrität überprüft.
- Tabellenstatistiken mit ANALYZE aktualisiert.
- Gemessene Selektivität für customer_id <= 100:
  1,002 % (10.020 Datensätze).

### Schritt 9 – Indexexperimente

Status: Abgeschlossen.

#### Durchgeführte Arbeiten

- Ausgangszustand ohne Indizes überprüft.
- Abfrageperformance ohne Index gemessen.
- Zwei B-Tree-Indizes erstellt:
  - idx_normal_customer
  - idx_normal_created_at
- Abfrageperformance mit Index gemessen.
- Sechs unterschiedliche Selektivitätsstufen untersucht.
- Pro Abfrage ein Warm-up und drei gemessene
  Wiederholungen durchgeführt.
- Tatsächliche Selektivitäten bestimmt.
- Zugriffsmethoden dokumentiert.
- Speicherbedarf der Indizes gemessen.
- Vorläufige Ergebnisse interpretiert.
- Methodische Einschränkungen dokumentiert.

#### Experimentelle Ergebnisse

- Anzahl der Datensätze: 1.000.000
- Mittlere Ausführungszeit ohne Index: 215.251 ms
- Mittlere Ausführungszeit mit Index: 0.238333 ms
- Tatsächliche Selektivität: 0.0075 %
- Beschleunigungsfaktor: ca. 903.15
- Reduktion der Ausführungszeit: ca. 99.89 %

#### Beobachtete Zugriffsmethoden

- Bitmap Heap Scan und Bitmap Index Scan bei
  den getesteten Selektivitätsstufen bis ca. 50 %.
- Sequential Scan bei 100 % Selektivität.
- Der genaue Übergangspunkt wurde noch nicht bestimmt.

#### Speicherbedarf

- Tabellengröße (Heap): 150 MB
- Gesamtgröße der Indizes: 28 MB
- Gesamtgröße einschließlich Indizes: 179 MB
- Index auf customer_id: 6960 kB
- Index auf created_at: 21 MB
- Relativer Speicherbedarf der Indizes: 18.80 %

#### Methodische Erkenntnisse

- Indizes können bei selektiven Abfragen erhebliche
  Performancevorteile bieten.
- Indizes verursachen zusätzlichen Speicherbedarf.
- Die Ausführungszeit steigt nicht zwangsläufig
  monoton mit der Selektivität.
- Cache-Effekte müssen bei weiteren Experimenten
  berücksichtigt werden.
- Automatisierte Messungen sind für eine
  systematische Evaluation erforderlich.

#### Dokumentation

- docs/preliminary_results.md
- results/without_index.txt
- results/with_index.txt
- results/selectivity_tests.txt
- results/index_sizes.txt
- sql/03_create_indexes.sql
- sql/05_test_queries.sql

#### Nächster Schritt

Schritt 10 – Erstellung einer partitionierten Tabelle
mit zwölf monatlichen Partitionen und identischem
Datenbestand für vergleichende Experimente.

### Schritt 16 – Validierungsplan mit realen Daten

**Status:** Abgeschlossen

**Datum:** 26.11.2026

- Auswahl des NYC Yellow Taxi Trip Records-Datensatzes.
- Definition der relevanten Datenattribute.
- Planung der Datenaufbereitung und Qualitätskontrolle.
- Definition der experimentellen Konfigurationen und Evaluationsmetriken.
- Planung des Vergleichs zwischen synthetischen und realen Daten.
- Dokumentation möglicher Limitationen.

Der vollständige Validierungsplan befindet sich in `docs/real_data_validation.md`.

Die praktische Validierung erfolgt in einer späteren Projektphase.
