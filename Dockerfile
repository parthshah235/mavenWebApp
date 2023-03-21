# Use a base image with Java 8 installed
FROM openjdk:8-jdk-alpine

# Set the working directory to /app
WORKDIR /app

# Install Maven
RUN apk add --no-cache maven

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the maven dependencies
RUN ["mvn", "dependency:go-offline"]

# Copy the source code to the container
COPY src/ ./src/

# Compile and package the Java webapp
RUN ["mvn", "clean", "package"]

# Expose port 8080
EXPOSE 8080

# Start the Java webapp
CMD ["java", "-jar", "target/my-webapp.war"]
