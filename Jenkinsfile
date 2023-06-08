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
                    nexusUrl: '54.227.41.117:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'HTech-FinanceApp', 
                    version: "${readPomVersion.version}"
                }
            }
        }
        stage('Docker Image Build') {
            steps {
                script {
                            sh 'docker image build -t cj15/htech-finance-app:v1.$BUILD_ID .'
                        }
                }
            }
        stage('Push Image to dockerhub') {
            steps {
                script {
                     withCredentials([string(credentialsId: 'docker_cred2', variable: 'docker_hub_cred')]) {
                            sh 'docker login -u cj15 -p ${docker_hub_cred}'
                            sh 'docker image push cj15/htech-finance-app:v1.$BUILD_ID '
                        }
                }
            }
        }
    }
}
