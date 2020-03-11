#FROM openjdk:8-jdk-alpine
#ARG DEPENDENCY=target/dependency
#COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
#COPY ${DEPENDENCY}/META-INF /app/META-INF
#COPY ${DEPENDENCY}/BOOT-INF/classes /app
#ENTRYPOINT ["java","-cp","app:app/lib/*","com.codecoda.authservice.AuthserviceApplication"]

#FROM openjdk:8
#ADD authservice-0.0.1-SNAPSHOT.jar authservice-0.0.1-SNAPSHOT.jar
#RUN bash -c 'touch /app.jar'
#ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=container", "-jar", "authservice-0.0.1-SNAPSHOT.jar"]


FROM openjdk:8
VOLUME /tmp
ADD ./AuthService/authservice/target/authservice-0.0.1-SNAPSHOT.jar authservice-0.0.1-SNAPSHOT.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","authservice-0.0.1-SNAPSHOT.jar"]