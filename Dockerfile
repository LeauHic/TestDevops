FROM node:16-alpine

# Mise à jour et configuration
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash 

# Suppression pour essai compat gitlab vips-dev
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/

COPY ./package.json ./package-lock.json ./

# Ajout de npm a bash
ENV PATH /opt/node_modules/.bin:$PATH

RUN npm install

WORKDIR /opt/app

COPY ./ .

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]