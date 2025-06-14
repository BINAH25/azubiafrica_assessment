# Use Node.js LTS base image
FROM node:22.16-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy all source files
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Start the app
CMD ["node", "index.js"]
