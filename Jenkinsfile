pipeline {
  agent {
    label 'LIN_WKR'
  }
  stages {
    stage('dependencies') {
      steps {
        sh 'git clone https://github.com/nirocr/msc.get msc.local '
        dir(path: 'msc.local /deploy/tools') {
          sh 'chmod a+rw setupVectorCASTLinux.sh'
          sh 'sudo ./setupVectorCASTLinux.sh'
        }

      }
    }
    stage('Infrastructure') {
      parallel {
        stage('Infrastructure') {
          steps {
            sh 'sudo apt-get -y install gcc make build-essential'
          }
        }
        stage('VectorCAST Deploy') {
          steps {
            sh '''mkdir -p tools/vcast && \\
cd tools/vcast && \\
curl -o vcast.tar.gz $(curl https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/vcTargetFile) && \\
tar -xvf vcast.tar.gz
'''
          }
        }
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