{{/*
Usage: {{ include "bootstrap.source" (dict  "value" .Values.path.to.the.value "global" $.Values.type.value) }}
*/}}
{{- define "bootstrap.source" -}}
{{- if .value -}}
    {{- if .value.repoUrl }}
    repoURL: {{ .value.repoUrl }}
    {{- else }}
    repoURL: {{ .global.repoUrl }}
    {{- end -}}
    {{- if .value.targetRevision }}
    targetRevision: {{ .value.targetRevision }}
    {{- else }}
    targetRevision: {{ .global.targetRevision }}
    {{- end -}}
    {{- if .value.path }}
    path: {{ .value.path }}
    {{- else }}
    path: {{ .global.path }}
    {{- end -}}
    {{- if and (or .value.helm .global.helm) ( not .value.directory ) }}
    helm:
      valueFiles:
      {{- if .value.helm -}}
{{ toYaml .value.helm | indent 8 }}
        {{- else }}
{{ toYaml .global.helm | indent 8 }}
        {{- end -}}
    {{- else }}
    directory:
      recurse: {{ .value.directory }}
    {{- end -}}
{{- else -}}
    repoURL: {{ .global.repoUrl }}
    targetRevision: {{ .global.targetRevision }}
    path: {{ .global.path }}
    {{- if .global.helm }}
    helm:
        valueFiles:
{{ toYaml .global.helm | indent 8 }}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Usage: {{ include "bootstrap.destination" (dict  "value" .Values.path.to.the.value "global" $.Values.type.value) }}
*/}}
{{- define "bootstrap.destination" -}}
{{- if .value -}}
    {{- if .value.server -}}
    server: {{ .value.server }}
    {{- else }}
    server: {{ .global.server }}
    {{- end -}}
    {{- if .value.namespace }}
    namespace: {{ .value.namespace }}
    {{- else }}
    namespace: {{ .global.namespace }}
    {{- end -}}
{{- else -}}
    server: {{ .global.server }}
    namespace: {{ .global.namespace }}
{{- end -}}
{{- end -}}

{{/*
Usage: {{ include "bootstrap.syncOptions" (dict  "value" .Values.path.to.the.value "global" $.Values.type.value) }}
*/}}
{{- define "bootstrap.syncOptions" -}}
{{- if .value }}
{{ toYaml .value }}
{{- else }}
{{ toYaml .global }}
{{- end -}}
{{- end -}}

{{/*
Usage: {{ include "bootstrap.automated" (dict  "value" .Values.path.to.the.value "global" $.Values.type.value) }}
*/}}
{{- define "bootstrap.automated" -}}
{{- if .value }}
{{ toYaml .value }}
{{- else }}
{{ toYaml .global }}
{{- end -}}
{{- end -}}
