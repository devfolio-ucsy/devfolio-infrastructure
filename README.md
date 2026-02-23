# Devfolio Infrastructure

This repository contains the infrastructure configuration for the Devfolio project, using Docker Compose to orchestrate services including PostgreSQL and Keycloak.

## Services

### 1. PostgreSQL (postgres-core)
A PostgreSQL 14 instance that serves as the primary database for both the core application and Keycloak.

- **Host**: `localhost` (Internal: `postgres-core`)
- **Port**: `5432`
- **User**: `core_user`
- **Password**: `core_password`
- **Databases Initialized**:
  - `keycloak`: Used by Keycloak for identity management.
  - `core_db`: Main application database.

### 2. Keycloak
An open-source identity and access management solution.

- **URL**: [http://localhost:5000](http://localhost:5000)
- **Admin Credentials**:
  - **Username**: `admin`
  - **Password**: `admin`
- **Version**: `26.5.3`
- **Auto-Import**: The realm configuration is automatically imported from `realm-export.json` on startup.
- **SMTP Password Injection**: `KEYCLOAK_SMTP_PASSWORD` is injected into the realm file before Keycloak starts.

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd devfolio-infra
   ```

2. **Start the services**:
   - Set SMTP password in your shell (PowerShell):
     ```powershell
     $env:KEYCLOAK_SMTP_PASSWORD="your-smtp-app-password"
     ```
   - Or create a `.env` file in project root:
     ```dotenv
     KEYCLOAK_SMTP_PASSWORD=your-smtp-app-password
     ```

3. **Start the services**:
   ```powershell
   docker-compose up -d
   ```

4. **Verify the services**:
   - Check if containers are running:
     ```powershell
     docker-compose ps
     ```
   - Keycloak should be accessible at `http://localhost:5000`.

## Configuration Files

- [docker-compose.yml](docker-compose.yml): Defines the services, networks, and volumes.
- [init.sql](init.sql): SQL script executed on database initialization to create the necessary databases.
- [realm-export.json](realm-export.json): Keycloak realm configuration for automatic import.

## Notes

- The PostgreSQL container uses a persistent volume named `core_db_data`.
- Timezone is set to `Asia/Yangon`.
- Keycloak is running in development mode (`start-dev`).
- Keycloak startup fails fast if `KEYCLOAK_SMTP_PASSWORD` is missing, preventing import with an invalid SMTP password.
