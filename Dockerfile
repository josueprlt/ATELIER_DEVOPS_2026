FROM python:3.12-slim

# Utiliser une image slim pour limiter la taille tout en restant compatible glibc.
WORKDIR /app

# Mettre à jour les paquets système afin de corriger les vulnérabilités connues
# issues de la base Debian avant d'installer l'application Python.
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur non-root et lui donner la propriété des fichiers d'application.
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /usr/sbin/nologin -c "app user" appuser

COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser __init__.py .
COPY --chown=appuser:appuser templates/ templates/

EXPOSE 5000
USER appuser

CMD ["python", "__init__.py"]