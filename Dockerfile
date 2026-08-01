# Dockerfile
# Stage 1: Build
FROM oven/bun:1.3.14-alpine AS builder

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

# Generate optimized favicon.ico (16x16, 32x32) and PNG favicons from devidence-logo.png
RUN convert public/images/devidence-logo.png -resize 32x32 -define icon:auto-resize=32,16 public/favicon.ico && \
    convert public/images/devidence-logo.png -resize 180x180 public/apple-touch-icon.png && \
    convert public/images/devidence-logo.png -resize 32x32 public/favicon-32x32.png

# Build the application
RUN bun run build

# Stage 2: Production
FROM caddy:2.11.4-alpine

# Upgrade Alpine packages to get latest security patches (fixes zlib CVEs)
RUN apk upgrade --no-cache

# Copy build files from the build stage
COPY --from=builder --chown=1000:1000 /app/dist /srv
COPY --from=builder --chown=1000:1000 /app/public/images/*.webp /srv/images/
COPY --from=builder --chown=1000:1000 /app/public/favicon.ico /srv/
COPY --from=builder --chown=1000:1000 /app/public/favicon-32x32.png /srv/
COPY --from=builder --chown=1000:1000 /app/public/apple-touch-icon.png /srv/
COPY --from=builder --chown=1000:1000 /app/public/favicon.svg /srv/

# Copy Caddyfile
COPY --chown=1000:1000 Caddyfile /etc/caddy/Caddyfile

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