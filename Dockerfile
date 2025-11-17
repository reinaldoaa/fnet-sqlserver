# FROM mcr.microsoft.com/mssql/server:2019-latest

# # Copiar scripts y backup
# COPY scripts/ /scripts/

# # Dar permisos de ejecución
# USER root
# RUN chmod +x /scripts/init-database.sh
# RUN chown -R mssql:mssql /scripts
# USER mssql

# # Variables de entorno
# ENV SA_PASSWORD=88LAk+#9Dlb7Wb&SvrAra1
# ENV ACCEPT_EULA=Y

# # Comando de inicio
# CMD /bin/bash /scripts/init-database.sh & /opt/mssql/bin/sqlservr

# Usar la imagen oficial de SQL Server 2019
FROM mcr.microsoft.com/mssql/server:2019-latest

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo de backup al contenedor
COPY FNET_A2K12.bak /app/FNET_A2K12.bak

# Copiar los scripts y darles permisos de ejecución en un solo paso
COPY --chmod=0755 scripts/ /app/scripts/

# Exponer el puerto de SQL Server
EXPOSE 1433

# Establecer el script de entrada personalizado
CMD ["/app/scripts/entrypoint.sh"]