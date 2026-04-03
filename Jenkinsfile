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
                sh 'ls -la backend'
                sh 'ls -la frontend'
                sh 'ls -la monitoring'
                sh 'ls -la jenkins'
                sh 'ls -la k8s'
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

        stage('Validate Backend Files') {
            steps {
                echo 'Checking backend files...'
                sh 'ls -la backend'
            }
        }

        stage('Validate Frontend Files') {
            steps {
                echo 'Checking frontend files...'
                sh 'ls -la frontend'
            }
        }

        stage('Validate Kubernetes Files') {
            steps {
                echo 'Checking Kubernetes manifests...'
                sh 'ls -la k8s'
                sh 'cat k8s/backend-deployment.yaml'
                sh 'cat k8s/backend-service.yaml'
                sh 'cat k8s/frontend-deployment.yaml'
                sh 'cat k8s/frontend-service.yaml'
            }
        }

        stage('Pipeline Complete') {
            steps {
                echo 'Monitoring pipeline validation completed successfully.'
            }
        }
    }
}