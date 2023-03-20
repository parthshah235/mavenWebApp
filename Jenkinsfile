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
            stage('Deploy'){
            steps {
                bat 'if (docker ps -a | findstr /i "maven-webapp") ( docker stop maven-webapp )'
                bat 'if (docker ps -a | findstr /i "maven-webapp") ( docker rm maven-webapp )'
                bat 'docker run -d -p 8080:8080 --name maven-webapp parthshah230/maven-webapp:%TAG%'
            }
        }
    }
}
