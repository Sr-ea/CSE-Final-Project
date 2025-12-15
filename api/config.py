import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="vet_clinic"
    )


JWT_SECRET_KEY = "super-secret-key"