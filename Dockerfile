FROM node:20.11.1

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

# Create a simple server.js file
RUN echo "const http = require('http'); \n\
const server = http.createServer((req, res) => { \n\
  res.statusCode = 200; \n\
  res.setHeader('Content-Type', 'text/plain'); \n\
  res.end('Hello from Docker!'); \n\
}); \n\
server.listen(8080, '0.0.0.0', () => { \n\
  console.log('Server running on http://0.0.0.0:8080/'); \n\
});" > server.js

EXPOSE 8080
CMD [ "node", "server.js" ]