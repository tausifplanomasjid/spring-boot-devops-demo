FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /workspace
COPY pom.xml ./
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B clean package -DskipTests
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /workspace/target/spring-boot-devops-demo.jar /app/application.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/application.jar"]
