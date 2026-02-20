pipeline {
    agent any

    environment {
        APP_NAME = "node-app"
        HOST_PORT = "5006"
        CONTAINER_PORT = "5000"
    }

    stages {

        stage('Clone Repo') {
            steps {
                echo "Cloning forked repository..."
                git branch: 'master',
                    url: 'git@github.com:darenaranja-lab/node-js-sample.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh """
                    docker build -t ${APP_NAME}:latest .
                    docker images | grep ${APP_NAME}
                """
            }
        }

        stage('Cleanup Old Container') {
            steps {
                echo "Removing old container and image if they exist..."
                sh """
                    docker rm -f ${APP_NAME}-container || true
                """
            }
        }

        stage('Deploy Node App (Internal Only)') {
            steps {
                echo "Starting new container bound to localhost only..."
                sh """
                    docker run -d \
                      -e PORT=${CONTAINER_PORT} \
                      -p 127.0.0.1:${HOST_PORT}:${CONTAINER_PORT} \
                      --name ${APP_NAME}-container \
                      ${APP_NAME}:latest

                    docker ps | grep ${APP_NAME}-container
                """
            }
        }

        stage('Health Check') {
            steps {
                echo "Verifying application is responding internally..."
                sh """
                    sleep 5
                    curl -f http://127.0.0.1:${HOST_PORT} || exit 1
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
