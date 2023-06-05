# FROM tomcat:9-jdk8
# WORKDIR /usr/local/tomcat
# COPY target/htech-finance-app.war /usr/local/tomcat/webapps/

# Use the Tomcat 9 with JDK 8 as the base image
FROM tomcat:9-jdk8

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy any additional configuration files or webapps
COPY target/htech-finance-app.war $CATALINA_HOME/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
