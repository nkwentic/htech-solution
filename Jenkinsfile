pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    environment {
        imageName = "nexus-docker-registry-repo"
        registryCredentials = "nexus3"
        registry = "http://18.116.26.153:8081/repository/htech-app/"
        registry2 = "http://18.116.26.153:8082/repository/nexus-docker-registry-repo/"
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
        
        stage('Upload War file to Nexus') {
            steps { 
                sh "ls -la"
                sh "curl -v -u admin:admin123 --upload-file ./target/htech-finance-app-1.5.jar http://18.116.26.153:8081/repository/htech-app/com.htech/htech-finance-app/1.5/htech-finance-app-1.5.jar"
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
                    docker.withRegistry(registry2, registryCredentials) {
                        sh 'docker tag nexus-docker-registry-repo 18.116.26.153:8082/nexus-docker-registry-repo/nexus-docker-registry-repo:latest'
sh 'docker push 18.116.26.153:8082/nexus-docker-registry-repo/nexus-docker-registry-repo:latest'
                    // dockerImage.push('latest')
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
    
