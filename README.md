# daa

![Version: 0.4.0](https://img.shields.io/badge/Version-0.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.4.0](https://img.shields.io/badge/AppVersion-0.4.0-informational?style=flat-square)

Helm chart that can deploy some common applications

**Homepage:** <https://github.com/SELISEdigitalplatforms/daa>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Tek Nath Acharya |  | <https://github.com/teknatha136> |

## Source Code

* <https://github.com/SELISEdigitalplatforms/daa>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| common | object | `{"configMap":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"common"},"secret":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"common","stringData":{},"type":"Opaque"}}` | Common configuration for all deployments These will be applied to all deployments unless overridden at the deployment level |
| common.configMap | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"common"}` | Common ConfigMap settings for all deployments |
| common.configMap.annotations | object | `{}` | Annotations to apply to the common ConfigMap |
| common.configMap.data | object | `{}` | Data to be included in the common ConfigMap |
| common.configMap.enabled | bool | `false` | Enable creating a common ConfigMap for all deployments |
| common.configMap.labels | object | `{}` | Labels to apply to the common ConfigMap |
| common.configMap.name | string | `"common"` | Update name to have expected name. Example: "name: myapp" and Release Name "myapp" will produce "myapp-myapp" |
| common.secret | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"common","stringData":{},"type":"Opaque"}` | Common Secret settings for all deployments |
| common.secret.annotations | object | `{}` | Annotations to apply to the common Secret |
| common.secret.data | object | `{}` | Data to be included in the Secret (automatically base64 encoded) |
| common.secret.enabled | bool | `false` | Enable creating a common Secret for all deployments |
| common.secret.labels | object | `{}` | Labels to apply to the common Secret |
| common.secret.name | string | `"common"` | Update name to have expected name. Example: "name: myapp" and Release Name "myapp" will produce "myapp-myapp" |
| common.secret.stringData | object | `{}` | StringData for the Secret (not base64 encoded) |
| common.secret.type | string | `"Opaque"` | Secret type (defaults to Opaque) |
| deployments | object | `{"example-app":{"additionalContainers":[],"args":[],"autoscaling":{"enabled":false,"maxReplicas":10,"minReplicas":1,"name":"","targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80},"command":[],"configMap":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""},"deploymentStrategy":null,"enabled":false,"env":[],"envFrom":[],"image":{"pullPolicy":"IfNotPresent","repoTag":"nginx:stable-alpine"},"ingress":{"annotations":{},"className":"nginx","enabled":false,"hosts":[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}],"name":"","pathType":"Prefix","tls":[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]},"initContainers":[],"labels":{},"livenessProbe":{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":30,"periodSeconds":10},"name":"","podAnnotations":{},"podLabels":{},"readinessProbe":{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":5,"periodSeconds":10},"replicaCount":1,"resources":{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"50m","memory":"64Mi"}},"secret":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"},"service":{"annotations":{},"enabled":false,"labels":{},"name":"","port":80,"targetPort":80,"type":"ClusterIP"},"startupProbe":{"enabled":false,"failureThreshold":30,"httpGet":{"path":"/","port":"http"},"periodSeconds":10},"useCommonConfigMap":false,"useCommonSecret":false,"volumeMounts":[],"volumes":[]}}` | Deployment configurations |
| deployments.example-app | object | `{"additionalContainers":[],"args":[],"autoscaling":{"enabled":false,"maxReplicas":10,"minReplicas":1,"name":"","targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80},"command":[],"configMap":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""},"deploymentStrategy":null,"enabled":false,"env":[],"envFrom":[],"image":{"pullPolicy":"IfNotPresent","repoTag":"nginx:stable-alpine"},"ingress":{"annotations":{},"className":"nginx","enabled":false,"hosts":[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}],"name":"","pathType":"Prefix","tls":[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]},"initContainers":[],"labels":{},"livenessProbe":{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":30,"periodSeconds":10},"name":"","podAnnotations":{},"podLabels":{},"readinessProbe":{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":5,"periodSeconds":10},"replicaCount":1,"resources":{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"50m","memory":"64Mi"}},"secret":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"},"service":{"annotations":{},"enabled":false,"labels":{},"name":"","port":80,"targetPort":80,"type":"ClusterIP"},"startupProbe":{"enabled":false,"failureThreshold":30,"httpGet":{"path":"/","port":"http"},"periodSeconds":10},"useCommonConfigMap":false,"useCommonSecret":false,"volumeMounts":[],"volumes":[]}` | Example application deployment |
| deployments.example-app.additionalContainers | list | `[]` | Additional containers in the same pod |
| deployments.example-app.args | list | `[]` | Arguments to pass to the command (or to the image's entrypoint if command is not specified) |
| deployments.example-app.autoscaling | object | `{"enabled":false,"maxReplicas":10,"minReplicas":1,"name":"","targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Horizontal Pod Autoscaler configuration |
| deployments.example-app.autoscaling.enabled | bool | `false` | Enable or disable autoscaling |
| deployments.example-app.autoscaling.maxReplicas | int | `10` | Maximum number of replicas |
| deployments.example-app.autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| deployments.example-app.autoscaling.name | string | `""` | If not specified, it will use the deployment key prefixed with release name |
| deployments.example-app.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| deployments.example-app.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target Memory utilization percentage |
| deployments.example-app.command | list | `[]` | Command to run in the container (overrides the image's default entrypoint) |
| deployments.example-app.configMap | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""}` | ConfigMap configuration for the deployment If enabled, creates a dedicated ConfigMap for this deployment |
| deployments.example-app.configMap.annotations | object | `{}` | Annotations to apply to the ConfigMap |
| deployments.example-app.configMap.data | object | `{}` | Data to be included in the ConfigMap |
| deployments.example-app.configMap.enabled | bool | `false` | Enable or disable creating a ConfigMap for this deployment |
| deployments.example-app.configMap.labels | object | `{}` | Labels to apply to the ConfigMap |
| deployments.example-app.configMap.name | string | `""` | If not specified, it will use the deployment key prefixed with release name |
| deployments.example-app.deploymentStrategy | string | `nil` | Deployment strategy - overrides global setting if specified |
| deployments.example-app.enabled | bool | `false` | Enable or disable this deployment |
| deployments.example-app.env | list | `[]` | Environment variables for the container Each item can use 'value', 'valueFrom.configMapKeyRef', or 'valueFrom.secretKeyRef' |
| deployments.example-app.envFrom | list | `[]` | Sources for environment variables Mount entire ConfigMaps or Secrets as environment variables |
| deployments.example-app.image | object | `{"pullPolicy":"IfNotPresent","repoTag":"nginx:stable-alpine"}` | Container image configuration |
| deployments.example-app.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy (defaults to IfNotPresent) |
| deployments.example-app.image.repoTag | string | `"nginx:stable-alpine"` | full image repo and tag in format <repo>:<tag> |
| deployments.example-app.ingress | object | `{"annotations":{},"className":"nginx","enabled":false,"hosts":[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}],"name":"","pathType":"Prefix","tls":[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]}` | Ingress configuration for the deployment |
| deployments.example-app.ingress.annotations | object | `{}` | Ingress annotations |
| deployments.example-app.ingress.className | string | `"nginx"` | Ingress class name |
| deployments.example-app.ingress.enabled | bool | `false` | Enable or disable ingress |
| deployments.example-app.ingress.hosts | list | `[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}]` | Host configuration |
| deployments.example-app.ingress.name | string | `""` | If not specified, it will use the deployment key prefixed with release name |
| deployments.example-app.ingress.pathType | string | `"Prefix"` | Path type (Prefix, Exact, ImplementationSpecific) |
| deployments.example-app.ingress.tls | list | `[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]` | TLS configuration |
| deployments.example-app.initContainers | list | `[]` | Init containers that run before app containers |
| deployments.example-app.labels | object | `{}` | These labels will be added in addition to global and default labels |
| deployments.example-app.livenessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":30,"periodSeconds":10}` | Liveness probe configuration |
| deployments.example-app.livenessProbe.httpGet | object | `{"path":"/","port":"http"}` | HTTP Get probe configuration |
| deployments.example-app.livenessProbe.httpGet.path | string | `"/"` | Path for the HTTP probe |
| deployments.example-app.livenessProbe.httpGet.port | string | `"http"` | Port for the HTTP probe |
| deployments.example-app.livenessProbe.initialDelaySeconds | int | `30` | Initial delay before probing |
| deployments.example-app.livenessProbe.periodSeconds | int | `10` | How often to perform the probe |
| deployments.example-app.name | string | `""` | If not specified, it will use the key (example-app) prefixed with release name |
| deployments.example-app.podAnnotations | object | `{}` | Pod annotations |
| deployments.example-app.podLabels | object | `{}` | Pod labels |
| deployments.example-app.readinessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":5,"periodSeconds":10}` | Readiness probe configuration |
| deployments.example-app.readinessProbe.httpGet | object | `{"path":"/","port":"http"}` | HTTP Get probe configuration |
| deployments.example-app.readinessProbe.httpGet.path | string | `"/"` | Path for the HTTP probe |
| deployments.example-app.readinessProbe.httpGet.port | string | `"http"` | Port for the HTTP probe |
| deployments.example-app.readinessProbe.initialDelaySeconds | int | `5` | Initial delay before probing |
| deployments.example-app.readinessProbe.periodSeconds | int | `10` | How often to perform the probe |
| deployments.example-app.replicaCount | int | `1` | Number of replicas for this deployment |
| deployments.example-app.resources | object | `{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}` | Pod resource requests and limits |
| deployments.example-app.resources.limits | object | `{"cpu":"100m","memory":"128Mi"}` | Resource limits |
| deployments.example-app.resources.requests | object | `{"cpu":"50m","memory":"64Mi"}` | Resource requests |
| deployments.example-app.secret | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"}` | Secret configuration for the deployment If enabled, creates a dedicated Secret for this deployment |
| deployments.example-app.secret.annotations | object | `{}` | Annotations to apply to the Secret |
| deployments.example-app.secret.data | object | `{}` | Data to be included in the Secret (automatically base64 encoded) |
| deployments.example-app.secret.enabled | bool | `false` | Enable or disable creating a Secret for this deployment |
| deployments.example-app.secret.labels | object | `{}` | Labels to apply to the Secret |
| deployments.example-app.secret.name | string | `""` | Secret name (defaults to deployment name if not specified) |
| deployments.example-app.secret.stringData | object | `{}` | StringData for the Secret (not base64 encoded) |
| deployments.example-app.secret.type | string | `"Opaque"` | Secret type (defaults to Opaque) |
| deployments.example-app.service | object | `{"annotations":{},"enabled":false,"labels":{},"name":"","port":80,"targetPort":80,"type":"ClusterIP"}` | Service configuration for the deployment |
| deployments.example-app.service.annotations | object | `{}` | Service annotations |
| deployments.example-app.service.enabled | bool | `false` | Enable or disable service |
| deployments.example-app.service.labels | object | `{}` | Additional service labels |
| deployments.example-app.service.name | string | `""` | If not specified, it will use the deployment key prefixed with release name |
| deployments.example-app.service.port | int | `80` | Port exposed by the service |
| deployments.example-app.service.targetPort | int | `80` | Port targeted on the container |
| deployments.example-app.service.type | string | `"ClusterIP"` | Service type (ClusterIP, NodePort, LoadBalancer) |
| deployments.example-app.startupProbe | object | `{"enabled":false,"failureThreshold":30,"httpGet":{"path":"/","port":"http"},"periodSeconds":10}` | Startup probe configuration |
| deployments.example-app.startupProbe.enabled | bool | `false` | Enable or disable startup probe |
| deployments.example-app.startupProbe.failureThreshold | int | `30` | Number of failures before considering the startup failed |
| deployments.example-app.startupProbe.httpGet | object | `{"path":"/","port":"http"}` | HTTP Get probe configuration |
| deployments.example-app.startupProbe.httpGet.path | string | `"/"` | Path for the HTTP probe |
| deployments.example-app.startupProbe.httpGet.port | string | `"http"` | Port for the HTTP probe |
| deployments.example-app.startupProbe.periodSeconds | int | `10` | How often to perform the probe |
| deployments.example-app.useCommonConfigMap | bool | `false` | Use common ConfigMap (from common.configMap) |
| deployments.example-app.useCommonSecret | bool | `false` | Use common Secret (from common.secret) |
| deployments.example-app.volumeMounts | list | `[]` | Volume mounts for the main container |
| deployments.example-app.volumes | list | `[]` | Volume configuration |
| extraConfigMaps | object | `{"example-config":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""}}` | Extra ConfigMap configurations (not directly tied to deployments) |
| extraConfigMaps.example-config | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""}` | Example standalone ConfigMap |
| extraConfigMaps.example-config.annotations | object | `{}` | Annotations to apply to the ConfigMap |
| extraConfigMaps.example-config.data | object | `{}` | Data to be included in the ConfigMap |
| extraConfigMaps.example-config.enabled | bool | `false` | Enable or disable this ConfigMap |
| extraConfigMaps.example-config.labels | object | `{}` | Labels to apply to the ConfigMap |
| extraConfigMaps.example-config.name | string | `""` | If name is not specified it will take the key (example-config) prefixed with release name |
| extraIngresses | object | `{"example-ingress":{"annotations":{},"backend":{"serviceName":"example-service","servicePort":80},"className":"nginx","enabled":false,"hosts":[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}],"name":"","pathType":"Prefix","tls":[]}}` | create separate extraIngresses entries for each backend service. |
| extraIngresses.example-ingress | object | `{"annotations":{},"backend":{"serviceName":"example-service","servicePort":80},"className":"nginx","enabled":false,"hosts":[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}],"name":"","pathType":"Prefix","tls":[]}` | Example standalone Ingress with a single backend |
| extraIngresses.example-ingress.annotations | object | `{}` | Annotations for the Ingress resource |
| extraIngresses.example-ingress.backend | object | `{"serviceName":"example-service","servicePort":80}` | Backend service configuration - REQUIRED - each extraIngress supports only one backend |
| extraIngresses.example-ingress.backend.serviceName | string | `"example-service"` | Name of the service to route to (required) - will be prefixed with release name if not already |
| extraIngresses.example-ingress.backend.servicePort | int | `80` | Port of the service to route to (defaults to 80 if not specified) |
| extraIngresses.example-ingress.className | string | `"nginx"` | IngressClass to be used |
| extraIngresses.example-ingress.enabled | bool | `false` | Enable or disable this Ingress |
| extraIngresses.example-ingress.hosts | list | `[{"host":"chart-example.local","pathType":"Prefix","paths":"/"}]` | Host configuration for the Ingress |
| extraIngresses.example-ingress.name | string | `""` | If name is not specified it will take the key (example-ingress) prefixed with release name |
| extraIngresses.example-ingress.pathType | string | `"Prefix"` | Default path type for the ingress |
| extraIngresses.example-ingress.tls | list | `[]` | TLS configuration for the Ingress |
| extraSecrets | object | `{"example-secret":{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"}}` | Extra Secret configurations (not directly tied to deployments) |
| extraSecrets.example-secret | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"}` | Example standalone Secret |
| extraSecrets.example-secret.annotations | object | `{}` | Annotations to apply to the Secret |
| extraSecrets.example-secret.data | object | `{}` | Data to be included in the Secret (automatically base64 encoded) |
| extraSecrets.example-secret.enabled | bool | `false` | Enable or disable this Secret |
| extraSecrets.example-secret.labels | object | `{}` | Labels to apply to the Secret |
| extraSecrets.example-secret.name | string | `""` | If name is not specified it will take the key (example-secret) prefixed with release name |
| extraSecrets.example-secret.stringData | object | `{}` | StringData for the Secret (not base64 encoded) |
| extraSecrets.example-secret.type | string | `"Opaque"` | Secret type (defaults to Opaque) |
| global | object | `{"annotations":{},"deploymentStrategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0},"type":"RollingUpdate"},"imagePullSecrets":{"enabled":false,"secrets":[]},"labels":{}}` | Global configuration that applies across all resources |
| global.annotations | object | `{}` | Common annotations to be added to all resources |
| global.deploymentStrategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0},"type":"RollingUpdate"}` | Global deployment strategy - applied to all deployments unless overridden |
| global.deploymentStrategy.rollingUpdate | object | `{"maxSurge":1,"maxUnavailable":0}` | Rolling update configuration |
| global.deploymentStrategy.rollingUpdate.maxSurge | int | `1` | Maximum number or percentage of pods that can be created above desired during update |
| global.deploymentStrategy.rollingUpdate.maxUnavailable | int | `0` | Maximum number or percentage of pods that can be unavailable during update |
| global.deploymentStrategy.type | string | `"RollingUpdate"` | Deployment strategy type RollingUpdate |
| global.imagePullSecrets | object | `{"enabled":false,"secrets":[]}` | Image pull secrets configuration |
| global.imagePullSecrets.enabled | bool | `false` | Enable or disable the use of image pull secrets |
| global.imagePullSecrets.secrets | list | `[]` | List of image pull secret names |
| global.labels | object | `{}` | Common labels to be added to all resources |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
