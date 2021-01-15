FROM debian:buster AS buster
EXPOSE 80 443
ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ROOT_PASSWORD '123456'
ENV VER="4.9.0.1"

## Update part
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y upgrade

## Nginx SSL
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --no-install-suggests -y nginx
RUN apt-get update

RUN apt-get install -y wget procps psmisc debconf debconf-utils perl lsb-release gnupg
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --no-install-suggests -y php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN cd /tmp && wget https://files.phpmyadmin.net/phpMyAdmin/${VER}/phpMyAdmin-${VER}-all-languages.tar.gz && tar xvf phpMyAdmin-${VER}-all-languages.tar.gz && rm phpMyAdmin*.gz
RUN mkdir /var/www/html/monsite
RUN mv /tmp/phpMyAdmin-* /var/www/html/monsite/phpmyadmin
RUN mkdir -p /var/lib/phpmyadmin/tmp && chown -R www-data:www-data /var/lib/phpmyadmin && mkdir /etc/phpmyadmin/

RUN cd /var/www/html/monsite && wget https://wordpress.org/latest.tar.gz
RUN cd /var/www/html/monsite && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
RUN wget -q https://dev.mysql.com/get/mysql-apt-config_0.8.9-1_all.deb
RUN echo "mysql-server-5.7 mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
RUN export DEBIAN_FRONTEND=noninteractive && dpkg -i mysql-apt-config*
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 8C718D3B5072E1F5
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y  mysql-server

RUN rm -rf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY ./srcs/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

ENV HOSTNAME localhost
ENV DOMAIN localhost
ENV WORDPRESS_USER wordpress
ENV WORDPRESS_PASS wordpress
ENV WORDPRESS_DB_NAME wordpress
ENV NGINX_EMAIL example@domain.com

COPY ./srcs/conf /etc/nginx/sites-available/conf
COPY ./srcs/config.inc.php /etc/phpmyadmin/config.inc.php
RUN ln -s /etc/nginx/sites-available/conf /etc/nginx/sites-enabled

COPY ./srcs/wp-config.php /var/www/html/monsite/wordpress/wp-config.php

RUN rm -rf /etc/nginx/sites-available/default && rm -rf /etc/nginx/sites-enabled/default

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/monsite.pem -keyout /etc/nginx/ssl/monsite.key -subj "/C=FR/ST=Paris/L=Paris/O=WP Docker FT/OU=Saadaoui Hassan/CN=monsite"
RUN nginx -t
VOLUME /var/lib/mysql
ENTRYPOINT service php7.3-fpm start \
    && service mysql start \
    && mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$WORDPRESS_USER'@'localhost' IDENTIFIED BY '$WORDPRESS_PASS';"  \
    && mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $WORDPRESS_DB_NAME CHARACTER SET utf8 COLLATE utf8_bin;"  \
    && mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,INDEX on $WORDPRESS_DB_NAME.* TO '$WORDPRESS_USER'@'$HOSTNAME' IDENTIFIED BY '$WORDPRESS_PASS';" mysql \
    && mysql -u root -p$MYSQL_ROOT_PASSWORD -e "flush privileges;" \
    && service nginx start && bash

CMD ["nginx", "-g", "daemon off;"]
