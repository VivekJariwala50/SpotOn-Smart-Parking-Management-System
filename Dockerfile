FROM python:3.11-slim

LABEL org.opencontainers.image.title="SpotOn Smart Parking System" \
      org.opencontainers.image.description="Full-stack Flask/PostgreSQL smart parking management system" \
      org.opencontainers.image.authors="Vivek Jariwala" \
      org.opencontainers.image.source="https://github.com/VivekJariwala50/SpotOn-Smart-Parking-Management-System"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Gunicorn binds on 8000; expose that port for Docker / orchestrators
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "--timeout", "120", "app:app"]
