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
Status: In Bearbeitung.

Ziel:
Vergleich der Abfrageperformance mit und ohne
B-Tree-Index bei unterschiedlichen Selektivitäten.

## Methodische Entscheidungen

- Verwendung synthetischer Daten für kontrollierte
  und reproduzierbare Experimente.
- Zunächst eine Million Datensätze.
- Keine Primärschlüsselindizes im Ausgangszustand.
- Messung mit EXPLAIN (ANALYZE, BUFFERS).
- Verwendung identischer Daten für spätere
  Vergleiche mit partitionierten Tabellen.

## Abweichungen von der ursprünglichen Planung

- Windows statt Linux.
- PostgreSQL 19.0 statt PostgreSQL 16.

## Nächste Schritte

- B-Tree-Indizes erstellen.
- Selektivitätsexperimente durchführen.
- Partitionierte Tabelle erstellen.
- Messungen mit Python automatisieren.