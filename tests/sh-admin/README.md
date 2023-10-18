<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Hoppscotch, verified and packaged by Elestio

[Hoppscotch](https://hoppscotch.io/) is an open source API development ecosystem.

<img src="https://raw.githubusercontent.com/elestio-examples/hoppscotch/main/hoppscotch.png" alt="hoppscotch" width="800">

[![deploy](https://github.com/elestio-examples/hoppscotch/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/hoppscotch)

Deploy a <a target="_blank" href="https://elest.io/open-source/hoppscotch">fully managed Hoppscotch</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/hoppscotch.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./pgdata
    chown -R 1000:1000 ./pgdata

Run the project with the following command

    docker-compose up -d
    ./scripts/postInstall.sh

You can access the Web UI at: `http://your-domain:3130`
You can access the Admin UI at: `http://your-domain:3100`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    services:
        hoppscotch-backend:
            image: elestio4test/hoppscotch-backend:latest
            env_file:
                - ./.env
            restart: always
            environment:
                - DATABASE_URL=postgresql://postgres:${ADMIN_PASSWORD}@hoppscotch-db:5432/hoppscotch?connect_timeout=300
                - PORT=3170
            depends_on:
                - hoppscotch-db
            ports:
                - "172.17.0.1:3170:3170"

        hoppscotch-app:
            image: elestio4test/hoppscotch-app:latest
            env_file:
                - ./.env
            depends_on:
                - hoppscotch-backend
            ports:
                - "172.17.0.1:3130:8080"

        hoppscotch-sh-admin:
            image: elestio4test/hoppscotch-sh-admin:latest
            env_file:
                - ./.env
            depends_on:
                - hoppscotch-backend
            ports:
                - "172.17.0.1:3100:8080"

        hoppscotch-db:
            image: elestio/postgres:15
            ports:
                - "172.17.0.1:5282:5432"
            environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: ${ADMIN_PASSWORD}
            POSTGRES_DB: hoppscotch
            volumes:
                - ./pgdata:/var/lib/postgresql/data/

### Environment variables

|           Variable           |                                             Value (example)                                              |
| :--------------------------: | :------------------------------------------------------------------------------------------------------: |
|             var              |                                                   val                                                    |
|         ADMIN_EMAIL          |                                             yourh@email.com                                              |
|        ADMIN_PASSWORD        |                                              your-password                                               |
|         DATABASE_URL         |                       postgresql://postgres:your-password@database:5432/hoppscotch                       |
|          JWT_SECRET          |                                              your-password                                               |
|    TOKEN_SALT_COMPLEXITY     |                                                    10                                                    |
|  MAGIC_LINK_TOKEN_VALIDITY   |                                                    3                                                     |
|    REFRESH_TOKEN_VALIDITY    |                                                604800000                                                 |
|    ACCESS_TOKEN_VALIDITY     |                                                 86400000                                                 |
|        SESSION_SECRET        |                                              your-password                                               |
|         REDIRECT_URL         |                                         https://your.domain.com                                          |
|     WHITELISTED_ORIGINS      |            https://your.domain.com,https://your.domain.com:8443,https://your.domain.com:7443             |
| VITE_ALLOWED_AUTH_PROVIDERS  |                                                 'EMAIL'                                                  |
|       MAILER_SMTP_URL        | smtp://172.17.0.1:25/?skip_ssl_verify=true&legacy_ssl=false&smtp_ssl_enabled=false&disable_starttls=true |
|     MAILER_ADDRESS_FROM      |                                      'Hoppscotch sender@email.com'                                       |
|        RATE_LIMIT_TTL        |                                                    60                                                    |
|        RATE_LIMIT_MAX        |                                                   100                                                    |
|        VITE_BASE_URL         |                                         https://your.domain.com                                          |
|   VITE_SHORTCODE_BASE_URL    |                                         https://your.domain.com                                          |
|        VITE_ADMIN_URL        |                                       https://your.domain.com:8443                                       |
|     VITE_BACKEND_GQL_URL     |                                   https://your.domain.com:7443/graphql                                   |
|     VITE_BACKEND_WS_URL      |                                    wss://your.domain.com:7443/graphql                                    |
|     VITE_BACKEND_API_URL     |                                     https://your.domain.com:7443/v1                                      |
|      VITE_APP_TOS_LINK       |                                 https://docs.hoppscotch.io/support/terms                                 |
| VITE_APP_PRIVACY_POLICY_LINK |                                https://docs.hoppscotch.io/support/privacy                                |

# Maintenance

## Logging

The Elestio Hoppscotch Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.hoppscotch.io/">Hoppscotch documentation</a>

- <a target="_blank" href="https://github.com/hoppscotch/hoppscotch">Hoppscotch Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/hoppscotch">Elestio/Hoppscotch Github repository</a>
