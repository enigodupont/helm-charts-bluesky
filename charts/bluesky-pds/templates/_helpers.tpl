{{/*
Expand the name of the chart.
*/}}
{{- define "bluesky-pds.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bluesky-pds.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bluesky-pds.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bluesky-pds.labels" -}}
helm.sh/chart: {{ include "bluesky-pds.chart" . }}
{{ include "bluesky-pds.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bluesky-pds.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bluesky-pds.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bluesky-pds.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bluesky-pds.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Determine the name of the secret
*/}}
{{- define "bluesky-pds.secretName" -}}
{{- if .Values.pds.config.secrets.existingSecret }}
{{- .Values.pds.config.secrets.existingSecret }}
{{- else }}
{{- include "bluesky-pds.fullname" . -}}-secret
{{- end }}
{{- end }}
