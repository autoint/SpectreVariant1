pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '''make sv1.exe'''
      }
    }
    stage('Test') {
      steps {
        echo 'Testing 1 2 3'
      }
    }
  }
}
