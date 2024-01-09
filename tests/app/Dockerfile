# Use a lightweight Node image as the base
FROM node:18-alpine3.19 as app_builder

# Set the working directory
WORKDIR /usr/src/app

# Copy only necessary files for the app
COPY pnpm-lock.yaml .
COPY packages/hoppscotch-selfhost-web ./packages/hoppscotch-selfhost-web

# Install pnpm and fetch dependencies
RUN npm install -g pnpm && \
    pnpm fetch

# Change working directory to the app
WORKDIR /usr/src/app/packages/hoppscotch-selfhost-web

# Run pnpm install
RUN pnpm install -f --offline

# Generate static files
RUN pnpm run generate

# Create a minimal runtime image
FROM caddy:2-alpine as app_runtime

# Set the working directory
WORKDIR /site

# Copy only necessary files from the builder stage
COPY --from=app_builder /usr/src/app/packages/hoppscotch-selfhost-web/prod_run.mjs /usr
COPY --from=app_builder /usr/src/app/packages/hoppscotch-selfhost-web/selfhost-web.Caddyfile /etc/caddy/selfhost-web.Caddyfile
COPY --from=app_builder /usr/src/app/packages/hoppscotch-selfhost-web/dist/ .

# Install necessary dependencies
RUN apk add --no-cache nodejs npm && \
    npm install -g @import-meta-env/cli

# Expose ports
EXPOSE 80
EXPOSE 3000

# Define the command to run the app
CMD ["/bin/sh", "-c", "node /usr/prod_run.mjs && caddy run --config /etc/caddy/selfhost-web.Caddyfile --adapter caddyfile"]
