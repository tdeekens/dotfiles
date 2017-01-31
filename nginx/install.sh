set -e

echo "› nginx: creating directories"

sudo mkdir -p /etc/resolver
sudo mkdir -p /Library/Logs/nginx

mkdir -p /usr/local/etc/nginx/sites-available
mkdir -p /usr/local/etc/nginx/sites-enabled
mkdir -p /usr/local/etc/nginx/conf.d
mkdir -p /usr/local/etc/nginx/ssl

echo "› nginx: generate ssl key and cert"
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/O=Office/CN=localhost" -keyout /usr/local/etc/nginx/ssl/localhost.key -out /usr/local/etc/nginx/ssl/localhost.crt

echo "› nginx: linking things in"
ln -s dnsmasq.conf /usr/local/etc/dnsmasq.conf
ln -s dev /etc/resolver/dev
ln -s nginx.conf /usr/local/etc/nginx/nginx.conf
ln -s default /usr/local/etc/nginx/sites-available/default
ln -s default-ssl /usr/local/etc/nginx/sites-available/default-ssl

ln -s php-fqm /usr/local/etc/nginx/conf.d/php-fqm
ln -s apache-deny /usr/local/etc/nginx/conf.d/apache-deny
ln -s seo-url /usr/local/etc/nginx/conf.d/seo-url

ln -sfv /usr/local/etc/nginx/sites-available/default /usr/local/etc/nginx/sites-enabled/default
ln -sfv /usr/local/etc/nginx/sites-available/default-ssl /usr/local/etc/nginx/sites-enabled/default-ssl

echo "› nginx: generate info php"
echo "<?php phpinfo();" > ~/Development/info.php

echo "› nginx: starting dnsmasq"
sudo brew services start dnsmasq

echo "› nginx: starting php70"
sudo brew services start php70

echo "› nginx: starting nginx"
sudo brew services start nginx
