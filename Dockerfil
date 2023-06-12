# FROM adoptopenjdk:11-jdk-hotspot

# ARG NEXUS_URL

# ENV APP_HOME /app
# WORKDIR $APP_HOME

# # Copy the JAR file from Nexus
# ADD 
# # /var/lib/jenkins/workspace/HTech-FinanceApp/target/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar
# # http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar
# # $NEXUS_URL/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar $APP_HOME/htech-finance-app.jar

# # Run the Java application
# CMD ["java", "-jar", "htech-finance-app.jar"]
# Use a base image with Java 11 installed
FROM adoptopenjdk:11-jdk-hotspot

# Set the working directory inside the container
WORKDIR /app

# Install any additional dependencies if required
RUN apt-get update && apt-get install -y curl

# Define an environment variable for the artifact URL
ENV ARTIFACT_URL="http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar"

# Download the artifact using curl
RUN curl -LO $ARTIFACT_URL

# Add any other necessary steps, such as running the downloaded artifact

# Set the entry point for the container, if required
CMD ["java", "-jar", "htech-finance-app.jar"]
