# Build
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy project files
COPY . .

# Build the Maven project
RUN mvn clean package

# Runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built JAR file
COPY --from=builder /app/target/ssh-1.0-SNAPSHOT.jar app.jar

# Run the application
<<<<<<< Updated upstream
CMD ["java", "-jar", "app.jar"]
=======
CMD ["java", "-jar", "ssh-1.0-SNAPSHOT.jar"]
>>>>>>> Stashed changes
