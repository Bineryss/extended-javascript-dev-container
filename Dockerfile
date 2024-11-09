FROM node:22-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm i -g pnpm
RUN pnpm install

# Bundle app source
COPY index.js index.js


EXPOSE 8080
CMD [ "node", "index.js" ]

USER node