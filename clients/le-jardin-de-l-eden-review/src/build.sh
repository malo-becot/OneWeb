#!/usr/bin/env bash
# Compile la page OneWeb Review du Jardin de l'Eden en un seul fichier HTML minifié (../index.html) + la fiche contact .vcf
# Prérequis : npm i -D tailwindcss@3 html-minifier-terser (dans le dossier passé en $TW)
set -euo pipefail
cd "$(dirname "$0")"
TW="${TW:-.}"
"$TW/node_modules/.bin/tailwindcss" -i input.css --content review.html --minify -o /tmp/review-eden.css 2>/dev/null
python3 - <<'PY'
import urllib.parse
s = open('review.html').read()
fav = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' rx='16' fill='#020617'/><text x='16' y='21' font-family='Georgia,serif' font-style='italic' font-size='14' fill='#fef3c7' text-anchor='middle'>JE</text></svg>"
icons = '<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,' + urllib.parse.quote(fav, safe=" =:/'<>,.") + '">'
s = s.replace('__CSS__', open('/tmp/review-eden.css').read()).replace('__ICONS__', icons)
open('/tmp/review-eden.full.html','w').write(s)
PY
"$TW/node_modules/.bin/html-minifier-terser" --collapse-whitespace --remove-comments --remove-redundant-attributes \
  --remove-script-type-attributes --minify-css true --minify-js true --collapse-boolean-attributes \
  -o ../index.html /tmp/review-eden.full.html
node vcard.js
ls -l ../index.html ../*.vcf
