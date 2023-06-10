FROM openjdk:8-jdk-alpine

# Copy the JAR file from Nexus
ADD http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar /app/htech-finance-app.jar

# Set the working directory
WORKDIR /app

# Run the Java application
CMD ["java", "-jar", "htech-finance-app.jar"]
