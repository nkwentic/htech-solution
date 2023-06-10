FROM openjdk:8-jdk-alpine

# Copy the JAR file from Nexus
ADD  http://172.31.22.239:8081/repository/HtechApp-SNAPSHOT/com/htech/htech-finance-app/1.1-SNAPSHOT/maven-metadata.xml

# Set the working directory
WORKDIR /app

# Run the Java application
CMD ["java", "-jar", "htech-finance-app-1.1-SNAPSHOT.jar"]

