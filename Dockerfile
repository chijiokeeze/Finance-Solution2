FROM tomcat:9-jdk8
WORKDIR /usr/local/tomcat
COPY target/htech-finance-app.war /usr/local/tomcat/webapps/
