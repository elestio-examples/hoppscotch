# Use a lighter base image
FROM caddy:2-alpine as app

# Set the working directory
WORKDIR /site

# Copy only necessary files
COPY --from=fe_builder /usr/src/app/packages/hoppscotch-selfhost-web/prod_run.mjs /usr
COPY --from=fe_builder /usr/src/app/packages/hoppscotch-selfhost-web/selfhost-web.Caddyfile /etc/caddy/selfhost-web.Caddyfile
COPY --from=fe_builder /usr/src/app/packages/hoppscotch-selfhost-web/dist/ .

# Install required dependencies
RUN apk add --no-cache nodejs npm && \
    npm install -g @import-meta-env/cli

# Expose ports
EXPOSE 80
EXPOSE 3000

# Define the command to run the app
CMD ["/bin/sh", "-c", "node /usr/prod_run.mjs && caddy run --config /etc/caddy/selfhost-web.Caddyfile --adapter caddyfile"]
