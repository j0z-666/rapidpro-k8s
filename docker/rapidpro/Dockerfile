FROM python:3.12-slim

ARG RAPIDPRO_VERSION=v26.0.0

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /rapidpro

#
# Dependencias del sistema
#
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    g++ \
    build-essential \
    libpq-dev \
    gettext \
    curl \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

#
# Clonar RapidPro
#
RUN git clone --branch ${RAPIDPRO_VERSION} \
    https://github.com/nyaruka/rapidpro.git .

#
# Settings custom
#
COPY settings.py /rapidpro/temba/settings.py

#
# Entrypoint
#
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

#
# Poetry
#
RUN pip install --upgrade pip setuptools wheel poetry

#
# Instalar deps
#
RUN poetry install

#
# Static files
#
RUN poetry run python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["webapp"]