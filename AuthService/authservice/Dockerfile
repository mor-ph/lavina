FROM maven:3.3-jdk-8
VOLUME /tmp
WORKDIR /authservice
ADD ./AuthService/authservice/pom.xml /authservice/pom.xml
ADD ./AuthService/authservice/src /authservice/src
RUN ["mvn", "clean", "install", "-Dmaven.test.skip=true"]
RUN ["ls", "/authservice/target"]
RUN ["pwd"]
RUN ["ls", "-ltrh", "/authservice/target/authservice-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/authservice/target/authservice-0.0.1-SNAPSHOT.jar" ]
