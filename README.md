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



## 🙋‍♀️ À propos de moi

Je m'appelle Joana, je suis développeuse web, issue d'une formation **Développeur Web et Web Mobile (DWWM)**.  
Je suis actuellement en attente de la validation de mon titre professionnel,  
et je souhaite poursuivre mon parcours en intégrant une **formation en alternance spécialisée en PHP/Symfony**.

Je suis à la recherche d’une entreprise prête à m’accompagner en alternance pour continuer à progresser,  
mettre en pratique mes compétences, et participer activement à des projets concrets.

Rigoureuse, motivée et curieuse, j’ai particulièrement apprécié travailler sur ce projet Symfony,  
qui m’a permis de développer des compétences solides en backend, base de données et interface d’administration.

📧 Contactez-moi : [mon profil LinkedIn](https://www.linkedin.com/in/joana-laffitte-069415319/)

### Remerciements

Merci à mon tuteur de stage pour sa confiance,
à mon formateur David LEGRAND pour l’accompagnement,
et à la communauté Symfony pour ses outils puissants et bien documentés !
