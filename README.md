#  Site vitrine pour artisan plombier - Projet Symfony

Ce projet a été réalisé dans le cadre de ma formation **Développeur Web et Web Mobile (DWWM)**,  
pendant mes **2 mois de stage en entreprise**.

Il s’agit d’un **site vitrine pour un artisan plombier**, avec un back-office complet lui permettant de :
- Mettre en avant ses réalisations
- Gérer son contenu de manière autonome via une interface d’administration



## Fonctionnalités principales

- Authentification des utilisateurs (admin)
- Back-office avec EasyAdmin
- Gestion des réalisations (création, modification, suppression)
- Page d’accueil dynamique affichant les projets
- Architecture MVC via Symfony
- Base de données relationnelle avec Doctrine ORM



##  Objectifs pédagogiques

Ce projet m’a permis de consolider les compétences suivantes :
- Création d’un projet Symfony complet (front + back)
- Intégration d’EasyAdmin pour une interface d’administration rapide
- Configuration d’une base de données et gestion des entités avec Doctrine
- Utilisation de Git et GitHub pour le versionnage
- Approfondissement du développement web dans un contexte professionnel
- **Déploiement d’un projet Symfony en production** :
  - sur **Render** (avec Docker et PostgreSQL)
  - sur **Infomaniak** (hébergement mutualisé, SSH, MySQL)


## Technologies utilisées

- PHP 8.2
- Symfony 7.2
- Doctrine ORM
- EasyAdmin
- MySQL
- Twig
- Git & GitHub



## Lancer le projet en local

### 1. Cloner le projet

git clone https://github.com/Joana-l/mon_projet_symfony.git
cd mon_projet_symfony

### 2. Installer les dépendances

composer install

### 3.Créer le fichier .env.local avec vos identifiants de base de données

DATABASE_URL="mysql://root:motdepasse@127.0.0.1:3306/plombier"

### 4. Créer et migrer la base de données

php bin/console doctrine:database:create
php bin/console doctrine:migrations:migrate

### 5. Lancer le serveur de développement

symfony server:start

### 6. Deploiement en production
Render (Docker + PostgreSQL)
Utilisation d’un Dockerfile adapté
Déploiement via GitHub auto
Base de données PostgreSQL 
Configuration .env spécifique à Render

Infomaniak (hébergement mutualisé + MySQL)
Envoi des fichiers par FTP
Installation des dépendances via SSH (composer install)
Base de données MySQL configurée via le manager
Génération du mot de passe admin avec security:hash-password
.htaccess configuré pour rediriger les routes Symfony
Dossier cible du site : /public

## 🙋‍♀️ À propos de moi

Je m'appelle Joana, je suis **développeuse web diplômée**, titulaire du **titre professionnel “Développeur Web et Web Mobile (DWWM)”**.

💻 Je me spécialise dans le développement **back-end PHP / Symfony**, avec une appétence pour :
- la conception de back-offices avec EasyAdmin
- la gestion de base de données avec Doctrine et MySQL
- le déploiement web en production (Render, mutualisé via SSH)
- l’optimisation du code et la structure MVC

🎯 Je suis actuellement à la recherche :
- d’une **alternance** en développement back-end (PHP / Symfony)
- ou d’un **premier poste** dans une équipe technique bienveillante où je pourrai continuer à apprendre et progresser

Rigoureuse, autonome et motivée, j’aime comprendre le fonctionnement des outils que j’utilise, structurer proprement mes projets et livrer du code fiable.

📧 Contactez-moi :
- par email ou sur [mon profil LinkedIn](https://www.linkedin.com/in/joana-laffitte-069415319/)
- je serais ravie d’échanger autour de vos projets !

### Remerciements

Merci à mon tuteur de stage pour sa confiance,
à mon formateur David LEGRAND pour l’accompagnement,
et à la communauté Symfony pour ses outils puissants et bien documentés !
