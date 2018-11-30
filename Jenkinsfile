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

   stage('Build') {
      // Run the maven build
      // sh "pwd"
      // sh "ls"

       dir('app') {
           //sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
           sh "mvn -DskipTests -Dmaven.test.failure.ignore clean package"
       }
   }

   // stage('Results') {
      // junit '**/target/surefire-reports/*.xml'
      // archive 'target/*.jar'
   // }
}
