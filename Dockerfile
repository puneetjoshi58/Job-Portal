FROM amazoncorretto:17
ADD target/joblisting.jar app.jar
ENTRYPOINT [ "java","-jar","app.jar" ]