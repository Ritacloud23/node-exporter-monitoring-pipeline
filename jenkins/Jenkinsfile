pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Files') {
            steps {
                echo 'Checking project structure...'
                sh 'ls -la'
                sh 'ls -la k8s'
            }
        }

        stage('Build Backend Image') {
            steps {
                echo 'Building backend image...'
                sh 'docker build -t backend-app:latest ./backend'
            }
        }

        stage('Build Frontend Image') {
            steps {
                echo 'Building frontend image...'
                sh 'docker build -t frontend-app:latest ./frontend'
            }
        }

        stage('Load Images to Minikube') {
            steps {
                echo 'Loading images into Minikube...'
                sh 'minikube image load backend-app:latest'
                sh 'minikube image load frontend-app:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                sh 'kubectl apply -f k8s/'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
                sh 'kubectl get svc'
            }
        }
    }
}