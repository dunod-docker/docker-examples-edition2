FROM openjdk:8-alpine

VOLUME /opt/output

COPY front-end /front-end

ENTRYPOINT cd /front-end && chmod u+x gradlew && ./gradlew clean build && cp build/libs/*.jar /opt/output
