# Use a lightweight Node image as the base
FROM node:18-alpine3.19 as sh_admin_builder

# Set the working directory
WORKDIR /usr/src/app

# Copy only necessary files for sh-admin
COPY pnpm-lock.yaml .
COPY packages/hoppscotch-sh-admin ./packages/hoppscotch-sh-admin

# Install pnpm and fetch dependencies
RUN npm install -g pnpm && \
    pnpm fetch

# Change working directory to sh-admin
WORKDIR /usr/src/app/packages/hoppscotch-sh-admin

# Generate two builds for `sh-admin`, one based on subpath-access and the regular build
RUN pnpm run build --outDir dist-multiport-setup && \
    pnpm run build --outDir dist-subpath-access --base /admin/

# Use Caddy image as the runtime image
FROM caddy:2-alpine as sh_admin_runtime

# Set the working directory
WORKDIR /site

# Copy files from sh_admin_builder
COPY --from=sh_admin_builder /usr/src/app/packages/hoppscotch-sh-admin/prod_run.mjs /usr
COPY --from=sh_admin_builder /usr/src/app/packages/hoppscotch-sh-admin/sh-admin-multiport-setup.Caddyfile /etc/caddy/sh-admin-multiport-setup.Caddyfile
COPY --from=sh_admin_builder /usr/src/app/packages/hoppscotch-sh-admin/sh-admin-subpath-access.Caddyfile /etc/caddy/sh-admin-subpath-access.Caddyfile
COPY --from=sh_admin_builder /usr/src/app/packages/hoppscotch-sh-admin/dist-multiport-setup /site/sh-admin-multiport-setup
COPY --from=sh_admin_builder /usr/src/app/packages/hoppscotch-sh-admin/dist-subpath-access /site/sh-admin-subpath-access

# Install necessary dependencies
RUN apk add --no-cache nodejs npm && \
    npm install -g @import-meta-env/cli

# Expose ports
EXPOSE 80
EXPOSE 3100

# Define the command to run sh-admin
CMD ["node", "/usr/prod_run.mjs"]
