#!/bin/bash

# Salir inmediatamente si un comando falla
set -e

# --- CONFIGURACIÓN ---
DB_NAME="FNET_A2K12"
BACKUP_FILE="/app/FNET_A2K12.bak"
# --- FIN DE LA CONFIGURACIÓN ---

echo "Verificando si la base de datos '$DB_NAME' ya existe..."

# Verificar si la base de datos ya existe
# CAMBIO AQUÍ: Usar la nueva ruta de sqlcmd
DB_EXISTS=$(/opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -Q "SELECT 1 FROM sys.databases WHERE name = '$DB_NAME'" -h -1 | tr -d '[:space:]')

if [ "$DB_EXISTS" = "1" ]; then
    echo "La base de datos '$DB_NAME' ya existe. Omitiendo restauración."
else
    echo "La base de datos '$DB_NAME' no existe. Iniciando restauración desde $BACKUP_FILE..."

    # Comando RESTORE DATABASE
    # IMPORTANTE: 'FNET_A2K12_Data' y 'FNET_A2K12_Log' son los nombres lógicos de los archivos.
    # CAMBIO AQUÍ: Usar la nueva ruta de sqlcmd
    /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -Q "
    RESTORE DATABASE [$DB_NAME] 
    FROM DISK = '$BACKUP_FILE' 
    WITH MOVE 'FNET_A2K12_Data' TO '/var/opt/mssql/data/FNET_A2K12.mdf', 
         MOVE 'FNET_A2K12_Log' TO '/var/opt/mssql/data/FNET_A2K12.ldf', 
    REPLACE;
    "

    echo "Restauración completada."
fi