#!/bin/bash
echo "🔹 Instalando ODBC Driver 17 para SQL Server en Render..."

# Instalar dependencias necesarias
apt-get update && apt-get install -y odbcinst unixodbc unixodbc-dev

# Agregar clave de Microsoft y su repositorio
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl -o /etc/apt/sources.list.d/mssql-release.list https://packages.microsoft.com/config/ubuntu/20.04/prod.list

# Actualizar paquetes e instalar ODBC Driver 17
apt-get update && apt-get install -y msodbcsql17

echo "✅ Instalación completada. Procediendo con las dependencias de Python..."
pip install -r requirements.txt
