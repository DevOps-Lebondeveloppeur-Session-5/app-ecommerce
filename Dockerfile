# ----------------------------------------------------------------
#  **** Étape 1 : Construction de l'application avec Node.js ****
# ----------------------------------------------------------------

# Utilise l'image officielle Node.js version 20 comme base pour la construction
FROM node:20 AS builder 

# Répertoire où seront copiés les fichiers et où les commandes seront exécutées
WORKDIR /usr/src/app 

# Copier uniquement le fichier package.json pour tirer parti du cache Docker
COPY package.json .  

# Installer les dépendances avec Yarn
RUN yarn install 

# Copier les fichiers sources dans l'image
COPY . . 

# Lancer la commande de construction pour générer les fichiers optimisés (généralement dans un répertoire comme `dist`)
RUN yarn run build  

# ----------------------------------------------------------------
# **** Étape 2 : Serveur de production avec Nginx ****
# ----------------------------------------------------------------

# Utilise une image légère d'Nginx pour servir les fichiers statiques
FROM nginx:alpine 

# Copier les fichiers construits depuis l'étape précédente dans le répertoire HTML d'Nginx
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html 

# Copier un fichier de configuration personnalisé pour Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf  

# Exposer le port 80 pour permettre aux utilisateurs d'accéder à l'application
EXPOSE 80 

# Démarre Nginx en mode premier plan (non détaché) pour que le conteneur reste actif
CMD ["nginx", "-g", "daemon off;"]  
