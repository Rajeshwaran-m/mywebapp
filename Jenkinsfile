pipeline {
    agent any
    environment {
        ACR_NAME = 'rajeshacr01'
        IMAGE_NAME = 'mywebapp'
        RESOURCE_GROUP = 'cicd-rg'
        APP_NAME = 'rajeshwebapp123'
        LOGIN_SERVER = "${ACR_NAME}.azurecr.io"
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Rajeshwaran-m/mywebapp.git'

            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $LOGIN_SERVER/$IMAGE_NAME:latest .'
            }
        }
        stage('Login to ACR') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'acr-creds', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
            sh 'docker login rajeshacr01.azurecr.io -u $ACR_USER -p $ACR_PASS'
        }
    }
}

     
        stage('Push to ACR') {
            steps {
                sh 'docker push $LOGIN_SERVER/$IMAGE_NAME:latest'
            }
        }
        stage('Deploy to Azure Web App') {
            steps {
                sh '''
                az webapp config container set \
                --name $APP_NAME \
                --resource-group $RESOURCE_GROUP \
                --docker-custom-image-name $LOGIN_SERVER/$IMAGE_NAME:latest
                '''
            }
        }
    }
}
