# Helm based deployment

Helm is a package manager for Kubernetes that helps manage and deploy applications, including their configuration and dependencies. A project using Helm to deploy Liquibase changes to different environments may look like below:

## helm-chart Folder Structure

```yml
helm-chart/
├── templates/
│ └── projectName.yml
├── chart.yml
├── projectname-dev.yml
├── projectname-uat.yml
├── projectname-prod.yml
├── values.yml
```

## Key Components

1. chart.yml:

This file defines the metadata for your Helm chart, such as the name, version, and description of the chart.

```yaml
apiVersion: v2
name: projectName
description: A Helm chart for deploying Liquibase changes
version: 1.0.0
```

2. `templates/` Folder:

Contains Kubernetes manifests and other templates. These files use Helm's templating language to inject values from the values.yml and other environment-specific files.
Example projectName.yml:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: liquibase-job
spec:
  template:
    spec:
      containers:
        - name: liquibase
          image: liquibase/liquibase
          env:
            - name: LB_URL
              value: { { .Values.lbUrl } }
            - name: LB_USERNAME
              value: { { .Values.lbUsername } }
            - name: LB_PASSWORD
              value: { { .Values.lbPassword } }
            - name: LB_CHANGELOG
              value: { { .Values.lbChangelog } }
          args:
            - update
      restartPolicy: OnFailure
```

3. Environment-Specific Files (e.g., projectname-dev.yml, projectname-uat.yml, projectname-prod.yml):

These files contain environment-specific values that override or supplement the values in values.yml. They allow you to customize the deployment for different environments.

Example projectname-dev.yml:

```yaml
lbUrl: jdbc:mysql://dev-db:3306/my_database
lbUsername: dev_user
lbPassword: dev_password
lbChangelog: changelog/changelog_dev.yml
```

4. values.yml:

This file contains default values for the Helm chart. These values can be overridden by the environment-specific files.

Example `values.yml`:

```yaml
lbUrl: jdbc:mysql://localhost:3306/my_database
lbUsername: root
lbPassword: root_password
lbChangelog: changelog/changelog.yml
```

## How It Works

1. Templating:

The templates in the templates/ folder use placeholders (e.g., {{ .Values.lbUrl }}) that Helm replaces with actual values from values.yml and environment-specific files.

2. Deploying with Helm:

When you deploy the Helm chart, you specify the environment-specific values file. Helm uses these values to fill in the placeholders in the templates.

3. Example Command to Deploy to Dev Environment:

```sh
helm install liquibase-deployment ./helm-chart -f ./helm-chart/projectname-dev.yml
```

4. Job Execution:

The resulting Kubernetes Job (defined in projectName.yml) runs a Liquibase container that connects to the specified database and applies the changes defined in the lbChangelog file.

## Benefits of Using Helm for Deployment

1. **Consistency**: Ensures consistent deployments across different environments by using the same Helm chart with environment-specific values.
2. **Scalability**: Easily scalable to manage multiple environments and configurations.
3. **Automation**: Integrates well with CI/CD pipelines for automated deployments.
4. **Modularity**: Keeps configuration modular and manageable, separating common settings from environment-specific ones.

## Summary

By using Helm, your project can efficiently manage and deploy Liquibase changes to different environments. The helm-chart folder contains the necessary templates and configuration files to support these deployments, ensuring consistency and automation in the process.
