pipeline{
  agent any
  environment {
        imageName = "docker-image"
        registryCredentials = "docker"
        registry = "hub.docker.com/repository/docker/vishal7500/task01/"
        dockerImage = ''
    }
  stages{
    stage('checkout'){
      steps{
         checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/utsav1313/Task-Kubernets.git']]])
      }
    }
     stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imageName
        }
      }
    }
    stage('Uploading to dockehub') {
     steps{  
         script {
             docker.withRegistry( 'http://'+registry, registryCredentials ) {
             dockerImage.push('latest')
          }
        }
      }
    }
    stage('Pre Prod..') {
     steps{  
         script {
             sh ' docker run -it -d -p 9090:9090 --name demo localhost:9091/docker-image'
        }
      }
    }
  }
}
