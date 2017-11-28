#!/bin/bash
#

echo '
----------------------------------------
ADD SWAP
----------------------------------------
';
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1


echo '
----------------------------------------
ADD REPOSITORIES
----------------------------------------
';
sudo echo '
deb http://nginx.org/packages/debian/ jessie nginx
deb-src http://nginx.org/packages/debian/ jessie nginx
' >> /etc/apt/sources.list

# nginx
cd /tmp/ && sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

# php
sudo apt-get -y install apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ jessie main" | sudo tee --append /etc/apt/sources.list.d/php.list

# update repo
sudo apt-get update

echo '
----------------------------------------
INSTALL UTILS
----------------------------------------
';
sudo apt-get install htop nano screenfetch

echo '
----------------------------------------
INSTALL NGINX
----------------------------------------
';
sudo apt-get -y install nginx

echo "[Info] Adding user vagrant to group www-data to allow nginx to access to vagrant directories"
usermod -G www-data vagrant
#ln -s /vagrant/www /var/www
 
echo '
----------------------------------------
INSTALL PHP
----------------------------------------
';
sudo apt-get -y install \
    php5.6-fpm \
    php5.6-mysql \
	php5.6-curl \
    php5.6-mcrypt \
    php5.6-intl \
    php5.6-gd \
    php5.6-sqlite \
    php5.6-json \
    php5.6-cli \
    php5.6-mbstring \
    php5.6-dom \
    php5.6-zip \
	php5.6-soap

echo '
----------------------------------------
COPY CONFIGS
----------------------------------------
';

sudo rm /etc/nginx/conf.d/default.conf
sudo cp -f /vagrant/provision/configs/nginx.conf /etc/nginx/nginx.conf
sudo cp -f /vagrant/provision/configs/nginx-host.conf /etc/nginx/conf.d/nginx-host.conf
sudo cp -f /vagrant/provision/configs/php.ini /etc/php/5.6/fpm/php.ini

echo '
----------------------------------------
RESTART ALL SERVICES
----------------------------------------
';

sudo service nginx restart
sudo service php5.6-fpm restart

echo '
----------------------------------------
DONE! MACHINE IP ADDRESS IS:
----------------------------------------
';

/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'


