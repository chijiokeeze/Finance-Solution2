# # FROM tomcat:9-jdk8
# # WORKDIR /usr/local/tomcat
# # COPY target/htech-finance-app.war /usr/local/tomcat/webapps/

# # Use the Tomcat 9 with JDK 8 as the base image
# FROM tomcat:9-jdk8

# # Set environment variables
# ENV CATALINA_HOME /usr/local/tomcat
# ENV PATH $CATALINA_HOME/bin:$PATH

# # Copy any additional configuration files or webapps
# ADD http://54.90.134.201:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/0.3/htech-finance-app-0.3.jar $CATALINA_HOME/webapps/

# # Expose the default Tomcat port
# EXPOSE 8080

# # Start Tomcat when the container launches
# CMD ["catalina.sh", "run"]

FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM tomcat:9-jdk8
WORKDIR /usr/local/tomcat
COPY --from=build /app/target/htech-finance-app-2.0.jar /usr/local/tomcat/
EXPOSE 8083
CMD ["catalina.sh", "run"]
