pipeline {
    agent any
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
        DOCKERHUB_CREDENTIALS = credentials('7df15b48-86ac-42c4-9bdf-aaf180d3c872')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        // add more stages if needed
        stage('Docker Build') {
            steps {
                script {
                    docker.build("parthshah230/maven-webapp:${TAG}")
                }
            }
        }
        stage('Docker Login') {
            steps {
                bat "docker login -u ${DOCKER_CREDENTIALS_USR} -p ${DOCKER_CREDENTIALS_PSW}"
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', '7df15b48-86ac-42c4-9bdf-aaf180d3c872') {
                        docker.image("parthshah230/maven-webapp:${TAG}").push()
                        docker.image("parthshah230/maven-webapp:${TAG}").push("latest")
                    }
                }
            }
        }
    }
}
