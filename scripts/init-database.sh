#!/bin/bash
# Esperar a que SQL Server esté listo
echo "Esperando a que SQL Server esté listo..."
sleep 30s
echo "Iniciando restauración de FNET_2K12..."
# Restaurar la base de datos
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "88LAk+#9Dlb7Wb&SvrAra1" -Q "
RESTORE DATABASE FNET_A2K12
FROM DISK = '/scripts/FNET_A2K12.bak'
WITH 
MOVE 'FNET_A2K12' TO '/var/opt/mssql/data/FNET_A2K12.mdf',
MOVE 'FNET_A2K12_log' TO '/var/opt/mssql/data/FNET_A2K12.ldf',
REPLACE,
STATS = 5
"
echo "✅ Base de datos FNET restaurada exitosamente!"
