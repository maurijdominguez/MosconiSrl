from fastapi import FastAPI
import pymssql  # 🔹 Usar pymssql en lugar de pyodbc

app = FastAPI()

# Configuración de conexión a SQL Server
SERVER = "ts.mosconi.com.ar,50001"
DATABASE = "em360"
USERNAME = "em360_consulta"
PASSWORD = "Lsinet20*1"

def conectar_sql():
    conexion = pymssql.connect(
        server=SERVER,
        user=USERNAME,
        password=PASSWORD,
        database=DATABASE,
        as_dict=True  # 🔹 Para devolver resultados como diccionario
    )
    return conexion

@app.get("/datos")
def obtener_datos():
    try:
        conexion = conectar_sql()
        cursor = conexion.cursor()
        cursor.execute("SELECT * FROM audiusua")  # Modifica con tu consulta
        datos = cursor.fetchall()
        conexion.close()
        return datos
    except Exception as e:
        return {"error": str(e)}

@app.get("/")
def read_root():
    return {"message": "¡API funcionando correctamente!"}
