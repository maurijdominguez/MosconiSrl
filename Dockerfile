# 🔹 Imagen base con soporte para ODBC y Python
FROM ubuntu:20.04

# 🔹 Definir variables de entorno para aceptar la licencia de Microsoft
ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# 🔹 Actualizar paquetes y agregar claves de Microsoft
RUN apt-get update && apt-get install -y \
    curl gnupg2 apt-transport-https \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && add-apt-repository "$(curl -fsSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"

# 🔹 Instalar dependencias ODBC
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
