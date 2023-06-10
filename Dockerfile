FROM adoptopenjdk:8-jdk-hotspot

ARG NEXUS_URL
ARG BASE_IMAGE

ENV APP_HOME /app
WORKDIR $APP_HOME

# Copy the JAR file from Nexus
ADD $NEXUS_URL/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar

# Run the Java application
CMD ["java", "-jar", "htech-finance-app.jar"]
