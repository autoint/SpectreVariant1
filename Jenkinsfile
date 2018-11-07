pipeline {
  agent {
    label  'linux'
  }
  stages {
    stage('Infrastructure'){
      steps {
        sh '''sudo apt-get -y install gcc make build-essential'''
      }
    }
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
