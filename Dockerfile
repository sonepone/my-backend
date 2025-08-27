# Use an official OpenJDK 17 image
FROM openjdk:17-jdk-slim AS build

# Install dos2unix just in case we have CRLF endings
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Maven wrapper and project files
COPY . .

# Ensure mvnw is executable and has LF endings
RUN chmod +x mvnw && dos2unix mvnw

# Build the project (skip tests for faster builds)
RUN ./mvnw clean package -DskipTests

# ==========================
# Runtime stage
# ==========================
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy built jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the Spring Boot port
EXPOSE 8080

# Run the Spring Boot app
CMD ["java", "-jar", "app.jar"]
