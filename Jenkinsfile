pipeline{
  agent any
  environment {
        imageName = "docker-image"
        registryCredentials = "docker"
        registry = "registry.hub.docker.com/vishal7500/task01"
        dockerImage = ''
    }
  stages{
    stage('checkout'){
      steps{
         checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/VishalTx/Task-Kubernets.git']]])
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
             docker.withRegistry( 'https://'+registry, registryCredentials ) {
             dockerImage.push('latest')
          }
        }
      }
    }
  }
}
