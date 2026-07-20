pipeline {
  agent any

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
        powershell '''
          python --version
          python -m venv .venv
          & .\.venv\Scripts\python.exe -m pip install --upgrade pip
          & .\.venv\Scripts\python.exe -m pip install -r requirements.txt
        '''
      }
    }

    stage('Validate source code') {
      steps {
        powershell '''
          & .\.venv\Scripts\python.exe -m compileall -q main.py helpers.py image_handler.py font_utils.py
          if ($LASTEXITCODE -ne 0) {
            throw 'Python syntax validation failed.'
          }

          & .\.venv\Scripts\python.exe -c "import cv2, keyboard, numpy; from PIL import Image; print('Dependencies imported successfully.')"
          if ($LASTEXITCODE -ne 0) {
            throw 'A required Python dependency could not be imported.'
          }
        '''
      }
    }

    stage('Check required assets') {
      steps {
        powershell '''
          if (-not (Test-Path 'consola.ttf')) {
            throw 'consola.ttf is missing. Add a redistributable .ttf font with this name before packaging ASCIICAM.'
          }
        '''
      }
    }

    stage('Package application') {
      steps {
        powershell '''
          Remove-Item -Recurse -Force dist -ErrorAction SilentlyContinue
          New-Item -ItemType Directory -Path dist | Out-Null

          Copy-Item main.py, helpers.py, image_handler.py, font_utils.py, requirements.txt, README.md, LICENSE, consola.ttf -Destination dist
          Copy-Item img -Destination dist -Recurse

          Compress-Archive -Path dist\* -DestinationPath ASCIICAM.zip -Force
        '''
        archiveArtifacts artifacts: 'ASCIICAM.zip', fingerprint: true
      }
    }
  }
}
