# Vorläufige experimentelle Ergebnisse

## Experiment 1 – Vergleich mit und ohne B-Tree-Index

### Forschungsziel

Untersuchung des Einflusses eines B-Tree-Index
auf die Ausführungszeit einer selektiven Abfrage.

### Versuchsbedingungen

- PostgreSQL 19.0
- Windows
- 1.000.000 Datensätze
- Tabelle: transactions_normal
- Drei Wiederholungen pro Konfiguration
- Messmethode: EXPLAIN (ANALYZE, BUFFERS)

### Testabfrage

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM transactions_normal
WHERE customer_id = 42;
```

### Messergebnisse

| Konfiguration | Lauf 1 (ms) | Lauf 2 (ms) | Lauf 3 (ms) | Mittelwert (ms) |
|---|---:|---:|---:|---:|
| Ohne Index | TODO | TODO | TODO | TODO |
| Mit Index | TODO | TODO | TODO | TODO |

### Ausführungspläne

- Ohne Index: TODO
- Mit Index: TODO

### Beschleunigungsfaktor

TODO

## Experiment 2 – Einfluss der Selektivität

| Selektivität (ca.) | Bedingung | Scan-Typ | Execution Time (ms) |
|---|---|---|---:|
| 0,01 % | customer_id = 42 | TODO | TODO |
| 1 % | customer_id <= 100 | TODO | TODO |
| 10 % | customer_id <= 1000 | TODO | TODO |
| 50 % | customer_id <= 5000 | TODO | TODO |
| 100 % | customer_id <= 10000 | TODO | TODO |

## Experiment 3 – Speicherbedarf

| Metrik | Größe |
|---|---:|
| Tabelle ohne Indizes | TODO |
| Tabelle (Heap) | TODO |
| Indizes | TODO |
| Gesamtgröße mit Indizes | TODO |

## Diskussion

TODO – Interpretation nach Durchführung
der Experimente.

## Einschränkungen

Die bisherigen Messungen dienen als Proof of Concept.
Cache-Effekte und Hintergrundprozesse können die
Ausführungszeiten beeinflussen.

Die systematische Messung erfolgt später automatisiert
mit Python und einer größeren Anzahl von Wiederholungen.

### Messung ohne Index

- Scan-Typ: Seq Scan
- Warm-up: 466.363 ms
- Anzahl der gefundenen Datensätze: 75
- Tabellengröße (Heap): 150
- Indexgröße: 0 bytes
- Gesamtgröße: 150

| Wiederholung | Execution Time (ms) |
|---|---:|
| 1 | 287.187 |
| 2 | 207.999 |
| 3 | 150.567 |
| Mittelwert | 215.251 |

Die abnehmenden Ausführungszeiten können auf Cache-Effekte zurückzuführen sein.

![Ohne index, stats](image.png)

### Messung mit Index

- Scan-Typ: Bitmap Heap Scan + Bitmap Index Scan
- Warm-up: 1.132 ms
- Anzahl der gefundenen Datensätze: 75 (bei unverändertem Datenbestand)

| Wiederholung | Execution Time (ms) |
|---|---:|
| 1 | 0.295 |
| 2 | 0.213 |
| 3 | 0.207 |
| Mittelwert | 0.238 |

### Vergleich mit und ohne Index

| Konfiguration | Mittlere Ausführungszeit (ms) |
|---|---:|
| Ohne Index | 215.251 |
| Mit Index | 0.238 |

- Beschleunigungsfaktor: 903.15x
- Reduktion der Ausführungszeit: 99.89 %
- Gemessene Selektivität: 0,0075 %

Die Ergebnisse sind vorläufig. Cache-Effekte und Hintergrundprozesse können die Messungen beeinflussen.

## Experiment 2 – Einfluss der Selektivität

### Forschungsziel

Untersuchung des Einflusses der Selektivität
auf die Ausführungszeit und die Wahl der
Zugriffsmethode durch den PostgreSQL-Optimierer.

### Versuchsbedingungen

- Tabelle: transactions_normal
- Datensatz: 1.000.000 Transaktionen
- Konfiguration: mit B-Tree-Indizes
- Messmethode: EXPLAIN (ANALYZE, BUFFERS)
- Ein Warm-up pro Abfrage
- Drei gemessene Wiederholungen pro Abfrage

### Messergebnisse

| Erwartete Selektivität | Tatsächliche Selektivität | Datensätze | Scan-Typ | Warm-up (ms) | Lauf 1 (ms) | Lauf 2 (ms) | Lauf 3 (ms) | Mittelwert (ms) |
|---:|---:|---:|---|---:|---:|---:|---:|---:|
| 0.01 % | 0.0075 % | 75 | Bitmap Heap Scan + Bitmap Index Scan | 1.132 | 0.295 | 0.213 | 0.207 | 0.238 |
| 1 % | 1.0020 % | 10020 | Bitmap Heap Scan + Bitmap Index Scan | 397.032 | 11.715 | 15.017 | 16.086 | 14.273 |
| 10 % | 9.9576 % | 99576 | Bitmap Heap Scan + Bitmap Index Scan | 442.616 | 142.271 | 138.972 | 248.884 | 176.709 |
| 25 % | 24.9457 % | 249457 | Bitmap Heap Scan + Bitmap Index Scan | 138.886 | 131.506 | 143.245 | 127.001 | 133.917 |
| 50 % | 49.9521 % | 499521 | Bitmap Heap Scan + Bitmap Index Scan | 312.586 | 204.121 | 335.387 | 202.436 | 247.315 |
| 100 % | 100.0000 % | 1000000 | Seq Scan | 159.933 | 152.174 | 151.678 | 169.542 | 157.798 |

### Interpretation

Bei einer tatsächlichen Selektivität zwischen
0,0075 % und 49,9521 % wurde ein Bitmap Heap Scan
in Kombination mit einem Bitmap Index Scan verwendet.

Bei einer Selektivität von 100 % entschied sich
der PostgreSQL-Optimierer für einen Sequential Scan.

Der genaue Übergangspunkt zwischen diesen
Zugriffsmethoden wurde noch nicht bestimmt.

Die Ausführungszeit steigt nicht monoton mit
der Selektivität. Beispielsweise war die Abfrage
bei ungefähr 25 % schneller als bei 10 %.

Mögliche Einflussfaktoren sind Cache-Effekte,
unterschiedliche Zugriffskosten und Hintergrundprozesse.

### Einschränkungen

Die Ergebnisse stellen einen vorläufigen
Proof of Concept dar.

Da die verschiedenen Selektivitätsstufen bisher
nur in der Konfiguration mit Indizes untersucht
wurden, kann noch keine allgemeine Aussage über
den Performancevorteil der Indizes getroffen werden.

Weitere automatisierte Experimente mit und ohne
Indizes sowie zusätzlichen Wiederholungen sind
erforderlich.

## Experiment 3 – Speicherbedarf der Indizes

### Forschungsziel

Untersuchung des zusätzlichen Speicherbedarfs der B-Tree-Indizes.

### Versuchsbedingungen

- Tabelle: transactions_normal
- Datensatz: 1.000.000 Transaktionen
- Zwei B-Tree-Indizes

### Messergebnisse

| Metrik | Gemessener Wert |
|---|---:|
| Tabellengröße (Heap) | 150 MB |
| Gesamtgröße der Indizes | 28 MB |
| Gesamtgröße einschließlich Indizes | 179 MB |
| idx_normal_created_at | 21 MB |
| idx_normal_customer | 6960 kB |
| Tabellengröße in Bytes | 157540352 |
| Indexgröße in Bytes | 29614080 |
| Gesamtgröße in Bytes | 187228160 |
| Relativer Speicherbedarf der Indizes | 18.80 % |

### Interpretation

Die beiden B-Tree-Indizes benötigen zusammen 28 MB zusätzlichen Speicherplatz. Dies entspricht 18.80 % der Heap-Größe. Der zusätzliche Speicherbedarf muss bei der Bewertung der Performancevorteile berücksichtigt werden.

### Einschränkungen

Die Messung bezieht sich auf den aktuellen synthetischen Datensatz. Bei größeren Datensätzen oder anderen Datenverteilungen können sich die Indexgrößen und der relative Speicherbedarf verändern.

### Reproduzierbarkeit

- SQL-Skript: sql/05_test_queries.sql
- Messwerte: results/index_sizes.txt