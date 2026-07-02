#!/bin/sh

set -e

#export REMOTE_CONTAINERS=true Alberto: needs to be false in k8s
export POSTGIS=off

ACTION=${1:-webapp}

if [ "$ACTION" = "webapp" ]; then
    echo "Running RapidPro webapp..."

    poetry run python manage.py migrate
    poetry run python manage.py migrate_dynamo

    exec poetry run gunicorn temba.wsgi:application \
        --bind 0.0.0.0:8000 \
        --workers 1 \
        --threads 5 \
        --timeout 60

elif [ "$ACTION" = "celery" ]; then
    echo "Running RapidPro celery worker..."

    exec poetry run celery -A temba worker -E -B --loglevel=INFO

else
    echo "Unknown action: $ACTION"

    exit 1
fi