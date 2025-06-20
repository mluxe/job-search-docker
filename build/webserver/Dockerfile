FROM httpd:2.4

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -qy mariadb-client \
    vim git wget php jq curl iputils-ping

RUN apt-get install -qy php-intl php-mbstring php-opcache php-pdo php-calendar php-ctype php-exif \
          php-ffi php-fileinfo php-ftp php-php-gettext php-iconv php-phar php-posix php-readline \
        php-shmop php-sockets php-sysvmsg php-sysvsem php-sysvshm php-tokenizer php-xmlreader \
        php-xmlwriter php-xsl php-curl php-mysql php-pgsql php-sqlite3 php-redis php-memcache \
        php-psr-http-client php-guzzlehttp-psr7  php-guzzlehttp-guzzle php-mongodb

RUN apt-get install -qy unzip
RUN apt install -y nodejs npm

RUN apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet

RUN mv composer.phar /usr/local/bin/composer
#RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN /usr/sbin/a2enmod rewrite
RUN phpenmod intl mbstring opcache pdo calendar ctype exif ffi fileinfo ftp gettext iconv phar \
    posix readline shmop sockets sysvmsg sysvsem sysvshm tokenizer xmlreader xmlwriter xsl pgsql \
    sqlite3 redis memcache curl mysql mongodb

#ENV APACHE_RUN_DIR=/var/run/apache2
#ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
#ENV APACHE_LOCK_DIR=/var/lock/apache2
#ENV APACHE_RUN_USER=www-data
#ENV APACHE_RUN_GROUP=www-data
#ENV APACHE_LOG_DIR=/var/log/apache2

COPY configs/apache2.conf /etc/apache2/apache2.conf
#COPY configs/apache2.conf /usr/local/apache2/conf/httpd.conf
#RUN cat /usr/local/apache2/conf/httpd.conf


RUN sed -i 's/zend.assertions = -1/zend.assertions = 1/g' /etc/php/*/apache2/php.ini

#RUN wget -qO- http://10.0.0.3/docker-build-scripts/install.sh | bash


#### INSTALL Nodejs

#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
#RUN source ~/.bashrc
#RUN ~/.nvm/nvm.sh install 22
#RUN nvm list-remote

RUN node -v


RUN mkdir /docker-entrypoint.d
COPY docker-entrypoint.sh /
COPY docker-entrypoint.d/* /docker-entrypoint.d


# change work directory
WORKDIR /var/www/html

ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/bin/sh", "-c", "while sleep 1000; do :; done" ]
CMD ["tail", "-f", "/var/www/html/api/logs/error.log" ]
#CMD ["httpd-foreground", "-f", "/etc/apache2/apache2.conf"]
