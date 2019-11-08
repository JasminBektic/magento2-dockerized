#!/usr/bin/env bash

source .env
shopt -s dotglob

wget https://github.com/magento/magento2/archive/$MAGENTO_VERSION.zip && 
unzip $MAGENTO_VERSION.zip &&
mv -v magento2-$MAGENTO_VERSION/* www/html/ &&
rm -rf magento2-$MAGENTO_VERSION $MAGENTO_VERSION.zip www/html/magento2-dockerized-init.txt

composer update -d www/html 

docker-compose up -d

docker-compose exec web chmod 777 -R app/etc var pub composer.json composer.lock
docker-compose exec web chown -R 33:33 app bin generated lib pub setup var vendor
docker-compose exec web composer config repositories.magento composer https://repo.magento.com/
docker-compose exec web bash /usr/local/bin/install-magento
docker-compose exec web bash /usr/local/bin/install-sampledata