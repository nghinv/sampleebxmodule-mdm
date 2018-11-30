# xyz-mdm

works with ebx5.9.0 & tomcat9 & jre11

EBX Module with Maven

uses ps-lib

## requirement

have maven and be able to run mvn commands

## maven build commands

use jdk8

```
cd app && mvn clean install && cd .. && cp app/target/xyz-mdm-0.1.war xyz-mdm.war
```

## Docker build

```
docker build --build-arg EBX_VERSION=5.9.0.1098 --build-arg EBX_ADDONS_VERSION=5.9.0.1098_addons_4.0.0.0038 -t xyz-mdm:0.0.1 .
```

## Docker run

```
put your ebxLicense in ~/.profile
export EBXLICENSE=XXXXX-XXXXX-XXXXX-XXXXX
source ~/.profile

docker run --rm -p 9090:8080 --mount type=volume,src=ebx590,dst=/data/app/ebx -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" --name ebx1 xyz-mdm:0.0.1
```

open your browser at ```http://localhost:9090/ebx```

## all in one command

```
source ~/.profile \
&& cd app && mvn clean install && cd .. && cp app/target/xyz-mdm-0.1.war xyz-mdm.war \
&& docker build --build-arg EBX_VERSION=5.9.0.1098 --build-arg EBX_ADDONS_VERSION=5.9.0.1098_addons_4.0.0.0038 -t xyz-mdm:0.0.1 . \
&& docker run --rm -p 9090:8080 --mount type=volume,src=ebx590,dst=/data/app/ebx -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" --name ebx1 xyz-mdm:0.0.1
```

## connect to running container

```
docker exec -it ebx1 /bin/bash
```

## jenkins setup

=== Configure



. Download Jenkins, this was tested with jenkins/jenkins:2.151-slim [https://hub.docker.com/r/jenkins/jenkins/].
. Start Jenkins: `docker run --rm --name jenkins1 -p 8080:8080 -p 50000:50000 --mount type=volume,src=Jenkins,dst=/var/jenkins_home jenkins/jenkins:2.151-slim`
. Create First Admin User, `Save and Finish`.
. Install suggested plugins
. `Manage Jenkins`, `Global Tool Configuration`, configure Maven, use name `M3` (this name is used in `Jenkinsfile`)
. `Manage Jenkins`, `Manage Plugins`, `Available`, install `CloudBees Docker Pipeline` plugin, `Install without restart`, select `Restart Jenkins`

=== Create Project

. Create a new project of the type `Pipeline from SCM`
. Configure git repo
. `Build Now`
