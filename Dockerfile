# Stage 1: Build Stage
FROM python:3.11-slim AS builder

WORKDIR /app

# Upgrade pip and install dependencies into a virtual environment or user base to keep final image clean
COPY app/requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Production Stage
FROM python:3.11-slim

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copy installed dependencies from the builder stage
COPY --from=builder /root/.local /home/appuser/.local

# Copy application code
COPY app/ .

# Ensure the non-root user owns the app directory
RUN chown -R appuser:appuser /app

# Set PATH so python can find the installed dependencies
ENV PATH=/home/appuser/.local/bin:$PATH

# Switch to the non-root user
USER appuser

# Expose the API port
EXPOSE 8000

# Start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
