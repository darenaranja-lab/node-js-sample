pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning forked repo..."
                git url: 'https://github.com/darenaranja-lab/node-js-sample.git', branch: 'master'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t node-app .'
            }
        }

        stage('Deploy Node App') {
            steps {
                echo "Stopping old container if exists..."
                sh 'docker rm -f node-app-container || true'

                echo "Running new container..."
                sh 'docker run -d -p 5006:5006 --name node-app-container node-app'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}

