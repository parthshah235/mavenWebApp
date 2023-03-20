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
                    docker.build("parthshah230/mavenWebApp:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', '7df15b48-86ac-42c4-9bdf-aaf180d3c872') {
                        docker.image("parthshah230/mavenWebApp:${TAG}").push()
                        docker.image("parthshah230/hello-world:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                bat "docker stop mavenWebApp | true"
                bat "docker rm mavenWebApp | true"
                bat "docker run --name mavenWebApp -d -p 9004:8080 parthshah230/mavenWebApp:${TAG}"
            }
        }
    }
}
