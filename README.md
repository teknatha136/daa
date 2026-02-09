# daa - Deploy Any Application

A generic, flexible Helm chart that can deploy any application type including frontends, backends, workers, and any combination thereof.

## Overview

**daa** (Deploy Any Application) is designed to solve the challenge of maintaining multiple Helm charts for different application types. Instead of creating separate charts for each application pattern, daa provides a single, configurable chart that adapts to your needs.

### Key Features

- **Zero default resources** - Chart generates nothing until you explicitly enable components
- **Map-based deployments** - Define multiple deployments in a single release
- **Common configurations** - Share ConfigMaps, Secrets, init containers, and sidecars across deployments
- **Granular control** - Opt-out individual deployments from common resources
- **Flexible naming** - Resources named as `RELEASE_NAME-COMPONENT_KEY`

### Supported Application Types

- **Frontend only** - Websites, SPAs, static sites
- **Backend only** - APIs, microservices
- **Backend + Frontend** - Full-stack applications
- **Workers** - Background processors, queue consumers (Rails SolidQueue, .NET console services, etc.)
- **Any combination** - Multiple frontends, backends, and workers in a single release

### Supported Kubernetes Resources

| Resource         | Scope                          | Description                                        |
| ---------------- | ------------------------------ | -------------------------------------------------- |
| **Deployment**   | Per-component                  | Main workload resources with full pod spec support |
| **Service**      | Per-component                  | ClusterIP, NodePort, LoadBalancer support          |
| **Ingress**      | Per-component + Extra          | NGINX and other ingress controllers                |
| **ConfigMap**    | Common + Per-component + Extra | Environment configuration                          |
| **Secret**       | Common + Per-component + Extra | Sensitive data (base64 or stringData)              |
| **SealedSecret** | Common + Per-component + Extra | Bitnami Sealed Secrets for GitOps                  |

## Installation

```bash
# Add the Helm repository
helm repo add daa https://teknatha136.github.io/daa
helm repo update

# Install with custom values
helm install my-app daa/daa -f values.yaml
```

Or install from a local clone:

```bash
git clone https://github.com/teknatha136/daa.git
helm install my-app ./daa -f values.yaml
```

## Quick Start

### Simple Frontend

```yaml
deployments:
  frontend:
    enabled: true
    image:
      repoTag: "nginx:1.25-alpine"
    ports:
      - name: http
        containerPort: 80
    service:
      enabled: true
      port: 80
    ingress:
      enabled: true
      className: nginx
      hosts:
        - host: "app.example.com"
          paths: "/"
```

### Rails App with Puma + SolidQueue Worker

```yaml
common:
  configMap:
    enabled: true
    data:
      RAILS_ENV: "production"
      DATABASE_URL: "postgres://db:5432/app"

deployments:
  puma:
    enabled: true
    image:
      repoTag: "myapp:v1.0"
    command: ["bundle", "exec", "puma"]
    ports:
      - name: http
        containerPort: 3000
    useCommonConfigMap: true
    service:
      enabled: true
      port: 80
      targetPort: 3000
    ingress:
      enabled: true
      hosts:
        - host: "api.example.com"
          paths: "/"

  solidq:
    enabled: true
    image:
      repoTag: "myapp:v1.0"
    command: ["bundle", "exec", "solid_queue:start"]
    useCommonConfigMap: true
    service:
      enabled: false  # Workers don't need a service
```

## Configuration

### Global Settings

```yaml
global:
  labels: {}           # Applied to all resources
  annotations: {}      # Applied to all resources
  imagePullSecrets:
    enabled: false
    secrets: []
  deploymentStrategy:  # Default strategy for all deployments
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
```

### Common Resources

Share configurations across all deployments:

```yaml
common:
  # Init containers applied to all deployments by default
  initContainers:
    - name: wait-for-db
      image: busybox
      command: ['sh', '-c', 'until nc -z db 5432; do sleep 2; done']

  # Sidecars applied to all deployments by default
  additionalContainers:
    - name: log-shipper
      image: fluent/fluent-bit:latest

  # Shared ConfigMap
  configMap:
    enabled: true
    data:
      SHARED_VAR: "value"

  # Shared Secret
  secret:
    enabled: true
    stringData:
      API_KEY: "secret"

  # Shared SealedSecret
  sealedSecret:
    enabled: true
    encryptedData:
      PASSWORD: "AgBy3i4..."
```

### Deployment Options
Check values.yaml file for more details.

### Common Resource Opt-Out

Deployments include common init containers and sidecars by default. To opt-out:

```yaml
deployments:
  my-deployment:
    enabled: true
    # Full opt-out from common init containers
    useCommonInitContainers: false
    
    # Or exclude specific ones by name
    excludeCommonInitContainers:
      - migrations
    
    # Same for sidecars
    useCommonAdditionalContainers: false
    excludeCommonAdditionalContainers:
      - log-shipper
```

### Extra Resources

Create standalone resources not tied to specific deployments:

```yaml
extraConfigMaps:
  nginx-config:
    enabled: true
    data:
      nginx.conf: |
        server { ... }

extraSecrets:
  api-keys:
    enabled: true
    stringData:
      KEY: "value"

extraSealedSecrets:
  db-creds:
    enabled: true
    encryptedData:
      PASSWORD: "AgBy3i4..."

extraIngresses:
  main:
    enabled: true
    backend:
      serviceName: frontend
      servicePort: 80
    hosts:
      - host: "www.example.com"
        paths: "/"
```

## Development

### Prerequisites

- **Helm 3.x**
- **helm-values-schema-json** - https://github.com/losisin/helm-values-schema-json
- **kubeconform** - (https://github.com/yannh/kubeconform)

### Common Commands

```bash
# Lint the chart
helm lint .

# Render templates with test values
helm template test-release . -f ci/test-values.yaml

# Render with debug output
helm template test-release . -f ci/test-values.yaml --debug

# Generate JSON schema
helm-values-schema-json -input values.yaml -output values.schema.json

# Validate rendered templates against Kubernetes schemas
helm template test-release . -f ci/test-values.yaml | kubeconform -strict -summary -kubernetes-version 1.29.0

# Package the chart
helm package .
```

### Testing

The chart includes comprehensive CI testing:

1. **Lint** - Validates chart structure
2. **Template & Validate** - Renders templates and validates against K8s schemas (1.27, 1.28, 1.29)
3. **Empty Values Test** - Ensures no resources are generated with default values
4. **Schema Check** - Verifies schema is up to date

## License

MIT License - See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`helm lint . && helm template test-release . -f ci/test-values.yaml`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Links

- **Repository**: https://github.com/teknatha136/daa
- **Issues**: https://github.com/teknatha136/daa/issues
- **Helm Repository**: https://teknatha136.github.io/daa
