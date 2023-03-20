pipeline {
    agent any
    
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
                    docker.build("parthshah230/hello-world")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', '7df15b48-86ac-42c4-9bdf-aaf180d3c872') {
                        docker.image("parthshah230/hello-world").push()
                        docker.image("parthshah230/hello-world").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                bat "docker stop hello-world | true"
                bat "docker rm hello-world | true"
                bat "docker run --name hello-world -d -p 9004:8080 parthshah230/hello-world"
            }
        }
    }
}
