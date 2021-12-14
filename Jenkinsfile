pipeline {
    options {
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '30'))
    }
    agent any
    environment {
      DOCKER_TAG = getVersion()
    }
    triggers {
        pollSCM "* * * * *"
       }
    stages {
        stage('Build Application') { 
            steps {
                echo '=== Building Petclinic Application ==='
                sh 'mvn -B -DskipTests clean package' 
            }
        }
        stage('Test Application') {
            steps {
                echo '=== Testing Petclinic Application ==='
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
                stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                echo '=== Building Petclinic Docker Image ==='
                sh "docker build . -t oleksandrmykhalchenko/petclinic:${DOCKER_TAG}" 
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps{
                withCredentials([string(credentialsId: 'dockerHubCredentials', variable: 'dockerHubPwd')]) {
                    sh "docker login -u oleksandrmykhalchenko -p ${dockerHubPwd}"
                }
                sh "docker push oleksandrmykhalchenko/petclinic:${DOCKER_TAG}"
            }
        }
        stage ('Deploy') {
            steps {
                ansiblePlaybook( 
                    playbook: 'ansible/deploy.yaml',
                    dynamicInventory: 'ansible/aws_ec2.yaml', 
                    credentialsId: 'mainkey',
                    disableHostKeyChecking: true,
                    installation: 'ansible', 
                    extras: "-e DOCKER_TAG=${DOCKER_TAG}") 
            }
        }
        stage('Remove local images') {
            steps {
                echo '=== Delete the local docker images ==='
                sh "docker rmi -f oleksandrmykhalchenko/petclinic:${DOCKER_TAG}"
            }
        }
    }
}
def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
