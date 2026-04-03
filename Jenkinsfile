pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling code from repository...'
                checkout scm
            }
        }

        stage('Verify Files') {
            steps {
                echo 'Checking project structure...'
                sh 'ls -la'
            }
        }

        stage('Validate Monitoring Config') {
            steps {
                echo 'Showing Prometheus config...'
                sh 'cat monitoring/prometheus.yml'
            }
        }

        stage('Done') {
            steps {
                echo 'Jenkins pipeline ran successfully.'
            }
        }
    }
}