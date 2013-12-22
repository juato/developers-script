#!/usr/bin/env bash




echo '#############################'
echo 'BUNDLE DJIT'
echo '#############################'

# add 10gen package GPG key and repository
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list

# add latest nginx package PGP key and repository
apt-key adv --keyserver keyserver.ubuntu.com --recv C300EE8C
echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -cs) main" >> /etc/apt/sources.list

#Agregado de php 5.5
echo "${bold}=====> Instalando PHP 5.5"
echo "Agregando repositorio"
sudo add-apt-repository ppa:ondrej/php5 -y

# update apt and install
apt-get update 
apt-get install -y --force-yes build-essential libcurl4-gnutls-dev php5-fpm php5-dev php-pear php5-cli php5-curl php5-mcrypt php5-gd nginx mongodb-10gen git

# install php-fpm pecl extensions
pecl install pecl_http
pecl install mongo

# enable extensions
echo "extension=mongo.so" >> /etc/php5/fpm/php.ini
echo "extension=http.so" >> /etc/php5/fpm/php.ini

# create socket dir for php-fpm pool
mkdir /var/run/php5-fpm

# create webroot dir
sudo mkdir -p /var/www/default.local
touch /var/www/default.local/index.php
echo "<?php phpinfo();" >> /var/www/default.local/index.php

# remove default nginx server conf
cd /etc/nginx/sites-enabled
rm default

# download default website conf
wget https://raw.github.com/djit/install-nginx-php-fpm-mongodb/master/default.local.conf
service nginx restart

# download default pool conf
wget https://raw.github.com/djit/install-nginx-php-fpm-mongodb/master/default.local.pool
mv default.local.pool /etc/php5/fpm/pool.d/default.local.conf
service php5-fpm restart


echo "${bold}=====> Instalando SUBLIME TEXT 3"
echo "Agregando Repositorio"
sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
echo "Actualizando Repositorios"
sudo apt-get update -y
echo "Instalando Sublime Text 3"
sudo apt-get install sublime-text-installer -y

echo "${bold}=====> Instalando COMPOSER"
echo "Instalando dependencia (curl)"
sudo apt-get install curl -y
sudo service nginx restart && sudo service php5-fpm restart
echo "Descargando Composer"
curl -sS https://getcomposer.org/installer | php
echo "Acceso global por medio de por ejemplo: -composer update-"
sudo mv composer.phar /usr/local/bin/composer


echo '#############################'
echo 'REDIS instalación'
echo '#############################'

sudo apt-get update
echo "${bold}=====> Dependencias"
sudo apt-get install build-essential tcl8.5 -y
echo "${bold}=====> Descarga redis oficial"
wget http://download.redis.io/releases/redis-2.8.3.tar.gz
echo "${bold}=====> Descompresión"
tar xzf redis-2.8.3.tar.gz
cd redis-2.8.3
echo "${bold}=====> Compilación"
make
echo "${bold}=====> TEST!!"
make test
echo "${bold}=====> Instalación"
sudo make install -y
cd utils 
echo "${bold}=====> Instalación de parametros por defaul de REDIS"
sudo ./install_server.sh -y
echo "${bold}=====> Inicio del demonio"
sudo service redis_6379 start
echo "${bold}=====> Colocamos demonio al inicio"
sudo update-rc.d redis_6379 defaults -y


echo '#############################'
echo 'MEMCACHED instalación'
echo '#############################'

sudo apt-get install -y memcached php5-memcache php5-memcache php5-memcached
echo "CONFIG IN  /etc/memcached.conf"
sudo service nginx restart && sudo service php5-fpm restart


echo "${bold}=====> Eliminando dependencias innecesarias?"
sudo apt-get autoremove

echo " =============================================="
echo "${bold} ===== ===== ===== FIN ===== ===== ====="
echo " =============================================="



