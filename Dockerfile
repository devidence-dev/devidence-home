# Dockerfile
# Stage 1: Build
FROM oven/bun:1.3.10-alpine AS builder

# Set working directory
WORKDIR /app

# Create a non-root user for build
RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup appuser && \
    chown -R appuser:appgroup /app

# Set ownership and permissions
USER appuser

# Copy package files
COPY --chown=appuser:appgroup package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

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
RUN bun run build

# Stage 2: Production
FROM caddy:2.11.2-alpine

# Copy build files from the build stage
COPY --from=builder --chown=caddy:caddy /app/dist /srv
COPY --from=builder --chown=caddy:caddy /app/public/images/*.webp /srv/images/
COPY --from=builder --chown=caddy:caddy /app/public/favicon.ico /srv/

# Copy Caddyfile
COPY --chown=caddy:caddy Caddyfile /etc/caddy/Caddyfile

# Remove file capabilities from caddy binary (not needed on port 8080,
# and incompatible with no-new-privileges:true in docker-compose)
RUN apk add --no-cache libcap && \
    setcap -r /usr/bin/caddy && \
    apk del libcap && \
    rm -rf /var/cache/apk/*

# Expose port 8080 (non-privileged)
EXPOSE 8080

# Run as caddy user (non-privileged)
USER caddy

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]