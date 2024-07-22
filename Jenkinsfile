pipeline {
	agent none
    environment {
        CONTAINER_IP = ''
    }
	stages {
        stage('Integration Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        sh 'chmod +x ./jenkins/scripts/deploy.sh'
                        sh './jenkins/scripts/deploy.sh'
                        script {
                            CONTAINER_IP = sh(script: "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-apache-php-app", returnStdout: true).trim()
                            echo "CONTAINER_IP is ${CONTAINER_IP}"
                        }
                    }
                }
                stage('Headless Browser Test') {
                    agent {
                        docker {
                            image 'maven:3-alpine'
                            args '-v /root/.m2:/root/.m2'
                        }
                    }
                    steps {
                        sh 'mvn -B -DskipTests clean package'
                        sh "mvn test -Dapp.url=http://${CONTAINER_IP}"
                    }
                    post {
                        always {
                            junit 'target/surefire-reports/*.xml'
                        }
                    }
                }
            }
        }
	}
}