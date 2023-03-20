pipeline {
    agent any
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
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
        stage('Deploy'){
            steps {
                bat "docker stop maven-webapp | true"
                bat "docker rm maven-webapp | true"
                bat "docker run --name maven-webapp -d -p 9004:8080 parthshah230/maven-webapp:${TAG}"
            }
        }
    }
}
