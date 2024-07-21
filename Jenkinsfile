pipeline {
	agent none
	stages {
		stage('Integration UI Test') {
			parallel {
				stage('Deploy') {
					agent any
					steps {
						sh 'chmod +x ./jenkins/scripts/deploy.sh'
						script {
                            CONTAINER_IP = sh(script: "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-apache-php-app", returnStdout: true).trim()
                            echo "CONTAINER_IP is ${CONTAINER_IP}"
                        }
						input message: 'Finished using the web site? (Click "Proceed" to continue)'
						sh 'chmod +x ./jenkins/scripts/kill.sh'
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