FROM ubuntu:16.04 as yoman

ENV TZ=Europe/Paris

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y openjdk-8-jdk maven git

RUN apt-get install -f -y libpng16-16  libdc1394-22 libjasper1

WORKDIR /home

RUN git clone https://github.com/barais/TPDockerSampleApp

WORKDIR /home/TPDockerSampleApp

RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar

RUN mvn package

CMD ["java", "-Djava.library.path=lib/", "-jar", "target/fatjar-0.0.1-SNAPSHOT.jar"]
