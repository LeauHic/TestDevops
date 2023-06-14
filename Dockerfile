FROM node:16-alpine

# Mise à jour et configuration
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash 

# Suppression pour essai compat gitlab vips-dev
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/app

COPY ./ .

# Ajout de npm a bash
ENV PATH /opt/node_modules/.bin:$PATH

RUN npm install

RUN npm run build

COPY docker/next/docker-entrypoint.sh /usr/local/bin/docker-entrypoint

# Exécutez la commande chmod pour rendre le fichier exécutable
RUN chmod +x /usr/local/bin/docker-entrypoint

EXPOSE 3000
ENTRYPOINT [ "docker-entrypoint" ]
CMD ["npm", "run", "start"]