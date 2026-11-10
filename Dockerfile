
# --------------------------------------------------
# Enterprise-Grade DevSecOps Pipeline
# Production-oriented Flask container
# --------------------------------------------------

FROM python:3.12-slim

# Python runtime configuration
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PORT=3000

# Application working directory
WORKDIR /app

# Create a dedicated non-root application user
RUN groupadd --system app && \
    useradd --system \
    --gid app \
    --create-home \
    --home-dir /home/app \
    app

# Install pinned application dependencies
COPY --chown=app:app app/requirements.txt ./requirements.txt

RUN python -m pip install --no-cache-dir \
    --requirement requirements.txt

# Copy application source code
COPY --chown=app:app app/ ./

# Run as an unprivileged user
USER app

# Application port
EXPOSE 3000

# Container health check
HEALTHCHECK --interval=30s \
    --timeout=3s \
    --start-period=10s \
    --retries=3 \
    CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:3000/health', timeout=2)"]

# Production WSGI server
CMD ["gunicorn", \
     "--bind", "0.0.0.0:3000", \
     "--workers", "2", \
     "--access-logfile", "-", \
     "--error-logfile", "-", \
     "app:app"]
