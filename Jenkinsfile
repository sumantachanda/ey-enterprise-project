pipeline {
    agent any
    
    environment {
        AWS_ACCOUNT_ID = "339713106190" // This will be dynamic in a real enterprise setup
        AWS_REGION     = "ap-south-1"
        ECR_REPO_NAME  = "ey-enterprise-repo"
        SCAN_TOKEN     = credentials('sonarqube-token') // We will create this next
        IMAGE_TAG      = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube-Server') {
                        sh "echo 'Scanning code...'"
                        // Placeholder for actual scanner command if needed
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
    
    post {
        always {
            sh "docker logout ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
            cleanWs()
        }
    }
}
