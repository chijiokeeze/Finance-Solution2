FROM adoptopenjdk:11-jdk-hotspot

# Set the working directory inside the container
WORKDIR /app

# Install any additional dependencies if required
RUN apt-get update && apt-get install -y curl

# Define an environment variable for the artifact URL
ENV ARTIFACT_URL="http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar"

# Download the artifact using curl
RUN curl -LO $ARTIFACT_URL

EXPOSE 8888

# Add any other necessary steps, such as running the downloaded artifact

# Set the entry point for the container, if required
CMD ["java", "-jar", "htech-finance-app.jar"]
