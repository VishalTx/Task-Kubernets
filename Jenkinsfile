pipeline {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
  
       app = docker.build("vishal7500/vishal4")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
     stage('Sonarqube') {
      environment {
     scannerHome = tool 'sonarscanner'
     }
    steps {
         withSonarQubeEnv('productionsonarqubescanner') {
         sh "${scannerHome}/bin/sonar-scanner"
            }
         }
      }
    stage('slack notification') {
       steps{
           slackSend channel: 'kubernetes-task', color: 'good', message: 'welcome to slack', teamDomain: 'testingxperts', tokenCredentialId: 'sl-nt'  
           }
        }
    stage('selenium-test') {
      steps {
          sh 'mvn validate -P parallel'   
       }
     }
  stage('jira integration') {
      steps {
          jiraSendBuildInfo site: 'example.atlassian.net'
           }
        }
  stage('Email-Notification') {
      steps {
         emailext mimeType: 'text/html',               
         subject: "[Jenkins]${currentBuild.fullDisplayName}",               
         to:" ravali.ganigapeta@testingxperts.com",             
          body: """Please go to console output of ${BUILD_URL}input to approve or Reject"""    
      input(id: 'Proceed1', message: 'Promote build?', parameters: [[$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you agree with this']])
         sh 'docker build -t vishal7500/vishal4'
             }
          }
  stage('Jmeter-test_reports') {
      steps {
        sh "/bin/python3 -m bzt.cli test.yml"
      }
   }
     stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
     
}
