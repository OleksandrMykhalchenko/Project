FROM java:8
VOLUME /tmp
ADD target/spring-petclinic-2.5.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
