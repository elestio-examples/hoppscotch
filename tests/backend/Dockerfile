# Use the base builder image
FROM base_builder as backend

# Install additional dependencies
RUN apk add --no-cache caddy

# Set the working directory
WORKDIR /usr/src/app/packages/hoppscotch-backend

# Generate Prisma and build the backend
RUN pnpm exec prisma generate && \
    pnpm run build

# Copy Caddyfile from the base builder
COPY --from=base_builder /usr/src/app/packages/hoppscotch-backend/backend.Caddyfile /etc/caddy/backend.Caddyfile

# Remove the env file to avoid backend copying it in and using it
RUN rm "../../.env"

# Set environment variables
ENV PRODUCTION="true"
ENV PORT=8080
ENV APP_PORT=${PORT}
ENV DB_URL=${DATABASE_URL}

# Define the command to run the backend
CMD ["node", "/usr/src/app/packages/hoppscotch-backend/prod_run.mjs"]

# Expose ports
EXPOSE 80
EXPOSE 3170
