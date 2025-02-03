# 🔹 Imagen base con Python y soporte de ODBC
FROM mcr.microsoft.com/mssql-tools

# 🔹 Instalar dependencias necesarias para ODBC
RUN apt-get update && apt-get install -y \
    unixodbc unixodbc-dev odbcinst msodbcsql17 \
    && rm -rf /var/lib/apt/lists/*

# 🔹 Crear y configurar el entorno de trabajo
WORKDIR /app
COPY . /app

# 🔹 Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# 🔹 Exponer el puerto de FastAPI
EXPOSE 10000

# 🔹 Comando para ejecutar FastAPI
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "10000"]
