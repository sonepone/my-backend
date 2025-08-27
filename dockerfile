# Use an official OpenJDK 17 image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy Maven wrapper and project files
COPY . .

# Build the project (skip tests for faster builds)
RUN ./mvnw clean package -DskipTests

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Run the Spring Boot JAR
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
