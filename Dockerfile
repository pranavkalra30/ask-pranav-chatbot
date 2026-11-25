# 1. Start from a small Linux image that already has Python 3.12
FROM python:3.12-slim

# 2. Don't write .pyc files, and print logs immediately (no buffering)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. Work inside /app in the container
WORKDIR /app

# 4. Copy only the dependency list first, so this layer is cached
#    and pip install is skipped when only your code changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the code
COPY . .

# 6. Document the port the app listens on
EXPOSE 8000

# 7. Start the API; 0.0.0.0 makes it reachable from outside the container
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
