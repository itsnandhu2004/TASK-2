pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'nandhini1694'   // Your Docker Hub username
        DOCKER_IMAGE = 'myrepo'          // Your Docker repository name
    }


    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'DOCKER_PAT', variable: 'DOCKER_PAT')]) {
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh'
                    }
                }
            }
        }
    }
}

