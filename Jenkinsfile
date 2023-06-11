pipeline {
    agent any

    environment {
        registryCredentials = "Nexus-credentials"
        registry = "http://54.173.113.208:8085/"
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
        stage('Upload War file to Nexus') {
            steps {
                script {
                    def readPomVersion = readMavenPom file: 'pom.xml'
                    nexusArtifactUploader artifacts: [
                        [
                            artifactId: 'htech-finance-app',
                            classifier: '',
                            file: 'target/htech-finance-app-2.0.jar',
                            type: 'jar'
                        ]
                    ],
                    credentialsId: 'Nexus-credentials',
                    groupId: 'com.htech',
                    nexusUrl: '54.173.113.208:8081',
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    repository: 'HTech-FinanceApp',
                    version: "${readPomVersion.version}"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('http://54.173.113.208:8081', 'Nexus-credentials') {
                        def customImage = docker.build("htech-finance-app:${env.BUILD_ID}", "--build-arg NEXUS_URL=http://54.173.113.208:8081/repository/HTech-FinanceApp/com/htech/htech-finance-app/2.0/htech-finance-app-2.0.jar .")
                    }
                }
            }
        }
        // Uploading Docker images into Nexus Registry
        stage('Uploading to Nexus') {
            steps{
                script {
                    docker.withRegistry(registry, registryCredentials) {
                        sh 'docker image push cj15/htech-finance-app:v1.$BUILD_ID'
                    }
                }
            }
        }
    }
}
