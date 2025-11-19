#!/bin/bash
# Función para verificar si SQL Server está listo
wait_for_sql_server() {
    echo "Esperando a que SQL Server se inicie..."
    # CORRECCIÓN: Usar la nueva ruta de sqlcmd y la bandera -C
    until /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -Q "SELECT 1" &> /dev/null
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

# INICIO: Servidor web dummy para el health check de Render
echo "Iniciando servidor web dummy en el puerto 8080 para el health check de Render..."
python3 -m http.server 8080 &
# FIN: Servidor web dummy

# Mantener el contenedor en ejecución (el proceso principal)
wait
