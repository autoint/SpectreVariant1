pipeline {
  agent {
    label  'LIN_WKR'
  }
  stages {
    stage('dependencies'){
      steps {
         sh '''wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/setupVcLinux.sh'''
         sh '''sudo setupVcLinux.sh'''
      }
    }
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
