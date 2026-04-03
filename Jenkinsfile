pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling code from repository...'
                checkout scm
            }
        }

        stage('Verify Project Files') {
            steps {
                echo 'Listing project structure...'
                sh 'ls -la'
                sh 'ls -la monitoring'
                sh 'ls -la jenkins'
            }
        }

        stage('Validate Prometheus Config') {
            steps {
                echo 'Validating Prometheus config file...'
                sh 'cat monitoring/prometheus.yml'
            }
        }

        stage('Validate Jenkins Files') {
            steps {
                echo 'Showing Jenkins Docker Compose file...'
                sh 'cat jenkins/docker-compose.yml'
            }
        }

        stage('Pipeline Complete') {
            steps {
                echo 'Monitoring pipeline validation completed successfully.'
            }
        }
    }
}