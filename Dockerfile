FROM tomcat:8-jre11-alpine as build
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

FROM aquasec/trivy:latest as vulnscan
COPY --from=build /usr/local/tomcat /usr/local/tomcat
RUN trivy filesystem --no-progress --exit-code 1 /usr/local/tomcat

FROM tomcat:8-jre11-alpine as runtime
WORKDIR /usr/local/tomcat
COPY --from=build /usr/local/tomcat/webapps/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
