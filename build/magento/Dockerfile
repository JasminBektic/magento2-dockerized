FROM php:7.2-apache-stretch

LABEL maintainer="jaskio89@gmail.com"

ENV WORKDIR /var/www/html
ENV COMPOSER_HOME /var/www/.composer/

RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/composer
COPY ./auth.json $COMPOSER_HOME

RUN apt-get update \
        && apt-get install -y libpng-dev libmcrypt-dev libmcrypt4 libcurl3-dev libpng-dev libfreetype6 libjpeg62-turbo-dev libfreetype6-dev libicu-dev libxslt1-dev unzip libsodium-dev \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install gd \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install zip \
        && docker-php-ext-install intl \
        && docker-php-ext-install xsl \
        && docker-php-ext-install soap \
        && docker-php-ext-install bcmath

RUN apt-get update \
        && apt-get install -y libmcrypt-dev \
        && yes '' | pecl install mcrypt-1.0.1
COPY ./mcrypt.ini /usr/local/etc/php/conf.d/mcrypt.ini

RUN chsh -s /bin/bash www-data

COPY ./install-magento /usr/local/bin/install-magento
RUN chmod +x /usr/local/bin/install-magento

COPY ./install-sampledata /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata

RUN a2enmod rewrite
COPY ./memory-limit.ini /usr/local/etc/php/conf.d/memory-limit.ini

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR $WORKDIR