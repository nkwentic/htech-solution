pipeline {
    agent any
    stages {
        stage('Download Source Code') {
            steps {
                 git 'https://github.com/nkwentic/htech-solution.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(installationName: 'SonarQube-10.0', credentialsId: 'sonarqube-token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
//         stage('Publish Artifacts to Nexus') {
//             steps {
//              nexusArtifactUploader artifacts: [[artifactId: 'htech-finance-app', classifier: '', file: 'target/htech-finance-app-1.2-SNAPSHOT.jar', type: 'jar']], credentialsId: 'b8444f2e-91d4-4111-b11c-e17fca17a02c', groupId: 'com.htech', nexusUrl: '172.31.22.239:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'HtechApp-SNAPSHOT', version: '1.2-SNAPSHOT'   
                
//             }
//         }
//         stage( 'Build image'){
//         steps {
//         withDockerRegistry(toolName: 'Docker', url: 'https://hub.docker.com/repository/docker/nkwentic/htech-finance-app/general') {
//     // some block
// }
// }
//  }
    }
}







       
    
        
    
    
