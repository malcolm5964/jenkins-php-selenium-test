#!/usr/bin/env sh

set -x
docker run -d -p 80:80 --name my-apache-php-app -v "$(pwd)/src":/var/www/html php:7.2-apache
sleep 10
docker ps
docker logs my-apache-php-app
curl http://localhost  # This will show if the app is accessible
set +x

echo 'Now...'
echo "Visit http://localhost to see your PHP application in action."