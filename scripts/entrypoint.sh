#!/bin/bash
# Esperar a que SQL Server se inicie
/opt/mssql/bin/sqlservr &

# Esperar a que esté listo
sleep 30s

# Ejecutar scripts de inicialización si existen
if [ -f "/scripts/init-database.sh" ]; then
    /opt/mssql/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i /scripts/init-database.sh
fi

# Mantener el contenedor en ejecución
wait