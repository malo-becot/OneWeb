# Malo OneWeb — site one page

Site vitrine statique (un seul fichier `index.html`, aucune dépendance à installer).

## Publier avec surge.sh

```bash
npm install --global surge   # une seule fois
cd OneWeb
surge . malo-oneweb.surge.sh  # ou ton propre domaine
```

## Modifier

Tout est dans `index.html` : textes, prix (300€, 29/49/99€, 19€, 99€/an), coordonnées et liens.
Le formulaire de contact ouvre la messagerie du visiteur avec un e-mail pré-rempli vers malo.oneweb@gmail.com.
