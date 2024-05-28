# Project Database Management with Liquibase

## Introduction

This document provides an overview of the file structure, usage, and benefits of our Liquibase-based database management system. It also includes instructions for setting up a local MySQL database and performing rollbacks if necessary.

File Structure
The project is organized into the following structure:

```scss
changelog/
  ├── 1.0.X/
  │   ├── changelog-master.yml
  │   ├── change1.sql (DDL)
  │   ├── change2.sql (DDL)
  ├── data_migrations/
  │   ├── 1.0.X/
  │   │   ├── changelog-master.yml
  │   │   ├── data_change1.sql (DML)
  │   │   ├── data_change2.sql (DML)
  ├── TeamA/
  │   ├── 1.0.X/
  │   │   ├── changelog-master.yml
  │   │   ├── change1.sql (DDL)
  │   │   └── ...
  ├── TeamB/
  │   ├── 1.0.X/
  │   │   ├── changelog-master.yml
  │   │   ├── change1.sql (DDL)
  │   │   └── ...
  ├── changelog_dev.yml
  ├── changelog_uat.yml
  ├── changelog_prod.yml
```

## Key Components

1. Versioned Folders (e.g., 1.0.X/):

- Contain changelog-master.yml and DDL SQL files.
- Each folder represents a specific version of the database schema changes.

2. Data Migrations Folder (data_migrations/):

- Contains DML SQL files for data manipulation operations.
- Organized similarly to the versioned folders for DDL changes.

3. Team-Specific Folders (e.g., TeamA/, TeamB/):

- Each team manages their own schema changes independently.
- Follows the same versioned folder structure.

4. Environment-Specific Changelog Files (e.g., changelog_dev.yml, changelog_uat.yml):

- Aggregate versioned changelog files for specific environments.
- Include references to the versioned changelog-master.yml files.

## Example of Changelog Files

Versioned changelog-master.yml:

```yaml
databaseChangeLog:
  - changeSet:
      id: 1
      author: your_name
      context: DEV
      changes:
        - sqlFile:
            path: change1.sql
            relativeToChangeLogFile: true

  - changeSet:
      id: 2
      author: your_name
      context: UAT
      changes:
        - sqlFile:
            path: change2.sql
            relativeToChangeLogFile: true
Environment-Specific Changelog (changelog_dev.yml):
```

Environment-Specific Changelog (changelog_dev.yml):

```yaml
databaseChangeLog:
  - include:
      file: 1.0.1/changelog-master.yml
      relativeToChangeLogFile: true
  - include:
      file: 1.0.2/changelog-master.yml
      relativeToChangeLogFile: true
  - include:
      file: 1.0.3/changelog-master.yml
      relativeToChangeLogFile: true
```

## Benefits of the File Structure

1. **Organized Management**: Separate folders for versioned changes, data migrations, and team-specific changes help keep the project organized and manageable.
2. **Modularity**: Each set of changes is modular, making it easier to track, update, and manage changes independently.
3. **Flexibility**: Environment-specific changelog files allow for selective application of changes based on the deployment environment.
4. **Scalability**: The structure supports easy integration of new teams and functionalities without disrupting the existing setup.

## Rollback Methods

If anything goes wrong during a deployment, Liquibase provides rollback capabilities to undo changes:

Rollback to a Tag:

```sh
liquibase --changeLogFile=changelog/changelog_dev.yml rollback <tag>
```

Rollback to a Specific Date:

```sh
liquibase --changeLogFile=changelog/changelog_dev.yml rollbackToDate <date>
```

Rollback a Specific Number of Changes:

```sh
liquibase --changeLogFile=changelog/changelog_dev.yml rollbackCount <number>
```

## Setting Up Local MySQL Database

Follow these steps to set up a local MySQL database with the changes from the cluster:

1. Install MySQL:

- Ensure MySQL is installed on your local machine.

2. Create Database:

```sql
CREATE DATABASE my_database;
```

3. Configure liquibase.properties:
   Create a liquibase.properties file with your local database connection details:

```yml
url: jdbc:mysql://localhost:3306/my_database
username: root
password: your_password
changeLogFile: changelog/changelog_dev.yml
Run Liquibase Update:
```

4. Run Liquibase Update:

```sh
liquibase update
```

This will apply all changes defined in the changelog_dev.yml file to your local MySQL database.

<hr/>

By following this guide, new users should be able to understand the file structure, benefits, rollback methods, and how to set up a local MySQL database with the changes from the project. If you have any questions or need further assistance, feel free to reach out to the team.
