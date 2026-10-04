# Malo OneWeb — site one page

Site vitrine statique (un seul fichier `index.html`, aucune dépendance à installer).

## Publier avec surge.sh

Adresse officielle : **https://malo-oneweb.fr/** (sans www). C'est elle qui figure dans la balise canonical, les données structurées et partout ailleurs.

```bash
npm install --global surge                   # une seule fois
surge . malo-oneweb.fr                       # le site (index.html + fonts/ + logos/)
surge redirection www.malo-oneweb.fr         # la version www renvoie vers malo-oneweb.fr
surge redirection malo-oneweb.surge.sh       # l'ancienne adresse renvoie vers malo-oneweb.fr
```

Le dossier `redirection/` contient une page qui renvoie immédiatement vers `malo-oneweb.fr` en conservant le chemin (`index.html` + `200.html` pour toutes les autres adresses).

## Modifier

Tout est dans `index.html` : textes, prix (300€, 29/49/99€, 19€, 99€/an), coordonnées et liens.
Le formulaire de contact est envoyé via Web3Forms (clé d'accès dans le champ caché `access_key`) : les demandes arrivent sur l'e-mail associé à la clé.

## Logos (`logos/`)

| Fichier | Usage |
|---|---|
| `logo-clair.svg` / `.png` | Logo + texte, pour fond clair |
| `logo-sombre.svg` / `.png` | Logo + texte, pour fond sombre |
| `symbole-clair.svg` / `.png` | Symbole seul, pour fond clair |
| `symbole-sombre.svg` / `.png` | Symbole seul, pour fond sombre |

Fonds transparents. Le SVG est vectoriel (texte converti en tracés) ; les PNG font 2400 px (logo) et 1024 px (symbole) de large.

## OneWeb Review (`review/`)

- `review/index.html` + `review/Malo-OneWeb.vcf` : page finale minifiée et fiche contact, à publier ensemble (ex. `surge review malo-oneweb-review.surge.sh`). Le `.vcf` est régénéré par `build.sh` depuis le bloc `DONNÉES CLIENT`.
- `review/src/` : source lisible. Les données client sont dans le bloc `DONNÉES CLIENT` de `review.html` (nom, téléphone, liens, Place ID, note et nombre d'avis).
- Recompiler après modification : `npm i -D tailwindcss@3 html-minifier-terser` puis `TW=. ./review/src/build.sh` (avec `TW` = dossier contenant `node_modules`).
