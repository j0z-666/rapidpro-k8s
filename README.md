# RapidPro Helm Chart for GKE

## Prerrequisitos

- Kubernetes 1.19+
- Helm 3.0+
- GKE cluster con Workload Identity habilitado
- Cloud SQL instance
- Memorystore (Redis)
- Elasticsearch (puede ser Elastic Cloud)
- GCS Buckets para archivos

## Instalación

```bash
# Clonar o crear el chart
helm dependency update

# Instalar con secrets
helm install rapidpro . \
  --set secrets.djangoSecretKey="mi-clave-secreta" \
  --set secrets.dbPassword="password-bd" \
  --set secrets.encryptionKey="llave-encriptacion" \
  --set secrets.emailPassword="email-password" \
  --set cloudsql.instanceConnectionName="proyecto:region:instancia"
```

## Actualización

```bash
helm upgrade rapidpro . \
  --set secrets.djangoSecretKey="nueva-clave" \
  --set secrets.dbPassword="nuevo-password"
```

## Estructura

- `templates/configmap.yaml`: Configuración global (DB, Redis, Elastic, S3, DynamoDB)
- `templates/secret.yaml`: Secrets globales
- `templates/*/configmap.yaml`: Configuración específica por componente
- `templates/*/deployment.yaml`: Deployments con sidecar de Cloud SQL Proxy

## Componentes

- rapidpro: Web app en puerto 8000
- celery: Worker de tareas asíncronas
- mailroom: Procesamiento de mensajes en puerto 8090
- courier: Envío de mensajes en puerto 8080
- indexer: Indexado en Elasticsearch
