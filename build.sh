#!/bin/bash
set -e

# Name der Hauptdatei (ohne .tex Endung)
MAIN="Thesis"

# Clean-Option prüfen
if [ "$1" == "clean" ]; then
  echo "🧹 Bereinige temporäre Dateien..."
  # Sicherheitsnetz: Versionierte Dateien niemals loeschen.
  # Das verhindert, dass ein Clean-Lauf lokale Git-Aenderungen "zerstoert".
  while IFS= read -r -d '' file; do
    rel="${file#./}"
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      if git ls-files --error-unmatch "$rel" >/dev/null 2>&1; then
        continue
      fi
    fi
    rm -f "$file"
  done < <(find . -type f \( -name "*.aux" -o -name "*.bbl" -o -name "*.bcf" -o -name "*.blg" -o -name "*.toc" -o -name "*.lof" -o -name "*.lot" -o -name "*.idx" -o -name "*.ilg" -o -name "*.ind" -o -name "*.out" -o -name "*.log" -o -name "*.run.xml" -o -name "*.lol" -o -name "*.synctex.gz" -o -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.nlo" -o -name "*.nls" \) -print0)
  rm -f build.txt build_output.txt
  rm -rf build
  echo "✅ Bereinigung abgeschlossen."
  exit 0
fi

echo "🚀 Starte Build-Prozess für $MAIN..."

# 1. Initialer LaTeX-Lauf (erstellt .aux, .toc, etc.)
pdflatex "$MAIN.tex"

# 2. Literaturverzeichnis verarbeiten
biber "$MAIN"

# 3. Verzeichnisse und Referenzen aktualisieren
pdflatex "$MAIN.tex"

# 4. Finaler Lauf für korrekte Seitenzahlen und Verweise
pdflatex "$MAIN.tex"

echo "✅ Build erfolgreich! $MAIN.pdf wurde erstellt."
