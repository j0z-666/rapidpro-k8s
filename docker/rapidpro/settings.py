from .settings_common import *

import os

# ------------------------------------------------------------------------------
# CORE
# ------------------------------------------------------------------------------

DEBUG = False

SECRET_KEY = os.environ.get(
    "SECRET_KEY",
    "changeme-super-secret-key"
)

HOSTNAME = os.environ.get(
    "HOSTNAME",
    "localhost"
)

ALLOWED_HOSTS = ["*"]

# ------------------------------------------------------------------------------
# DATABASE
# ------------------------------------------------------------------------------

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.environ.get("POSTGRES_DB", "rapidpro"),
        "USER": os.environ.get("POSTGRES_USER", "rapidpro"),
        "PASSWORD": os.environ.get("POSTGRES_PASSWORD", "rapidpro"),
        "HOST": os.environ.get("POSTGRES_HOST", "postgres"),
        "PORT": os.environ.get("POSTGRES_PORT", "5432"),
        "CONN_MAX_AGE": 60,
    }
}

# ------------------------------------------------------------------------------
# REDIS
# ------------------------------------------------------------------------------

REDIS_HOST = os.environ.get("REDIS_HOST", "redis")
REDIS_PORT = int(os.environ.get("REDIS_PORT", "6379"))

REDIS_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/0"

# ------------------------------------------------------------------------------
# CELERY
# ------------------------------------------------------------------------------

CELERY_BROKER_URL = REDIS_URL

# ------------------------------------------------------------------------------
# MAILROOM
# ------------------------------------------------------------------------------

MAILROOM_URL = os.environ.get(
    "MAILROOM_URL",
    "http://mailroom:8090"
)

# ------------------------------------------------------------------------------
# STORAGE
# ------------------------------------------------------------------------------

# Local storage (dev)
STORAGE_ROOT = "/rapidpro/storage"

# ------------------------------------------------------------------------------
# SECURITY
# ------------------------------------------------------------------------------

SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")

USE_X_FORWARDED_HOST = True

# ------------------------------------------------------------------------------
# LOGGING
# ------------------------------------------------------------------------------

LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": "INFO",
    },
}

# ------------------------------------------------------------------------------
# BRANDING
# ------------------------------------------------------------------------------

ORG_BRAND = "Nono Labs"

# ------------------------------------------------------------------------------
# TIMEZONE
# ------------------------------------------------------------------------------

TIME_ZONE = "America/Mexico_City"

# ------------------------------------------------------------------------------
# STATIC
# ------------------------------------------------------------------------------

STATIC_URL = "/sitestatic/"
MEDIA_URL = "/media/"

# ------------------------------------------------------------------------------
# INTERNAL ADDRESSES
# ------------------------------------------------------------------------------

INTERNAL_IPS = ["127.0.0.1"]

##ALBERTO NONO DEV

AWS_ACCESS_KEY_ID = os.environ.get("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.environ.get("AWS_SECRET_ACCESS_KEY")
AWS_REGION = os.environ.get("AWS_REGION", "us-east-1")

S3_SESSIONS_BUCKET = os.environ.get("S3_SESSIONS_BUCKET", "rapidpro-sessions")
S3_ATTACHMENTS_BUCKET = os.environ.get("S3_ATTACHMENTS_BUCKET", "rapidpro-attachments")

STORAGES = {
    "default": {
        "BACKEND": "storages.backends.s3boto3.S3Boto3Storage",
        "OPTIONS": {
            "bucket_name": S3_ATTACHMENTS_BUCKET  # o S3_SESSIONS_BUCKET según tu lógica
        },
    },
    "archives": {
        "BACKEND": "storages.backends.s3boto3.S3Boto3Storage",
        "OPTIONS": {
            "bucket_name": S3_ATTACHMENTS_BUCKET  # usa el que requieras
        },
    },
    "public": {
        "BACKEND": "storages.backends.s3boto3.S3Boto3Storage",
        "OPTIONS": {
            "bucket_name": S3_ATTACHMENTS_BUCKET,
            "signature_version": "s3v4",
            "default_acl": "public-read",
            "querystring_auth": False,
            # Aquí pon el custom_domain SOLO si tienes un CDN/bucket website configurado,
            # si no, puedes omitirlo (Django devolverá enlaces de S3 firmados/reales)
            # "custom_domain": "rapidpro.nono-labs.com/media",
        },
    },
    "staticfiles": {
        "BACKEND": "django.contrib.staticfiles.storage.StaticFilesStorage",
    },
}

AWS_S3_REGION_NAME = os.environ.get("AWS_REGION", "us-east-1")
AWS_S3_ENDPOINT_URL = os.environ.get("S3_ENDPOINT", "https://storage.googleapis.com")
AWS_S3_ADDRESSING_STYLE = "path" if os.environ.get("S3_PATH_STYLE", "true").lower() in ("1", "true", "yes", "on") else "virtual"
AWS_S3_FILE_OVERWRITE = False

STORAGE_URL = f"{AWS_S3_ENDPOINT_URL}/{S3_ATTACHMENTS_BUCKET}"