pipeline{
  agent any
  environment {
        imageName = "docker-image"
        registryCredentials = "docker"
        registry = "registry.hub.docker.com/"
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
    stage('Uploading to dockehub') {
     steps{  
         steps {
				sh 'docker push vishal7500/docker-image:latest'
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
