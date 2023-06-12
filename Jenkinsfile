pipeline {
    agent any
    environment {
        registryCredentials = "Nexus-credentials"
        registry = "54.173.113.208:8085/"
    }
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
//         stage('Upload War file to Nexus') {
//             steps {
//                 script {
//                     def readPomVersion = readMavenPom file: 'pom.xml'
//                     nexusArtifactUploader artifacts: 
//                     [
//                         [
//                             artifactId: 'htech-finance-app', 
//                             classifier: '', 
//                             file: 'target/htech-finance-app-2.0.jar', 
//                             type: 'jar'
//                         ]
//                     ], 
//                     credentialsId: 'Nexus-credentials', 
//                     groupId: 'com.htech', 
//                     nexusUrl: '54.173.113.208:8081', 
//                     nexusVersion: 'nexus3', 
//                     protocol: 'http', 
//                     repository: 'HTech-FinanceApp', 
//                     version: "${readPomVersion.version}"
//                 }
//             }
//         }
//         stage('Docker Image Build') {
//             steps {
//                 script {
//                             sh 'docker image build -t cj15/htech-finance-app:v1.$BUILD_ID .'
//                         }
//                 }
//             }        
//             // Uploading Docker images into Nexus Registry
//         stage('Uploading to Nexus') {
//             steps{
//                 script {
//                     docker.withRegistry( 'http://'+registry, registryCredentials ) {
//                     sh 'docker image push cj15/htech-finance-app:v1.$BUILD_ID '
//                     }
//                 }
//             }
//         }
        stage('Upload Docker Image to Nexus') {
          steps {
            script {
              def dockerImage = docker.build("cj15/htech-finance-app:v1.$BUILD_ID")
              withDockerRegistry([credentialsId: 'Nexus-credentials', url: 'http://54.173.113.208:8081']) {
                docker.withRegistry('', 'docker') {
                  dockerImage.push()
                }
              }
            }
          }
        }        
        stage('Push Image to dockerhub') {
            steps {
                script {
                     withCredentials([string(credentialsId: 'docker_cred2', variable: 'docker_hub_cred')]) {
                            sh 'docker login -u cj15 -p ${docker_hub_cred}'
                            sh 'docker image push cj15/htech-finance-app:v1.$BUILD_ID '
                            sh 'docker rmi cj15/htech-finance-app:v1.$BUILD_ID '
                        }
                }
            }
        }
    }
}
