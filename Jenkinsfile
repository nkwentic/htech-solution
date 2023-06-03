pipeline {
    agent any
    stages {
        stage('Download-Source-Code') {
            steps {
                git 'https://github.com/nkwentic/htech-solution.git'
            }
        }
        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube') 
                    withMaven(maven:'Maven 3.9.2') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage('Dockerize') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Docker-credentials', 
                    passwordVariable: 'PASSWD', 
                    usernameVariable: 'USER')]) {
                sh 'docker build -t cj15/htech-finance-app:latest .'
                sh 'docker push cj15/htech-finance-app:latest'
                }
            }
        }
    }
}
