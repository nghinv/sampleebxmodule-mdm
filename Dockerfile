FROM tomcat:9.0.12-jre11

ENV EBX_HOME /data/app/ebx
RUN mkdir -p ${EBX_HOME}

WORKDIR $CATALINA_HOME

RUN keytool -genkey -noprompt \
 -alias tomcat \
 -keyalg RSA \
 -dname "CN=helloworld, OU=ID, O=ON, L=OAuthSample, S=WithTomcat, C=US" \
 -keystore $CATALINA_HOME/.keystore \
 -storepass "ebx tomcat password" \
 -keypass "ebx tomcat password"

COPY tomcat_conf/context.xml ${CATALINA_HOME}/conf/
COPY tomcat_conf/logging.properties ${CATALINA_HOME}/conf/
COPY tomcat_conf/server.xml $CATALINA_HOME/conf/
COPY tomcat_conf/catalina.properties $CATALINA_HOME/conf/

COPY tomcat_conf/context/ebx.xml ${CATALINA_HOME}/conf/Catalina/localhost/

COPY --from=mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/libs/*.jar $CATALINA_HOME/lib/
COPY --from=mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/lib/ebx.jar $CATALINA_HOME/lib/
COPY --from=mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/lib/lib-h2/h2-1.3.170.jar $CATALINA_HOME/lib/
COPY --from=mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/webapps/wars-packaging/*.war $CATALINA_HOME/webapps/

COPY --from=mickaelgermemont/ebx-addons:5.8.1.1067-0029_addons_3.20.4.0036-0020 /data/ebx/lib/ebx-addons.jar $CATALINA_HOME/lib/
COPY --from=mickaelgermemont/ebx-addons:5.8.1.1067-0029_addons_3.20.4.0036-0020 /data/ebx/wars/ebx-addon-common.war $CATALINA_HOME/webapps/
COPY --from=mickaelgermemont/ebx-addons:5.8.1.1067-0029_addons_3.20.4.0036-0020 /data/ebx/wars/ebx-addon-adix.war $CATALINA_HOME/webapps/

COPY --from=mickaelgermemont/ebx-mima-dataonly:2.0.0 /data/mima/on-ps-mima-lib.jar $CATALINA_HOME/lib/
COPY --from=mickaelgermemont/ebx-mima-dataonly:2.0.0 /data/mima/on-ps-mima-web.war $CATALINA_HOME/webapps/

###
### PROJECT

ENV EBX_OPTS="-Debx.home=${EBX_HOME} -Debx.properties=/data/app/ebx.properties"

COPY app/target/deps/*.jar $CATALINA_HOME/lib/
COPY xyz-mdm.war $CATALINA_HOME/webapps/

COPY ebx.properties /data/app/ebx.properties

###
### startup parameters

ENV JAVA_OPTS="${EBX_OPTS} ${JAVA_OPTS}"
ENV CATALINA_OPTS ""

###
### SECURITY

RUN groupadd -g 1000 user \
   && useradd -u 1000 -g 1000 -m -s /bin/bash user \
   && chown -R 1000 /data /usr/local/tomcat
USER user

VOLUME ["/data/app/ebx"]

EXPOSE 8080
CMD ["catalina.sh", "run"]
