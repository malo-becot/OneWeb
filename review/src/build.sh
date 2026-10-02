#!/usr/bin/env bash
# Compile la page OneWeb Review en un seul fichier HTML minifié : review/index.html
# Prérequis : npm i -D tailwindcss@3 html-minifier-terser (dans le dossier passé en $TW, par défaut ./node_modules)
set -euo pipefail
cd "$(dirname "$0")"
TW="${TW:-.}"
"$TW/node_modules/.bin/tailwindcss" -i input.css --content review.html --minify -o /tmp/review.css 2>/dev/null
python3 - <<'PY'
import base64, re
s = open('review.html').read()
sym = open('../../logos/symbole-sombre.svg').read()
sym = sym[sym.index('<defs>'):sym.rindex('</svg>')].replace('id="sd', 'id="r').replace('#sd', '#r')
fav = base64.b64encode(open('../../logos/favicon.svg','rb').read()).decode()
photo = base64.b64encode(open('vcard-photo.jpg','rb').read()).decode()
icons = f'<link rel="icon" type="image/svg+xml" href="data:image/svg+xml;base64,{fav}">'
s = s.replace('__CSS__', open('/tmp/review.css').read()).replace('__SYMBOL__', sym).replace('__ICONS__', icons).replace('__PHOTO__', photo)
open('/tmp/review.full.html','w').write(s)
PY
"$TW/node_modules/.bin/html-minifier-terser" --collapse-whitespace --remove-comments --remove-redundant-attributes \
  --remove-script-type-attributes --minify-css true --minify-js true --collapse-boolean-attributes \
  -o ../index.html /tmp/review.full.html
ls -l ../index.html
