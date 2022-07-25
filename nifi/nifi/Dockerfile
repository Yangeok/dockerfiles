ARG NIFI_VERSION

FROM apache/nifi:$NIFI_VERSION

ARG NIFI_VERSION
ENV NIFI_VERSION $NIFI_VERSION

# download MySQL, Oracle, PostgreSQL, AWS RDS connector, JSON parser
RUN cd /opt/nifi/nifi-current/lib &&\
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar &&\
    wget https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/19.8.0.0/ojdbc8-19.8.0.0.jar &&\
    wget https://jdbc.postgresql.org/download/postgresql-42.2.18.jar &&\
    wget https://s3.amazonaws.com/rds-downloads/rds-ca-2019-root.pem &&\
    wget https://repo1.maven.org/maven2/org/apache/nifi/nifi-kite-nar/$NIFI_VERSION/nifi-kite-nar-$NIFI_VERSION.nar

ENTRYPOINT ["/opt/nifi/scripts/start.sh"]