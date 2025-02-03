from fastapi import FastAPI
import pyodbc
import pandas as pd

# Configurar FastAPI
app = FastAPI()

# Configuración de conexión a SQL Server
SERVER = "ts.mosconi.com.ar,50001"
DATABASE = "em360"
USERNAME = "em360_consulta"
PASSWORD = "Lsinet20*1"
DRIVER = "{ODBC Driver 17 for SQL Server}"

def conectar_sql():
    conexion = pyodbc.connect(
        f"DRIVER={DRIVER};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD};Encrypt=no;TrustServerCertificate=yes;Protocol=TCP"
    )
    return conexion

# Endpoint para obtener datos de SQL Server
@app.get("/datos")
def obtener_datos():
    try:
        conexion = conectar_sql()
        query = "SELECT * FROM audiusua"  # Modifica con tu consulta
        df = pd.read_sql(query, conexion)
        conexion.close()
        return df.to_dict(orient="records")  # Convertir a JSON
    except Exception as e:
        return {"error": str(e)}

@app.get("/")
def read_root():
    return {"message": "¡API funcionando correctamente!"}
