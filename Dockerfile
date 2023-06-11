FROM adoptopenjdk:11-jdk-hotspot

ARG NEXUS_URL

ENV APP_HOME /app
WORKDIR $APP_HOME

# Copy the JAR file from Nexus
ADD /var/lib/jenkins/workspace/HTech-FinanceApp/target/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar
# http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar
# $NEXUS_URL/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar

# Run the Java application
CMD ["java", "-jar", "htech-finance-app.jar"]
