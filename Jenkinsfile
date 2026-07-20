pipeline {
  agent any

  triggers {
    githubPush()
  }

  options {
    timestamps()
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '20'))
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install dependencies') {
      steps {
        sh '''
          set -eu
          python3 --version
          python3 -m venv .venv
          . .venv/bin/activate
          python -m pip install --upgrade pip
          python -m pip install -r requirements.txt
        '''
      }
    }

    stage('Validate source code') {
      steps {
        sh '''
          set -eu
          . .venv/bin/activate
          python -m compileall -q main.py helpers.py image_handler.py font_utils.py
          python -c "import cv2, keyboard, numpy; from PIL import Image; print('Dependencies imported successfully.')"
        '''
      }
    }

    stage('Check required assets') {
      steps {
        sh '''
          test -f consola.ttf || {
            echo 'consola.ttf is missing. Add a redistributable font with this name before packaging ASCIICAM.'
            exit 1
          }
        '''
      }
    }

    stage('Package application') {
      steps {
        sh '''
          rm -f ASCIICAM.tar.gz
          tar -czf ASCIICAM.tar.gz main.py helpers.py image_handler.py font_utils.py requirements.txt README.md LICENSE consola.ttf img
        '''
        archiveArtifacts artifacts: 'ASCIICAM.tar.gz', fingerprint: true
      }
    }
  }
}
