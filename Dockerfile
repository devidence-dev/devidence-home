# Dockerfile
# Stage 1: Build
FROM node:24.13.0-alpine3.23 AS builder

# Set working directory
WORKDIR /app

# Create a non-root user for build
RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup appuser && \
    chown -R appuser:appgroup /app

# Set ownership and permissions
USER appuser

# Copy package files
COPY --chown=appuser:appgroup package*.json ./

# Install dependencies
RUN npm ci

# Install cwebp and ImageMagick for image and favicon conversion
USER root
RUN apk add --no-cache libwebp-tools imagemagick
USER appuser

# Copy source code
COPY --chown=appuser:appgroup . .

# Convert images in public/images to webp
RUN find public/images \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -exec sh -c 'for img; do cwebp -q 80 "$img" -o "${img%.*}.webp"; done' sh {} +

# Generate favicon.ico from devidence-logo.png (multi-resolution)
RUN convert public/images/devidence-logo.png -resize 256x256,128x128,64x64,32x32,16x16 public/favicon.ico

# Build the application
RUN npm run build

# Stage 2: Production
FROM nginx:1.28.1-alpine3.23

# Prepare nginx directories (nginx user already exists in base image)
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp && \
    mkdir -p /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp && \
    chown -R nginx:nginx /var/cache/nginx && \
    rm -f /etc/nginx/conf.d/default.conf

# Copy build files from the build stage
COPY --from=builder --chown=nginx:nginx /app/dist /usr/share/nginx/html

# Copy webp images to nginx html directory
COPY --from=builder --chown=nginx:nginx /app/public/images/*.webp /usr/share/nginx/html/images/

# Copy favicon.ico to nginx html directory
COPY --from=builder --chown=nginx:nginx /app/public/favicon.ico /usr/share/nginx/html/

# Copy custom nginx configuration
COPY --chown=nginx:nginx nginx/default.conf /etc/nginx/conf.d/default.conf

# Security hardening
RUN chmod -R 755 /usr/share/nginx/html && \
    chmod 755 /etc/nginx/conf.d/default.conf && \
    # Remove unnecessary tools
    apk --no-cache del curl wget && \
    rm -rf /var/cache/apk/*

# Configure nginx to run as nginx user (already exists in base image)
RUN sed -i 's/user  nginx;/user  nginx;/' /etc/nginx/nginx.conf && \
    # Configure PID file location for non-root user
    sed -i 's|pid /var/run/nginx.pid;|pid /tmp/nginx.pid;|' /etc/nginx/nginx.conf || \
    echo 'pid /tmp/nginx.pid;' > /etc/nginx/conf.d/pid.conf && \
    # Give nginx user ownership of necessary directories
    chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx

# Expose port 8080 (non-privileged)
EXPOSE 8080

# Run as nginx user (non-privileged)
USER nginx

# Run nginx in non-daemon mode
CMD ["nginx", "-g", "daemon off;"]