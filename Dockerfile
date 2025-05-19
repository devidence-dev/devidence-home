# Dockerfile
# Stage 1: Build
FROM node:22.15.1-alpine3.20 AS builder

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
FROM nginx:stable-alpine

# Create a non-root user for running the application
RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -s /bin/sh -D appuser && \
    # Create directories with proper permissions
    mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R appuser:appgroup /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d && \
    chmod -R 755 /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d && \
    # Symlink access log and error log to stdout and stderr
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # Remove default nginx config
    rm -f /etc/nginx/conf.d/default.conf

# Copy build files from the build stage
COPY --from=builder --chown=appuser:appgroup /app/dist /usr/share/nginx/html

# Copy webp images to nginx html directory
COPY --from=builder --chown=appuser:appgroup /app/public/images/*.webp /usr/share/nginx/html/images/

# Copy favicon.ico to nginx html directory
COPY --from=builder --chown=appuser:appgroup /app/public/favicon.ico /usr/share/nginx/html/

# Copy custom nginx configuration
COPY --chown=appuser:appgroup nginx/default.conf /etc/nginx/conf.d/default.conf

# Security hardening
RUN chmod -R 755 /usr/share/nginx/html && \
    chmod 755 /etc/nginx/conf.d/default.conf && \
    # Remove unnecessary tools
    apk --no-cache del curl wget && \
    rm -rf /var/cache/apk/*

# Expose port 8080 (non-privileged)
EXPOSE 8080

# Use root user for starting nginx (it will drop privileges later)
# This is required because nginx needs to bind to ports and access logs initially
USER root

# Run nginx in non-daemon mode
CMD ["nginx", "-g", "daemon off;"]