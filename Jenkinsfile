pipeline {
    agent any
    stages {
        stage('Download Source Code') {
            steps {
                git 'https://github.com/chijiokeeze/finance-solution.git'
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
                withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'jenkins-token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        stage('Upload War file to Nexus') {
            steps {
                script {
                    def readPomVersion = readMavenPom file: 'pom.xml'
                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: 'htech-finance-app', 
                            classifier: '', 
                            file: 'target/htech-finance-app-2.0.jar', 
                            type: 'jar'
                        ]
                    ], 
                    credentialsId: 'Nexus-credentials', 
                    groupId: 'com.htech', 
                    nexusUrl: '54.226.148.203:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'HTech-FinanceApp', 
                    version: "${readPomVersion.version}"
                }
            }
        }
//         stage('Dockerize') {
//             steps {
//                 withCredentials([usernamePassword(
//                     credentialsId: 'Docker-credentials', 
//                     passwordVariable: 'PASSWD', 
//                     usernameVariable: 'USER')]) {
//                 sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
//                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID cj15/$JOB_NAME:v1.$BUILD_ID
//                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID cj15/$JOB_NAME:latest    
//                 }
//             }
//         }
    }
}
