# # Usar la imagen oficial de SQL Server 2019
# FROM mcr.microsoft.com/mssql/server:2019-latest
# # Establecer el directorio de trabajo
# WORKDIR /app
# # Copiar el archivo de backup al contenedor
# COPY FNET_A2K12.bak /app/FNET_A2K12.bak
# # Copiar los scripts y darles permisos de ejecución en un solo paso
# COPY --chmod=0755 scripts/ /app/scripts/
# # Exponer el puerto de SQL Server
# EXPOSE 1433
# # Establecer el script de entrada personalizado
# CMD ["/app/scripts/entrypoint.sh"]

# Usar la imagen oficial de SQL Server 2019
FROM mcr.microsoft.com/mssql/server:2019-latest

# Establecer el directorio de trabajo
WORKDIR /app

# Cambiar a root para instalar dependencias
USER root

# Instalar netcat y herramientas necesarias
RUN apt-get update && \
    apt-get install -y netcat-openbsd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Volver al usuario mssql para seguridad
USER mssql

# Copiar el archivo de backup al contenedor
COPY FNET_A2K12.bak /app/FNET_A2K12.bak

# Copiar los scripts y darles permisos de ejecución en un solo paso
COPY --chmod=0755 scripts/ /app/scripts/

# Exponer el puerto de SQL Server
EXPOSE 1433

# Establecer el script de entrada personalizado
CMD ["/app/scripts/entrypoint.sh"]