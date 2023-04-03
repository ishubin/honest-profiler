FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u362-b09

RUN apt-get update && apt-get install -y cmake libunittest++-dev maven pkg-config build-essential

RUN mkdir /app

COPY CMakeLists.txt /app/CMakeLists.txt
COPY pom.xml /app/pom.xml
COPY src /app/src


WORKDIR /app

RUN cd /app && cmake CMakeLists.txt
RUN cd /app && export LC_ALL=C && mvn clean package -DskipTests