node {

    checkout scm
    env.PATH = "${tool 'M3'}/bin:${env.PATH}"

   // def mvnHome

   //stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      // git 'https://github.com/mickaelgermemont/sampleebxmodule-mdm/'

      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.
      //mvnHome = tool 'M3'
   //}

   stage('Build mvn') {
      // Run the maven build
      // sh "pwd"
      // sh "ls"

       dir('app') {
           //sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
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

   // stage('Results') {
      // junit '**/target/surefire-reports/*.xml'
      // archive 'target/*.jar'
   // }
}
