# git add scripts/entrypoint.sh#!/bin/bash
# # Función para verificar si SQL Server está listo
# wait_for_sql_server() {
#     echo "Esperando a que SQL Server se inicie..."
#     # CORRECCIÓN: Usar la nueva ruta de sqlcmd y la bandera -C
#     until /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -Q "SELECT 1" &> /dev/null
#     do
#         echo "."
#         sleep 5
#     done
#     echo "SQL Server está listo."
# }
# # Iniciar SQL Server en segundo plano
# echo "Iniciando SQL Server..."
# /opt/mssql/bin/sqlservr &
# # Esperar a que esté completamente operativo
# wait_for_sql_server
# # Ejecutar el script de restauración
# echo "Ejecutando script de restauración de base de datos..."
# /app/scripts/restore-db.sh
# # Mantener el contenedor en ejecución (el proceso principal)
# wait


#************* PARA TEST
#!/bin/bash
echo "=== DEBUG: El script entrypoint.sh se está ejecutando ==="
echo "=== DEBUG: Usuario actual: $(whoami) ==="
echo "=== DEBUG: Directorio actual: $(pwd) ==="
echo "=== DEBUG: Listando archivos en /app ==="
ls -l /app
echo "=== DEBUG: Listando archivos en /app/scripts ==="
ls -l /app/scripts
echo "=== DEBUG: Esperando 60 segundos para que puedas ver este mensaje... ==="
sleep 60
echo "=== DEBUG: Saliendo con código 0 ==="
exit 0