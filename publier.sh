#!/usr/bin/env bash
# Publie le site principal sur https://malo-oneweb.fr avec surge.
# Authentification : soit SURGE_TOKEN dans l'environnement, soit un secret réseau (en-tête Authorization: Basic
# base64("token:<jeton>")) injecté par le proxy pour surge.surge.sh ; dans ce cas un jeton factice suffit ici.
# N'envoie que les fichiers du site (pas clients/, sauvegardes/, review/src…).
set -euo pipefail
cd "$(dirname "$0")"
export SURGE_TOKEN="${SURGE_TOKEN:-injecte-par-le-proxy}"
SURGE="${SURGE:-npx --yes surge@0.55.0}"
DIST="$(mktemp -d)"; trap 'rm -rf "$DIST"' EXIT
cp index.html "$DIST/"
cp -r fonts logos "$DIST/"
echo "malo-oneweb.fr" > "$DIST/CNAME"
$SURGE "$DIST" malo-oneweb.fr
# Vérification : la page en ligne doit être identique au fichier local
sleep 3
if [ "$(curl -s https://malo-oneweb.fr/ | sha256sum)" = "$(sha256sum < index.html)" ]; then echo "En ligne : version à jour."; else echo "Attention : la page en ligne diffère encore (cache ?)."; fi
