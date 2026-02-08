{{/*
Expand the name of the chart.
*/}}
{{- define "daa.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
Truncated at 63 chars due to DNS naming spec limits.
*/}}
{{- define "daa.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "daa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a consistent resource name using release name and resource identifier.
Usage: {{ include "daa.resourceName" (list . "component-name") }}
*/}}
{{- define "daa.resourceName" -}}
{{- $root := index . 0 }}
{{- $resourceId := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $resourceId | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a deployment.
Usage: {{ include "daa.deploymentName" (list . "deployment-key") }}
*/}}
{{- define "daa.deploymentName" -}}
{{- $root := index . 0 }}
{{- $deployment := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $deployment | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a service.
Usage: {{ include "daa.serviceName" (list . "service-key") }}
*/}}
{{- define "daa.serviceName" -}}
{{- $root := index . 0 }}
{{- $service := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $service | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a configmap.
Usage: {{ include "daa.configMapName" (list . "configmap-key") }}
*/}}
{{- define "daa.configMapName" -}}
{{- $root := index . 0 }}
{{- $configMap := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $configMap | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a secret.
Usage: {{ include "daa.secretName" (list . "secret-key") }}
*/}}
{{- define "daa.secretName" -}}
{{- $root := index . 0 }}
{{- $secret := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $secret | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of an ingress.
Usage: {{ include "daa.ingressName" (list . "ingress-key") }}
*/}}
{{- define "daa.ingressName" -}}
{{- $root := index . 0 }}
{{- $ingress := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $ingress | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels applied to all resources.
*/}}
{{- define "daa.labels" -}}
helm.sh/chart: {{ include "daa.chart" . }}
{{ include "daa.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels for identifying pods.
*/}}
{{- define "daa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "daa.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Resource-specific labels with component identifier.
Usage: {{ include "daa.resourceLabels" (list . "component-name") }}
*/}}
{{- define "daa.resourceLabels" -}}
{{- $root := index . 0 }}
{{- $component := index . 1 }}
helm.sh/chart: {{ include "daa.chart" $root }}
app.kubernetes.io/name: {{ include "daa.name" $root }}
app.kubernetes.io/instance: {{ $root.Release.Name }}
app.kubernetes.io/component: {{ $component }}
app.kubernetes.io/managed-by: {{ $root.Release.Service }}
{{- with $root.Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels with component identifier.
Usage: {{ include "daa.resourceSelectorLabels" (list . "component-name") }}
*/}}
{{- define "daa.resourceSelectorLabels" -}}
{{- $root := index . 0 }}
{{- $component := index . 1 }}
app.kubernetes.io/name: {{ include "daa.name" $root }}
app.kubernetes.io/instance: {{ $root.Release.Name }}
app.kubernetes.io/component: {{ $component }}
{{- end }}

{{/*
Global annotations applied to all resources.
*/}}
{{- define "daa.annotations" -}}
{{- with .Values.global.annotations }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Image pull secrets configuration.
Usage: {{ include "daa.imagePullSecrets" . }}
*/}}
{{- define "daa.imagePullSecrets" -}}
{{- if and .Values.global.imagePullSecrets.enabled .Values.global.imagePullSecrets.secrets }}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets.secrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Merge common init containers with deployment-specific ones.
Handles useCommonInitContainers and excludeCommonInitContainers.
Usage: {{ include "daa.initContainers" (list . $deploymentConfig) }}
*/}}
{{- define "daa.initContainers" -}}
{{- $root := index . 0 }}
{{- $deployment := index . 1 }}
{{- $initContainers := list }}
{{- /* Add common init containers if enabled (default: true) */}}
{{- $useCommon := true }}
{{- if hasKey $deployment "useCommonInitContainers" }}
{{- $useCommon = $deployment.useCommonInitContainers }}
{{- end }}
{{- if and $useCommon $root.Values.common.initContainers }}
{{- $excludeList := $deployment.excludeCommonInitContainers | default list }}
{{- range $root.Values.common.initContainers }}
{{- if not (has .name $excludeList) }}
{{- $initContainers = append $initContainers . }}
{{- end }}
{{- end }}
{{- end }}
{{- /* Add deployment-specific init containers */}}
{{- if $deployment.initContainers }}
{{- range $deployment.initContainers }}
{{- $initContainers = append $initContainers . }}
{{- end }}
{{- end }}
{{- if $initContainers }}
{{ toYaml $initContainers }}
{{- end }}
{{- end }}

{{/*
Merge common additional containers (sidecars) with deployment-specific ones.
Handles useCommonAdditionalContainers and excludeCommonAdditionalContainers.
Usage: {{ include "daa.additionalContainers" (list . $deploymentConfig) }}
*/}}
{{- define "daa.additionalContainers" -}}
{{- $root := index . 0 }}
{{- $deployment := index . 1 }}
{{- $additionalContainers := list }}
{{- /* Add common additional containers if enabled (default: true) */}}
{{- $useCommon := true }}
{{- if hasKey $deployment "useCommonAdditionalContainers" }}
{{- $useCommon = $deployment.useCommonAdditionalContainers }}
{{- end }}
{{- if and $useCommon $root.Values.common.additionalContainers }}
{{- $excludeList := $deployment.excludeCommonAdditionalContainers | default list }}
{{- range $root.Values.common.additionalContainers }}
{{- if not (has .name $excludeList) }}
{{- $additionalContainers = append $additionalContainers . }}
{{- end }}
{{- end }}
{{- end }}
{{- /* Add deployment-specific additional containers */}}
{{- if $deployment.additionalContainers }}
{{- range $deployment.additionalContainers }}
{{- $additionalContainers = append $additionalContainers . }}
{{- end }}
{{- end }}
{{- if $additionalContainers }}
{{ toYaml $additionalContainers }}
{{- end }}
{{- end }}
