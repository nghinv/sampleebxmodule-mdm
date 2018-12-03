node {

    checkout scm
    env.PATH = "${tool 'M3'}/bin:${env.PATH}"

   stage('Build mvn') {

       dir('app') {
           sh "mvn -DskipTests -Dmaven.test.failure.ignore clean package"
           sh "cp target/xyz-mdm-0.1.war ../xyz-mdm.war"
       }
   }

   stage('Build docker') {
      // Run the docker build
      sh "pwd"
      sh "ls"

      app = docker.build("mickaelgermemont/xyz:${env.BUILD_NUMBER}", "--build-arg EBX_VERSION=5.9.0.1098 --build-arg EBX_ADDONS_VERSION=5.9.0.1098_addons_4.0.0.0038 .")
      docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
   }

}
