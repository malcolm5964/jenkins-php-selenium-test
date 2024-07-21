#!/usr/bin/env sh

set -x
"C:\Users\malco\Documents\SIT\Y2T3\SSD\jenkins-php-selenium-test"
docker run -d -p 80:80 --name my-apache-php-app -v C:\\Users\\malco\\Documents\\SIT\\Y2T3\\SSD\\jenkins-php-selenium-test\\src:/var/www/html php:7.2-apache
sleep 5
set +x

echo 'Now...'
echo "Visit http://localhost to see your PHP application in action."

