FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm install express
EXPOSE 8080
CMD ["node", "-e", "require(\"express\")().get(\"/\",(r,s)=>s.send(\"Hello from Jenkins on Azure!\")).
listen(8080)"]
