pipeline {
  agent {
    label  'LIN_WKR'
  }
  stages {
    stage('dependencies'){
      steps {
        withAWS(credentials:'	AKIAJAPMYFWBIVAO32CQ') {
           s3Download(file: 'setupVcLinux.sh', bucket: 'drivers.automation-intelligence', path: 'VectorCAST/')
        }
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
