pipeline {
  agent {
    label 'LIN_WKR'
  }
  stages {
    stage('dependencies') {
      steps {
        sh 'git clone https://github.com/nirocr/msc'
        dir(path: 'msc/deploy/tools') {
          sh 'chmod a+rw setupVectorCASTLinux.sh'
          sh 'sudo ./setupVectorCASTLinux.sh'
        }

      }
    }
    stage('Infrastructure') {
      steps {
        sh 'sudo apt-get -y install gcc make build-essential'
      }
    }
    stage('Build') {
      steps {
        sh 'make sv1.exe'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing 1 2 3'
      }
    }
  }
}