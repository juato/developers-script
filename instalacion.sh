#!/bin/sh
echo "${bold}=========================================="
echo "${bold}============= By Bruno Cascio ============"
echo "${bold}=========================================="
echo ""

echo "${bold}=========================================="
echo "${bold}=====> Instalando SSH"
echo "${bold}=========================================="
sudo apt-get install ssh -y

echo "${bold}=========================================="
echo "${bold}=====> Instalando GIT"
echo "${bold}=========================================="
sudo apt-get install git -y

echo "${bold}=========================================="
echo "${bold}=====> Instalando NGINX"
echo "${bold}=========================================="
sudo apt-get install nginx -y

echo "${bold}=========================================="
echo "${bold}=====> Instalando PHP 5.5"
echo "${bold}=========================================="
echo "Agregando repositorio"
sudo add-apt-repository ppa:ondrej/php5 -y
echo "Actualizando repositorios"
sudo apt-get update -y
echo "Instalando dependencias"
sudo apt-get install python-software-properties -y
echo "Instalando PHP 5.5, fpm, cli y mcrypt (dependencias laravel)"
sudo apt-get install php5 php5-fpm php5-cli php5-mcrypt -y
echo "Reiniciando Nginx"
sudo service nginx restart -y

echo "${bold}=========================================="
echo "${bold}=====> Instalando Mongodb-10gen"
echo "${bold}=========================================="
echo "Agregando keyserver"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 -y
echo "Agregando Repositorio a la lista"
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
echo "Actualizando repositorios"
sudo apt-get update -y
echo "Instalando MongoDB"
sudo apt-get install mongodb-10gen -y
sudo apt-get install mongodb -y
sudo pecl install mongo -y
echo "Instalando MongoDB Server"
sudo apt-get install mongodb-server -y
echo "Instalando MongoDB Clients"
sudo apt-get install mongodb-clients -y
echo "Arrancando mongodb"
sudo service mongodb start -y
echo "Agregando Extension mongo.so"
sudo echo 'extension=mongo.so' >> /etc/php5/fpm/php.ini
sudo echo 'extension=mongo.so' >> /etc/php5/cli/php.ini

echo "${bold}=========================================="
echo "${bold}=====> Instalando SUBLIME TEXT 3"
echo "${bold}=========================================="
echo "Agregando Repositorio"
sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
echo "Actualizando Repositorios"
sudo apt-get update -y
echo "Instalando Sublime Text 3"
sudo apt-get install sublime-text-installer -y

echo "${bold}=========================================="
echo "${bold}=====> Instalando COMPOSER"
echo "${bold}=========================================="
echo "Instalando dependencia (curl)"
sudo apt-get install curl -y
sudo service nginx restart && sudo service php5-fpm restart
echo "Descargando Composer"
curl -sS https://getcomposer.org/installer | php
echo "Acceso global por medio de por ejemplo: -composer update-"
sudo mv composer.phar /usr/local/bin/composer

echo "${bold}=========================================="
echo "${bold}=========================================="
echo "${bold}=========================================="
echo "${bold}=====> Eliminando dependencias innecesarias?"
echo "${bold}=========================================="
echo "${bold}=========================================="
echo "${bold}=========================================="
sudo apt-get autoremove

echo " =============================================="
echo "${bold} ===== ===== ===== FIN ===== ===== ====="
echo " =============================================="



