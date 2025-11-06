# Use an official Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of your app
COPY . .

# Azure expects the app to listen on $PORT (from environment)
# 8080 is still okay as a fallback for local testing
EXPOSE 8080

# Start the app
CMD ["npm", "start"]


