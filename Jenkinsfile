pipeline {
	agent none

	stages {
        stage('Integration UI Test') {
            stages {
                stage('Deploy') {
                    agent any
                    steps {
                        sh 'chmod +x ./jenkins/scripts/deploy.sh'
                        sh './jenkins/scripts/deploy.sh'
                        sh 'docker ps'  // This will show running containers
                        sh 'sleep 30'   // Give more time for the app to start
                    }
                }
                stage('Headless Browser Test') {
                    agent {
                        docker {
                            image 'maven:3-alpine'
                            args '--network host -v /root/.m2:/root/.m2'
                        }
                    }
                    steps {
                        sh 'mvn -B -DskipTests clean package'
                        sh 'mvn test'
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