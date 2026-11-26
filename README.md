# Wann lohnt sich ein Index in relationalen Datenbanken wirklich?

## Wechselwirkungen zwischen Indizes und Tabellenpartitionierung

### Projektbeschreibung

Dieses Forschungsprojekt untersucht den Einfluss von
B-Tree-Indizes und horizontaler Tabellenpartitionierung
auf die Abfrageperformance in PostgreSQL.

### Forschungsfrage

Bei welcher Selektivität wechselt der PostgreSQL-Optimizer
zwischen Index Scan, Bitmap Scan und Sequential Scan,
und welchen Einfluss hat Partition Pruning auf diese
Entscheidung?

### Methodik

- Generierung synthetischer Transaktionsdaten
- Vergleich partitionierter und unpartitionierter Tabellen
- Variation der Abfrageselektivität
- Messung mittels EXPLAIN (ANALYZE, BUFFERS)
- Automatisierte Experimente mit Python
- Statistische Auswertung und Visualisierung

### Testumgebung

- PostgreSQL 19.0
- Windows
- Python 3.12.10
- Visual Studio Code
- Git

### Projektstruktur

- `sql/`: SQL-Skripte
- `experiments/`: Automatisierung der Experimente
- `results/`: Messergebnisse und Diagramme

### Projektstatus

Das Projekt befindet sich derzeit in der Implementierungsphase.

Universitatea Babeș-Bolyai, Cluj-Napoca  
Studiengang Informatik – Forschungsprojekt