# Use an official Maven image to build the Spring Boot app
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Use an official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/Ecommerce-multi-vendor-0.0.1-SNAPSHOT.jar .

# Expose the port your app listens on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/Ecommerce-multi-vendor-0.0.1-SNAPSHOT.jar"]
