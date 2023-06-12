FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy the JAR file from jenkins
ADD  /root/.jenkins/workspace/htech-pipeline/target/htech-finance-app-1.2-SNAPSHOT.jar

# Run the Java application
CMD ["java", "-jar", "htech-finance-app-1.2-SNAPSHOT.jar"]

