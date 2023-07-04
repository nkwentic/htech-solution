pipeline {
    agent any
    environment {
        imageName = "htech-finance-app"
        registryCredentials = "nexus3"
        registry = "http://18.116.26.153:8081/repository/htech-app/"
        dockerImage = ''
    }
    stages {
        stage('Download Source Code') {
            steps {
                git 'https://github.com/nkwentic/htech-solution.git'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Integration Testing') {
            steps {
                sh 'mvn verify -DskipUnitTest'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube-Analysis') {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube', credentialsId: 'sonarqube-token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        // stage("Quality Gate") {
        //     steps {
        //       timeout(time: 1, unit: 'HOURS') {
        //         waitForQualityGate abortPipeline: true
        //       }
        //     }
        //   }
        // stage('Upload War file to Nexus') {
        //     steps {
        //        nexusArtifactUploader artifacts: [
        //            [artifactId: 'htech-finance-app',
        //             classifier: '',
        //             file: 'target/htech-finance-app-1.2.jar',
        //             type: 'jar']
        //        ],
        //            credentialsId: 'nexus3',
        //            groupId: 'com.htech',
        //            nexusUrl: '172.31.24.213', 
        //            nexusVersion: 'nexus3', 
        //            protocol: 'http', 
        //            repository: 'htech-app',
        //            version: '1.2' 
        // }
        // }
stage('Upload Jar file to Nexus') {
    steps {
    nexusArtifactUploader(
        nexusVersion: 'nexus3',
        protocol: 'http',
        nexusUrl: '18.116.26.153:8081',
        groupId: 'com.htech',
        version: '1.5',
        repository: 'htech-app',
        credentialsId: 'nexus3',
        artifacts: [
            [artifactId: 'htech-finance-app',
             classifier: '',
             file: 'htech-finance-app-' + version + '.jar',
             type: 'jar']
        ]
     )
    }
}

        stage('Docker Image Build') {
            steps {
                script {
                            dockerImage = docker.build imageName
                        }
                }
            }        
            // Uploading Docker images into Nexus Registry
        stage('Uploading-DockerImage-to-Nexus') {
            steps{
                script {
                    docker.withRegistry(registry, registryCredentials) {
                    dockerImage.push('latest')
                  }   
                }
            }
        }
//         stage('Upload Docker Image to Nexus') {
//           steps {
//             script {
//               def dockerImage = docker.build("ec2-54-173-113-208.compute-1.amazonaws.com/htech-finance-app:v1.$BUILD_ID")
//               withDockerRegistry([credentialsId: 'Nexus-credentials', url: 'http://54.173.113.208:8085/']) {
//                 docker.withRegistry('', 'docker') {
//                   dockerImage.push()
//                 }
//               }
//             }
//           }
//         }        
//         stage('Push Image to dockerhub') {
//             steps {
//                 script {
//                      withCredentials([string(credentialsId: 'docker_cred2', variable: 'docker_hub_cred')]) {
//                             sh 'docker login -u cj15 -p ${docker_hub_cred}'
//                             sh 'docker image push cj15/htech-finance-app:v1.$BUILD_ID '
//                             sh 'docker rmi cj15/htech-finance-app:v1.$BUILD_ID '
//                         }
//                 }
//             }
//         }
    }
} 
    
