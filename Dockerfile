# Use a base image with Java 11 installed
FROM adoptopenjdk:11-jdk-hotspot

# Set the working directory inside the container
WORKDIR /app

# Install any additional dependencies if required
RUN apt-get update && apt-get install -y curl

# Define an environment variable for the artifact URL
ENV ARTIFACT_URL="http://18.219.164.120:8081/repository/htech-app/com/htech/htech-finance-app/1.2/htech-finance-app-1.2.jar"

# Download the artifact using curl
RUN curl -LO $ARTIFACT_URL

# Add any other necessary steps, such as running the downloaded artifact

# Set the entry point for the container, if required
CMD ["java", "-jar", "htech-finance-app.jar"]
