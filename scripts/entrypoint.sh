#!/bin/bash

# Función para verificar si SQL Server está listo
wait_for_sql_server() {
    echo "Esperando a que SQL Server se inicie..."
    until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "SELECT 1" &> /dev/null
    do
        echo "."
        sleep 5
    done
    echo "SQL Server está listo."
}

# Iniciar SQL Server en segundo plano
echo "Iniciando SQL Server..."
/opt/mssql/bin/sqlservr &

# Esperar a que esté completamente operativo
wait_for_sql_server

# Ejecutar el script de restauración
echo "Ejecutando script de restauración de base de datos..."
/app/scripts/restore-db.sh

# Mantener el contenedor en ejecución (el proceso principal)
wait