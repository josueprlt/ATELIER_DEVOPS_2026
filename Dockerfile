FROM python:3.9-slim

# Utiliser une image slim pour limiter la taille tout en restant compatible glibc.
WORKDIR /app

# Créer un utilisateur non-root et lui donner la propriété des fichiers d'application.
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /usr/sbin/nologin -c "app user" appuser

COPY --chown=appuser:appuser __init__.py .
COPY --chown=appuser:appuser templates/ templates/

RUN pip install --no-cache-dir flask

EXPOSE 5000
USER appuser

CMD ["python", "__init__.py"]