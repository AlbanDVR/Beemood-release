# BeeMood - Release

Notre application BeeMood se divise en 3 partie.
- Un repo centrale, release, avec l'initialisation de la base de donnée
- Un repo front-end
- Un repo back-end

Chaque repo a sa configuration et les instructions pour la configuration en local du front-end
et du back-end sont respectivement dans leur README.
Pour release, il est nécessaire de créer un fichier .env.template contenant les informations suivante : 

```dotenv
POSTGRES_USER=beemood
POSTGRES_PASSWORD=beemood
POSTGRES_DB=beemooddb
```

Pour lancer les conteneurs Docker, il faut lancer la commande :
```bash
docker-compose up --build
```
En prenant soin de bien être à la racine du projet, c'est-à-dire release.