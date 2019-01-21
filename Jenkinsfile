pipeline {
  agent {
    label 'LIN_WKR'
  }
  stages {
    stage('dependencies') {
      steps {
        sh 'rm -rf msc.local'
        sh 'git clone https://github.com/nirocr/msc.git msc.local '
        dir(path: 'msc.local/deploy/tools') {
          sh 'ls -al'
          sh 'chmod a+rwx setupVectorCASTLinux.sh'
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
            sh 'wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/vcast.linux.$VERSION_VECTORCAST.tar.gz'
            sh 'mkdir -p $VECTORCAST_DIR'
            sh 'tar -xvf vcast.linux.$VERSION_VECTORCAST.tar.gz -C $VECTORCAST_DIR'
            sh '$VECTORCAST_DIR/clicast'
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
  environment {
    VECTORCAST_DIR = '/tmp/vcast'
    VECTOR_LICENSE_FILE = '27000@lic.automation-intelligence.com'
    VERSION_VECTORCAST = '2018sp3'
  }
}