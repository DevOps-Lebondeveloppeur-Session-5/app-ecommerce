# ----------------------------------------------------------------
#  **** Étape 1 : Construction de l'application avec Node.js ****
# ----------------------------------------------------------------

FROM node:20 AS builder 

WORKDIR /usr/src/app 

ARG API_URL
ENV API_URL=${API_URL}

COPY package.json .  

RUN yarn install 

COPY . . 

RUN yarn run build  

# ----------------------------------------------------------------
# **** Étape 2 : Serveur de production avec Nginx ****
# ----------------------------------------------------------------

FROM nginx:alpine 

COPY --from=builder /usr/src/app/dist /usr/share/nginx/html 

COPY nginx.conf /etc/nginx/nginx.conf 

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]  
