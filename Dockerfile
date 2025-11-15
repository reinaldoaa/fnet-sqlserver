FROM mcr.microsoft.com/mssql/server:2019-latest

# Copiar scripts y backup
COPY scripts/ /scripts/

# Dar permisos de ejecución
USER root
RUN chmod +x /scripts/init-database.sh
USER mssql

# Variables de entorno
ENV SA_PASSWORD=88LAk+#9Dlb7Wb&SvrAra1
ENV ACCEPT_EULA=Y

# Comando de inicio
CMD /bin/bash /scripts/init-database.sh & /opt/mssql/bin/sqlservr