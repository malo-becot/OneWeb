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
Le formulaire de contact est envoyé via Web3Forms (clé d'accès dans le champ caché `access_key`) : les demandes arrivent sur l'e-mail associé à la clé.
