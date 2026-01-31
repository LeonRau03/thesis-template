# Copilot Instructions für LaTeX Thesis-Template

## Projektübersicht

Dies ist eine **deutsche LaTeX-Vorlage** für Bachelor-/Masterarbeiten (IU Internationale Hochschule). Hauptdatei: `Thesis.tex`, Dokumentenklasse: KOMA-Script `scrreprt`.

## Architektur

```
Thesis.tex              # Einstiegspunkt, Metadaten, Dokumentstruktur
├── preambel/
│   ├── settings.tex    # KOMA-Script Optionen (Layout, TOC, Bibliography)
│   ├── preambel.tex    # Paketladung (biblatex, hyperref, listings...)
│   ├── preambel-commands.tex  # Custom Commands (\theAuthor, \printDeclarationOfIndependence)
│   ├── Fonts.tex       # Schriftarten-Konfiguration
│   └── Hyphenation.tex # Silbentrennung für Fachbegriffe
├── content/
│   ├── 00_*.tex        # Frontmatter (Titel, Abstract, Danksagung, Abkürzungen)
│   ├── 01-05_*.tex     # Hauptkapitel (Einführung → Abschluss)
│   └── Z-Anhang*.tex   # Anhänge inkl. KI-Deklaration
├── bib/
│   └── BibtexDatabase.bib  # Literaturquellen (BibLaTeX/Biber)
└── images/             # Abbildungen
```

## Build-Prozess

```bash
./build.sh        # Vollständiger Build: pdflatex → biber → pdflatex → pdflatex
./build.sh clean  # Temporäre Dateien löschen (*.aux, *.bbl, *.log, etc.)
```

Manuell: `pdflatex Thesis.tex && biber Thesis && pdflatex Thesis.tex && pdflatex Thesis.tex`

## Wichtige Konfigurationen

| Einstellung | Datei | Zeile/Bereich |
|-------------|-------|---------------|
| Sprache (ngerman/english) | `Thesis.tex` | `\def\lang{ngerman}` |
| Zitierstil | `preambel/preambel.tex` | `\usepackage[style=apa, backend=biber]{biblatex}` |
| Metadaten (Autor, Titel, etc.) | `Thesis.tex` | `\author{}`, `\title{}`, `\thesis{}` |
| KI-Tools Deklaration | `Thesis.tex` | `\def\declareUseOfGenerativeAITool{...}` |

## Konventionen

### Dateinamen in `content/`
- `00_*.tex` = Frontmatter (vor Inhaltsverzeichnis)
- `01-05_*.tex` = Hauptkapitel (nummeriert)
- `Z-*.tex` = Anhänge (nach Literaturverzeichnis)

### Literaturquellen (BibLaTeX)
- **Online-Dokumentationen**: `@online` mit `author = {{Firmenname}}` (doppelte Klammern!)
- **urldate** wird automatisch auf Kompilierdatum gesetzt (siehe `\DeclareSourcemap` in Thesis.tex)
- Zitieren: `\cite{key}`, `\textcite{key}`, `\cite[Abschn. X]{key}`

### Custom Commands (definiert in `preambel-commands.tex`)
- `\theAuthor`, `\theTitle`, `\theStudentID` – Metadaten-Zugriff
- `\printDeclarationOfIndependence` – Selbstständigkeitserklärung
- `\printGenderDisclaimer` – Gender-Hinweis

## Häufige Aufgaben

### Neues Kapitel hinzufügen
1. Datei in `content/` erstellen (z.B. `06_Evaluation.tex`)
2. In `Thesis.tex` einbinden: `\input{content/06_Evaluation}`

### Abkürzung hinzufügen
In `content/00_Abkuerzungen.tex`:
```tex
\acro{API}{Application Programming Interface}
```

### Bild einfügen
```tex
\begin{figure}[ht]
  \centering
  \includegraphics[width=0.8\textwidth]{images/diagramm.png}
  \caption{Beschreibung}
  \label{fig:diagramm}
\end{figure}
```

## Hinweise für AI-Agenten

- **Sprache**: Dokumentation und Kommentare sind Deutsch, LaTeX-Befehle Englisch
- **Encoding**: UTF-8, deutsche Umlaute direkt verwendbar
- **Keine Änderungen** an `preambel/*.tex` ohne explizite Anfrage – diese sind stabil konfiguriert
- Bei Literaturquellen: `@online` für Webseiten/Dokumentationen, `@article`/`@book` für akademische Quellen

## Thesis-Thema: Observability-Strategie für frag.jetzt

**Titel:** Entwicklung einer umfassenden Observability-Strategie für frag.jetzt basierend auf den Four Golden Signals

**Forschungsfragen:**
1. Wie können die Four Golden Signals (Latency, Traffic, Errors, Saturation) für frag.jetzt-Services konkret instrumentiert werden?
2. Welcher Observability-Stack (Prometheus/Grafana, ELK Stack, Jaeger) ist am besten geeignet?
3. Wie kann ein intelligentes Alert-System mit minimalen False Positives entwickelt werden?

**Ziel-Services:** PWA-Frontend, Spring Boot Backend, PostgreSQL, KI-Services

**Erwartete Artefakte:**
- Wissenschaftlicher Bericht mit Observability-Strategie
- Lauffähige Observability-Plattform (Prometheus/Grafana)
- Rollenbasierte Grafana-Dashboards (DevOps, Entwickler, Product Owner)
- Operational Runbooks für Incident-Szenarien

## Referenzmaterialien

### Richtlinien (`Richtlinien und Thema/`)
| Datei | Inhalt |
|-------|--------|
| `DS_Richtlinien für die Gestaltung wissenschaftlicher Arbeiten.pdf` | IU-Formatvorgaben |
| `IU_Zitierleitfaden.pdf` | Zitierregeln (APA-Stil) |
| `DS_Leitfaden Vermeidung Plagiat.pdf` | Plagiatsvermeidung |
| `Bachelorarbeit_Thema-Übersicht.txt` | Thema, Forschungsfragen, Methodik |

### Literatur (`Literatur/`)
Wissenschaftliche Paper zum Thema Observability und Monitoring:
- **Faseeha et al.** – Observability in Microservices: Frameworks, Challenges, Deployment
- **Giamattei et al.** – Monitoring tools for DevOps and microservices (Grey Literature Review)
- **Google SRE** – Four Golden Signals (Monitoring Distributed Systems)
- **Cindy Sridharan** – Distributed Systems Observability (O'Reilly eBook)
- **Albuquerque & Correia** – Tracing and Metrics Design Patterns for Cloud-native Apps
- **Banerjee & Singh** – Comparative Analysis: Prometheus, ELK Stack, Custom Dashboards
- **Sakinala** – Monitoring and Observability for Cloud-Native Applications
- **Fischer et al.** – Microservice-Based Systems for Testing and Monitoring (Mapping Study)
- **Jalalvand et al.** – Alert Prioritisation in Security Operations Centres
- **Abieba et al.** – Advanced Observability Practices for Production Reliability
