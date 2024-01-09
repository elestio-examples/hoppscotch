# Use a lightweight Node image as the base
FROM node:18-alpine3.19 as backend_builder

# Set the working directory
WORKDIR /usr/src/app

# Copy only necessary files for the backend
COPY pnpm-lock.yaml .
COPY packages/hoppscotch-backend ./packages/hoppscotch-backend

# Install pnpm and fetch dependencies
RUN npm install -g pnpm && \
    pnpm fetch

# Change working directory to the backend
WORKDIR /usr/src/app/packages/hoppscotch-backend

# Run pnpm install
RUN pnpm install -f --offline

# Install additional dependencies
RUN apk add --no-cache caddy

# Generate Prisma and build the backend
RUN pnpm exec prisma generate && \
    pnpm run build

# Copy Caddyfile from the backend
COPY --from=backend_builder /usr/src/app/packages/hoppscotch-backend/backend.Caddyfile /etc/caddy/backend.Caddyfile

# Remove the env file to avoid backend copying it in and using it
RUN rm "../../.env"

# Set environment variables
ENV PRODUCTION="true"
ENV PORT=8080
ENV APP_PORT=${PORT}
ENV DB_URL=${DATABASE_URL}

# Expose ports
EXPOSE 80
EXPOSE 3170

# Define the command to run the backend
CMD ["node", "/usr/src/app/packages/hoppscotch-backend/prod_run.mjs"]
