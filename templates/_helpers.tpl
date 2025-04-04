{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "app.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app.labels" -}}
chart-version: {{ include "app.chart" . }}
{{ include "app.selectorLabels" . }}
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create a consistent resource name using release name and resource identifier
*/}}
{{- define "app.resourceName" -}}
{{- $root := index . 0 }}
{{- $resourceId := index . 1 }}
{{- printf "%s-%s" $root.Release.Name $resourceId | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a deployment
*/}}
{{- define "app.deploymentName" -}}
{{- $deployment := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $deployment | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a configmap
*/}}
{{- define "app.configMapName" -}}
{{- $configMap := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $configMap | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a secret
*/}}
{{- define "app.secretName" -}}
{{- $secret := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $secret | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of an ingress
*/}}
{{- define "app.ingressName" -}}
{{- $ingress := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $ingress | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a service
*/}}
{{- define "app.serviceName" -}}
{{- $service := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $service | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of a HPA
*/}}
{{- define "app.hpaName" -}}
{{- $hpa := index . 1 }}
{{- $root := index . 0 }}
{{- printf "%s-%s" $root.Release.Name $hpa | trunc 63 | trimSuffix "-" }}
{{- end }}