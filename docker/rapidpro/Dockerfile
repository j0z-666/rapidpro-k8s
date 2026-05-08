FROM python:3.12-slim

ARG RAPIDPRO_VERSION=mversion

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
# Clonar RapidPro desde upstream
#
RUN git clone --branch ${RAPIDPRO_VERSION} \
    https://github.com/nyaruka/rapidpro.git .

#
# Tu settings.py custom
#
COPY settings.py /rapidpro/temba/settings.py

#
# Instalar dependencias Python
#
RUN pip install --upgrade pip setuptools wheel

RUN pip install -r requirements.txt

#
# Colectar estáticos
#
RUN python manage.py collectstatic --noinput

#
# Puerto Django/Gunicorn
#
EXPOSE 8000

#
# Gunicorn
#
CMD ["gunicorn", "temba.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "4"]