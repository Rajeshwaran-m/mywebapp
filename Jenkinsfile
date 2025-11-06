pipeline {
    agent any

    environment {
        IMAGE_NAME = "mywebapp"
        ACR_NAME = "rajeshacr01"
        RESOURCE_GROUP = "cicd-rg"
        WEBAPP_NAME = "rajeshwebapp123"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Rajeshwaran-m/mywebapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${ACR_NAME}.azurecr.io/${IMAGE_NAME}:latest .'
            }
        }

        stage('Login to ACR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr-creds', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    sh 'docker login ${ACR_NAME}.azurecr.io -u $ACR_USER -p $ACR_PASS'
                }
            }
        }

        stage('Push to ACR') {
            steps {
                sh 'docker push ${ACR_NAME}.azurecr.io/${IMAGE_NAME}:latest'
            }
        }

        stage('Deploy to Azure Web App') {
            steps {
                withCredentials([string(credentialsId: 'azure-credentials', variable: 'AZURE_CREDENTIALS')]) {
                    sh '''
                        echo "$AZURE_CREDENTIALS" > azureauth.json
                        az login --service-principal --username $(jq -r .clientId azureauth.json) --password $(jq -r .clientSecret azureauth.json) --tenant $(jq -r .tenantId azureauth.json)
                        az account set --subscription $(jq -r .subscriptionId azureauth.json)
                        az webapp config container set --name ${WEBAPP_NAME} --resource-group ${RESOURCE_GROUP} --container-image-name ${ACR_NAME}.azurecr.io/${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! Visit your app on Azure.'
        }
        failure {
            echo '❌ Build failed. Check the Jenkins logs for errors.'
        }
    }
}
