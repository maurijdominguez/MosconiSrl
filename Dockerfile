# 🔹 Imagen base con Ubuntu
FROM ubuntu:20.04

# 🔹 Definir variables de entorno
ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# 🔹 Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl gnupg2 apt-transport-https ca-certificates unixodbc unixodbc-dev odbcinst python3 python3-pip \
    freetds-bin freetds-dev gcc python3-dev libssl-dev libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# 🔹 Agregar clave de Microsoft para los drivers ODBC
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# 🔹 Agregar el repositorio de Microsoft para SQL Server
RUN echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" > /etc/apt/sources.list.d/mssql-release.list

# 🔹 Instalar driver ODBC para SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc \
    && rm -rf /var/lib/apt/lists/*

# 🔹 Crear y configurar el entorno de trabajo
WORKDIR /app
COPY . /app

# 🔹 Asegurar que `pip` y `uvicorn` estén instalados
RUN python3 -m pip install --upgrade pip

# 🔹 Instalar las dependencias de Python (pymssql incluido)
RUN pip3 install --no-cache-dir -r requirements.txt

# 🔹 Exponer el puerto de FastAPI
EXPOSE 10000

# 🔹 Comando para ejecutar FastAPI
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "10000"]
