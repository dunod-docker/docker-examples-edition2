FROM openjdk:8-alpine

COPY *.jar /app.jar
COPY application.properties /config/application.properties

EXPOSE 8080

ENTRYPOINT java -jar app.jar -Dspring.config.location=/config