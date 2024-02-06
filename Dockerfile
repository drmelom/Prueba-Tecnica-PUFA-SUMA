# Usamos CentOS 7 como base
FROM centos:7

# Actualizamos el sistema e instalamos las herramientas necesarias
RUN yum -y update && yum -y install wget net-tools file


#Descargamos e instalamos el preinstalador de Oracle
RUN curl -o oracle-database-preinstall-21c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-21c-1.0-1.el7.x86_64.rpm
RUN yum -y localinstall oracle-database-preinstall-21c-1.0-1.el7.x86_64.rpm
ENV ORACLE_DOCKER_INSTALL=true
#Descargamos e instalamos Oracle XE
RUN wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol7.x86_64.rpm
RUN yum -y localinstall oracle-database-xe-21c-1.0-1.ol7.x86_64.rpm
ENV ORACLE_SID=XE 
ENV  ORAENV_ASK=NO 
RUN . /opt/oracle/product/21c/dbhomeXE/bin/oraenv
#instalamos leferay
WORKDIR /opt
ENV LIFERAY_HOME=/opt/liferay-ce-portal-7.4.3.106-ga106
ENV PATH=$PATH:$LIFERAY_HOME/tomcat-9.0.82/bin
RUN wget https://github.com/liferay/liferay-portal/releases/download/7.4.3.106-ga106/liferay-ce-portal-tomcat-7.4.3.106-ga106-20231207073813307.tar.gz
RUN tar xzf liferay-ce-portal-tomcat-7.4.3.106-ga106-20231207073813307.tar.gz

# Exponemos los puertos necesarios
EXPOSE 8080 1521 5000

