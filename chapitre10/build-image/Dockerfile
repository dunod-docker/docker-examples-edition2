FROM openjdk:8-alpine

VOLUME /opt/build

# On ajoute un utilisateur ayant le même id que celui de jenkins dans le conteneur jenkins
# Ceci nous assure que les deux conteneurs puissent s'échanger des fichiers sans problème
RUN adduser -D -u 1000 jenkins

# Lancement de la compilation avec Gradle et copie du JAR résultant dans /opt/build/jobs/<<build-id>>/output
ENTRYPOINT cd /opt/build/jobs/${BUILD_ID} \
                && mkdir -p output \
                && cd ${PROJECT_NAME} \
                && chmod u+x gradlew \
                && ./gradlew clean build \
                && cp build/libs/*.jar /opt/build/jobs/${BUILD_ID}/output/ \
                && chown -R jenkins:jenkins /opt/build/jobs/${BUILD_ID}
