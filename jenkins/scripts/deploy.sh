#!/usr/bin/env sh

set -x
docker rm -f my-apache-php-app || true
"C:\Users\malco\Documents\SIT\Y2T3\SSD\jenkins-php-selenium-test"
docker run -d -p 80:80 --name my-apache-php-app -v C:\\Users\\malco\\Documents\\SIT\Y2T3\\SSD\\jenkins-php-selenium-test\\src:/var/www/html php:7.2-apache
sleep 5
CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-apache-php-app)
set +x

echo 'Now...'
echo "Visit http://${CONTAINER_IP} to see your PHP application in action."

