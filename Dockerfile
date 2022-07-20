FROM maven:3.8.5-jdk-11 as builder
COPY .  /app
WORKDIR /app
ENV DB_HOSTNAME="54.202.208.206"
ENV DB_PORT="3306"
ENV DB_USER="root"
ENV DB_PASS="root"
ENV DB_DATABASE="employeedb"
RUN mvn install

FROM openjdk:11-jre
RUN mkdir /employee
ENV DB_HOSTNAME="54.202.208.206"
ENV DB_PORT="3306"
ENV DB_USER="root"
ENV DB_PASS="root"
ENV DB_DATABASE="employeedb"
COPY --from=builder /app/target/*.jar  /employee
WORKDIR /employee
CMD ["java","-jar","employee-1.0.jar"]
