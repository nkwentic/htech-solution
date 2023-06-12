FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy the JAR file from jenkins
ADD  /target/htech-finance-app-1.2-SNAPSHOT.jar

# Run the Java application
CMD ["java", "-jar", "htech-finance-app-1.2-SNAPSHOT.jar"]

