#!/bin/bash
echo "🔹 Instalando ODBC Driver 17 para SQL Server en Render..."

# Instalar dependencias necesarias
apt-get update && apt-get install -y odbcinst unixodbc unixodbc-dev

# Agregar clave de Microsoft y su repositorio
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl -o /etc/apt/sources.list.d/mssql-release.list https://packages.microsoft.com/config/ubuntu/20.04/prod.list

# Actualizar paquetes e instalar ODBC Driver 17
apt-get update && apt-get install -y msodbcsql17

#!/bin/bash
set -eux

# Actualizar los paquetes
apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    curl

# Agregar claves y repositorios de Microsoft
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"

# Instalar ODBC Driver 11 para SQL Server
apt-get update && apt-get install -y msodbcsql11

echo "✅ Instalación completada. Procediendo con las dependencias de Python..."
pip install -r requirements.txt
