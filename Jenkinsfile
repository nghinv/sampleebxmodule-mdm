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

      docker.build("mickaelgermemont/xyz:${env.BUILD_NUMBER}").push()
   }

   // stage('Results') {
      // junit '**/target/surefire-reports/*.xml'
      // archive 'target/*.jar'
   // }
}
