FROM store/oracle/serverjre:8
SHELL ["/bin/bash","-c"]
ENV SPLUNK_HOME /opt/splunk
COPY . /tmp
RUN mkdir -p $SPLUNK_HOME && \
    mkdir -p $SPLUNK_HOME/etc/apps/splunk_app_db_connect/drivers && \
    cp /tmp/grafana.repo /etc/yum.repos.d/ && \
    yum update -y && \
    yum install -y wget curl nano vim hostname grafana fontconfig freetype* urw-fonts && \
    wget -O /tmp/splunk-8.0.2-a7f645ddaf91-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.2&product=splunk&filename=splunk-8.0.2-a7f645ddaf91-linux-2.6-x86_64.rpm&wget=true' && \
    wget -O /tmp/mysql-connector-java-8.0.19-1.el8.noarch.rpm 'https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19-1.el8.noarch.rpm' && \
    chmod 744 /tmp/${SPLUNK_RPM} && \
    yum install -y /tmp/*.rpm && \
    cp /tmp/user-seed.conf $SPLUNK_HOME/etc/system/local/ && \
    cp /tmp/splunk-launch.conf $SPLUNK_HOME/etc/ && \
    tar -C $SPLUNK_HOME/etc/apps -zxf /tmp/splunk-db-connect_320.tgz && \
    cp /tmp/*.jar $SPLUNK_HOME/etc/apps/splunk_app_db_connect/drivers && \
    cp -f /tmp/jre_validator.py $SPLUNK_HOME/etc/apps/splunk_app_db_connect/bin/dbx2/ && \
    ulimit -n	64000 && \
    ulimit -u	16000 && \
    ulimit -d	1073741824 && \
    grafana-cli plugins install alexanderzobnin-zabbix-app

RUN $SPLUNK_HOME/bin/splunk start --accept-license --answer-yes --no-prompt

EXPOSE 3000 8000 8089 8443 9000

CMD $SPLUNK_HOME/bin/splunk start && tail -f /dev/null
