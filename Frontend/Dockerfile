# Stage 1: Build with Vite
FROM node:22.16-alpine AS web-build
WORKDIR /usr/src/app

# Accept build arg
ARG VITE_BACKEND_URL
ENV VITE_BACKEND_URL=$VITE_BACKEND_URL

# Install deps
COPY package.json package-lock.json ./
RUN npm ci

# Copy source
COPY . .

# Build Vite App 
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:stable-alpine3.21-slim

RUN rm -rf /usr/share/nginx/html/*
COPY --from=web-build /usr/src/app/dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
