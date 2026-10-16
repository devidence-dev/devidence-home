# Dockerfile
# Stage 1: Build
FROM oven/bun:1.4.3-alpine AS builder

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

# Install ImageMagick and librsvg (SVG delegate for favicon rendering)
USER root
RUN apk add --no-cache imagemagick librsvg
USER appuser

# Copy source code
COPY --chown=appuser:appgroup . .

# Generate optimized favicon.ico (16x16, 32x32) and PNG favicons from favicon.svg
RUN convert -background none public/favicon.svg -resize 32x32 -define icon:auto-resize=32,16 public/favicon.ico && \
    convert -background none public/favicon.svg -resize 180x180 public/apple-touch-icon.png && \
    convert -background none public/favicon.svg -resize 32x32 public/favicon-32x32.png

# Fail the build if any generated favicon is empty
RUN test -s public/favicon.ico && test -s public/favicon-32x32.png && test -s public/apple-touch-icon.png

# Build the application
RUN bun run build

# Stage 2: Production
FROM caddy:2.11.7-alpine

# Upgrade Alpine packages to get latest security patches (fixes zlib CVEs)
RUN apk upgrade --no-cache

# Copy build files from the build stage
COPY --from=builder --chown=1000:1000 /app/dist /srv
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

# Run as non-privileged user (UID 1000, matches docker-compose.yml)
USER 1000:1000

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]