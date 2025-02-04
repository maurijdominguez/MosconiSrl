from fastapi import FastAPI
import pyodbc  # 🔹 Usamos ODBC en lugar de pymssql

app = FastAPI()

# Configuración de conexión a SQL Server
SERVER = "ts.mosconi.com.ar,50001"
DATABASE = "em360"
USERNAME = "em360_consulta"
PASSWORD = "Lsinet20*1"

def conectar_sql():
    conexion = pyodbc.connect(
        f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}"
    )
    return conexion

@app.get("/datos")
def obtener_datos():
    try:
        conexion = conectar_sql()
        cursor = conexion.cursor()
        cursor.execute("SELECT * FROM audiusua")  # 🔹 Cambia por tu consulta
        datos = cursor.fetchall()
        conexion.close()
        return [dict(zip([column[0] for column in cursor.description], row)) for row in datos]
    except Exception as e:
        return {"error": str(e)}
