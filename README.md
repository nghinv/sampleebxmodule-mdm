# xyz-mdm

works with ebx5.8.1 & tomcat9 & jre11

EBX Module with Maven

## requirement

have maven and be able to run mvn commands

## maven build commands

use jdk8

```
cd app && mvn clean install && cd .. && cp app/target/xyz-mdm-0.1.war xyz-mdm.war
```

## Docker build

```
put your ebxLicense in ~/.profile
export EBXLICENSE=XXXXX-XXXXX-XXXXX-XXXXX
source ~/.profile
docker build -t xyz-mdm:0.0.1-ebx5.8.1-tomcat9.0.12-jre11 .
```

## Docker run

```
docker run --rm -p 9090:8080 --mount type=volume,src=ebx1,dst=/data/app/ebx -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" --name ebx1 xyz-mdm:0.0.1-ebx5.8.1-tomcat9.0.12-jre11
```

open your browser at ```http://localhost:9090/ebx```

## connect to running container

```
docker exec -it ebx1 /bin/bash
```
