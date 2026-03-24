# Stage 1: Install dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install

# Stage 2: Build the app
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build   # Vite outputs to /app/dist

# Stage 3: Serve with Apache
FROM ubuntu:22.04 AS runner
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/www/html/*

# Copy built Vite app to Apache web root
COPY --from=builder /app/dist /var/www/html

# Optional: enable mod_rewrite for SPA routing
RUN a2enmod rewrite

# Expose HTTP port
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]