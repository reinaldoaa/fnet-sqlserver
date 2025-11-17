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


# Usar una versión más reciente que pueda tener mejor compatibilidad
FROM mcr.microsoft.com/mssql/server:2022-latest

# Crear directorio para scripts
RUN mkdir -p /scripts
WORKDIR /scripts

# Copiar scripts de inicialización
COPY ./scripts /scripts/

# Dar permisos de ejecución
RUN chmod +x /scripts/*.sh

# Establecer variables de entorno
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=TuContraseñaSegura123!
ENV MSSQL_PID=Express

# Exponer puerto
EXPOSE 1433

# Comando de inicio personalizado
CMD /opt/mssql/bin/sqlservr