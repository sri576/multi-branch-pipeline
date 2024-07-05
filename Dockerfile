FROM openjdk:8
EXPOSE 8080
ADD **/*.war *.war
ENTRYPOINT ["java", "-jre", "*.war"]
