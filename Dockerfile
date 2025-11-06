# Use an official Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your code
COPY . .

# Expose port 8080 (the port your app listens on)
EXPOSE 8080

# Start your app
CMD ["npm", "start"]

