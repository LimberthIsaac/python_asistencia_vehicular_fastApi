# create_test_user.py
import sys
import os

# Añadimos el directorio actual al path para importar backend
sys.path.append(os.getcwd())

from backend.database import SessionLocal
from backend import crud, schemas

def create():
    db = SessionLocal()
    try:
        # Datos del usuario de prueba
        test_email = "prueba@asistauto.com"
        test_pass = "123456"
        
        # Verificar si ya existe
        existing = crud.get_cliente_by_email(db, email=test_email)
        if existing:
            print(f"El usuario {test_email} ya existe.")
            return

        # Crear esquema
        cliente_in = schemas.ClienteCreate(
            nombres="Usuario",
            apellidos="Prueba",
            telefono="70012345",
            correo=test_email,
            password=test_pass
        )
        
        # Guardar en DB
        new_user = crud.create_cliente(db, cliente_in)
        print(f"Usuario de prueba creado exitosamente:")
        print(f"Email: {test_email}")
        print(f"Password: {test_pass}")
        
    except Exception as e:
        print(f"Error al crear usuario: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    create()
