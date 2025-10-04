# ===== Stage 1: Build React App =====
FROM node:20-alpine AS build

WORKDIR /app

# Install deps
COPY frontend/package*.json ./
RUN npm ci --only=production

# Copy source and build
COPY frontend/ ./
RUN npm run build

# ===== Stage 2: Serve with Nginx =====
FROM nginx:1.27-alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from React
COPY --from=build /app/build /usr/share/nginx/html

# Copy secure Nginx config
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

# Fix permissions (but keep root user for Nginx startup)
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx \
    && chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run /var/log/nginx

# Expose port
EXPOSE 80

# Run as root but Nginx will drop to "nginx" user internally
CMD ["nginx", "-g", "daemon off;"]
