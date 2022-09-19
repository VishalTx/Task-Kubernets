pipeline{
  agent any
  environment {
        imageName = "docker-image"
        registryCredentials = "docker"
        registry = "hub.docker.com/repository/docker/vishal7500/task01"
        dockerImage = ''
        DOCKERHUB_CREDENTIALS=credentials('dokerhub')
    }
  stages{
    stage('checkout'){
      steps{
         checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/VishalTx/dockerflaskdemo.git']]])
      }
    }
     stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imageName
        }
      }
    }
    stage('Uploading to docker') {
     steps{  
         script {
             docker.withRegistry( 'http://'+registry, DOCKERHUB_CREDENTIALS ) {
             dockerImage.push('latest')
          }
        }
      }
    }
    
     
  }
}
