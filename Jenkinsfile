pipeline {
    agent any
    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'Region', description: "Region of ECR", defaultValue: 'us-east-1')
		string(name: 'cluster', description: "name of the EKS Cluster", defaultValue: 'demo-cluster1')
	}
    environment{

        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
    }

    stages {
        stage('Checkout Git') {
            steps {
                 git 'https://github.com/Bhaskara212/Medicure-application.git'
            }
        }
        stage ('Build the code') {
            steps {
                sh 'mvn clean package' 
            }
        }
        stage('Build the Docker Image') {
            steps {
                sh 'docker build -t krishna21290/medicure-app:1.0 .'
            }
        }
        stage('Push the Image into DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-pwd', variable: 'dockerHubPassword')]) {
                    sh "docker login -u krishna21290 -p ${dockerHubPassword}"
                    sh 'docker push krishna21290/medicure-app:1.0'
                }
                
            }
        }
        stage('Create EKS Cluster : Terraform') {
            when { expression {  params.action == 'create' } }
            steps {
                script{
                    dir('eks_module') {
                        sh """
                          
                          terraform init 
                          terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars
                          terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars --auto-approve
                      """
                    }
                }
                
            }
        }
        stage('Connect to EKS '){
            when { expression {  params.action == 'create' } }
            steps {

				script{

					sh """
					aws configure set aws_access_key_id "$ACCESS_KEY"
					aws configure set aws_secret_access_key "$SECRET_KEY"
					aws configure set region "${params.Region}"
					aws eks --region ${params.Region} update-kubeconfig --name ${params.cluster}
					"""
				}
            }
        }
        stage('Deployment on test-EKS Cluster'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                  
                  def apply = false

                  try{
                    input message: 'please confirm to deploy on test-eks cluster', ok: 'Ready to apply the config ?'
                    apply = true
                  }catch(err){
                    apply= false
                    currentBuild.result  = 'UNSTABLE'
                  }
                  if(apply){

                    sh """
                      kubectl apply -f test-deployment.yaml
                    """
                  }
                }
            }
        }
        
        stage('Run the Selenium runable jar') {
            steps {
              sh 'java -jar Medicure.jar'
            }
        }
        stage('Deployment on Prod-EKS Cluster'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                  
                  def apply = false

                  try{
                    input message: 'please confirm to deploy on prod-eks-cluster', ok: 'Ready to apply the config ?'
                    apply = true
                  }catch(err){
                    apply= false
                    currentBuild.result  = 'UNSTABLE'
                  }
                  if(apply){

                    sh """
                      kubectl apply -f prod-deployment.yaml
                    """
                  }
                }
            }
        } 
        
    }
}

