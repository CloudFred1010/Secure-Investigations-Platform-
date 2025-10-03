# ===== Stage 1: Build =====
FROM python:3.12-slim AS builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps into a venv
COPY api/requirements.txt .
RUN python -m venv /venv \
 && /venv/bin/pip install --no-cache-dir --upgrade pip \
 && /venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy API source code
COPY api /app/api

# ===== Stage 2: Runtime =====
FROM python:3.12-slim

WORKDIR /app

# Copy venv and API code from builder
COPY --from=builder /venv /venv
COPY --from=builder /app /app

# Add venv to PATH
ENV PATH="/venv/bin:$PATH"
# Ensure Python finds /app as a package root
ENV PYTHONPATH=/app

# Expose API port
EXPOSE 8000

# Run FastAPI app
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
